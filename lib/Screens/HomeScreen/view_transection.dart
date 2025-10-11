import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:get/get.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String transactionType = "Sale";
  List<Map<String, dynamic>> customers = [];
  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> productrx = [];
  String? selectedCustomerCode;
  final TextEditingController _codeController = TextEditingController();

  bool showAllEntries = false;
  DateTimeRange? selectedRange;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedRange = DateTimeRange(
      start: now.subtract(const Duration(days: 10)),
      end: now,
    );
    _fetchFirstCustomer();
  }

  Future<void> _fetchCustProList({
    String? code,
    bool all = false,
  }) async {
    try {
      final body = {
        "transactionType": transactionType,
        "code": code,
        if (!all && selectedRange != null) ...{
          "startDate": DateFormat("yyyy-MM-dd").format(selectedRange!.start),
          "endDate": DateFormat("yyyy-MM-dd").format(selectedRange!.end),
        }
      };

      final response = await ApiService.post("/transection", body);
      final data = response.data;

      print("Products: ${data["products"]}");
      print("Payments: ${data["payments"]}");

      if (data["success"] == true) {
        setState(() {
          customers = (data["customers"] as List?)?.cast<Map<String, dynamic>>() ?? [];
          transactions = (data["payments"] as List?)?.cast<Map<String, dynamic>>() ?? [];
          productrx = (data["products"] as List?)?.cast<Map<String, dynamic>>() ?? [];
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> _fetchFirstCustomer() async {
    try {
      final response = await ApiService.post("/transection", {
        "transactionType": transactionType,
      });
      final data = response.data;

      if (data["success"] == true) {
        final custs = (data["customers"] as List).cast<Map<String, dynamic>>();
        if (custs.isNotEmpty) {
          final firstCustomer = custs.first;
          setState(() {
            customers = custs;
            selectedCustomerCode = firstCustomer["code"].toString();
          });
          _fetchCustProList(code: selectedCustomerCode);
        }
      }
    } catch (e) {
      print("Error fetching first customer: $e");
    }
  }

  void _filterByCode(String code) {
    final match = customers.firstWhere(
      (c) => c["code"].toString() == code,
      orElse: () => {},
    );
    if (match.isNotEmpty) {
      setState(() {
        selectedCustomerCode = match["code"].toString();
      });
      _fetchCustProList(code: match["code"].toString());
    }
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: selectedRange,
    );
    if (picked != null) {
      setState(() {
        selectedRange = picked;
      });
      _fetchCustProList(code: selectedCustomerCode, all: false);
    }
  }

  /// ✅ Merge product + transaction into one timeline list
 /// ✅ Merge product + transaction into one timeline list and filter by date
List<Map<String, dynamic>> _getCombinedEntries() {
  // Step 1: merge
  List<Map<String, dynamic>> combinedEntries = [
    ...transactions.map((t) => {...t, "entryType": "transaction"}),
    ...productrx.map((p) => {...p, "entryType": "product"}),
  ];

  // Step 2: filter by selected date range (only if "All Entries" is false)
  if (!showAllEntries && selectedRange != null) {
    combinedEntries = combinedEntries.where((entry) {
      // Determine entry date
      DateTime? entryDate = DateTime.tryParse(
        entry["bill_date"] ?? entry["bill"] ?? entry["createdAt"] ?? "",
      );
      if (entryDate == null) return false;

      return entryDate.isAfter(
                selectedRange!.start.subtract(const Duration(days: 1))) &&
             entryDate.isBefore(
                selectedRange!.end.add(const Duration(days: 1)));
    }).toList();
  }

  // Step 3: sort by date
  combinedEntries.sort((a, b) {
    final dateA = DateTime.tryParse(a["bill_date"] ?? a["bill"] ?? a["createdAt"] ?? "") ?? DateTime(1900);
    final dateB = DateTime.tryParse(b["bill_date"] ?? b["bill"] ?? b["createdAt"] ?? "") ?? DateTime(1900);
    return dateA.compareTo(dateB);
  });

  return combinedEntries;
}


  @override
  Widget build(BuildContext context) {
    final selectedCustomer = customers.firstWhere(
      (c) => c["code"] == selectedCustomerCode,
      orElse: () => {},
    );

    final combinedEntries = _getCombinedEntries(); // ✅ moved inside build()

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        foregroundColor: Colors.white,
        title: const Text(
          "View transaction",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.print, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            // 📅 Date Range + Toggle
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickDateRange,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Text(
                          "${DateFormat('yyyy-MM-dd').format(selectedRange!.start)} to ${DateFormat('yyyy-MM-dd').format(selectedRange!.end)}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      const Text("All Entries", style: TextStyle(fontWeight: FontWeight.w500)),
                      Switch(
                        value: showAllEntries,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          setState(() => showAllEntries = val);
                          _fetchCustProList(
                            code: selectedCustomerCode,
                            all: val,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 👤 Customer Dropdown + Code
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.shopping_cart),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCustomerCode,
                      hint: const Text("Select Customer"),
                      items: customers.map<DropdownMenuItem<String>>((c) {
                        return DropdownMenuItem<String>(
                          value: c["code"].toString(),
                          child: Text("${c['name']} (${c['code']})"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCustomerCode = value;
                          _codeController.text = value ?? "";
                        });
                        _fetchCustProList(code: value);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        labelText: "Code",
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) _filterByCode(value);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 👤 Customer Info
            if (selectedCustomer.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${DateFormat('yyyy-MM-dd').format(selectedRange!.start)} to ${DateFormat('yyyy-MM-dd').format(selectedRange!.end)}",
                      style: const TextStyle(color: Colors.green),
                    ),
                    const SizedBox(height: 4),
                    Text("Account No: ${selectedCustomer["code"]}"),
                    Text("Name: ${selectedCustomer["name"]}"),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        selectedCustomer["customerType"] ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

            // 🧾 Table Header
            Container(
              color: Colors.green[600],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: const Row(
                children: [
                  Expanded(flex: 2, child: Text("Bill date", style: TextStyle(color: Colors.white))),
                  Expanded(flex: 3, child: Text("Detail", style: TextStyle(color: Colors.white))),
                  Expanded(flex: 2, child: Text("Created Date", style: TextStyle(color: Colors.white))),
                  Expanded(flex: 2, child: Text("Debit(-)/Credit(+)", style: TextStyle(color: Colors.white))),
                ],
              ),
            ),

            // 🔄 Combined Entries
            ...combinedEntries.map((entry) {
              bool isProduct = entry["entryType"] == "product";
              DateTime? entryDate = DateTime.tryParse(entry["bill_date"] ?? entry["bill"] ?? "");

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: isProduct ? Colors.grey[200] : Colors.white,
                  border: const Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        entryDate != null ? DateFormat("dd MMM").format(entryDate) : "",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: isProduct
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry["product_name"] ?? "",
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                  "Qty: ${entry["quantity"] ?? '-'} | Price: ${entry["price"] ?? '-'}",
                                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            )
                          : Text(entry["remark"] ?? ""),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        entry["createdAt"] != null
                            ? DateFormat("dd MMM").format(DateTime.parse(entry["createdAt"]))
                            : "",
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        entry["amount"].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: isProduct
                              ? Colors.black87
                              : ((double.tryParse(entry["amount"].toString()) ?? 0) < 0)
                                  ? Colors.red
                                  : Colors.green[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // ✅ Total Summary
            if (combinedEntries.isNotEmpty)
              Container(
                color: Colors.green[600],
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total (${combinedEntries.length})", style: const TextStyle(color: Colors.white)),
                    Text(
                      combinedEntries.fold<double>(
                        0.0,
                        (sum, e) => sum + (double.tryParse(e["amount"].toString()) ?? 0),
                      ).toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }
}
