import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class PaymentSlip {
  final String name;
  final String code;
  final DateTime? date;
  final String? item;
  final double sale;
  final double purchase;

  PaymentSlip({
    required this.name,
    required this.code,
    this.date,
    this.item,
    this.sale = 0.0,
    this.purchase = 0.0,
  });

  factory PaymentSlip.fromJson(Map<String, dynamic> json) {
    return PaymentSlip(
      name: json['Customer']?['name'] ?? "",
      code: json['Customer']?['code'] ?? "",
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      item: json['note'],
      sale: json['note'] == "Sale"
          ? double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0
          : 0.0,
      purchase: json['note'] == "Buy"
          ? double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0
          : 0.0,
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, List<PaymentSlip>> userSlips = {};
  Map<String, String> codeToName = {};
  List<PaymentSlip> allSlips = [];

  String? selectedUser;
  bool showAll = true;
  bool loading = true;

  int currentPage = 1;
  int totalPages = 1;
  bool isLoadingMore = false;
  late ScrollController _scrollController;

  List<dynamic> _lastPaymentEntries = []; // 👈 All payment entries

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (currentPage < totalPages && !isLoadingMore) {
            loadMore();
          }
        }
      });

    fetchPayments(page: 1);
  }

  Future<void> fetchPayments({int page = 1}) async {
    try {
      final resp =
          await ApiService.get('/paymentslip?page=$page&limit=20');
      final data = resp.data;
      print("Paymentslip response: $resp");

      if (data['status'] == true && data['payments'] != null) {
        final paymentEntries = (data['paymentEntries'] ?? []) as List<dynamic>;
        final payments = data['payments'] as List<dynamic>;
        final slips = payments.map((p) => PaymentSlip.fromJson(p)).toList();

        _lastPaymentEntries = paymentEntries; // 👈 store all payments

        final grouped = <String, List<PaymentSlip>>{};
        final codeNameMap = <String, String>{};

        for (var slip in slips) {
          if (slip.name.isEmpty) continue;
          grouped.putIfAbsent(slip.code, () => []).add(slip);
          codeNameMap[slip.code] = slip.name;
        }

        setState(() {
          if (page == 1) {
            allSlips = slips;
            userSlips = grouped;
          } else {
            allSlips.addAll(slips);
            grouped.forEach((code, list) {
              userSlips.putIfAbsent(code, () => []).addAll(list);
            });
          }

          codeToName.addAll(codeNameMap);
          totalPages = data['totalPages'] ?? 1;
          currentPage = data['currentPage'] ?? page;

          if (grouped.isNotEmpty && selectedUser == null) {
            selectedUser = grouped.keys.first;
            showAll = false;
          }

          loading = false;
          isLoadingMore = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      print("Error fetching payments: $e");
      setState(() {
        loading = false;
        isLoadingMore = false;
      });
    }
  }

  void loadMore() {
    setState(() => isLoadingMore = true);
    fetchPayments(page: currentPage + 1);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading && allSlips.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 🔹 Filter payment entries based on selected user or show all
    List<dynamic> filteredPayments = [];
    if (showAll || selectedUser == null) {
      filteredPayments = _lastPaymentEntries;
    } else {
      filteredPayments = _lastPaymentEntries
          .where((e) =>
              e['Customer']?['code']?.toString() == selectedUser)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF62C370),
        title: Text(
          "payment_slips".tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // 🔹 Filter Section
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedUser,
                    hint: Text("select_customer".tr),
                    underline: const SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down,
                        color: Color(0xFF62C370)),
                    items: userSlips.keys.map((code) {
                      final name = codeToName[code] ?? "";
                      return DropdownMenuItem(
                        value: code,
                        child: Text("$name ($code)"),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedUser = val;
                        showAll = false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text("all".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Switch(
                  activeColor: const Color(0xFF62C370),
                  value: showAll,
                  onChanged: (val) {
                    setState(() {
                      showAll = val;
                      if (val) selectedUser = null;
                    });
                  },
                ),
              ],
            ),
          ),

          // 🔹 Payment Entries Section
          Expanded(
            child: filteredPayments.isEmpty
                ? Center(
                    child: Text(
                      "no_data".tr,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredPayments.length +
                        (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= filteredPayments.length) {
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final entry = filteredPayments[index];
                      final customer =
                          entry['Customer']?['name'] ?? 'Unknown';
                      final code =
                          entry['Customer']?['code'] ?? '—';
                      final amount =
                          double.tryParse(entry['amount']?.toString() ?? '0') ?? 0.0;
                      final type = entry['type']?.toString() ?? '';
                      final date = entry['date'] != null
                          ? DateFormat('dd MMM yyyy')
                              .format(DateTime.parse(entry['date']))
                          : '';

                          final grandTotal =
    double.tryParse(entry['grand_total']?.toString() ?? '0') ?? 0.0;
final due = grandTotal - amount;


                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 6,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$customer ($code)",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF1A5D1A),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  date,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Sale: ₹0.00"),
                                    Text("Purchase: ₹0.00"),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // ✅ Show grand total
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Grand Total",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "₹${grandTotal.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF62C370),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // ✅ Show received and due
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${type.capitalizeFirst ?? 'Entry'}: ₹${amount.toStringAsFixed(2)}",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Due: ₹${due.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );

                    },
                  ),
          ),
        ],
      ),
    );
  }
}
