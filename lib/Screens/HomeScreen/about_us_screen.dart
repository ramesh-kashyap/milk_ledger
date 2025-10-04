import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fff7),
      appBar: AppBar(
        title: const Text(
          "About Us",
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
                  Icon(Icons.info_outline, color: Colors.white, size: 60),
                  SizedBox(height: 10),
                  Text(
                    "About Our Dairy App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Manage your dairy business with ease!",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // About Description
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "This Dairy Management App helps dairy owners to record milk entries, manage customers, generate bills, track payments, and view detailed reports. "
                  "Our goal is to simplify dairy operations and bring digital convenience to farmers and dairy businesses.",
                  style: TextStyle(fontSize: 14, height: 1.4),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Mission Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.flag, color: Colors.green),
                title: Text(
                  "Our Mission",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "To empower dairy farmers and business owners with simple and powerful digital tools.",
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Vision Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.visibility, color: Colors.green),
                title: Text(
                  "Our Vision",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "To create a smart dairy ecosystem where technology helps every farmer grow.",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
