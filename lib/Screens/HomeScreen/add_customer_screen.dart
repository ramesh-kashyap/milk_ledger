import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

  // Basic info
  final codeCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  // Visible value fields (one per animal, auto-filled from defaults based on basis)
  final _bmCtrl = TextEditingController(); // buffalo visible value
  final _cmCtrl = TextEditingController(); // cow visible value

  // (not shown on the form here but kept if you need later)
  final _bmFixCtrl = TextEditingController();
  final _cmFixCtrl = TextEditingController();

  PricingBasis _basis = PricingBasis.fat;
  bool buffaloEnabled = true;
  bool cowEnabled = false;

  String alertMethod = 'No Alerts';
  String printSlip = 'Default';

  bool _loading = true;

  final _numFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,2})?$')),
  ];

  final List<TextInputFormatter> fatAutoDotFormatter = [
    TextInputFormatter.withFunction((oldValue, newValue) {
      final oldText = oldValue.text;
      var text = newValue.text;

      // Allow full clear any time
      if (text.isEmpty) return newValue;

      final isDeletion = newValue.text.length < oldText.length;

      // If user deleted the dot from "7." -> clear all
      if (isDeletion &&
          oldText.endsWith('.') &&
          text == oldText.substring(0, oldText.length - 1)) {
        return const TextEditingValue(text: '');
      }

      // On insertion: auto add dot after the first digit (only if not present)
      if (!isDeletion && text.length == 1 && !text.contains('.')) {
        text = '$text.';
        return TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }

      // Validate: 1–2 digits before dot, optional dot, up to 2 digits after dot
      final valid = RegExp(r'^\d{1,2}(\.\d{0,2})?$');
      if (valid.hasMatch(text)) {
        return TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }

      // Reject invalid change
      return oldValue;
    }),
  ];
  // Holds the API defaults so we can autofill repeatedly on toggles / basis change
  Map<String, dynamic> _defaults = {};

  @override
  void initState() {
    super.initState();
    _loadDefaults();
  }

  @override
  void dispose() {
    codeCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    _bmCtrl.dispose();
    _cmCtrl.dispose();
    _bmFixCtrl.dispose();
    _cmFixCtrl.dispose();
    super.dispose();
  }

  // ---------- Load defaults and auto-apply ----------
  Future<void> _loadDefaults() async {
    try {
      final res = await ApiService.get("/rates/defaults");
      // expected shape (from earlier):
      // {
      //   buffalo: { rate: {fixed_rate}, fat:{fat_rate}, fat_snf:{fat_rate,snf_rate} },
      //   cow:     { rate: {fixed_rate}, fat:{fat_rate}, fat_snf:{fat_rate,snf_rate} }
      // }
      final data = (res.data is Map ? res.data['data'] : null) as Map? ?? {};
      _defaults = Map<String, dynamic>.from(data);

      // Optional: store fixed for reference (not shown in form)
      _bmFixCtrl.text = _numOrEmpty(_pickDefault('buffalo', PricingBasis.rate));
      _cmFixCtrl.text = _numOrEmpty(_pickDefault('cow', PricingBasis.rate));

      // Apply visible box autofill now
      _applyAutoFill();
    } catch (e) {
      // graceful fallback defaults
      _defaults = {
        'buffalo': {
          'fat': {'fat_rate': 7.5},
          'rate': {'fixed_rate': 60},
          'fat_snf': {'fat_rate': 7.5, 'snf_rate': 3.5},
        },
        'cow': {
          'fat': {'fat_rate': 7.0},
          'rate': {'fixed_rate': 55},
          'fat_snf': {'fat_rate': 7.0, 'snf_rate': 3.0},
        },
      };
      _applyAutoFill();
      _showSnack('Couldn\'t load current rates, using defaults');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Picks the default number from `_defaults` for a given animal+basis.
  double _pickDefault(String animal, PricingBasis basis) {
    final a = _defaults[animal];
    if (a is! Map) return 0;

    switch (basis) {
      case PricingBasis.fat:
        final fat = a['fat'];
        final v = fat is Map ? fat['fat_rate'] : null;
        return _asDouble(v);
      case PricingBasis.rate:
        final rate = a['rate'];
        final v = rate is Map ? rate['fixed_rate'] : null;
        return _asDouble(v);
      case PricingBasis.fatSnf:
        final fs = a['fat_snf'];
        final v = fs is Map
            ? fs['fat_rate']
            : null; // single visible box uses fat part
        return _asDouble(v);
    }
  }

  double _asDouble(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  String _numOrEmpty(double v) => v == 0 ? '' : v.toString();

  /// Re-applies defaults into the visible inputs according to current basis and toggles
  void _applyAutoFill() {
    if (buffaloEnabled) {
      final val = _pickDefault('buffalo', _basis);
      _bmCtrl.text = _numOrEmpty(val);
    } else {
      _bmCtrl.clear();
    }

    if (cowEnabled) {
      final val = _pickDefault('cow', _basis);
      _cmCtrl.text = _numOrEmpty(val);
    } else {
      _cmCtrl.clear();
    }
    setState(() {});
  }

  void _onBasisChanged(PricingBasis b) {
    setState(() => _basis = b);
    _applyAutoFill();
  }

  void _onBuffaloToggle(bool? v) {
    buffaloEnabled = v ?? false;
    _applyAutoFill();
  }

  void _onCowToggle(bool? v) {
    cowEnabled = v ?? false;
    _applyAutoFill();
  }

  // ---------- Save ----------
  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      "customerType": widget.customerType, // Seller or Purchaser
      "code": codeCtrl.text.trim(),
      "name": nameCtrl.text.trim(),
      "phone": phoneCtrl.text.trim(),
      "basis": _basis.name, // "fat" | "rate" | "fatSnf"
      "buffalo": {
        "enabled": buffaloEnabled,
        "value":
            buffaloEnabled ? _bmCtrl.text.trim() : null, // value as per basis
      },
      "cow": {
        "enabled": cowEnabled,
        "value": cowEnabled ? _cmCtrl.text.trim() : null,
      },
      "alertMethod": alertMethod,
      "printSlip": printSlip,
    };

    try {
      // 👇 call backend
      final response = await ApiService.post('/addCustomer', payload);
      // print("Response: $response");
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

  // ---------- UI ----------
  String _fieldLabel() {
    switch (_basis) {
      case PricingBasis.rate:
        return 'Rate / litre';
      case PricingBasis.fatSnf:
        return 'Fat rate';
      case PricingBasis.fat:
      default:
        return 'Fat rate';
    }
  }

  void _showSnack(String m) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
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
              blurRadius: 6, offset: Offset(0, 2), color: Color(0x11000000)),
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
        title: Text(
          'add_customer'.trParams({'type': widget.customerType}), // 👈 dynamic param
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),

      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: Text('cancel'.tr),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined),
                label: Text('save'.tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                children: [
                  // Customer Details
                  _sectionCard(
                    title: 'customer_details'.tr,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: codeCtrl,
                          decoration: _decor('code'.tr),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'code_required'.tr
                              : null,
                        ),
                        spacer,
                        TextFormField(
                          controller: nameCtrl,
                          decoration: _decor('name'.tr),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'name_required'.tr
                              : null,
                        ),
                        spacer,
                        TextFormField(
                          controller: phoneCtrl,
                          decoration: _decor('phone_optional'.tr),
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),

                  // Basis
                  _sectionCard(
                    title: 'on_basis_of'.tr, 
                    child: Wrap(
                      spacing: 14,
                      children: [
                        ChoiceChip(
                          label:  Text('fat'.tr),
                          selected: _basis == PricingBasis.fat,
                          onSelected: (_) => _onBasisChanged(PricingBasis.fat),
                        ),
                        ChoiceChip(
                          label: const Text('Rate'),
                          selected: _basis == PricingBasis.rate,
                          onSelected: (_) => _onBasisChanged(PricingBasis.rate),
                        ),
                        ChoiceChip(
                          label: const Text('Fat/SNF'),
                          selected: _basis == PricingBasis.fatSnf,
                          onSelected: (_) =>
                              _onBasisChanged(PricingBasis.fatSnf),
                        ),
                      ],
                    ),
                  ),

                  // Buffalo Milk
                  _sectionCard(
                    title: 'buffalo_milk',
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _bmCtrl,
                            enabled: buffaloEnabled,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: _basis == PricingBasis.fat
                                ? fatAutoDotFormatter
                                : _numFormatter,
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
                            value: buffaloEnabled, onChanged: _onBuffaloToggle),
                      ],
                    ),
                  ),

                  // Cow Milk
                  _sectionCard(
                    title: 'cow_milk',
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cmCtrl,
                            enabled: cowEnabled,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: _basis == PricingBasis.fat
                                ? fatAutoDotFormatter
                                : _numFormatter,
                            decoration: _decor(_fieldLabel()),
                            validator: (v) {
                              if (!cowEnabled) return null;
                              if (v == null || v.isEmpty) return 'Required';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Checkbox(value: cowEnabled, onChanged: _onCowToggle),
                      ],
                    ),
                  ),

                  if (_basis == PricingBasis.fatSnf)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Tip: For Fat/SNF basis this box shows the FAT rate. "
                        "SNF rate can be edited from the Fat & SNF screen.",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54),
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
                            'Phone Call'
                          ]
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
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
                            'None'
                          ]
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
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
