import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  String selectedUnit = "kg";
  List<Map<String, dynamic>> products = [];
  int? editingProductId; // Track editing product ID

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  /// ✅ Fetch products
  Future<void> _fetchProducts() async {
    try {
      Response response = await ApiService.get("/fetchProducts");
      final data = response.data;

      if (data["status"] == true) {
        setState(() {
          products = List<Map<String, dynamic>>.from(data["product"]);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Failed to load products")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching products: $e")),
      );
    }
  }

  /// ✅ Save product (add/update)
  Future<void> _saveProduct() async {
    String name = _productNameController.text.trim();
    String price = _priceController.text.trim();
    String stock = _stockController.text.trim();

    if (name.isEmpty || price.isEmpty || stock.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    try {
      Response response = await ApiService.post("/dairyProducts", {
        "id": editingProductId, // null → insert, not null → update
        "productName": name,
        "productUnit": selectedUnit,
        "price": price,
        "stock": stock,
      });

      final data = response.data;

      if (data["status"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Saved successfully")),
        );
        _clearInputs();
        _fetchProducts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Failed to save product")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving: $e")),
      );
    }
  }

  /// ✅ Delete product
  Future<void> _deleteProduct(int id) async {
    try {
      Response response = await ApiService.post("/dairyProducts/$id", {});
      final data = response.data;

      if (data["status"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Deleted successfully")),
        );
        _clearInputs();
        _fetchProducts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Failed to delete")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting: $e")),
      );
    }
  }

  /// ✅ Edit product → fill inputs
  void _editProduct(Map<String, dynamic> product) {
    setState(() {
      editingProductId = product["id"];
      _productNameController.text = product["product_name"] ?? "";
      _priceController.text = product["product_price"].toString();
      _stockController.text = product["stock"].toString();
      selectedUnit = product["productUnit"] ?? "kg";
    });
  }

  void _clearInputs() {
    _productNameController.clear();
    _priceController.clear();
    _stockController.clear();
    selectedUnit = "kg";
    editingProductId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Product Management",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[500],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Name
            Row(
              children: [
                const Text("Product Name",
                    style: TextStyle(color: Colors.green, fontSize: 16)),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _productNameController,
                    decoration: InputDecoration(
                      hintText: "Enter product name",
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      suffixIcon: Icon(Icons.search,
                          color: Colors.green.shade700, size: 22),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Product Unit
            Row(
              children: [
                const Text("Product Unit",
                    style: TextStyle(color: Colors.green, fontSize: 16)),
                const SizedBox(width: 16),
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      hintText: "Select unit",
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      border: const UnderlineInputBorder(),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedUnit,
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                        items: ["kg", "litre", "piece"].map((unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedUnit = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Price
            Row(
              children: [
                const Text("Price",
                    style: TextStyle(color: Colors.green, fontSize: 16)),
                const SizedBox(width: 40),
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter price",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Stock
            Row(
              children: [
                const Text("Stock",
                    style: TextStyle(color: Colors.green, fontSize: 16)),
                const SizedBox(width: 40),
                Expanded(
                  child: TextField(
                    controller: _stockController,
                    decoration: const InputDecoration(
                      hintText: "Enter stock (e.g. Unlimited or 50)",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: editingProductId == null
                        ? null
                        : () => _deleteProduct(editingProductId!),
                    child: const Text("DELETE",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: _saveProduct,
                    child: Text(
                      editingProductId == null ? "ADD" : "UPDATE",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Product Table Header
            Container(
              width: double.infinity,
              color: Colors.green.shade700,
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  "All Products",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              color: Colors.green.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: const Row(
                children: [
                  Expanded(
                      child: Text("Product Name",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("Product Unit",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("Stock",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),

            /// Product List
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return InkWell(
                    onTap: () => _editProduct(item),
                    child: Container(
                      color: index % 2 == 0
                          ? Colors.grey.shade100
                          : Colors.grey.shade200,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Row(
                        children: [
                          Expanded(child: Text(item["product_name"] ?? "")),
                          Expanded(
                              child: Text(
                                  "${item["product_price"]}/per ${item["product_unit"]}")),
                          Expanded(child: Text(item["stock"].toString())),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
