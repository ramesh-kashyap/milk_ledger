import 'package:flutter/material.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:get/get.dart';
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
  String customerType = "";
    String type = "";
@override
void initState() {
  super.initState();

  _fetchDetailsByAcNo().then((_) async {
    if (customers.isNotEmpty) {
      final first = customers.first;

      setState(() {
        selectedCustomerId = first['id'];
        _codeCtrl.text = first['code'] ?? '';
        _nameCtrl.text = '${first['name']} (${first['code']})';
        accountNo = first['code'] ?? '';
        name = first['name'] ?? '';
        customerType = first['customerType'] ?? '';

        final createdAtStr = first['createdAt'];
        if (createdAtStr != null && createdAtStr.isNotEmpty) {
          try {
            _startDate = DateTime.parse(createdAtStr);
          } catch (_) {
            _startDate = DateTime.now().subtract(const Duration(days: 30));
          }
        } else {
          _startDate = DateTime.now().subtract(const Duration(days: 30));
        }
        _endDate = DateTime.now();
      });

      // fetch all milk, product, payment data
      await _fetchMilkData(selectedCustomerId);
    }
  });
}


 final _formKey = GlobalKey<FormState>();

  final TextEditingController _acNoCtrl = TextEditingController();
  final TextEditingController _codeCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
   final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarkCtrl = TextEditingController();
  List<Map<String, dynamic>> payments = [];
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
         customerType = customers[0]['customerType'] ?? '';
          selectedCustomerId = customers[0]['id'];
          _codeCtrl.text = customers[0]['code'] ?? '';
          _nameCtrl.text = '${customers[0]['name']} (${customers[0]['code']})';
          
           final String? createdAtStr = customers[0]['createdAt'];
  if (createdAtStr != null && createdAtStr.isNotEmpty) {
    try {
      _startDate = DateTime.parse(createdAtStr);
    } catch (e) {
      print('Invalid createdAt format: $createdAtStr');
      _startDate = DateTime.now().subtract(const Duration(days: 30)); // fallback
    }
  } else {
    _startDate = DateTime.now().subtract(const Duration(days: 30)); // fallback
  }

  _endDate = DateTime.now();

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

Future<void> _createPayment(String type) async {
  if (selectedCustomerId == null || _amountController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Select a customer and enter an amount")),
    );
    return;
  }
  print('Creating payment of type: $type for customer ID: $selectedCustomerId');

  final double? amount = double.tryParse(_amountController.text);
  if (amount == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Enter a valid amount")),
    );
    return;
  }

  try {
    final response = await ApiService.post('/create-payment', {
      'amount': amount,
      'type': type, // use the determined type
      'customerId': selectedCustomerId,
    });

    if (response.data['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment recorded successfully")),
      );

      // Clear input after success
      _amountController.clear();

      // Refresh milk data if needed
      await _fetchMilkData(selectedCustomerId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['message'] ?? "Payment failed")),
      );
    }
  } catch (e) {
    print('Error creating payment: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Server Error")),
    );
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
      await _fetchMilkData(selectedCustomerId);
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
    await _fetchMilkData(selectedCustomerId);
  }
}

