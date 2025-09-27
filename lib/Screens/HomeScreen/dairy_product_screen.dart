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
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
  Map<String, dynamic>? selectedCustomer; // ✅ now a Map, not String
  Map<String, dynamic>? selectedProduct;
  String transactionType = "Sale";

  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> productList = [];
  bool _isQuantityValid = true;
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

  @override
  void dispose() {
    _quantityController.removeListener(_calculateAmount);
    _priceController.removeListener(_calculateAmount);
    _quantityController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  void _calculateAmount() {
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final amount = quantity * price;
    if (mounted) {
      setState(() {
        _amountController.text = amount.toStringAsFixed(2);
        _isQuantityValid = quantity <= availableStock;
      });
    }
  }

  Future<void> _fetchCustProList({String? customerId}) async {
    try {
      final body = {"transactionType": transactionType};
      if (customerId != null) body["customerId"] = customerId;

      final response = await ApiService.post("/custprolist", body);
      final data = response.data;
      if (data["success"] == true) {
        final customersRaw = (data["customers"] as List?) ?? [];
        final productsRaw = (data["products"] as List?) ?? [];
        print(customersRaw);

        setState(() {
          customerList = customersRaw.cast<Map<String, dynamic>>();
          if (customerList.isNotEmpty && selectedCustomer == null) {
            selectedCustomer = customerList.first;
          }

          productList = productsRaw.cast<Map<String, dynamic>>();
          if (productList.isNotEmpty) {
            selectedProduct = productList.first;
            availableStock =
                (productList.first["stock"] as num? ?? 0).toDouble();
            _priceController.text =
                (productList.first["product_price"] ?? _priceController.text)
                    .toString();
          }
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data["message"] ?? "Failed to load")),
          );
        }
      }
    } catch (e, st) {
      debugPrint("Error fetching customer/products: $e\n$st");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to load customers/products")),
        );
      }
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
          Icon(icon, size: 18, color: Colors.green[700]),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Widget child, {EdgeInsets? padding}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(12),
        child: child,
      ),
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
      body: SafeArea(
        child: customerList.isEmpty || productList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Date
                    _buildCard(
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.green),
                                  const SizedBox(width: 8),
                                  Text(
                                    DateFormat("dd MMM yyyy")
                                        .format(selectedDate),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_calendar,
                                color: Colors.green),
                            onPressed: () => _selectDate(context),
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
                                child: DropdownButtonFormField<
                                    Map<String, dynamic>>(
                                  value: selectedCustomer,
                                  decoration: const InputDecoration(isDense: true),
                                  items: customerList.map((c) {
                                    final nameWithCode =
                                        "${c["name"]} (${c["code"]})";
                                    final type = c["customerType"] ?? "";

                                    IconData icon;
                                    Color color;
                                    if (type.toLowerCase() == "seller") {
                                      icon = Icons.storefront;
                                      color = Colors.green;
                                    } else if (type.toLowerCase() ==
                                        "purchaser") {
                                      icon = Icons.shopping_cart;
                                      color = Colors.blue;
                                    } else {
                                      icon = Icons.person;
                                      color = Colors.grey;
                                    }

                                    return DropdownMenuItem<
                                        Map<String, dynamic>>(
                                      value: c,
                                      child: Row(
                                        children: [
                                          Icon(icon, color: color, size: 18),
                                          const SizedBox(width: 8),
                                          Text(nameWithCode),
                                          const SizedBox(width: 6),
                                          Text(type,
                                              style: TextStyle(
                                                  fontSize: 12, color: color)),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() => selectedCustomer = value);
                                    if (transactionType == "Purchase" &&
                                        value != null) {
                                      _fetchCustProList(
                                          customerId: value["id"].toString());
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () =>
                                    Get.to(() => const ProductManagementScreen()),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.add_circle,
                                      color: Colors.green, size: 32),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Transaction + Product
                    Row(
                      children: [
                        Expanded(child: _buildSmallDropdownCardTransactionType()),
                        const SizedBox(width: 12),
                        Expanded(child: _buildSmallDropdownCardProduct()),
                      ],
                    ),

                    // Quantity / Price / Amount
                    _buildCard(
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Quantity",
                                errorText: !_isQuantityValid
                                    ? "Exceeds stock ($availableStock)"
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _priceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration:
                                  const InputDecoration(labelText: "Price"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _amountController,
                              readOnly: true,
                              decoration:
                                  const InputDecoration(labelText: "Amount"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Stock
                    _buildCard(
                      Row(
                        children: [
                          const Icon(Icons.inventory_2, color: Colors.green),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text("Available Stock",
                                style: TextStyle(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text("$availableStock L",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ],
                      ),
                    ),

                    // Remark
                    _buildCard(
                      TextFormField(
                        controller: _remarkController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                            hintText: "Enter remark"),
                      ),
                    ),

                    const SizedBox(height: 6),
                    SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isQuantityValid ? _submitTransaction : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.green,
                            elevation: 3,
                          ),
                          child: Text(
                            transactionType.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSmallDropdownCardProduct() {
    return _buildCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Product", Icons.local_grocery_store),
          DropdownButtonFormField<Map<String, dynamic>>(
            value: selectedProduct,
            decoration: const InputDecoration(isDense: true),
            items: productList.map((p) {
              return DropdownMenuItem<Map<String, dynamic>>(
                value: p,
                child: Text("${p['product_name']} (${p['product_unit']})"),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedProduct = value;
                  availableStock = (value["stock"] as num? ?? 0).toDouble();
                  _priceController.text =
                      (value["product_price"] ?? _priceController.text)
                          .toString();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSmallDropdownCardTransactionType() {
    return _buildCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Transaction Type", Icons.swap_horiz),
          DropdownButtonFormField<String>(
            value: transactionType,
            decoration: const InputDecoration(isDense: true),
            items: ["Sale", "Purchase"]
                .map((e) => DropdownMenuItem<String>(
                    value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => transactionType = value);
                String? customerId;
                if (value == "Purchase" && selectedCustomer != null) {
                  customerId = selectedCustomer?["id"].toString();
                }
                _fetchCustProList(customerId: customerId);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submitTransaction() async {
    try {
      final body = {
        "bill": DateFormat("yyyy-MM-dd").format(selectedDate),
        "note": _remarkController.text,
        "customer_id": selectedCustomer?["id"], // ✅ send ID
        "code": selectedCustomer?["code"],
        "customer": selectedCustomer?["name"],
        "product_id": selectedProduct?["id"],
        "product_name": selectedProduct?["product_name"],
        "price": _priceController.text,
        "quantity": _quantityController.text,
        "amount": _amountController.text,
        "stock": availableStock.toString(),
        "transactionType": transactionType,
      };

      final response = await ApiService.post("/customerproducts", body);

      if (response.data["success"] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Transaction saved successfully")),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.data["message"] ?? "Failed")),
          );
        }
      }
    } catch (e, st) {
      debugPrint("Submit error: $e\n$st");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong")),
        );
      }
    }
  }
}
