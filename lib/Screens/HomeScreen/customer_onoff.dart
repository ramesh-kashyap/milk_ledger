import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class CustomerOnOffScreen extends StatefulWidget {
  const CustomerOnOffScreen({super.key});

  @override
  State<CustomerOnOffScreen> createState() => _CustomerOnOffScreenState();
}

class _CustomerOnOffScreenState extends State<CustomerOnOffScreen> {
  List<Map<String, dynamic>> customers = []; // ✅ multiple users
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCustomerDetail();
  }

  /// Fetch all customers
  Future<void> fetchCustomerDetail() async {
    try {
      final response = await ApiService.get('/userOn'); 
      final data = response.data;

      if (data['status'] == true && data['customer'] != null) {
              setState(() {
                customers = (data['customer'] as List).map((c) {
                      return {
                        "id": c['id'].toString(),
                        "name": c['name'],
                        "active": c['active_status'] == 1, // or set default false
                      };
                    }).toList();
                isLoading = false;
              });
            }
      else {
        setState(() => isLoading = false);
        Get.snackbar("Error ❌", data['message'] ?? "No customers found");
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to fetch customers: $e")),
      );
    }
  }

  /// Update active/inactive status for one customer
  Future<void> updateCustomerStatus(String id, bool active) async {
    final payload = {"id": id, "active": active ? 1 : 0};

    try {
      final res = await ApiService.post('/onCustomer', payload);

      if (res.data['status'] == true) {
        // Get.snackbar("Success ✅", "Status updated successfully");
      } else {
        // rollback UI if failed
        setState(() {
          final index = customers.indexWhere((c) => c["id"] == id);
          if (index != -1) customers[index]["active"] = !active;
        });
        // Get.snackbar("Update Failed ❌", res.data['message']);
      }
    } catch (e) {
      // rollback UI on error
      setState(() {
        final index = customers.indexWhere((c) => c["id"] == id);
        if (index != -1) customers[index]["active"] = !active;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error updating status: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          "Customer On/Off",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.search, color: Colors.white),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : customers.isEmpty
              ? const Center(child: Text("No customers found"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.green.shade700, width: 1),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          child: const Icon(Icons.person, color: Colors.green),
                        ),
                        title: Text(
                          customer["name"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "ID: ${customer["id"]}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Switch(
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                          value: customer["active"],
                          onChanged: (val) {
                            setState(() => customer["active"] = val);
                            updateCustomerStatus(customer["id"], val);
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
