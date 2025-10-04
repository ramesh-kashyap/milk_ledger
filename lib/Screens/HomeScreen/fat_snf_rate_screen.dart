import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
class FatSnfRateScreen extends StatefulWidget {
  /// Optional initial values
  final double? buffaloFatRate; // ₹ per 1.0 fat for Buffalo
  final double? buffaloSnfRate; // ₹ per 1.0 SNF kg for Buffalo
  final double? cowFatRate; // ₹ per 1.0 fat for Cow
  final double? cowSnfRate; // ₹ per 1.0 SNF kg for Cow
  final double? cowRate;       // Add this
  final double? buffaloRate;   // Add this

  const FatSnfRateScreen({
    super.key,
    this.buffaloFatRate,
    this.buffaloSnfRate,
    this.cowFatRate,
    this.cowSnfRate,
    this.cowRate,
    this.buffaloRate,
  });

  @override
  State<FatSnfRateScreen> createState() => _FatSnfRateScreenState();
}

class _FatSnfRateScreenState extends State<FatSnfRateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _makeCtrl = TextEditingController();
late final TextEditingController _bmFatCtrl;
  late final TextEditingController _bmSnfCtrl;
  late final TextEditingController _bmRateCtrl;
  late final TextEditingController _cmFatCtrl;
  late final TextEditingController _cmSnfCtrl;
  late final TextEditingController _cmRateCtrl;

 @override
void initState() {
  super.initState();
  _bmFatCtrl = TextEditingController(text: widget.buffaloFatRate?.toString() ?? '');
  _bmSnfCtrl = TextEditingController(text: widget.buffaloSnfRate?.toString() ?? '');
  _bmRateCtrl = TextEditingController(text:widget.buffaloRate?.toString() ?? '');
  _cmFatCtrl = TextEditingController(text: widget.cowFatRate?.toString() ?? '');
  _cmSnfCtrl = TextEditingController(text: widget.cowSnfRate?.toString() ?? '');
  _cmRateCtrl = TextEditingController(text: widget.cowRate?.toString() ?? '');
}

  @override
  void dispose() {
    _bmFatCtrl.dispose();
    _bmSnfCtrl.dispose();
    // _bmRateCtrl.dispose();
    _cmFatCtrl.dispose();
    _cmSnfCtrl.dispose();
    // _cmRateCtrl.dispose();
    super.dispose();
  }

  String? _numRequired(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final n = double.tryParse(v);
    if (n == null || n < 0) return 'Enter a valid number';
    return null;
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      "buffalo_fat_rate": double.parse(_bmFatCtrl.text.trim()),
      "buffalo_snf_rate": double.parse(_bmSnfCtrl.text.trim()),
      "cow_fat_rate": double.parse(_cmFatCtrl.text.trim()),
      "cow_snf_rate": double.parse(_cmSnfCtrl.text.trim()),
      "buffalo_fixed_rate": double.parse(_bmRateCtrl.text.trim()),
      "cow_fixed_rate": double.parse(_cmRateCtrl.text.trim()),
    };

    try {
      
      final payload = {
      "buffalo_fat_rate": double.parse(_bmFatCtrl.text.trim()),
      "buffalo_snf_rate": double.parse(_bmSnfCtrl.text.trim()),
      "cow_fat_rate": double.parse(_cmFatCtrl.text.trim()),
      "cow_snf_rate": double.parse(_cmSnfCtrl.text.trim()),
      "buffalo_fixed_rate": double.parse(_bmRateCtrl.text.trim()),
      "cow_fixed_rate": double.parse(_cmRateCtrl.text.trim()),
    };

    final response = await ApiService.post('/user-fat-snf-rates', payload);
    final data = response.data;

    if (data['status'] == true) {
        Get.snackbar("Rates Saved ✅", "Milk rates have been updated successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.shade100);
        Navigator.pop(context, payload);
      } else {
        Get.snackbar("Save Failed ❌", data['message'] ?? "Could not save milk rates",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade100);
      }
    }catch(e){
      print("Error saving rates: $e");
    }

   
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Rate chart')),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child:
              const Text('Save', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Text('Make rate',
                style:
                    theme.textTheme.titleMedium?.copyWith(color: Colors.green)),
            const SizedBox(height: 12),

            // ---- Buffalo ----
            Text('Buffalo Milk',
                style:
                    theme.textTheme.titleMedium?.copyWith(color: Colors.green)),
            const SizedBox(height: 8),
            _Tile(
              title: 'Buffalo Rate',
              subtitle: '₹ per fat unit',
              child: _NumInput(controller: _bmFatCtrl, validator: _numRequired),
            ),

            const SizedBox(height: 10),
            _Tile(
              title: 'Buffalo SNFBase',
              subtitle: '₹ per SNF kg',
              child: _NumInput(controller: _bmSnfCtrl, validator: _numRequired),
            ),
             const SizedBox(height: 8),
            _Tile(
              title: 'Buffalo Fixed Rate',
              subtitle: 'Fixed Rate Per Litre',
              child: _NumInput(controller: _bmRateCtrl, validator: _numRequired),
            ),

            const Divider(height: 32),

            // ---- Cow ----
            Text('Cow Rate',
                style:
                    theme.textTheme.titleMedium?.copyWith(color: Colors.green)),
            const SizedBox(height: 8),
            _Tile(
              title: 'Cow Rate',
              subtitle: '₹ per fat unit',
              child: _NumInput(controller: _cmFatCtrl, validator: _numRequired),
            ),
            const SizedBox(height: 10),
            _Tile(
              title: 'Cow SNFBase',
              subtitle: '₹ per SNF kg',
              child: _NumInput(controller: _cmSnfCtrl, validator: _numRequired),
            ),
             const SizedBox(height: 8),
            _Tile(
              title: 'Cow Fixed Rate',
              subtitle: 'Fixed Rate Per Litre',
              child: _NumInput(controller: _cmRateCtrl, validator: _numRequired),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  const _Tile({required this.title, this.subtitle, required this.child});

  @override
  Widget build(BuildContext context) {
    final hintStyle =
        Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54);
    return Material(
      elevation: .3,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(subtitle!, style: hintStyle),
            ],
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _NumInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const _NumInput({required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: 'Not set',
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 1.4),
        ),
      ),
    );
  }
}
