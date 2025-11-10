import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/dairy_account_setting.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:get_storage/get_storage.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/AuthScreens/login_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool sendReceipt = true;
  bool printSlip = true;
  String selectedLang = "English"; // default language
  String selectedDuration = "Every Month"; // 👈 added default duration

  final box = GetStorage();

  @override
  void initState() {
    super.initState();

    final currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'hi') {
      selectedLang = "Hindi";
    } else if (currentLocale?.languageCode == 'pa') {
      selectedLang = "Punjabi";
    } else {
      selectedLang = "English";
    }
  }

  Future<void> logout() async {
    try {
      final response = await ApiService.post('/logout', {});
      if (response.data['status'] == true) {
        await ApiService.removeToken();
        Get.offAll(() => LogInScreen());
      } else {
        Get.snackbar('Error', response.data['message'] ?? 'Logout failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // ✅ Language Selection Dialog
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
              Get.updateLocale(const Locale('en', 'US'));
              box.write('language', 'en_US');
              Get.back();
            },
            title: const Text("English"),
          ),
          RadioListTile<String>(
            value: "Hindi",
            groupValue: selectedLang,
            onChanged: (val) {
              setState(() => selectedLang = val!);
              Get.updateLocale(const Locale('hi', 'IN'));
              box.write('language', 'hi_IN');
              Get.back();
            },
            title: const Text("हिंदी"),
          ),
          RadioListTile<String>(
            value: "Punjabi",
            groupValue: selectedLang,
            onChanged: (val) {
              setState(() => selectedLang = val!);
              Get.updateLocale(const Locale('pa', 'IN'));
              box.write('language', 'pa_IN');
              Get.back();
            },
            title: const Text("ਪੰਜਾਬੀ"),
          ),
        ],
      ),
      radius: 12,
    );
  }

  // ✅ Duration Popup Dialog
      void _showDurationDialog() {
        final List<int> durations = [5, 10, 15, 30];
        int? selectedDuration = box.read('duration');

        Get.defaultDialog(
          title: "select_duration".tr,
          content: Column(
            children: durations.map((days) {
              return RadioListTile<int>(
                title: Text("$days ${'days'.tr}"),
                value: days,
                groupValue: selectedDuration,
                onChanged: (val) {
                  setState(() {
                    selectedDuration = val;
                    box.write('duration', val); // ✅ store selected duration
                  });
                  Get.back();
                  Get.snackbar(
                    "updated".tr, // 🌐 "Updated" translated
                    "${'duration_set_to'.tr} $val ${'days'.tr}", // 🌐 message translated
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              );
            }).toList(),
          ),
        );
      }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "settings".tr,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            title: "language".tr,
            subtitle: selectedLang,
            onTap: _showLanguageDialog,
          ),

          // 👇 Added duration selection tile
          _buildSettingTile(
            icon: Icons.calendar_today,
            title: "duration".tr,
            subtitle: "${box.read('duration') ?? 5} days",
            onTap: _showDurationDialog,
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
            onTap: () {
              Get.defaultDialog(
                title: "Sign Out".tr,
                middleText: "Are you sure you want to logout?".tr,
                textCancel: "cancel".tr,
                textConfirm: "logout".tr,
                confirmTextColor: Colors.white,
                cancelTextColor: Colors.green,
                buttonColor: Colors.green,
                onConfirm: () async {
                  Get.back();
                  await logout();
                },
                onCancel: () {},
                radius: 12,
              );
            },
          ),
          const SizedBox(height: 20),

          _buildSectionHeader("preferences".tr),
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
              children: const [
                Text("Version", style: TextStyle(color: Colors.grey)),
                Text("0.2.30+60", style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header
  Widget _buildSectionHeader(String text) => Padding(
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

  // Tile
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

  // Switch
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
