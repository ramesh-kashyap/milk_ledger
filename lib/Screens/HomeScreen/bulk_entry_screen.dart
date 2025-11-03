import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class BulkEntryScreen extends StatefulWidget {
  const BulkEntryScreen({Key? key}) : super(key: key);

  @override
  State<BulkEntryScreen> createState() => _BulkEntryScreenState();
}

class _BulkEntryScreenState extends State<BulkEntryScreen> {
  // Sample data
  final List<Map<String, dynamic>> customers = [
    {'sno': 1221, 'name': 'raahh', 'liter': '0', 'selected': false},
    {'sno': 1232, 'name': 'raaj', 'liter': '0', 'selected': false},
  ];

  void _saveData() {
    final selectedData = customers
        .where((item) => item['selected'] == true)
        .map((item) => {
              'sno': item['sno'],
              'name': item['name'],
              'liter': item['liter'],
            })
        .toList();

    // You can print, send API request, etc.
    debugPrint('Selected Data: $selectedData');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Bulk Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(60),
              1: FixedColumnWidth(70),
              2: FlexColumnWidth(),
              3: FixedColumnWidth(80),
            },
            children: [
              // Table Header
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Select',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('S. No.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Name',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Liter',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),

              // Table Rows
              for (var i = 0; i < customers.length; i++)
                TableRow(
                  children: [
                    Checkbox(
                      value: customers[i]['selected'],
                      onChanged: (value) {
                        setState(() {
                          customers[i]['selected'] = value!;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(customers[i]['sno'].toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(customers[i]['name']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (val) {
                          customers[i]['liter'] = val;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        controller: TextEditingController(
                          text: customers[i]['liter'],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: _saveData,
          child: const Text(
            'SAVE',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
