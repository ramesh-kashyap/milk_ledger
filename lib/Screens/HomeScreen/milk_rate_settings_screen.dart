import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/fat_snf_rate_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MilkRateSettingsScreen extends StatefulWidget {
  const MilkRateSettingsScreen({super.key});

  @override
  State<MilkRateSettingsScreen> createState() => _MilkRateSettingsScreenState();
}

class _MilkRateSettingsScreenState extends State<MilkRateSettingsScreen> {
  final _bmFatCtrl = TextEditingController();
  final _cmFatCtrl = TextEditingController();
  final _bmFixCtrl = TextEditingController();
  final _cmFixCtrl = TextEditingController();

  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadDefaults();
  }

  @override
  void dispose() {
    _bmFatCtrl.dispose();
    _cmFatCtrl.dispose();
    _bmFixCtrl.dispose();
    _cmFixCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadDefaults() async {
    try {
      final res = await ApiService.get("/rates/defaults");
      final Map<String, dynamic> data = (res.data is Map
              ? res.data['data'] as Map<String, dynamic>?
              : null) ??
          {};

      // helpers to read nested values safely
      double _get(String animal, String basis, String key, double def) {
        final a = data[animal];
        if (a is Map) {
          final b = a[basis];
          if (b is Map && b[key] != null) {
            final v = b[key];
            if (v is num) return v.toDouble();
            final parsed = double.tryParse(v.toString());
            if (parsed != null) return parsed;
          }
        }
        return def;
      }

      String _textOrEmpty(double v) => (v == 0) ? '' : v.toString();

      // BM (buffalo) – common fat rate and fixed rate
      final bmFatRate = _get('buffalo', 'fat', 'fat_rate', 0);
      final bmFixRate = _get('buffalo', 'rate', 'fixed_rate', 0);

      // CM (cow) – common fat rate and fixed rate
      final cmFatRate = _get('cow', 'fat', 'fat_rate', 0);
      final cmFixRate = _get('cow', 'rate', 'fixed_rate', 0);

      _bmFatCtrl.text = _textOrEmpty(bmFatRate);
      _cmFatCtrl.text = _textOrEmpty(cmFatRate);
      _bmFixCtrl.text = _textOrEmpty(bmFixRate);
      _cmFixCtrl.text = _textOrEmpty(cmFixRate);
    } catch (e) {
      debugPrint('Load defaults failed: $e');

      // graceful fallbacks
      _bmFatCtrl.text = '7.5';
      _cmFatCtrl.text = '7.0';
      _bmFixCtrl.text = '60';
      _cmFixCtrl.text = '55';
      _showSnack('Couldn\'t load current rates, using defaults');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final payload = {
        "bm_fat_rate": _toNumOrNull(_bmFatCtrl.text),
        "cm_fat_rate": _toNumOrNull(_cmFatCtrl.text),
        "bm_fixed_rate": _toNumOrNull(_bmFixCtrl.text),
        "cm_fixed_rate": _toNumOrNull(_cmFixCtrl.text),
      };

      print(payload);

      final response = await ApiService.post('/rates/defaults/save', payload);
      final data = response.data;
      if (data['status'] == true) {
        Get.snackbar(
            "Rates Saved ✅", "Milk rates have been updated successfully");
      } else {
        Get.snackbar(
            "Save Failed ❌", data['message'] ?? "Could not save milk rates");
      }
    } on DioException catch (e) {
      _showSnack(e.response?.data?['message']?.toString() ?? 'Save failed');
    } catch (e) {
      _showSnack('Save failed');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  // -------- helpers --------
  String _numOrEmpty(dynamic v, {required num defaultVal}) {
    if (v == null) return defaultVal.toString();
    if (v is num) return v == 0 ? defaultVal.toString() : v.toString();
    final parsed = num.tryParse(v.toString());
    return parsed == null || parsed == 0
        ? defaultVal.toString()
        : parsed.toString();
  }

  num? _toNumOrNull(String s) {
    final v = num.tryParse(s.trim());
    return v;
  }

  void _showSnack(String m) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Milk Rate Settings"),
      ),
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
          child: const Text("Save Rates",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _SectionCard(
            icon: Icons.opacity,
            title: "Common Rate (Fat based)",
            subtitle: "Set rate per fat unit for buffalo & cow",
            children: [
              Row(
                children: [
                  Expanded(
                      child: _RoundedInputFat(
                          label: "BM", ctrl: _bmFatCtrl, isFat: true)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _RoundedInputFat(
                          label: "CM", ctrl: _cmFatCtrl, isFat: true)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SectionCard(
            icon: Icons.attach_money,
            title: "Fixed Rate (per litre)",
            subtitle: "Set fixed price per litre of milk",
            children: [
              Row(
                children: [
                  Expanded(child: _RoundedInput(label: "BM", ctrl: _bmFixCtrl)),
                  const SizedBox(width: 12),
                  Expanded(child: _RoundedInput(label: "CM", ctrl: _cmFixCtrl)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          // inside MilkRateSettingsScreen
          _InfoCard(
            title: "Fat & SNF",
            subtitle: "Fat SNF Chart • Formula",
            onTap: () async {
              try {
                // 1. Load defaults from API
                final res = await ApiService.get("/rates/defaults");
                final data = (res.data is Map
                        ? res.data['data'] as Map<String, dynamic>?
                        : null) ??
                    {};

                // 2. Helper to safely extract a number
                double _get(
                    String animal, String basis, String key, double def) {
                  final a = data[animal];
                  if (a is Map) {
                    final b = a[basis];
                    if (b is Map) {
                      final v = b[key];
                      if (v is num) return v.toDouble();
                      final p = double.tryParse(v?.toString() ?? '');
                      if (p != null) return p;
                    }
                  }
                  return def;
                }

                // 3. Push FatSnfRateScreen with defaults
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FatSnfRateScreen(
                      buffaloFatRate: _get('buffalo', 'fat_snf', 'fat_rate', 0),
                      buffaloSnfRate: _get('buffalo', 'fat_snf', 'snf_rate', 0),
                      cowFatRate: _get('cow', 'fat_snf', 'fat_rate', 0),
                      cowSnfRate: _get('cow', 'fat_snf', 'snf_rate', 0),
                      cowRate: _get('cow', 'fat_snf', 'fixed_rate', 0),
                      buffaloRate: _get('buffalo', 'fat_snf', 'fixed_rate', 0),
                    ),
                  ),
                );

                // 4. Update controllers after screen returns
                if (result is Map) {
                  _bmFatCtrl.text =
                      (result['buffalo_fat_rate'] ?? '').toString();
                  _cmFatCtrl.text = (result['cow_fat_rate'] ?? '').toString();
                  // if you want SNF also:
                  // _bmSnfCtrl.text = (result['buffalo_snf_rate'] ?? '').toString();
                  // _cmSnfCtrl.text = (result['cow_snf_rate'] ?? '').toString();

                  setState(() {});
                }
              } catch (e) {
                debugPrint("Error opening FatSnfRateScreen: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Failed to load Fat & SNF rates")),
                );
              }
            },
          ),
          const SizedBox(height: 18),
          Text(
            "Tip: If you buy & sell milk then fill both the fat rate and fixed rate. "
            "For local sale, you can just enter fixed rate. "
            "Further you can customize it for every seller or buyer.",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

/// ---------- UI helpers ----------

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: .5,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              CircleAvatar(
                backgroundColor: Colors.green.withOpacity(.12),
                child: Icon(icon, color: Colors.green),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54)),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _RoundedInput extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;

  const _RoundedInput({required this.label, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true, signed: false),
      decoration: InputDecoration(
        labelText: label,
        hintText: "Not set",
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
      ),
    );
  }
}

class _RoundedInputFat extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final bool isFat;

  const _RoundedInputFat(
      {required this.label, required this.ctrl, this.isFat = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      inputFormatters: isFat
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // optional
              AutoDotOneDecimalFormatter(),
            ]
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: isFat ? '' : 'Not set',
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
      ),
    );
  }
}

class AutoDotOneDecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final isBackspace = newValue.text.length < oldValue.text.length;

    // If user backspaced and the raw string now ends with a dot like "7."
    // clear the field entirely.
    if (isBackspace && newValue.text.trim().endsWith('.')) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Keep only digits
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Nothing left
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }

    String formatted;

    if (digits.length == 1) {
      // Only first digit, no dot yet
      formatted = digits;
    } else {
      // Insert dot after first digit, but allow only ONE decimal digit
      final first = digits.substring(0, 1);
      final dec = digits.substring(1); // all after first
      final oneDec = dec.substring(0, 1); // keep only one decimal digit
      formatted = '$first.$oneDec';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
      composing: TextRange.empty,
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _InfoCard(
      {required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: .5,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.bar_chart, color: Colors.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
