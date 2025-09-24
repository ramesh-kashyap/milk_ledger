import 'package:flutter/material.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

import 'package:intl/intl.dart';
class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  // String startDate = "11 Sep 2025";
  // String endDate = "20 Sep 2025";

 String accountNo = "";
String name = "";
  double previousBalance = 5446.82;
  
@override
void initState() {
  super.initState();
  _fetchDetailsByAcNo();

  // Listen for changes
  
}

 final _formKey = GlobalKey<FormState>();

  final TextEditingController _acNoCtrl = TextEditingController();
  final TextEditingController _codeCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _remarkCtrl = TextEditingController();
int? selectedCustomerId;
  DateTime _billDate = DateTime.now();
  String? _mode;
final TextEditingController _nameCtrl = TextEditingController();
bool _isFormValid = false;
List<Map<String, dynamic>> customers = [];
String? selectedCustomerName;

 Future<void> _fetchDetailsByAcNo() async {
  
   final response = await ApiService.get('/get-code');
print('Response: ${response}');

    try {
   if ( response.data['success'] == true) {
   final fetchedCustomers = List<Map<String, dynamic>>.from(response.data['data']);

      setState(() {
        customers = fetchedCustomers;

        // Set first customer as default
        if (customers.isNotEmpty) {
          accountNo = customers[0]['code'] ?? '';
          name = customers[0]['name'] ?? '';
         
          selectedCustomerId = customers[0]['id'];
          _codeCtrl.text = customers[0]['code'] ?? '';
          _nameCtrl.text = '${customers[0]['name']} (${customers[0]['code']})';
        }
      });
  } else {
    setState(() {
      _codeCtrl.text = '';
      _amountCtrl.text = '';
    });
  }
} catch (e) {
    setState(() {
      _codeCtrl.text = '';
      _amountCtrl.text = '';
    });
  }
  }

String _formatSessionDate(String dateStr, String session) {
  try {
    final parsedDate = DateTime.parse(dateStr);
    final formatted = DateFormat('ddMMM').format(parsedDate); // e.g., 11Sep
    return '$formatted $session';
  } catch (e) {
    return '$dateStr $session';
  }
}




  @override
  void dispose() {
    _acNoCtrl.dispose();
    _codeCtrl.dispose();
    _amountCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }
  String startDate = "11 Sep 2025";
String endDate = "20 Sep 2025";
DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
DateTime _endDate = DateTime.now();

// Date picker for Start Date
void _pickStartDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _startDate,
    firstDate: DateTime(2020),
    lastDate: _endDate,
  );
  if (picked != null) {
    setState(() {
      _startDate = picked;
    });
  }
}

void _pickEndDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _endDate,
    firstDate: _startDate,
    lastDate: DateTime.now(),
  );
  if (picked != null) {
    setState(() {
      _endDate = picked;
    });
  }
}


Future<void> _fetchMilkData(int? customerId) async {
  final response = await ApiService.get('/milk-entries?customer_id=$customerId');
  print('Response: ${response}');

  try {
    if (response.data['success'] == true) {
      final List<dynamic> data = response.data['data'];
      final List<dynamic>  customers = response.data['customer'];
      print('Fetched Milk Data: $customers');
       accountNo = customers[0]['code'] ?? '';
       name = customers[0]['name'] ?? '';
      final filtered = data
          .where((entry) =>
              entry['customer_id'] == customerId &&
              DateTime.parse(entry['date']).isAfter(_startDate.subtract(const Duration(days: 1))) &&
              DateTime.parse(entry['date']).isBefore(_endDate.add(const Duration(days: 1))))
          .map((entry) => {
                "date": _formatSessionDate(entry['date'], entry['session']),
                "milk": double.tryParse(entry['litres'] ?? '0') ?? 0.0,
                "fat": double.tryParse(entry['fat'] ?? '0') ?? 0.0,
                "rate": double.tryParse(entry['rate'] ?? '0') ?? 0.0,
                "amount": double.tryParse(entry['amount'] ?? '0') ?? 0.0,
              })
          .toList();

      setState(() {
        milkData = filtered;
      });

      print('Filtered Milk Data: $milkData');
    } else {
      setState(() {
        milkData = [];
      });
    }
  } catch (e) {
    print('Error fetching milk data: $e');
    setState(() {
      milkData = [];
    });
  }
}


