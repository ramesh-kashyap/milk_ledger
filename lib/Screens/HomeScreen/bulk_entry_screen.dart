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
          print("📦 Parsed Response Data: $resData");
          if (resData != null &&
              resData['success'] == true &&
              resData['customers'] != null) {
            final List<dynamic> data = resData['customers'];

            setState(() {
              customers = data
                  .map((c) => {
                        'sno': c['code'] ?? '',
                        'name': c['name'] ?? '',
                        'liter': c['default_value'] ?? '',
                        'selected': false,
                        'note': c['customer_type'] ?? '',
                      })
                  .toList();
            });
          } else {
            Get.snackbar("no_customers".tr, resData?['message'] ?? "no_data_found".tr);
          }
        } catch (e) {
          print("❌ Error fetching customers: $e");
          Get.snackbar("error".tr, "failed_to_load_customers".tr);
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
        Get.snackbar("no_selection".tr, "please_select_customer".tr);
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

        Get.snackbar("success".tr, "milk_entries_saved".tr);
      } catch (e) {
        print("❌ Error saving entries: $e");
        Get.snackbar("error".tr, "something_went_wrong".tr);
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text(
          'bulk_entry'.tr,
          style: TextStyle(color: Colors.white), // ✅ white text
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : customers.isEmpty
              ?  Center(child: Text("no_customers_found".tr))
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
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('select'.tr,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('s_no'.tr,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('name'.tr,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('liter'.tr,
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
                                    customers[i]['liter'] = double.tryParse(val) ?? 0;
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: TextEditingController(
                                    text: customers[i]['liter']?.toString() ?? '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20), // bottom 20 gives extra space
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _saveData,
                  child: Text(
                    'save'.tr,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),

    );
  }
}
