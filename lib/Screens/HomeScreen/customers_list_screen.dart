import 'dart:convert';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/add_customer_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersListScreen extends StatefulWidget {
  const CustomersListScreen({Key? key}) : super(key: key);

  @override
  State<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  bool _loading = true;
  List<dynamic> _all = [];
  List<dynamic> _sellers = [];
  List<dynamic> _purchasers = [];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);

    try {
      // 🔹 Use list endpoint with filter in body
      final sellersRes =
          await ApiService.post('/customers/list', {"type": "Seller"});
      final purchasersRes =
          await ApiService.post('/customers/list', {"type": "Purchaser"});

      // 🔹 Always read .items from response
      final sellersRes2 = sellersRes.data;
      final purchasersRe2 = purchasersRes.data;
      final sellers =
          List<Map<String, dynamic>>.from(sellersRes2['items'] ?? []);
      final purchasers =
          List<Map<String, dynamic>>.from(purchasersRe2['items'] ?? []);

      setState(() {
        _sellers = sellers;
        _purchasers = purchasers;
        _all = [...sellers, ...purchasers];
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load customers\n$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade900,
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _addCustomerFlow() async {
    // Ask for type first
    final type = await _selectCustomerType(context);
    if (type == null) return;

    final saved = await Get.to(() => AddCustomerScreen(customerType: type));
    if (saved != null) _load();
  }

  Future<String?> _selectCustomerType(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Customer Type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.sell, color: Colors.green),
              title: const Text('Seller'),
              onTap: () => Navigator.pop(ctx, 'Seller'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.blue),
              title: const Text('Purchaser'),
              onTap: () => Navigator.pop(ctx, 'Purchaser'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _TableView(title: 'All', data: _all),
      _TableView(title: 'Sellers', data: _sellers),
      _TableView(title: 'Purchasers', data: _purchasers),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addCustomerFlow,
            tooltip: 'Add',
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {}, // hook up later
            tooltip: 'Print',
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(28),
            ),
            child: TabBar(
              controller: _tab,
              isScrollable: false,
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              indicator: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.25),
                    blurRadius: 10,
                    // offset: const Offset(0, 4),
                  ),
                ],
              ),
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Sellers'),
                Tab(text: 'Purchasers'),
              ],
            ),
          ),

          // Info line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Sellers: Those who sell milk to you. Buyers: Those to whom you sell milk',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87.withOpacity(.8)),
            ),
          ),

          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tab,
                    children: tabs,
                  ),
          ),
        ],
      ),
    );
  }
}

/// Bordered table like the screenshot
class _TableView extends StatelessWidget {
  final String title;
  final List<dynamic> data;
  const _TableView({Key? key, required this.title, required this.data})
      : super(key: key);

  TableRow _headerRow() {
    Widget cell(String t) => Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            t,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        );
    return TableRow(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black87, width: 1)),
      children: [
        cell('S. No.'),
        cell('Name'),
        cell('Mobile Number'),
      ],
    );
  }

  TableRow _dataRow(int index, Map c) {
    Widget cell(String? t, {TextAlign align = TextAlign.left}) => Padding(
          padding: const EdgeInsets.all(12),
          child: Text(t ?? '',
              textAlign: align,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
        );

    return TableRow(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black87, width: .8)),
      children: [
        cell(c['code']?.toString()),
        cell(c['name']?.toString()),
        cell(c['phone']?.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Table(
          // full borders like screenshot
          border: TableBorder.all(color: Colors.black87, width: 1),
          columnWidths: const {
            0: FixedColumnWidth(90), // S. No.
            1: FlexColumnWidth(2), // Name
            2: FlexColumnWidth(2), // Mobile
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _headerRow(),
            if (data.isEmpty)
              TableRow(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87, width: .8)),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text('—', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text('No records', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text('—', textAlign: TextAlign.center),
                  ),
                ],
              ),
            ...List.generate(
              data.length,
              (i) => _dataRow(i, Map<String, dynamic>.from(data[i])),
            ),
          ],
        ),
      ),
    );
  }
}
