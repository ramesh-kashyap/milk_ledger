import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class DairyAccountSettings extends StatefulWidget {
  const DairyAccountSettings({super.key});

  @override
  State<DairyAccountSettings> createState() => _DairyAccountSettingsState();
}

class _DairyAccountSettingsState extends State<DairyAccountSettings> {
  bool isLoading = true;
  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    fetchCustomerDetail();
  }

  /// Fetch single user details
  Future<void> fetchCustomerDetail() async {
    try {
      final response = await ApiService.get('/userDetails');
      final data = response.data;

      if (data['success'] == true && data['data'] != null) {
        setState(() {
          userDetails = data['data']; // single object
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        Get.snackbar("Error ❌", data['message'] ?? "No user details found");
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to fetch user details: $e")),
      );
    }
  }

  /// Update field API call
  Future<void> updateField(String field, String newValue) async {
    try {
      final response = await ApiService.post('/updateUserDetail', {
        field: newValue,
      });

      if (response.data['success'] == true) {
        setState(() {
          userDetails?[field] = newValue;
        });
        Get.snackbar("✅ Success", "$field updated successfully");
      } else {
        Get.snackbar("❌ Error", response.data['message'] ?? "Update failed");
      }
    } catch (e) {
      Get.snackbar("❌ Error", "Failed to update $field: $e");
    }
  }

  /// Show edit dialog
  void _showEditDialog(String field, String currentValue) {
    final controller = TextEditingController(text: currentValue);

    Get.defaultDialog(
        title: "Edit $field",
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter new $field",
            border: OutlineInputBorder(),
          ),
        ),
        cancel: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Cancel button color
          ),
          onPressed: () => Get.back(),
          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
        ),
        confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Save button color
          ),
          onPressed: () {
            if (controller.text.trim().isNotEmpty) {
              updateField(field, controller.text.trim());
            }
            Get.back();
          },
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dairy Account Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[600],
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userDetails == null
              ? const Center(child: Text("No user details available"))
              : ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildInfoCard(
                      icon: Icons.apartment,
                      title: "YOUR DAIRY NAME",
                      fieldKey: "name",
                      value: userDetails?['name'] ?? "N/A",
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.phone,
                      title: "Contact Number",
                      fieldKey: "phone",
                      value: userDetails?['phone'] ?? "N/A",
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.location_on,
                      title: "Address",
                      fieldKey: "address",
                      value: userDetails?['address'] ?? "N/A",
                    ),
                  ],
                ),
    );
  }

  /// Reusable card widget for each field
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required String fieldKey,
  }) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.withOpacity(0.1),
              child: Icon(icon, color: Colors.green),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black54,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green[600], size: 20),
              onPressed: () => _showEditDialog(fieldKey, value),
            ),
          ],
        ),
      ),
    );
  }
}
