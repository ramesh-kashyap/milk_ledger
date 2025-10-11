import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class DailySaleReportScreen extends StatefulWidget {
  const DailySaleReportScreen({super.key});

  @override
  State<DailySaleReportScreen> createState() => _DailySaleReportScreenState();
}

class _DailySaleReportScreenState extends State<DailySaleReportScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedSession = "Both";
  String selectedMilkType = "Both";
  bool loading = false;

  List<dynamic> allEntries = [];
  List<dynamic> filteredEntries = [];
  List<dynamic> morningEntries = [];
  List<dynamic> eveningEntries = [];

  final List<String> sessionOptions = ["Both", "Morning", "Evening"];
  final List<String> milkTypeOptions = ["Both", "Cow", "Buffalo"];

  @override
  void initState() {
    super.initState();
    fetchAllEntries();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _applyFilters();
      });
    }
  }

  Future<void> fetchAllEntries() async {
    setState(() => loading = true);
    try {
      final res = await ApiService.get('/dairysale');
      allEntries = res.data['entries'] ?? [];
      _applyFilters();
    } catch (e) {
      print("Error fetching entries: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  void _applyFilters() {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

    // Filter base list (date + milk type)
    List<dynamic> dateFiltered = allEntries.where((entry) {
      final entryDate = DateTime.parse(entry['createdAt']);
      final entryDateStr = DateFormat('yyyy-MM-dd').format(entryDate);
      bool dateMatch = entryDateStr == dateStr;

      bool milkTypeMatch = selectedMilkType == "Both" ||
          entry['animal'].toString().toLowerCase() ==
              selectedMilkType.toLowerCase();

      return dateMatch && milkTypeMatch;
    }).toList();

    // Separate AM and PM
    morningEntries = dateFiltered
        .where((e) => e['session'].toString().toUpperCase() == "AM")
        .toList();
    eveningEntries = dateFiltered
        .where((e) => e['session'].toString().toUpperCase() == "PM")
        .toList();

    // If “Both”, show all; otherwise filter by selected session
    if (selectedSession == "Morning") {
      filteredEntries = morningEntries;
    } else if (selectedSession == "Evening") {
      filteredEntries = eveningEntries;
    } else {
      filteredEntries = dateFiltered;
    }

    setState(() {});
  }

  Widget _buildHeaderRow() => Container(
        color: Colors.green[400],
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: [
            Expanded(flex: 1, child: Text("ac_no".tr, style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text("milk".tr, style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text("fat".tr, style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text("rate".tr, style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text("amount".tr, style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      );

  Widget _buildEntryRow(Map entry) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: Row(
          children: [
            Expanded(flex: 1, child: Text("${entry['customer_id'] ?? '0'}")),
            Expanded(flex: 1, child: Text("${entry['litres'] ?? '0'}")),
            Expanded(flex: 1, child: Text("${entry['fat'] ?? '0'}")),
            Expanded(flex: 1, child: Text("${entry['rate'] ?? '0'}")),
            Expanded(flex: 1, child: Text("${entry['amount'] ?? '0'}")),
          ],
        ),
      );

  Widget _buildListSection(String title, List<dynamic> list) {
    final totalLitres = list.fold<double>(
        0, (sum, e) => sum + double.parse(e['litres'] ?? "0"));
    final totalFat =
        list.fold<double>(0, (sum, e) => sum + double.parse(e['fat'] ?? "0"));
    final totalRate =
        list.fold<double>(0, (sum, e) => sum + double.parse(e['rate'] ?? "0"));
    final totalAmount = list.fold<double>(
        0, (sum, e) => sum + double.parse(e['amount'] ?? "0"));

    return Card(
      margin: const EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            const SizedBox(height: 8),
            _buildHeaderRow(),
            ...list.map((e) => _buildEntryRow(e)).toList(),
            Container(
              color: Colors.green[400],
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text("total".tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text("$totalLitres")),
                  Expanded(flex: 1, child: Text("$totalFat")),
                  Expanded(flex: 1, child: Text("$totalRate")),
                  Expanded(flex: 1, child: Text("₹ $totalAmount")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text("daily_sale_report".tr,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: fetchAllEntries,
              icon: const Icon(Icons.refresh, color: Colors.white))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InkWell(
              onTap: _pickDate,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedSession,
                    decoration: InputDecoration(labelText: "session".tr),
                    items: sessionOptions
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.tr)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSession = value!;
                        _applyFilters();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedMilkType,
                    decoration: InputDecoration(labelText: "milk_type".tr),
                    items: milkTypeOptions
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.tr)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMilkType = value!;
                        _applyFilters();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : selectedSession == "Both"
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildListSection("Morning Data (AM)", morningEntries),
                              _buildListSection("Evening Data (PM)", eveningEntries),
                            ],
                          ),
                        )
                      : filteredEntries.isEmpty
                          ? Center(child: Text("no_entries".tr))
                          : SingleChildScrollView(
                              child: _buildListSection(
                                  selectedSession == "Morning"
                                      ? "Morning Data (AM)"
                                      : "Evening Data (PM)",
                                  filteredEntries),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