Future<void> _fetchMilkData(int? customerId) async {
  if (customerId == null) return;

  try {
    final response = await ApiService.get('/milk-entries?customer_id=$customerId');
    print('Response: $response');

    if (response.data['success'] != true) {
      setState(() {
        milkData = [];
        productTransactions = [];
        payments = [];
      });
      return;
    }

    final List<dynamic> milkList = response.data['data'] ?? [];
    final List<dynamic> customerList = response.data['customer'] ?? [];
    final List<dynamic> paymentList = response.data['payment'] ?? [];
    final List<dynamic> productList = response.data['productTransactions'] ?? [];

    // Update customer info
    if (customerList.isNotEmpty) {
      final customer = customerList[0];
      setState(() {
        accountNo = customer['code'] ?? '';
        name = customer['name'] ?? '';
        customerType = customer['customerType'] ?? '';
      });
    }

    // Normalize start & end dates (ignore time)
  final start = DateTime(_startDate.year, _startDate.month, _startDate.day);
final end = DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59);
   print("Start: $start, End: $end");
    // Filter milk data
    final filteredMilk = milkList.where((entry) {
     DateTime entryDate = DateTime.parse(entry['date']).toLocal();
  entryDate = DateTime(entryDate.year, entryDate.month, entryDate.day);
  return entry['customer_id'] == customerId &&
         !entryDate.isBefore(start) && 
         !entryDate.isAfter(end);
    }).map((entry) => {
      "date": _formatSessionDate(entry['date'], entry['session']),
      "milk": double.tryParse(entry['litres']?.toString() ?? '0') ?? 0.0,
      "fat": double.tryParse(entry['fat']?.toString() ?? '0') ?? 0.0,
      "rate": double.tryParse(entry['rate']?.toString() ?? '0') ?? 0.0,
      "amount": double.tryParse(entry['amount']?.toString() ?? '0') ?? 0.0,
      "status": entry['status']?.toString() ?? 'inactive',
    }).toList();

    // Filter product transactions
    final filteredProducts = productList.where((entry) {
      DateTime entryDate = DateTime.parse(entry['bill']);
      entryDate = DateTime(entryDate.year, entryDate.month, entryDate.day);
      return entry['customer_id'] == customerId &&
             !entryDate.isBefore(start) &&
             !entryDate.isAfter(end);
    }).map((entry) => {
      "date": _formatSessionDate(entry['bill'], ''),
      "product": entry['product_name']?.toString() ?? '',
      "quantity": double.tryParse(entry['quantity']?.toString() ?? '0') ?? 0.0,
      "amount": double.tryParse(entry['amount']?.toString() ?? '0') ?? 0.0,
      "status": entry['status']?.toString() ?? 'inactive',
      "t_type": entry['t_type']?.toString() ?? 'inactive',
    }).toList();

    // Update state
    setState(() {
      milkData = filteredMilk;
      productTransactions = filteredProducts;
      payments = List<Map<String, dynamic>>.from(paymentList);
    });

    print('Filtered Milk Data: $milkData');
    print('Filtered Product Data: $productTransactions');
  } catch (e) {
    print('Error fetching milk data: $e');
    setState(() {
      milkData = [];
      productTransactions = [];
      payments = [];
    });
  }
}



// String get startDate => DateFormat('dd MMM yyyy').format(_startDate);
// String get endDate => DateFormat('dd MMM yyyy').format(_endDate);


// Date picker for End Date


 List<Map<String, dynamic>> milkData = [];
 List<Map<String, dynamic>> productTransactions = [];
  List<Map<String, dynamic>> billDetail = [
    {"date": "31Aug", "detail": "Previous balance 0.00", "created": "02Sep", "total": 0.00},
  ];

  double get totalBalance =>
      milkData.fold(0.0, (sum, item) => sum + item["amount"]);

double get totalProduct =>
    productTransactions.fold(0.0, (sum, item) {
      // make sure we are always working with a double
      final amount = double.tryParse(item['amount'].toString()) ?? 0.0;
      print('Processing item: $item with amount: $amount');
      // normalize the type (fix capital letters / spaces)
      final type = (item['t_type'] ?? '')
          .toString()
          .trim()               // remove spaces before/after
          .toLowerCase();       // convert to lower case
        print('Normalized type: $type');
      if (type == 'sale') {
        print('Subtracting for sale: $amount');
        return sum - amount;      // subtract for sale
      } else if (type == 'purchase') {
        print('Adding for purchase: $amount');
        return sum + amount;      // add for purchase
      } else {
        return sum;               // ignore unknown
      }
    });



double get totalSBalance {
  if (customerType == 'Seller') {
    return milkData.fold(0.0, (sum, item) => sum + (item["amount"] ?? 0.0));
  }
  return 0.0; // fallback if not Seller
}

double get totalPBalance {
  if (customerType != 'Seller') {
    return milkData.fold(0.0, (sum, item) => sum - (item["amount"] ?? 0.0));
  }
  return 0.0; // fallback if Seller
}

