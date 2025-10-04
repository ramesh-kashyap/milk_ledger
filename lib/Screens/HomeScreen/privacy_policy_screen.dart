import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fff7),
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
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
                children: const [
                  Icon(Icons.privacy_tip, color: Colors.white, size: 60),
                  SizedBox(height: 10),
                  Text(
                    "Our Privacy Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Your privacy and data security are important to us.",
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
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "This Privacy Policy describes how our Dairy App collects, uses, and protects your personal information. By using our app, you agree to the terms outlined here.",
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
              child: const ListTile(
                leading: Icon(Icons.cloud_download, color: Colors.green),
                title: Text(
                  "Data Collection",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "We may collect information such as your name, phone number, email address, and usage details to improve our services.",
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Data Usage
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.security, color: Colors.green),
                title: Text(
                  "Data Usage",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Your data is used only to provide better features, customer support, and personalized services. We do not sell your information.",
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Data Protection
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.lock, color: Colors.green),
                title: Text(
                  "Data Protection",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "We use secure methods to protect your personal data and ensure it is not misused or accessed by unauthorized parties.",
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Contact Info
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.contact_mail, color: Colors.green),
                title: Text(
                  "Contact Us",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "If you have any questions about this Privacy Policy, please contact us at support@yourdairy.com.",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
