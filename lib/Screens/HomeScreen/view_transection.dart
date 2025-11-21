import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  List<Map<String, dynamic>> milkEntries = [];
  List<Map<String, dynamic>> payments = [];
  String? selectedCustomerCode;
  final TextEditingController _codeController = TextEditingController();

  bool showAllEntries = false;
  DateTimeRange? selectedRange;

  double totalMilkAmount = 0;
  double totalProductAmount = 0;
  double totalPaymentAmount = 0;
  double totalTransactionAmount = 0;
  double netAmount = 0;
  String customerType = "";

  final box = GetStorage();  
 @override
void initState() {
  super.initState();
  final box = GetStorage();
  final savedDuration = box.read('duration') ?? 10; // default 10 days
  final now = DateTime.now();

  selectedRange = DateTimeRange(
    start: now.subtract(Duration(days: savedDuration)),
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
          "code": code,
          "allEntries": all,
          if (!all && selectedRange != null) ...{
            "startDate": DateFormat("yyyy-MM-dd").format(selectedRange!.start),
            "endDate": DateFormat("yyyy-MM-dd").format(selectedRange!.end),
          }
        };

        final response = await ApiService.post("/transection", body);
        final data = response.data;

        if (data["success"] == true) {
          setState(() {
            customers = (data["customers"] as List?)?.cast<Map<String, dynamic>>() ?? [];
            transactions = (data["entries"]["transactionEntries"] as List?)?.cast<Map<String, dynamic>>() ?? [];
            productrx = (data["entries"]["productEntries"] as List?)?.cast<Map<String, dynamic>>() ?? [];
            milkEntries = (data["entries"]["milkEntries"] as List?)?.cast<Map<String, dynamic>>() ?? [];
            payments = (data["entries"]["paymentEntries"] as List?)?.cast<Map<String, dynamic>>() ?? [];
            // Add these for net summary
            totalMilkAmount = double.tryParse(data["totals"]["totalMilkAmount"].toString()) ?? 0;
            totalProductAmount = double.tryParse(data["totals"]["totalProductAmount"].toString()) ?? 0;
            totalPaymentAmount = double.tryParse(data["totals"]["totalPaymentAmount"].toString()) ?? 0;
            totalTransactionAmount = double.tryParse(data["totals"]["totalTransactionAmount"].toString()) ?? 0;
            netAmount = double.tryParse(data["net"].toString()) ?? 0;
            customerType = data["customerType"] ?? "";
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
  // Merge all 4 tables
  List<Map<String, dynamic>> combinedEntries = [
    ...transactions.map((t) => {...t, "entryType": "transaction"}),
    ...productrx.map((p) => {...p, "entryType": "product"}),
    ...milkEntries.map((m) => {...m, "entryType": "milk"}),
    ...payments.map((p) => {...p, "entryType": "payment"}),
  ];

  // Filter by date range
  if (!showAllEntries && selectedRange != null) {
    combinedEntries = combinedEntries.where((entry) {
      DateTime? entryDate;
      switch (entry["entryType"]) {
        case "milk":
          entryDate = DateTime.tryParse(entry["date"] ?? "");
          break;
        case "payment":
          entryDate = DateTime.tryParse(entry["date"] ?? "");
          break;
        case "product":
          entryDate = DateTime.tryParse(entry["bill"] ?? "");
          break;
        case "transaction":
          entryDate = DateTime.tryParse(entry["bill_date"] ?? "");
          break;
      }

      if (entryDate == null) return false;
      return entryDate.isAfter(selectedRange!.start.subtract(const Duration(days: 1))) &&
          entryDate.isBefore(selectedRange!.end.add(const Duration(days: 1)));
    }).toList();
  }

  // Sort by date ascending
  combinedEntries.sort((a, b) {
    DateTime dateA, dateB;
    switch (a["entryType"]) {
      case "milk":
        dateA = DateTime.tryParse(a["date"] ?? "") ?? DateTime(1900);
        break;
      case "payment":
        dateA = DateTime.tryParse(a["date"] ?? "") ?? DateTime(1900);
        break;
      case "product":
        dateA = DateTime.tryParse(a["bill"] ?? "") ?? DateTime(1900);
        break;
      default:
        dateA = DateTime.tryParse(a["bill_date"] ?? "") ?? DateTime(1900);
    }
    switch (b["entryType"]) {
      case "milk":
        dateB = DateTime.tryParse(b["date"] ?? "") ?? DateTime(1900);
        break;
      case "payment":
        dateB = DateTime.tryParse(b["date"] ?? "") ?? DateTime(1900);
        break;
      case "product":
        dateB = DateTime.tryParse(b["bill"] ?? "") ?? DateTime(1900);
        break;
      default:
        dateB = DateTime.tryParse(b["bill_date"] ?? "") ?? DateTime(1900);
    }
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
        title: Text(
          'view_transactions'.tr,
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
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          "${DateFormat('d MMM').format(selectedRange!.start)} – ${DateFormat('d MMM').format(selectedRange!.end)}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text("all_entries".tr, style: TextStyle(fontWeight: FontWeight.w500)),
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
                 
                  
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCustomerCode,
                      hint: Text("select_customer".tr),
                      isExpanded: true, 
                      items: customers.map<DropdownMenuItem<String>>((c) {
                        return DropdownMenuItem<String>(
                          value: c["code"].toString(),
                          child: Row(
              children: [
                Icon(
                  c['customerType'] == 'Purchaser'
                      ? Icons.shopping_cart  // 🛒 Purchaser
                      : Icons.store,          // 🏪 Seller
                  color: c['customerType'] == 'Purchaser'
                      ? Colors.blue
                      : Colors.green,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  "${c['name'] ?? '-'}${c['code'] != null && c['code'].toString().isNotEmpty ? " (${c['code']})" : ""}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),

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
                      decoration: InputDecoration(
                        labelText: "code".tr,
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
                    Text("${'account_no'.tr}: ${selectedCustomer["code"]}"),
                    Text("${'name'.tr}: ${selectedCustomer["name"]}"),
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
              child:  Row(
                children: [
                  Expanded(flex: 2, child: Text("bill_date".tr, style: TextStyle(color: Colors.white))),
                  Expanded(flex: 3, child: Text("detail".tr, style: TextStyle(color: Colors.white))),
                  Expanded(flex: 2, child: Text("created_date".tr, style: TextStyle(color: Colors.white))),
                  Expanded(flex: 2, child: Text("debit_credit".tr, style: TextStyle(color: Colors.white))),
                ],
              ),
            ),

            // 🔄 Combined Entries
...combinedEntries.map((entry) {
  bool isProduct = entry["entryType"] == "product";

  // ✅ FIXED DATE SELECTION BY ENTRY TYPE
  DateTime? entryDate;
  switch (entry["entryType"]) {
    case "milk":
      entryDate = DateTime.tryParse(entry["date"] ?? "");
      break;
    case "payment":
      entryDate = DateTime.tryParse(entry["date"] ?? "");
      break;
    case "product":
      entryDate = DateTime.tryParse(entry["bill"] ?? "");
      break;
    default:
      entryDate = DateTime.tryParse(entry["bill_date"] ?? "");
  }

  // Format the chosen date
  String formattedDate = entryDate != null
      ? DateFormat("dd MMM").format(entryDate)
      : "";


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
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ✅ Label for table source
        Text(
          () {
            switch (entry["entryType"]) {
              case "milk":
                return "milk_entry".tr;
              case "product":
                return "product".tr;
              case "payment":
                return "payment".tr;
              case "transaction":
                return "transaction_entry".tr;
              default:
                return entry["entryType"].toString().capitalizeFirst ?? "";
            }
          }(),
          style: const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),


      const SizedBox(height: 2),

      // ✅ Product detail or remark
      if (entry["entryType"] == "product") ...[
        Text(entry["product_name"] ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          "Qty: ${entry["quantity"] ?? '-'} | Price: ${entry["price"] ?? '-'}",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ] else ...[
        Text(
          entry["remark"] ?? "-",
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    ],
  ),
),

              Expanded(
                flex: 2,
                child: Text(
                  () {
                    String? createdDate;

                    switch (entry["entryType"]) {
                      case "milk":
                        createdDate = entry["date"]; // ✅ milk entry uses "date"
                        break;
                      case "payment":
                        createdDate = entry["createdAt"];
                        break;
                      case "product":
                        createdDate = entry["createdAt"];
                        break;
                      case "transaction":
                        createdDate = entry["createdAt"];
                        break;
                    }

                    if (createdDate == null || createdDate.isEmpty) return "";

                    DateTime? parsedDate = DateTime.tryParse(createdDate);
                    return parsedDate != null
                        ? DateFormat("dd MMM").format(parsedDate)
                        : "";
                  }(),
                  style: const TextStyle(fontSize: 13),
                ),
              ),

              Expanded(
                flex: 2,
                child: Builder(
                  builder: (context) {
                    final amt = double.tryParse(entry["amount"].toString()) ?? 0;
                    final type = entry["entryType"];
                    final custType = selectedCustomer["customerType"] ?? "Seller";

                    bool isPositive = false;

                    // ✅ Determine whether this amount is + or -
                    if (custType == "Seller") {
                      // Seller → milk + product + payment - transaction
                      if (type == "milk" || type == "payment" || type == "product") {
                        isPositive = true;
                      } else if (type == "transaction") {
                        isPositive = false;
                      }
                    } else if (custType == "Purchaser") {
                      // Purchaser → -milk - product + payment + transaction
                      if (type == "transaction" || type == "payment") {
                        isPositive = true;
                      } else if (type == "product" || type == "milk") {
                        isPositive = false;
                      }
                    }

                    final prefix = isPositive ? "+" : "-";
                    final color = isPositive ? Colors.green[700] : Colors.red[700];

                    return Text(
                      "$prefix${amt.toStringAsFixed(2)}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),

                  ],
                ),
              );
            }),

            // ✅ Total Summary
            // ✅ Total Summary
            if (combinedEntries.isNotEmpty)
  Container(
    color: Colors.green[600],
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total (${combinedEntries.length})",
            style: const TextStyle(color: Colors.white)),

        Builder(
          builder: (context) {
            double total = 0;
            final customerType = selectedCustomer["customerType"] ?? "Seller"; // 🧠 get current type

            for (var e in combinedEntries) {
              final amt = double.tryParse(e["amount"].toString()) ?? 0;
              final type = e["entryType"];

              if (customerType == "Seller") {
                // Seller → milk + product + payment - transaction
                if (type == "milk" || type == "payment" || type == "product") {
                  total += amt;
                } else if (type == "transaction") {
                  total -= amt;
                }
              } else if (customerType == "Purchaser") {
                // Purchaser → -milk - product + payment + transaction
                if (type == "transaction" || type == "payment") {
                  total += amt;
                } else if (type == "product" || type == "milk") {
                  total -= amt;
                }
              }
            }

            return Text(
              total.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
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
