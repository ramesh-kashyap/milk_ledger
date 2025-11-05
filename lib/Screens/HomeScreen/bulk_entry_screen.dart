import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class BulkEntryScreen extends StatefulWidget {
  const BulkEntryScreen({Key? key}) : super(key: key);

  @override
  State<BulkEntryScreen> createState() => _BulkEntryScreenState();
}

class _BulkEntryScreenState extends State<BulkEntryScreen> {
  List<Map<String, dynamic>> customers = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  // ✅ Fetch customers from your API
      Future<void> fetchCustomers() async {
        setState(() {
          loading = true;
        });

        try {
          final response = await ApiService.post("/bulkEntryCustomer", {});

          print("📦 API Raw Response: ${response.data}");

          // ✅ Use response.data to access the JSON body
          final resData = response.data;

          if (resData != null &&
              resData['success'] == true &&
              resData['customers'] != null) {
            final List<dynamic> data = resData['customers'];

            setState(() {
              customers = data
                  .map((c) => {
                        'sno': c['code'] ?? '',
                        'name': c['name'] ?? '',
                        'liter': '0',
                        'selected': false,
                        'note': c['customer_type'] ?? '',
                      })
                  .toList();
            });
          } else {
            Get.snackbar("No Customers", resData?['message'] ?? "No data found");
          }
        } catch (e) {
          print("❌ Error fetching customers: $e");
          Get.snackbar("Error", "Failed to load customers: $e");
        }

        setState(() {
          loading = false;
        });
      }


  // ✅ Save selected customer data
    void _saveData() async {
      final selectedData = customers
          .where((item) => item['selected'] == true)
          .map((item) => {
                'code': item['sno'],
                'name': item['name'],
                'liters': item['liter'],
                // 'fat': 1.0, // default or change as needed
                'session': 'PM', // or AM, depends on time
                'note': item['note']
              })
          .toList();

      if (selectedData.isEmpty) {
        Get.snackbar("No Selection", "Please select at least one customer");
        return;
      }

      try {
        for (var entry in selectedData) {
          final response = await ApiService.post("/bulkEntry", entry);
          final resData = response.data;

          if (resData['success'] == true) {
            print("✅ Saved entry for ${entry['name']}");
          } else {
            print("⚠️ Failed for ${entry['name']}: ${resData['message']}");
          }
        }

        Get.snackbar("Success", "Milk entries saved successfully!");
      } catch (e) {
        print("❌ Error saving entries: $e");
        Get.snackbar("Error", "Something went wrong while saving entries");
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Bulk Entry'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : customers.isEmpty
              ? const Center(child: Text("No customers found"))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(60),
                        1: FixedColumnWidth(70),
                        2: FlexColumnWidth(),
                        3: FixedColumnWidth(80),
                      },
                      children: [
                        // Table Header
                        TableRow(
                          decoration:
                              const BoxDecoration(color: Color(0xFFE0E0E0)),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Select',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('S. No.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Name',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Liter',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
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
