import 'package:flutter/material.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String transactionType = "Sale";
  List<Map<String, dynamic>> customers = [];
  List<Map<String, dynamic>> transactions = [];
  String? selectedCustomerCode;
  final TextEditingController _codeController = TextEditingController();

  Future<void> _fetchCustProList({String? customerId, String? code}) async {
      try {
        final response = await ApiService.post(
          "/transection",
          {
            "transactionType": transactionType,
            "customerId": customerId, // null = all entries
            "code": code,             // optional filter by code
          },
        );

        final data = response.data;
        if (data["success"] == true) {
          setState(() {
            customers = (data["customers"] as List).cast<Map<String, dynamic>>();
            transactions = (data["products"] as List?)?.cast<Map<String, dynamic>>() ?? [];
          });
        }
      } catch (e) {
        print("Error fetching data: $e");
      }
    }


  @override
  void initState() {
    super.initState();
    _fetchCustProList(); // load all entries by default
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
        } else {
          _fetchCustProList(); // fallback to all
        }
      }



  @override
  Widget build(BuildContext context) {
    final selectedCustomer = customers.firstWhere(
      (c) => c["code"] == selectedCustomerCode,
      orElse: () => {},
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        foregroundColor: Colors.white,
        title: const Text("View transaction", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.print, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Filters Row
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCustomerCode = null;
                        });
                        _fetchCustProList(); // fetch all entries
                      },
                      child: const Text("All Entries"),
                    ),
                  ),
                ],
              ),
            ),

            // Customer Dropdown + Code Search
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.shopping_cart),
                  const SizedBox(width: 8),
                  Expanded(
                    child: 
                    DropdownButtonFormField<String>(
                    value: selectedCustomerCode,
                    hint: const Text("Select Customer"),
                    items: customers.map<DropdownMenuItem<String>>((c) {
                      return DropdownMenuItem<String>(
                        value: c["code"].toString(),
                        child: Text("${c['name']} (${c['code']})"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedCustomerCode = value);

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
                        if (value.isNotEmpty) {
                          _filterByCode(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),
            if (selectedCustomer.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${selectedCustomer["name"]}"),
                    Text("Code: ${selectedCustomer["code"]}"),
                    Text("Phone: ${selectedCustomer["phone"]}"),
                  ],
                ),
              ),

            // Transactions Table Header
            Container(
              color: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: const Row(
                children: [
                  Expanded(flex: 2, child: Text("Bill date", style: TextStyle(color: Colors.white))),
                  Expanded(flex: 2, child: Text("Detail", style: TextStyle(color: Colors.white))),
                  Expanded(flex: 2, child: Text("Amount", style: TextStyle(color: Colors.white))),
                  Expanded(flex: 2, child: Text("Code", style: TextStyle(color: Colors.white))),
                  Expanded(flex: 2, child: Text("Created Date", style: TextStyle(color: Colors.white))),                  
                ],
              ),
            ),

            // Transactions List
            ...transactions.map((tx) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(tx["bill_date"] ?? "")),
                    Expanded(flex: 2, child: Text(tx["remark"] ?? "")),
                    Expanded(flex: 2, child: Text(tx["amount"] ?? "")),
                    Expanded(flex: 2, child: Text(tx["code"] ?? "")),
                    Expanded(flex: 2, child: Text(tx["createdAt"] ?? "")),                    
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
