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

  String? selectedUser; // null = show all
  bool showAll = true;
  bool loading = true;

  // Pagination states
  int currentPage = 1;
  int totalPages = 1;
  bool isLoadingMore = false;
  late ScrollController _scrollController;

  /// Group slips into 10-day ranges
  List<Map<String, dynamic>> groupByTenDays(List<PaymentSlip> slips) {
    slips.sort((a, b) => a.date?.compareTo(b.date ?? DateTime.now()) ?? 0);

    final grouped = <Map<String, dynamic>>[];

    for (var slip in slips) {
      if (slip.date == null) continue;

      final start = slip.date!;
      final day = start.day;

      int startDay = ((day - 1) ~/ 10) * 10 + 1;
      int endDay = startDay + 9;
      final startDate = DateTime(start.year, start.month, startDay);
      final endDate = DateTime(start.year, start.month, endDay);

      final existing = grouped.firstWhere(
        (g) => g['start'] == startDate && g['end'] == endDate,
        orElse: () {
          final newGroup = {
            'start': startDate,
            'end': endDate,
            'slips': <PaymentSlip>[],
            'sale': 0.0,
            'purchase': 0.0,
          };
          grouped.add(newGroup);
          return newGroup;
        },
      );

      existing['slips'].add(slip);
      existing['sale'] += slip.sale;
      existing['purchase'] += slip.purchase;
    }

    return grouped;
  }

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
          await ApiService.get('/paymentslip?page=$page&limit=20'); // 👈 backend pagination
      final data = resp.data;
      if (data['status'] == true && data['payments'] != null) {
        final payments = data['payments'] as List<dynamic>;
        final slips = payments.map((p) => PaymentSlip.fromJson(p)).toList();

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

           // 👇 Default to first customer instead of all
          if (grouped.isNotEmpty && selectedUser == null) {
            selectedUser = grouped.keys.first;
            showAll = false; // default: only first user’s data
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

    // 👉 Build finalGroups dynamically
    Map<String, List<Map<String, dynamic>>> finalGroups = {};

    if (showAll || selectedUser == null) {
      userSlips.forEach((code, slips) {
        finalGroups[code] = groupByTenDays(slips);
      });
    } else {
      finalGroups[selectedUser!] =
          groupByTenDays(allSlips.where((s) => s.code == selectedUser).toList());
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF62C370),
        title: Text(
          "payment_slips".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Section
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
                    style: TextStyle(fontWeight: FontWeight.w600)),
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

          // Data Section
          Expanded(
            child: finalGroups.isEmpty
                ? Center(
                    child: Text(
                      "no_data".tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView(
                    controller: _scrollController,
                    children: [
                      ...finalGroups.entries.expand((entry) {
                        final code = entry.key;
                        final groups = entry.value;

                        return groups.map((group) {
                          final sale = group['sale'] as double;
                          final purchase = group['purchase'] as double;
                          final grandTotal = sale - purchase;
                          final start = group['start'] as DateTime;
                          final end = group['end'] as DateTime;

                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
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
                                    "${codeToName[code]} ($code)",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF1A5D1A),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "${DateFormat('dd MMM yyyy').format(start)} → ${DateFormat('dd MMM yyyy').format(end)}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${'sale'.tr}: ₹${sale.toStringAsFixed(2)}"), 
                                      Text("${'purchase'.tr}: ₹${purchase.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("grand_total".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${'received'.tr}: ₹${sale.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text("${'due'.tr}: ₹0.00",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList();
                      }),
                      if (isLoadingMore)
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child:
                              Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