double get totalReceive {
  // sum of payments received (type: receive)
  return payments.fold(0.0, (sum, item) {
    if (item['type'] == 'receive') {
      return sum + (double.tryParse(item['amount'].toString()) ?? 0.0);
    }
    return sum;
  });
}

double get totalPay {
  // sum of payments made (type: pay)
  return payments.fold(0.0, (sum, item) {
    if (item['type'] == 'pay') {
      return sum + (double.tryParse(item['amount'].toString()) ?? 0.0);
    }
    return sum;
  });
}

double get balanceAmount {
  // total milk amount minus payments received
  return totalBalance - totalReceive;
}


double get balanceProduct {
  // total product amount minus payments received
  print("Total Product: $totalProduct");
  return totalProduct ;
}

double get balanceProMilk {
  double totalDue = totalProduct + totalBalance;
  double net = (totalReceive - totalPay) - totalDue;

  if (net < 0) {
    type = "receive"; // Customer still owes
  } else {
    type = "pay";     // You owe customer
  }
  return net;  // Return net as is (can be positive or negative)
}


double get balanceGrantTotal {
  // total milk amount minus payments received
  print("Total Grant Total: $balanceProMilk");

  return   balanceProMilk;
}


  double get totalMilk =>
      milkData.fold(0.0, (sum, item) => sum + item["milk"]);

  double get avgFat =>
      milkData.isEmpty ? 0.0 : milkData.fold(0.0, (s, i) => s + i["fat"]) / milkData.length;

  double get avgRate =>
      milkData.isEmpty ? 0.0 : milkData.fold(0.0, (s, i) => s + i["rate"]) / milkData.length;

  double get totalQuantity =>
      productTransactions.isEmpty ? 0.0 : productTransactions.fold(0.0, (s, i) => s + i["quantity"]);

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
      Text("to".tr, style: TextStyle(fontSize: 16)),
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
onChanged: (int? value) async {
  if (value == null) return;
  final customer = customers.firstWhere((c) => c['id'] == value);

  setState(() {
    selectedCustomerId = customer['id'];
    _codeCtrl.text = customer['code'] ?? '';
    _nameCtrl.text = '${customer['name']} (${customer['code']})';
    accountNo = customer['code'] ?? '';
    name = customer['name'] ?? '';
    customerType = customer['customerType'] ?? '';

    // Reset date to customer registration → today
    final createdAt = customer['createdAt'];
    if (createdAt != null && createdAt.isNotEmpty) {
      try {
        _startDate = DateTime.parse(createdAt);
      } catch (_) {
        _startDate = DateTime.now().subtract(const Duration(days: 30));
      }
    } else {
      _startDate = DateTime.now().subtract(const Duration(days: 30));
    }
    _endDate = DateTime.now();
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
    onChanged: (value) async {
  final match = customers.firstWhere(
    (c) => c['code'] == value,
    orElse: () => {},
  );

  if (match.isNotEmpty) {
    setState(() {
      selectedCustomerId = match['id'];
      _codeCtrl.text = match['code'] ?? '';
      _nameCtrl.text = '${match['name']} (${match['code']})';
      accountNo = match['code'] ?? '';
      name = match['name'] ?? '';
      customerType = match['customerType'] ?? '';

      // Reset date to customer registration → today
      final createdAtStr = match['createdAt'];
      if (createdAtStr != null && createdAtStr.isNotEmpty) {
        try {
          _startDate = DateTime.parse(createdAtStr);
        } catch (_) {
          _startDate = DateTime.now().subtract(const Duration(days: 30));
        }
      } else {
        _startDate = DateTime.now().subtract(const Duration(days: 30));
      }
      _endDate = DateTime.now();
    });

    await _fetchMilkData(selectedCustomerId);
  } else {
    setState(() {
      selectedCustomerId = null;
      _nameCtrl.clear();
    });
  }
},


        decoration: InputDecoration(
          hintText: "enter_code".tr,
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
                      Text("account_no".tr + " $accountNo"),
                      Text(customerType),
                    ]),
                    Text("name".tr + " $name"),
                  Row(
                      children: [
                        Text(DateFormat('dd MMM yyyy').format(_startDate)),
                        const SizedBox(width: 8),
                        Text("to".tr, style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Text(DateFormat('dd MMM yyyy').format(_endDate)),
                      ],
                    ),
                    // Text("Previous balance   $previousBalance", style: const TextStyle(color: Colors.red)),
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
              if (milkData.any((row) => row["status"] == "active")) 
                buildMilkTable(),
                // buildBillDetail(),
              
                 if (productTransactions.any((row) => row["status"] == "active"))
                buildProductTable(),
                const SizedBox(height: 12),
                // const SizedBox(height: 12),
                buildGrantTotal(),
                const SizedBox(height: 20),
                // const Center(child: Text("abhi milk dairy", style: TextStyle(color: Colors.green))),
              ],
            ),
          ),

          // Bottom green box
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,   children: [
    Text("balance_amount".tr,
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
    Text(
      (balanceGrantTotal < 0 ? "- ₹ " : "₹ ") + balanceGrantTotal.abs().toStringAsFixed(2),
      style: TextStyle(
        color: balanceGrantTotal < 0 ? Colors.red : Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ],),
                const SizedBox(height: 10),
  TextField(
        controller: _amountController,
        textAlign: TextAlign.center, // center like your "0.0"
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          hintText: "0.0",
          hintStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          border: InputBorder.none, // no box border → same as your design
        ),
      ),
                GestureDetector(
                  onTap: () => _createPayment(type),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    child: Text("pay_bill".tr,
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
          child: Row(children: [
            Expanded(child: Center(child: Text("date".tr, style: headerStyle))),
            Expanded(child: Center(child: Text("milk".tr, style: headerStyle))),
            Expanded(child: Center(child: Text("fat".tr, style: headerStyle))),
            Expanded(child: Center(child: Text("rate".tr, style: headerStyle))),
            Expanded(child: Center(child: Text("amount".tr, style: headerStyle))),
          ]),
        ),

        // Rows
       ...milkData
    .where((row) => row["status"] == "active") // only active rows
    .map((row) => tableRow(
          row["date"],
          row["milk"].toString(),
          row["fat"].toString(),
          row["rate"].toString(),
          row["amount"].toString(),
        )),

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
            Expanded(child: Center(child: Text("${customerType == 'Seller' ? '-' : '+'}${balanceAmount.toStringAsFixed(1)}", style: whiteBold))),
          ]),
        ),
      ]),
    );
  }

   Widget buildProductTable() {
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
            Expanded(child: Center(child: Text("Product", style: headerStyle))),
            Expanded(child: Center(child: Text("Quantity", style: headerStyle))),
            Expanded(child: Center(child: Text("Amount", style: headerStyle))),
          ]),
        ),

        // Rows
       ...productTransactions
    .where((row) => row["status"] == "active") // only active rows
    .map((row) => productTableRow(
          row["date"],
          row["product"].toString(),
          row["quantity"].toString(),
          
        
          row["amount"].toString(),
        )),

        // Footer
        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            Expanded(child: Center(child: Text("Total Product Detail(${productTransactions.length})", style: whiteBold))),
          
           
            Expanded(child: Center(child: Text(totalQuantity.toStringAsFixed(2), style: whiteBold))),
            Expanded(child: Center(child: Text("${balanceProduct.toStringAsFixed(1)}", style: whiteBold))),
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
          child: Center(child:  Text("bill".tr, style: whiteBold)),
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
            Expanded(child: Center(child: Text(totalSBalance.toStringAsFixed(2)))),
            Expanded(child: Center(child: Text(totalPBalance.toStringAsFixed(2)))),
            Expanded(child: Center(child: Text(totalReceive.toStringAsFixed(2)))),
            Expanded(child: Center(child: Text("${balanceGrantTotal.toStringAsFixed(2)}"))),
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
  Widget productTableRow(String date, String product, String quantity, String amount) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
    child: Row(children: [
      Expanded(child: Center(child: Text(date))),
      Expanded(child: Center(child: Text(product))),
      Expanded(child: Center(child: Text(quantity))),
      Expanded(child: Center(child: Text(amount))),
    ]),
  );
}
}

const headerStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
const boldText = TextStyle(fontWeight: FontWeight.bold);
const whiteBold = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
