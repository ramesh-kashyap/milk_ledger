import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/add_Product_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dairy Products',
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green, width: 1.5),
          ),
          labelStyle: TextStyle(color: Colors.green.shade700),
        ),
      ),
      home: const DairyProductsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DairyProductsScreen extends StatefulWidget {
  const DairyProductsScreen({super.key});

  @override
  State<DairyProductsScreen> createState() => _DairyProductsScreenState();
}

class _DairyProductsScreenState extends State<DairyProductsScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedCustomer;
  Map<String, dynamic>? selectedProduct;
  String transactionType = "Sale";

  List<String> customerList = [];
  List<Map<String, dynamic>> productList = [];

  double availableStock = 0.0;

  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController =
      TextEditingController(text: "500.0");
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCustProList();

    // Auto calculate amount
    _quantityController.addListener(_calculateAmount);
    _priceController.addListener(_calculateAmount);
  }

  void _calculateAmount() {
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final amount = quantity * price;

    setState(() {
      _amountController.text = amount.toStringAsFixed(2);
    });
  }

  Future<void> _fetchCustProList({String? customerId}) async {
    try {
      final response = await ApiService.post(
        "/custprolist",
        {
          "transactionType": transactionType,
          "customerId": customerId,
        },
      );
      final data = response.data;
      if (data["success"] == true) {
        setState(() {
          customerList = (data["customers"] as List)
              .map((c) => "${c['name']} (${c['code']})")
              .toList();
          productList =
              (data["products"] as List).cast<Map<String, dynamic>>();

          if (productList.isNotEmpty) {
            selectedProduct = productList.first;
            availableStock =
                (productList.first["stock"] as num).toDouble();
          }

          if (customerList.isNotEmpty && selectedCustomer == null) {
            selectedCustomer = customerList.first;
          }
        });
      }
    } catch (e) {
      print("Error fetching customer/products: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load customers/products")),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.green),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: const Text(
          "Dairy Products",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: customerList.isEmpty || productList.isEmpty
          ? const Center(child: CircularProgressIndicator()) // 👈 loader
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Bill Date
                _buildCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Bill Date", Icons.calendar_today),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat("dd MMM yyyy").format(selectedDate),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const Icon(Icons.edit_calendar,
                                color: Colors.green),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Customer
                _buildCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Customer", Icons.person),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedCustomer,
                              items: customerList
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() => selectedCustomer = value);

                                // If Purchase, reload products for this customer
                                if (transactionType == "Purchase") {
                                  String customerId = value!
                                      .split("(")
                                      .last
                                      .split(")")
                                      .first;
                                  _fetchCustProList(customerId: customerId);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                                Get.to(() => const ProductManagementScreen());
                              },                            
                            icon: const Icon(Icons.add_circle,
                                color: Colors.green, size: 32),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Transaction Type
                _buildCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(
                          "Transaction Type", Icons.swap_horiz),
                      DropdownButtonFormField<String>(
                        value: transactionType,
                        items: ["Sale", "Purchase"]
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => transactionType = value);

                            // If Purchase, pass selected customer id
                            String? customerId;
                            if (value == "Purchase" &&
                                selectedCustomer != null) {
                              customerId = selectedCustomer!
                                  .split("(")
                                  .last
                                  .split(")")
                                  .first;
                            }

                            _fetchCustProList(customerId: customerId);
                          }
                        },
                      ),
                    ],
                  ),
                ),

                // Product
                _buildCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(
                          "Product", Icons.local_grocery_store),
                      DropdownButtonFormField<Map<String, dynamic>>(
                        value: selectedProduct,
                        items: productList.map((p) {
                          return DropdownMenuItem(
                            value: p,
                            child: Text(
                                "${p['product_name']} (${p['product_unit']})"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedProduct = value;
                              availableStock =
                                  (value["stock"] as num).toDouble();
                              _priceController.text =
                                  value["product_price"].toString();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),

                // Quantity / Price / Amount
                _buildCard(
                  Column(
                    children: [
                      TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: "Quantity"),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Price"),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(labelText: "Amount"),
                      ),
                    ],
                  ),
                ),

                // Stock
                _buildCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(
                          "Available Stock", Icons.inventory_2),
                      Text("$availableStock L",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ],
                  ),
                ),

                // Remark
                _buildCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Remark", Icons.note_alt_outlined),
                      TextFormField(
                        controller: _remarkController,
                        decoration: const InputDecoration(
                            hintText: "Enter remark"),
                      ),
                    ],
                  ),
                ),

                // Action Button
                const SizedBox(height: 10),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final customerId = selectedCustomer!
                              .split("(")
                              .last
                              .split(")")
                              .first;

                          final productName = selectedProduct!["product_name"];
                          final productId = selectedProduct!["id"];
                          final productUnit = selectedProduct!["product_unit"];

                          final body = {
                            "bill": DateFormat("yyyy-MM-dd")
                                .format(selectedDate),
                            "note": _remarkController.text,
                            "code": customerId,
                            "customer": selectedCustomer,
                            "product_id": productId,
                            "product_name": productName,
                            "price": _priceController.text,
                            "quantity": _quantityController.text,
                            "amount": _amountController.text,
                            "stock": availableStock.toString(),
                            "transactionType": transactionType,
                          };

                          final response = await ApiService.post(
                              "/customerproducts", body);

                          if (response.data["success"] == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Transaction saved successfully")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(response.data["message"] ??
                                      "Failed")),
                            );
                          }
                        } catch (e) {
                          print("Submit error: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Something went wrong")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.green,
                        elevation: 4,
                      ),
                      child: Text(
                        transactionType.toUpperCase(),
                        style: const TextStyle( color: Colors.white,
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
