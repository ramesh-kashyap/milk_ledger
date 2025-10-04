import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fff7),
      appBar: AppBar(
        title: const Text(
          "Contact Us",
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.green.shade600,
        elevation: 0,
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
                  Icon(Icons.support_agent, color: Colors.white, size: 60),
                  SizedBox(height: 10),
                  Text(
                    "We’re here to help you!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Get in touch with us anytime.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Contact Options
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text("Phone"),
                subtitle: const Text("+91 9876543210"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // handle phone call
                },
              ),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.green),
                title: const Text("Email"),
                subtitle: const Text("support@yourdairy.com"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // handle email
                },
              ),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.green),
                title: const Text("Address"),
                subtitle: const Text("123 Dairy Street, Village, India"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // open maps
                },
              ),
            ),
            const SizedBox(height: 20),

            // Social Media (Replaced with simple icons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.message, color: Colors.green, size: 30), // WhatsApp
                SizedBox(width: 20),
                Icon(Icons.facebook, color: Colors.blue, size: 30), // Facebook
                SizedBox(width: 20),
                Icon(Icons.camera_alt, color: Colors.purple, size: 30), // Instagram
              ],
            )
          ],
        ),
      ),
    );
  }
}
