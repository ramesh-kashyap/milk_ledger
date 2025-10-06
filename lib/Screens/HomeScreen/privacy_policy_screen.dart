import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fff7),
      appBar: AppBar(
        title: Text(
          'privacy_policy'.tr,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade600,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.privacy_tip, color: Colors.white, size: 60),
                  SizedBox(height: 10),
                  Text(
                    'our_privacy_policy'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'privacy_message'.tr,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Introduction
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'intro_privacy'.tr,
                  style: TextStyle(fontSize: 14, height: 1.4),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Data Collection
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.cloud_download, color: Colors.green),
                title: Text(
                  'data_collection'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                'data_collection_desc'.tr, 
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Data Usage
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.security, color: Colors.green),
                title: Text(
                  'data_usage'.tr, 
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                 'data_usage_desc'.tr,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Data Protection
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.lock, color: Colors.green),
                title: Text(
                 'data_protection'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                 'data_protection_desc'.tr,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Contact Info
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.contact_mail, color: Colors.green),
                title: Text(
                  'contact_us'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                 'contact_us_desc'.tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
