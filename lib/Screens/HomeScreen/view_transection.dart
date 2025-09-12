import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  final List<Map<String, String>> transactions;

  const TransactionPage({super.key, this.transactions = const [
    {
      "billDate": "01 Sep",
      "detail": "",
      "createdDate": "01 Sep",
      "amount": "100.00",
    },
  ]});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: const Text("View transaction"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Date Filters Row
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text("2025-09-01"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text("2025-09-10"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text("All Entries"),
                  ),
                  const SizedBox(width: 8),
                  Switch(value: false, onChanged: (v) {}),
                ],
              ),
            ),

            // Account Section
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.shopping_cart),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text("Anuj(088)"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Code",
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),
            const Text("2025-09-01 to 2025-09-10",
                style: TextStyle(color: Colors.green)),

            // Account Details
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account No. 088",
                      style: TextStyle(color: Colors.black87)),
                  Text("Name:- Anuj    Purchaser",
                      style: TextStyle(color: Colors.black87)),
                ],
              ),
            ),

            // Table Header
            Container(
              color: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: const Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text("Bill date",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 3,
                      child: Text("Detail",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 2,
                      child: Text("Created Date",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 2,
                      child: Text("Debit(-)/ Credit(+)",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))),
                ],
              ),
            ),

            // Transactions
            ...transactions.map((tx) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(tx["billDate"]!)),
                    Expanded(flex: 3, child: Text(tx["detail"]!)),
                    Expanded(flex: 2, child: Text(tx["createdDate"]!)),
                    Expanded(flex: 2, child: Text(tx["amount"]!)),
                  ],
                ),
              );
            }),

            // Total Row
            Container(
              color: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("Total(1)",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(flex: 3, child: Text("")),
                  Expanded(flex: 2, child: Text("")),
                  Expanded(
                    flex: 2,
                    child: Text("100.00",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