// String get startDate => DateFormat('dd MMM yyyy').format(_startDate);
// String get endDate => DateFormat('dd MMM yyyy').format(_endDate);


// Date picker for End Date


 List<Map<String, dynamic>> milkData = [];

  List<Map<String, dynamic>> billDetail = [
    {"date": "31Aug", "detail": "Previous balance 0.00", "created": "02Sep", "total": 0.00},
  ];

  double get totalBalance =>
      milkData.fold(0.0, (sum, item) => sum + item["amount"]);

  double get totalMilk =>
      milkData.fold(0.0, (sum, item) => sum + item["milk"]);

  double get avgFat =>
      milkData.isEmpty ? 0.0 : milkData.fold(0.0, (s, i) => s + i["fat"]) / milkData.length;

  double get avgRate =>
      milkData.isEmpty ? 0.0 : milkData.fold(0.0, (s, i) => s + i["rate"]) / milkData.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Bill", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.refresh, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.print, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.download, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),

      body: Column(
        children: [
          // Date selector
         Padding(
  padding: const EdgeInsets.all(12),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
     dateBox(DateFormat('dd MMM yyyy').format(_startDate), () => _pickStartDate(context)),
      const Text("to", style: TextStyle(fontSize: 16)),
      dateBox(DateFormat('dd MMM yyyy').format(_endDate), () => _pickEndDate(context)),
    ],
  ),
),
          // Account Info Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    /// Left side (icon + dropdown)
    Row(
      children: [
        const Icon(Icons.person, size: 20),
        const SizedBox(width: 5),

      DropdownButton<int?>(
  value: selectedCustomerId,
  items: customers.map((customer) {
    return DropdownMenuItem<int>(
      value: customer['id'],  // int id
      child: Text('${customer['name']} (${customer['code']})'),
    );
  }).toList(),
  onChanged: (int? value) async{
    setState(() {
      
      selectedCustomerId = value;
      print('Selected Customer ID: $selectedCustomerId');
      final selectedCustomer = customers.firstWhere((c) => c['id'] == value);
      _codeCtrl.text = selectedCustomer['code'] ?? '';
      _nameCtrl.text = '${selectedCustomer['name']} (${selectedCustomer['code']})';
    });
     await _fetchMilkData(selectedCustomerId); 
  },
),

      ],
    ),

    /// Right side (input box)
    SizedBox(
      width: 120,
      child: TextField(
        controller: _codeCtrl,
        keyboardType: TextInputType.number,
          onChanged: (value) async{
      final match = customers.firstWhere(
        (c) => c['code'] == value,
        orElse: () => {},
      );

      if (match.isNotEmpty) {
        setState(() {

          selectedCustomerId = match['id'];
          _nameCtrl.text = '${match['name']} (${match['code']})';
        });
      }else {
        // If code not found, clear selection
        setState(() {
          selectedCustomerId = null;
          _nameCtrl.clear();
        });
      }
       await _fetchMilkData(selectedCustomerId);
    },
        decoration: InputDecoration(
          hintText: "Enter Code",
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
  ],
),

                    const SizedBox(height: 8),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text("Account No. $accountNo"),
                      const Text("Seller"),
                    ]),
                    Text("Name $name"),
                  Row(
      children: [
        Text(DateFormat('dd MMM yyyy').format(_startDate)),
        const SizedBox(width: 8),
        const Text("to", style: TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Text(DateFormat('dd MMM yyyy').format(_endDate)),
      ],
    ),
                    Text("Previous balance   $previousBalance", style: const TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
          ),

          // Content Scrollable
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              children: [
                buildMilkTable(),
                const SizedBox(height: 12),
                buildBillDetail(),
                const SizedBox(height: 12),
                buildGrantTotal(),
                const SizedBox(height: 20),
                const Center(child: Text("abhi milk dairy", style: TextStyle(color: Colors.green))),
              ],
            ),
          ),

          // Bottom green box
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text("Balance Amount:", style: TextStyle(color: Colors.black, fontSize: 16)),
                  Text("₹ ${totalBalance.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                ]),
                const SizedBox(height: 10),
                const Text("0.0", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 15),
                GestureDetector(
                
                  child: Container(
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    child: const Text("Pay Bill",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =================== UI SECTIONS ===================

  Widget buildMilkTable() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        // Header
        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(children: [
            Expanded(child: Center(child: Text("Date", style: headerStyle))),
            Expanded(child: Center(child: Text("Milk", style: headerStyle))),
            Expanded(child: Center(child: Text("Fat", style: headerStyle))),
            Expanded(child: Center(child: Text("Rate", style: headerStyle))),
            Expanded(child: Center(child: Text("Amount", style: headerStyle))),
          ]),
        ),

        // Rows
        ...milkData.map((row) => tableRow(
              row["date"], row["milk"].toString(), row["fat"].toString(),
              row["rate"].toString(), row["amount"].toString())),

        // Footer
        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            Expanded(child: Center(child: Text("Total Milk Detail(${milkData.length})", style: whiteBold))),
            Expanded(child: Center(child: Text(totalMilk.toStringAsFixed(2), style: whiteBold))),
            Expanded(child: Center(child: Text(avgFat.toStringAsFixed(2), style: whiteBold))),
            Expanded(child: Center(child: Text(avgRate.toStringAsFixed(2), style: whiteBold))),
            Expanded(child: Center(child: Text("+${totalBalance.toStringAsFixed(1)}", style: whiteBold))),
          ]),
        ),
      ]),
    );
  }

  Widget buildBillDetail() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(8),
          child: const Center(child: Text("Bill Detail", style: whiteBold)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Row(children: [
            Expanded(child: Center(child: Text("Date", style: boldText))),
            Expanded(child: Center(child: Text("Detail", style: boldText))),
            Expanded(child: Center(child: Text("Created Date", style: boldText))),
            Expanded(child: Center(child: Text("Total", style: boldText))),
          ]),
        ),
        ...billDetail.map((row) => Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
              child: Row(children: [
                Expanded(child: Center(child: Text(row["date"]))),
                Expanded(child: Center(child: Text(row["detail"]))),
                Expanded(child: Center(child: Text(row["created"]))),
                Expanded(child: Center(child: Text(row["total"].toString()))),
              ]),
            )),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: const Text("Total(1)   0.00", style: boldText),
        ),
      ]),
    );
  }

  Widget buildGrantTotal() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(8),
          child: const Center(child: Text("Grant Total", style: whiteBold)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Row(children: [
            Expanded(child: Center(child: Text("Sale", style: boldText))),
            Expanded(child: Center(child: Text("Purchase", style: boldText))),
            Expanded(child: Center(child: Text("Payments", style: boldText))),
            Expanded(child: Center(child: Text("Grant Total", style: boldText))),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(children: [
            Expanded(child: Center(child: Text(totalBalance.toStringAsFixed(2)))),
            const Expanded(child: Center(child: Text("0.00"))),
            const Expanded(child: Center(child: Text("-0.36"))),
            Expanded(child: Center(child: Text(totalBalance.toStringAsFixed(2)))),
          ]),
        ),
      ]),
    );
  }

  // ============== Helpers ==============

  Widget dateBox(String text, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)),
          child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 15)),
        ),
      );

  Widget tableRow(String date, String milk, String fat, String rate, String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Row(children: [
        Expanded(child: Center(child: Text(date))),
        Expanded(child: Center(child: Text(milk))),
        Expanded(child: Center(child: Text(fat))),
        Expanded(child: Center(child: Text(rate))),
        Expanded(child: Center(child: Text(amount))),
      ]),
    );
  }
}

const headerStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
const boldText = TextStyle(fontWeight: FontWeight.bold);
const whiteBold = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
