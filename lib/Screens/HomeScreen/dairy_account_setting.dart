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
        Get.snackbar("error".tr, data['message'] ?? "no_user_details".tr);
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("error_fetch_user".trParams({'error': e.toString()}))),
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
        Get.snackbar("success".tr, "$field ${'update_success'.tr}");
      } else {
        Get.snackbar("error".tr, response.data['message'] ?? "update_failed".tr);
      }
    } catch (e) {
      Get.snackbar("error".tr, "update_failed_field".trParams({'field': field, 'error': e.toString()}));
    }
  }

  /// Show edit dialog
  void _showEditDialog(String field, String currentValue) {
    final controller = TextEditingController(text: currentValue);

    Get.defaultDialog(
        title: "${'edit'.tr} $field",
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "${'enter_new'.tr} $field",
            border: OutlineInputBorder(),
          ),
        ),
        cancel: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Cancel button color
          ),
          onPressed: () => Get.back(),
          child: Text("cancel".tr, style: const TextStyle(color: Colors.white)),
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
          child: Text("save".tr, style: const TextStyle(color: Colors.white)),
        ),
      );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "dairy_account_settings".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[600],
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userDetails == null
              ? Center(child: Text("no_user_details".tr))
              : ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildInfoCard(
                      icon: Icons.apartment,
                      title: "your_dairy_name".tr,
                      fieldKey: "name",
                      value: userDetails?['name'] ?? "N/A",
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.phone,
                      title: "contact_number".tr,
                      fieldKey: "phone",
                      value: userDetails?['phone'] ?? "N/A",
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.location_on,
                      title: "address".tr,
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
    bool isEditable = !(fieldKey == "phone" || fieldKey == "address");
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
          if (isEditable)
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
