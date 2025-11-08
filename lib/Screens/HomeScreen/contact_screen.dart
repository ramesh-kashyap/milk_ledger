import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart'; // ✅ Ensure correct class name

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  Map<String, dynamic>? adminDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAdminDetails();
  }

  Future<void> fetchAdminDetails() async {
    try {
      final response = await ApiService.get('/getDetail'); // Dio Response
      print(response);
      final data = response.data; // ✅ Extract actual JSON

      if (data['success'] == true && data['data'] != null) {
        setState(() {
          adminDetails = data['data'];
        });
      }
    } catch (e) {
      print("Error fetching admin details: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fff7),
      appBar: AppBar(
        title: Text('contact_us'.tr, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade600,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : adminDetails == null
              ? const Center(child: Text("Failed to load admin details"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Header
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
                            const Icon(Icons.support_agent, color: Colors.white, size: 60),
                            const SizedBox(height: 10),
                            Text('we_are_here'.tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text('get_in_touch'.tr,
                                style: const TextStyle(color: Colors.white70, fontSize: 14)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Phone
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.phone, color: Colors.green),
                          title: Text('phone'.tr),
                          subtitle: Text('${adminDetails?['phone'] ?? 'N/A'}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Email
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.email, color: Colors.green),
                          title: Text('email'.tr),
                          subtitle: Text('${adminDetails?['email'] ?? 'N/A'}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Address
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.location_on, color: Colors.green),
                          title: Text('address'.tr),
                          subtitle: Text('${adminDetails?['address'] ?? 'N/A'}'),

                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
