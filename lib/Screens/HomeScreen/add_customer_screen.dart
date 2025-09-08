import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum PricingBasis { fat, rate, fatSnf }

class AddCustomerScreen extends StatefulWidget {
  final String customerType; // "Seller" or "Purchaser"

  const AddCustomerScreen({Key? key, required this.customerType})
      : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final codeCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final buffaloCtrl = TextEditingController(text: '7.5');
  final cowCtrl = TextEditingController();

  // State
  PricingBasis _basis = PricingBasis.fat;
  bool buffaloEnabled = true;
  bool cowEnabled = false;

  String alertMethod = 'No Alerts';
  String printSlip = 'Default';

  final _numFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,2})?$')),
  ];

  @override
  void dispose() {
    codeCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    buffaloCtrl.dispose();
    cowCtrl.dispose();
    super.dispose();
  }

  String _fieldLabel() {
    switch (_basis) {
      case PricingBasis.rate:
        return 'Rate';
      case PricingBasis.fatSnf:
        return 'Fat/SNF';
      case PricingBasis.fat:
      default:
        return 'Fat Rate';
    }
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    final payload = {
      "customerType": widget.customerType, // Seller or Purchaser
      "code": codeCtrl.text.trim(),
      "name": nameCtrl.text.trim(),
      "phone": phoneCtrl.text.trim(),
      "basis": _basis.name,
      "buffalo": {
        "enabled": buffaloEnabled,
        "value": buffaloEnabled ? buffaloCtrl.text.trim() : null,
      },
      "cow": {
        "enabled": cowEnabled,
        "value": cowEnabled ? cowCtrl.text.trim() : null,
      },
      "alertMethod": alertMethod,
      "printSlip": printSlip,
    };

    try {
      // 👇 call backend
      final response = await ApiService.post('/addCustomer', payload);
      print("Response: $response");
      // success feedback
      final data = response.data;
      if (data['status'] == true) {
        Get.snackbar(
          "Success 🎉",
          "${widget.customerType} has been saved successfully",
        );
      } else {
        Get.snackbar(
            "Add Cusotmer Failed", data['message'] ?? "Something went wrong");
      }

      // close screen and return the saved object
      Navigator.pop(context, response);
    } catch (e) {
      // error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error saving customer: $e")),
      );
    }
  }

  InputDecoration _decor(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.green),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 2),
            color: Color(0x11000000),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black87)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacer = const SizedBox(height: 14);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Add ${widget.customerType}',
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            // Customer Details
            _sectionCard(
              title: 'Customer Details',
              child: Column(
                children: [
                  TextFormField(
                    controller: codeCtrl,
                    decoration: _decor('Code'),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Code is required'
                        : null,
                  ),
                  spacer,
                  TextFormField(
                    controller: nameCtrl,
                    decoration: _decor('Name'),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Name is required'
                        : null,
                  ),
                  spacer,
                  TextFormField(
                    controller: phoneCtrl,
                    decoration: _decor('Phone (Optional)'),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),

            // Basis
            _sectionCard(
              title: 'On basis of',
              child: Wrap(
                spacing: 14,
                children: [
                  ChoiceChip(
                    label: const Text('Fat'),
                    selected: _basis == PricingBasis.fat,
                    onSelected: (_) =>
                        setState(() => _basis = PricingBasis.fat),
                  ),
                  ChoiceChip(
                    label: const Text('Rate'),
                    selected: _basis == PricingBasis.rate,
                    onSelected: (_) =>
                        setState(() => _basis = PricingBasis.rate),
                  ),
                  ChoiceChip(
                    label: const Text('Fat/SNF'),
                    selected: _basis == PricingBasis.fatSnf,
                    onSelected: (_) =>
                        setState(() => _basis = PricingBasis.fatSnf),
                  ),
                ],
              ),
            ),

            // Buffalo Milk
            _sectionCard(
              title: 'Buffalo Milk',
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: buffaloCtrl,
                      enabled: buffaloEnabled,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: _numFormatter,
                      decoration: _decor(_fieldLabel()),
                      validator: (v) {
                        if (!buffaloEnabled) return null;
                        if (v == null || v.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Checkbox(
                    value: buffaloEnabled,
                    onChanged: (v) =>
                        setState(() => buffaloEnabled = v ?? true),
                  ),
                ],
              ),
            ),

            // Cow Milk
            _sectionCard(
              title: 'Cow Milk',
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cowCtrl,
                      enabled: cowEnabled,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: _numFormatter,
                      decoration: _decor(_fieldLabel()),
                      validator: (v) {
                        if (!cowEnabled) return null;
                        if (v == null || v.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Checkbox(
                    value: cowEnabled,
                    onChanged: (v) => setState(() => cowEnabled = v ?? false),
                  ),
                ],
              ),
            ),

            // Preferences
            _sectionCard(
              title: 'Preferences',
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: alertMethod,
                    decoration: _decor('Alert Method'),
                    items: const [
                      'No Alerts',
                      'SMS',
                      'WhatsApp',
                      'Phone Call',
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => alertMethod = v!),
                  ),
                  spacer,
                  DropdownButtonFormField<String>(
                    value: printSlip,
                    decoration: _decor("Print Entry Slip's"),
                    items: const [
                      'Default',
                      'Compact',
                      'Detailed',
                      'None',
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => printSlip = v!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
