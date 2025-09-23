import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/dairy_account_setting.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool sendReceipt = true;
  bool printSlip = true;
  String selectedLang = "English"; // default language

  void _showLanguageDialog() {
    Get.defaultDialog(
      title: "Select Language",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      content: Column(
        children: [
          RadioListTile<String>(
            value: "English",
            groupValue: selectedLang,
            onChanged: (val) {
              setState(() => selectedLang = val!);
              Get.updateLocale(const Locale('en', 'US')); // ✅ change locale
              Get.back();
            },
            title: const Text("English"),
          ),
          RadioListTile<String>(
            value: "Hindi",
            groupValue: selectedLang,
            onChanged: (val) {
              setState(() => selectedLang = val!);
              Get.updateLocale(const Locale('hi', 'IN')); // ✅ change locale
              print("✅ Locale changed to: ${Get.locale}");
              Get.back();
            },
            title: const Text("हिंदी"),
          ),
          RadioListTile<String>(
            value: "Punjabi",
            groupValue: selectedLang,
            onChanged: (val) {
              setState(() => selectedLang = val!);
              Get.updateLocale(const Locale('pa', 'IN')); // ✅ change locale
              Get.back();
            },
            title: const Text("ਪੰਜਾਬੀ"),
          ),

        ],
      ),
      radius: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),


        backgroundColor: Colors.green[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader("general".tr),
          _buildSettingTile(
            icon: Icons.language,
            title: "language".tr,     // ✅ translated
            subtitle: selectedLang, 
            onTap: _showLanguageDialog,
          ),

          _buildSettingTile(
            icon: Icons.calendar_today,
            title: "duration".tr,
            subtitle: "every_month".tr,
            onTap: () {},
          ),

          const SizedBox(height: 20),

          _buildSectionHeader("account".tr),
          _buildSettingTile(
            icon: Icons.account_circle,
            title: "dairy_account_settings".tr,
            subtitle: "dairy_name_address".tr,
            onTap: () {
              Get.to(() => const DairyAccountSettings());
            },
          ),
          _buildSettingTile(
            icon: Icons.delete,
            title: "delete_account".tr,
            iconColor: Colors.red,
            onTap: () {},
          ),
          _buildSettingTile(
            icon: Icons.logout,
            title: "sign_out".tr,
            onTap: () {},
          ),

          const SizedBox(height: 20),

          _buildSectionHeader("Preferences"),
          _buildSwitchTile(
            title: "send_receipt".tr,
            value: sendReceipt,
            onChanged: (val) => setState(() => sendReceipt = val),
          ),
          _buildSwitchTile(
            title: "print_slip".tr,
            value: printSlip,
            onChanged: (val) => setState(() => printSlip = val),
          ),

          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Text(
                  "version".tr,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "0.2.30+60",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section header widget
  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  // Reusable Setting Tile
  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color iconColor = Colors.green,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 28),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }

  // Reusable Switch Tile
  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        activeColor: Colors.white,
        activeTrackColor: Colors.green[600],
      ),
    );
  }
}
