import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
class DeleteMilkEntriesScreen extends StatefulWidget {
  const DeleteMilkEntriesScreen({super.key});

  @override
  State<DeleteMilkEntriesScreen> createState() => _DeleteMilkEntriesScreenState();
}

class _DeleteMilkEntriesScreenState extends State<DeleteMilkEntriesScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedSession = "both";
  String selectedMilkType = "both";
  bool loading = false;

  List<Map<String, dynamic>> _allEntries = [];
  List<Map<String, dynamic>> _filtered = [];

  final List<String> sessionOptions = ["both", "morning", "evening"];
  final List<String> milkTypeOptions = ["both", "cow", "buffalo"];

  @override
  void initState() {
    super.initState();
    fetchAllEntries();
  }

 Future<void> fetchAllEntries() async {
  setState(() => loading = true);
  try {
    final res = await ApiService.get('/recent-milk-entries');
    print(res.data);

    // ✅ Corrected: Access 'data', not 'entries'
    final List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.from(res.data['data'] ?? []);

    setState(() => _allEntries = items);
    _applyFilters();
    //  setState(() {
    //   _allEntries = items;
    //   _filtered = items; // show all data initially
    // });
  } catch (e) {
    Get.snackbar(
      'Error',
      'Failed to load entries\n$e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade50,
      colorText: Colors.red.shade900,
    );
  } finally {
    setState(() => loading = false);
  }
}


  void _applyFilters() {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

    setState(() {
      _filtered = _allEntries.where((entry) {
        final entryDate = DateTime.parse(entry['createdAt']);
        final entryDateStr = DateFormat('yyyy-MM-dd').format(entryDate);

        final sessionMatch = selectedSession == 'both' ||
            entry['session'].toString().toLowerCase() ==
                (selectedSession == 'morning' ? 'am' : 'pm');

        final milkMatch = selectedMilkType == 'both' ||
            entry['animal'].toString().toLowerCase() ==
                selectedMilkType.toLowerCase();

        return entryDateStr == dateStr && sessionMatch && milkMatch;
      }).toList();
    });
  }

  Future<void> _deleteEntry(Map<String, dynamic> entry) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('delete_entry'.tr),
        content: Text('Delete entry ID: ${entry['id']}? ${'cannot_undo'.tr}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('cancel'.tr)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('delete'.tr, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (ok != true) return;

    try {
      final res = await ApiService.post('/deleteMilkEntry', {'id': entry['id']});
  final data = res.data; // 👈 Extract the actual JSON body

  // 🧠 Check backend response
  if (data['status'] == true) {
    setState(() => _filtered.remove(entry));

    Get.snackbar(
      'Deleted',
      data['message'] ?? 'Entry removed successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade50,
      colorText: Colors.green.shade900,
    );
  } else {
    // ❌ Backend returned failure
    Get.snackbar(
      'Failed',
      data['message'] ?? 'Unable to delete entry',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade50,
      colorText: Colors.red.shade900,
    );
  }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete\n$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade50,
          colorText: Colors.red.shade900);
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
      _applyFilters();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('delete_milk_entries'.tr,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: fetchAllEntries),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'en') Get.updateLocale(const Locale('en', 'US'));
              if (v == 'hi') Get.updateLocale(const Locale('hi', 'IN'));
              if (v == 'pa') Get.updateLocale(const Locale('pa', 'IN'));
            },
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'hi', child: Text('हिंदी')),
              const PopupMenuItem(value: 'pa', child: Text('ਪੰਜਾਬੀ')),
            ],
            icon: const Icon(Icons.language, color: Colors.white),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: _pickDate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green, width: 1.5),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, color: Colors.green),
                              const SizedBox(width: 12),
                              Text(DateFormat('yyyy-MM-dd').format(selectedDate),
                                  style: const TextStyle(fontSize: 16)),
                              const Spacer(),
                              const Icon(Icons.arrow_drop_down, color: Colors.green),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedSession,
                              decoration: InputDecoration(labelText: 'session'.tr),
                              items: sessionOptions
                                  .map((e) =>
                                      DropdownMenuItem(value: e, child: Text(e.tr)))
                                  .toList(),
                              onChanged: (v) {
                                setState(() => selectedSession = v!);
                                _applyFilters();
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedMilkType,
                              decoration: InputDecoration(labelText: 'milk_type'.tr),
                              items: milkTypeOptions
                                  .map((e) =>
                                      DropdownMenuItem(value: e, child: Text(e.tr)))
                                  .toList(),
                              onChanged: (v) {
                                setState(() => selectedMilkType = v!);
                                _applyFilters();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _filtered.isEmpty
                      ? Center(child: Text('no_entries_found'.tr))
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 100),
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (ctx, i) {
                            final e = _filtered[i];
                            final id = e['id']?.toString() ?? '?';
                            final animal = e['Customer']['code']?.toString() ?? '0';
                            final fat = e['animal']?.toString() ?? '0';
                            final rate = e['rate']?.toString() ?? '0';
                            final amount = e['amount']?.toString() ?? '0';
                            final litres = e['Customer']['name']?.toString() ?? '';
                            final session = e['session']?.toString() ?? '';

                            return Dismissible(
                              key: ValueKey(id + i.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.delete_outline, color: Colors.red),
                              ),
                              confirmDismiss: (_) async {
                                await _deleteEntry(e);
                                return false;
                              },
                           child: Card(
  elevation: 0.5,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14),
  ),
  child: ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    leading: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.green.shade100,
      child: Text(
        session.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    ),

    // 👇 Custom title row
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${animal.toUpperCase()}  $litres',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          '₹$amount',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),

    // 👇 Subtitle below
    subtitle: Text(
      '${fat.toUpperCase()}  Rate: ₹$rate',
      style: const TextStyle(
        fontSize: 13,
        color: Colors.grey,
      ),
    ),

  trailing: PopupMenuButton<String>(
  tooltip: 'Options',
  onSelected: (v) async {
    if (v == 'delete') {
      await _deleteEntry(e);
    } else if (v == 'share') {
        final phone = e['Customer']['phone']?.toString() ?? '';
      final name = e['Customer']['name']?.toString() ?? 'Unknown';
      final litres = e['litres']?.toString() ?? '0';
      final amount = e['amount']?.toString() ?? '0';
      final session = e['session']?.toString().toUpperCase() ?? '';
      final animal = e['animal']?.toString().toUpperCase() ?? '';

      
    if (phone.isNotEmpty) {
        // ✅ Create the WhatsApp message
        final message = Uri.encodeComponent('''
Hello $name 👋,

 Animal: $animal
 Session: $session
 Litres: $litres L
 Amount: ₹$amount

Thank you!
''');

        // ✅ Format WhatsApp URL (include country code)
        // ✅ Try both schemes for Android + iOS
        final Uri whatsapp = Uri.parse("whatsapp://send?phone=91$phone&text=$message");
        
            try {
      // Try WhatsApp first
      await launchUrl(whatsapp, mode: LaunchMode.externalApplication);
    } catch (e) {
      // ⚠️ If WhatsApp not available, fallback to SMS
      final Uri sms = Uri.parse("sms:91$phone?body=$message");

      try {
        await launchUrl(sms, mode: LaunchMode.externalApplication);
      } catch (e2) {
        Get.snackbar(
          'Error',
          'Could not open WhatsApp or SMS app.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade50,
          colorText: Colors.red.shade900,
        );
      }
    }
       
       
      }
    }
  },
  itemBuilder: (_) {
    final phone = e['Customer']['phone']?.toString();

    // build popup items dynamically
    List<PopupMenuEntry<String>> items = [];

    // show share only if phone exists
    if (phone != null && phone.isNotEmpty) {
      items.add(
        const PopupMenuItem(
          value: 'share',
          child: Row(
            children: [
              Icon(Icons.share, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Text('Share'),
            ],
          ),
        ),
      );
    }

    // always show delete
    items.add(
      const PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.red, size: 20),
            SizedBox(width: 8),
            Text('Delete'),
          ],
        ),
      ),
    );

    return items;
  },
  icon: const Icon(Icons.more_vert),
),


  ),
),
  
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
