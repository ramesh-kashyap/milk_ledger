import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
// CHANGE this import to your actual ApiService path:
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/add_customer_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/delete_milk_enteries.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/bulk_entry_screen.dart';

class MilkEntryScreen extends StatefulWidget {
  const MilkEntryScreen({super.key});

  @override
  State<MilkEntryScreen> createState() => _MilkEntryScreenState();
}



class _MilkEntryScreenState extends State<MilkEntryScreen> {
  final _formKey = GlobalKey<FormState>();
@override
void initState() {
  super.initState();
 _allResultst();
 _loadRecentEntries();
 
}
  // form state
  DateTime date = DateTime.now();
  String session = 'PM'; // AM / PM
  Map<String, dynamic>? seller; // current selected
  final litresCtrl = TextEditingController();
  final fatCtrl = TextEditingController();
  final rateCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  final snfCtrl = TextEditingController(); // 👈 NEW
  final fatCtrl1 = TextEditingController();
  final fatSnfCtrl = TextEditingController();
  final fixRateCtrl = TextEditingController();
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool _isSubmitting = false;
  bool zero = false;
  String animal = 'buffalo'; // cow/buffalo

  // which inputs to show (depends on selected customer's price basis)
  bool showFat = false;
  bool showRate = true;
  bool showSnf = false; // 👈 NEW

   List<Map<String, dynamic>> _recentEntries = [];
   bool _loadingEntries = false;

  num get snf => num.tryParse(snfCtrl.text) ?? 0; // 👈 NEW
void _fillFatSnfRatesForAnimal(String animal) {
  // Make sure we already fetched allRates from the API
  if (allRates.isEmpty) {
    debugPrint("No allRates data yet");
    return;
  }

  final animalRates = allRates[animal]; // e.g., allRates['cow'] or allRates['buffalo']
  if (animalRates == null) {
    debugPrint("No rates found for animal: $animal");
    fatCtrl1.text = '';
    fatSnfCtrl.text = '';
    return;
  }

  double fatRate1 = 0;
  double fatSnfRate = 0;
  double fixRate = 0;
  // Get the fat-only rate
  if (animalRates['fat_snf'] != null && (animalRates['fat_snf'] as List).isNotEmpty) {
    fatRate1 = (animalRates['fat_snf'][0]['fat_rate'] ?? 0).toDouble();
  }

  // Get the fat+snf rate
  if (animalRates['fat_snf'] != null && (animalRates['fat_snf'] as List).isNotEmpty) {
    fatSnfRate = (animalRates['fat_snf'][0]['snf_rate'] ?? 0).toDouble();
  }
  if (animalRates['fat_snf'] != null && (animalRates['fat_snf'] as List).isNotEmpty) {
    fixRate = (animalRates['fat_snf'][0]['fixed_rate'] ?? 0).toDouble();
  }

  fatCtrl1.text = fatRate1 == 0 ? '' : fatRate1.toStringAsFixed(2);
  fatSnfCtrl.text = fatSnfRate == 0 ? '' : fatSnfRate.toStringAsFixed(2);
  fixRateCtrl.text = fixRate == 0 ? '' : fixRate.toStringAsFixed(2);
  debugPrint(
    "Rates for $animal → FAT: ${fatCtrl1.text}, SNF: ${fatSnfCtrl.text}"
  );
}


  // enabled animals for the selected customer
  bool isCashSell = false;
  bool cowEnabled = true;
  bool buffaloEnabled = true;
   Map<String, dynamic> allRates = {};
  num get litres => num.tryParse(litresCtrl.text) ?? 0;
  num get rate => num.tryParse(rateCtrl.text) ?? 0;
  num get amount => (litres * rate);

  String _normBasis(dynamic b) {
    final s = (b ?? 'rate')
        .toString()
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll('-', '')
        .replaceAll('_', '');
    if (s == 'rate') return 'rate';
    if (s == 'fat') return 'fat';
    if (s == 'fatsnf' || s == 'fat+snf') return 'fat_snf';
    return 'rate';
  }

  @override
  void dispose() {
    litresCtrl.dispose();
    fatCtrl.dispose();
    snfCtrl.dispose(); // 👈 NEW
    rateCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  // ---------- helpers ----------
  static bool _toBool(dynamic v) {
    if (v == null) return false;
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase();
      return s == '1' || s == 'true' || s == 'yes';
    }
    return false;
  }

  static num _toNum(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v;
    return num.tryParse(v.toString()) ?? 0;
  }

  num _animalValueFor(Map<String, dynamic> src, String a) {
    return a == 'buffalo'
        ? _toNum(src['buffaloValue'])
        : _toNum(src['cowValue']);
  }

  num _rateFromFat() {
    if (seller == null) return 0;
    final fat = num.tryParse(fatCtrl.text) ?? 0;
    final perFat = _animalValueFor(seller!, animal); // money per 1.0 fat
    return fat * perFat;
  }

  num _rateFromFatSnf() {
    if (seller == null) return 0;

    final f = num.tryParse(fatCtrl.text) ?? 0;
    final s = num.tryParse(snfCtrl.text) ?? 0;

    final perFat = _animalValueFor(seller!, animal); // ₹ per 1 fat
    debugPrint('per Fat → ${_toNum(fatSnfCtrl.text)}');

    final perfat = fatCtrl1.text.trim().isEmpty
        ? 0
        : _toNum(fatCtrl1.text); // ₹ per 1 snf
     print('per Snf → $perfat');
    // fixedRate depends on animal
    final snfRate = fatSnfCtrl.text.trim().isEmpty
        ? 0
        : _toNum(fatSnfCtrl.text); // ₹ fixed rate

    final fixRate0 = fixRateCtrl.text.trim().isEmpty
        ? 0
        : _toNum(fixRateCtrl.text); // ₹ fixed rate
    //  final perLiter = ((f * perfat) + (s * snfRate) +55)/1000;

    final perLiter = ((f + s)/(perfat/10 + snfRate/10))*(fixRate0/100);
  print("Calculated perLiters: $perLiter for Fat: $f, SNF: $s, perFat: $perfat, snfRate: $snfRate, litres: ${litresCtrl.text}, fixRate: $fixRate0");
 
     return  perLiter ;

  }

  void _recompute() {
    if (zero) {
      rateCtrl.text = '0';
      setState(() {});
      return;
    }

    if (showFat && showSnf) {
      final hasAny =
          fatCtrl.text.trim().isNotEmpty || snfCtrl.text.trim().isNotEmpty;
      if (!hasAny) {
        rateCtrl.text = '';
      } else {
        final r = _rateFromFatSnf();
        rateCtrl.text = r == 0 ? '' : r.toStringAsFixed(2);
      }
    } else if (showFat) {
      if (fatCtrl.text.trim().isEmpty) {
        rateCtrl.text = '';
      } else {
        final r = _rateFromFat();
        rateCtrl.text = r == 0 ? '' : r.toStringAsFixed(2);
      }
    } else if (showRate && seller != null && rateCtrl.text.trim().isEmpty) {
      final v = _animalValueFor(seller!, animal);
      rateCtrl.text = v == 0 ? '' : v.toStringAsFixed(2);
    }

    setState(() {});
  }

  /// --- Fetch sellers from API, fallback to some defaults ---
  Future<List<Map<String, dynamic>>> fetchSellers(String q) async {
    try {
      // Your API: POST /customers/list  (change to GET if needed)
      final res = await ApiService.post('/customers/list', {});
      final data = res.data;
      print("/customers/list response: $data");

      // Adjust this based on your real response shape
      final List list = (data is Map && data['items'] is List)
          ? data['items']
          : (data is List ? data : []);

      // Normalize items to a single map shape used by the UI

      final normalized = list.map<Map<String, dynamic>>((e) {
        final basis = _normBasis(e['basis']);

        final cowValue = _toNum(e['cowValue'] ?? e['cowValue']);
        final buffaloValue = _toNum(e['buffaloValue'] ?? e['buffaloValue']);

        final cowSnf = _toNum(e['cowValue'] ?? e['cowValue'] ?? e['cowValue']);
        final buffaloSnf =
            _toNum(e['buffaloValue'] ?? e['buffaloValue'] ?? e['buffaloValue']);

        return {
          'id': e['id'],
          'name': e['name'],
          'code': (e['code'] ?? e['code'])?.toString(),
          'customer_type': (e['customerType'] ?? e['customerType'])?.toString(),
          'cowEnabled': _toBool(e['cowEnabled'] ?? e['cowEnabled']),
          'buffaloEnabled': _toBool(e['buffaloEnabled'] ?? e['buffaloEnabled']),
          'cowValue': cowValue,
          'buffaloValue': buffaloValue,
          'cowSnfValue': basis == 'fatSnf' ? cowSnf : 0,
          'buffaloSnfValue': basis == 'fatSnf' ? buffaloSnf : 0,
          'basis': basis,
        };
      }).toList();

      // filter by name or code
      if (q.trim().isEmpty) return normalized;
      final ql = q.toLowerCase();
      return normalized
          .where((e) =>
              (e['name']?.toString().toLowerCase().contains(ql) ?? false) ||
              (e['code']?.toString().contains(q) ?? false))
          .toList();
    } catch (_) {
      // Fallback defaults if API fails
      final defaults = [
        {
          'id': 1,
          'name': 'Rameshk',
          'code': '0',
          'cowEnabled': false,
          'buffaloEnabled': true,
          'cowValue': 0,
          'buffaloValue': 46.0,
          'basis': 'rate',
        },
        {
          'id': 2,
          'name': 'Anuj',
          'code': '088',
          'cowEnabled': true,
          'buffaloEnabled': false,
          'cowValue': 34.0,
          'buffaloValue': 0,
          'basis': 'fat', // fat-based pricing for demo
        },
        {
          'id': 3,
          'name': 'Meena',
          'code': '121',
          'cowEnabled': true,
          'buffaloEnabled': true,
          'cowValue': 32.0,
          'buffaloValue': 44.0,
          'basis': 'rate',
        },
      ];
      if (q.isEmpty) return defaults;
      final ql = q.toLowerCase();
      return defaults
          .where((e) =>
              e['name']!.toString().toLowerCase().contains(ql) ||
              e['code']!.toString().contains(q))
          .toList();
    }
  }

  Future<void> pickSeller() async {
    final picked = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _SellerPicker(fetch: fetchSellers),
    );

  //    if (picked != null) {
  //   print("Initial basis: ${picked['basis']}");
  //   _loadRecentEntries();
  //   final basis = _normBasis(picked['basis']);
  //   showSnf = basis == 'fat_snf';   // use underscore, not fatSnf
  //   print("After normalization: $basis, showSnf: $showSnf");
  //   _applySellerDefaults(picked);
  //   _fillFatSnfRatesForAnimal(animal);
  //   setState(() {}); // refresh the UI to show SNF field if needed
  // } else {
  //   showSnf = false;
  // }


  if (picked != null) {
  if (picked['type'] == 'cash_sell') {
    print("🟢 Cash Sell selected");
    // Handle your cash sell logic here
    setState(() {
      showSnf = false;
      isCashSell = true;
       seller = {
          'id': null,
          'name': 'Cash',
          'code': 'CASH',
          'basis': 'fat'
        };  // No customer selected
    });
  } else {
    print("Seller selected: ${picked['name']}");
    final basis = _normBasis(picked['basis']);
    showSnf = basis == 'fat_snf';
    _applySellerDefaults(picked);
    _fillFatSnfRatesForAnimal(animal);
  }
  setState(() {});
} else {
  showSnf = false;
}

  }


   Future<void> _allResultst() async {
  try {
    final res = await ApiService.get('/all-fat-snf-rates');
    // print("/all-fat-snf-rates ${res.data}");
      final data = res.data;
      if(data['status'] == true){
          setState(() {
        allRates = res.data['data'] as Map<String, dynamic>;
      });
      }
  } catch (e) {
    print("Error fetching initial sellers: $e");
  }
}

 Future<void> _loadRecentEntries() async {
 
  setState(() => _loadingEntries = true);
  try {
    // Pass customer_id as a query parameter
    print('Session: ${session}, Date: ${date.toIso8601String().substring(0, 10)}');
    final formattedDate = date.toIso8601String().substring(0, 10);
    final res = await ApiService.get(
  '/recent-milk-entries');

    final data = res.data;

  
    if (data['status'] == true && data['data'] is List) {
       final allEntries = List<Map<String, dynamic>>.from(data['data']);

      // 🔽 Apply frontend filters
      final filteredEntries = allEntries.where((entry) {
        final entrySession = entry['session']?.toString().toUpperCase() ?? '';
        final entryDate = entry['date']?.toString().substring(0, 10) ?? '';

        return entrySession == session.toUpperCase() &&
               entryDate == formattedDate;
      }).toList();

      setState(() {
        _recentEntries = filteredEntries;
      });

      print('✅ Filtered entries count: ${filteredEntries.length}');
    }
  } catch (e) {
    print("Error loading recent entries: $e");
    setState(() => _recentEntries = []);
  } finally {
    setState(() => _loadingEntries = false);
  }
}

  void _applySellerDefaults(Map<String, dynamic> s) {
    // enabled animals
    final ce = _toBool(s['cowEnabled']);
    final be = _toBool(s['buffaloEnabled']);
      
    // choose default animal
    String defaultAnimal;
    if (be) {
      defaultAnimal = 'buffalo';
      print("Default animal set to buffalo");
    } else if (ce) {
      defaultAnimal = 'cow';
      print("Default animal set to cow");
    } else {
      defaultAnimal = 'cow';
    }
    print("Basis in _applySellerDefaults: ${s['basis']}");
    // pick rate by animal (used only for basis == rate)
    final rateFromAnimal = defaultAnimal == 'buffalo'
        ? _toNum(s['buffaloValue'])
        : _toNum(s['cowValue']);

    // basis

    setState(() {
      seller = s;
      cowEnabled = ce;
      buffaloEnabled = be;
      animal = defaultAnimal;

      print("Applying animal: $animal");
      final basis = _normBasis(s['basis']);
    print("Applying basis: $s");
      showFat = basis == 'fat' || basis == 'fat_snf';
      showSnf = basis == 'fat_snf';
      showRate = basis == 'rate';

      // prefill rate field if needed (for basis==rate)
      rateCtrl.text = showRate
          ? (rateFromAnimal == 0 ? '' : rateFromAnimal.toString())
          : '';
      fatCtrl.text = '';
      zero = false;
    });

    _recompute(); // ensure summary matches basis & defaults
  }


  Future<void> pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => date = d);
    _loadRecentEntries();
  }

  // When animal tile tapped
  void _onAnimalChange(String a) {
    if (a == 'cow' && !cowEnabled) return;
    if (a == 'buffalo' && !buffaloEnabled) return;
      print("Animal changed to: $a");

    setState(() {
      animal = a;
      if (seller != null) {
        if (showRate) {
          final v = _animalValueFor(seller!, animal);
          rateCtrl.text = v == 0 ? '' : v.toStringAsFixed(2);
        } else {
          // basis==fat -> rate is derived via _recompute
        }
      }
  _fillFatSnfRatesForAnimal(a);  // <-- add this
    
    });
    _recompute();
  }

  void onZeroChanged(bool val) {
    setState(() {
      zero = val;
      if (zero) {
        litresCtrl.text = '0';
      }
    });
    _recompute();
  }

 Future<void> save() async {
  
  if (seller == null) {
    Get.snackbar("Warning", "Please select a customer");
    return;
  }
  if (!zero) {
    if (litres <= 0) {
      Get.snackbar("Warning", "Enter litres");
      return;
    }
    if (showRate && (rateCtrl.text.trim().isEmpty || rate <= 0)) {
      Get.snackbar("Warning", "Enter rate / litre");
      return;
    }
    if (showFat && fatCtrl.text.trim().isEmpty) {
      Get.snackbar("Warning", "Enter fat");
      return;
    }
  }

  if (_isSubmitting) return;
  setState(() => _isSubmitting = true);

  final payload = {
    'date': date.toIso8601String().substring(0, 10),
    'session': session,
    'customer_id': isCashSell ? null : seller?['id'],
    'litres': zero ? 0 : litres,
    'fat': zero ? null : (num.tryParse(fatCtrl.text) ?? null),
    'rate': zero ? 0 : rate,
    'snf': zero ? null : (num.tryParse(snfCtrl.text) ?? null),
    'amount': zero ? 0 : amount,
    'animal': animal,
    'basis': seller!['basis'],
    'zero': zero,
    "type": isCashSell ? "cash_sell" : "regular",
  };

  try {
    final response = await ApiService.post('/save/milk-entries', payload);
    final data = response.data;

    // 🧩 If backend detects duplicate
    if ( data['duplicate'] == true) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Duplicate Entry"),
          content: Text("An entry already exists. Do you want to add anyway?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Yes"),
            ),
          ],
        ),
      );

      // 👇 if user confirms, send again with force=true
      if (confirm == true) {
            payload['forceSave'] = true;
            final retry = await ApiService.post('/save/milk-entries', payload);
            final retryData = retry.data;
        if (retryData['status'] == true) {
            Get.snackbar("Success 🎉", "Milk entry saved successfully"); 
            _loadRecentEntries();        
            // Navigator.pop(context, retry);
        } else {
          Get.snackbar("Error", retryData['message'] ?? "Something went wrong");
        }
      }

      setState(() => _isSubmitting = false);
      return;
    }

    // ✅ Normal success
    if (data['status'] == true) {
      Get.snackbar("Success 🎉", "Milk entry saved successfully");
      _loadRecentEntries();  
    } else {
      Get.snackbar("Milk Add Failed", data['message'] ?? "Something went wrong");
    }

  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Error saving milk entry: $e")));
  } finally {
    if (mounted) setState(() => _isSubmitting = false);
  }
}

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

   Future<String?> _selectCustomerType(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("select_customer_type".tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: Text("seller".tr),
              onTap: () => Navigator.pop(ctx, "Seller"),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
             title: Text("purchaser".tr),
              onTap: () => Navigator.pop(ctx, "Purchaser"),
            ),
            const Divider(),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Colors.orange),
            title: const Text("Cash Sell"),
            onTap: () => Navigator.pop(ctx, "Cash Sell"),
          ),
          ],
        ),
      ),
    );
  }

  // ---------- OPTION 1: Edit action in AppBar ----------
  void _openEditCustomerSheet() async {
    if (seller == null) return;

    // seed with current values
    final nameCtrl =
        TextEditingController(text: seller!['name']?.toString() ?? '');
    final codeCtrl =
        TextEditingController(text: seller!['code']?.toString() ?? '');

    final cowValCtrl =
        TextEditingController(text: _toNum(seller!['cowValue']).toString());
    final bufValCtrl =
        TextEditingController(text: _toNum(seller!['buffaloValue']).toString());

    // Per-SNF (may be 0 / absent for non fat_snf basis)
    final cowSnfCtrl =
        TextEditingController(text: _toNum(seller!['cowSnfValue']).toString());
    final bufSnfCtrl = TextEditingController(
        text: _toNum(seller!['buffaloSnfValue']).toString());

    bool ce = _toBool(seller!['cowEnabled']);
    bool be = _toBool(seller!['buffaloEnabled']);
    String basis = _normBasis(seller!['basis']);
   





    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final inset = MediaQuery.of(ctx).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: inset),
          child: SafeArea(
            child: StatefulBuilder(
              builder: (ctx, setModalState) {
                // small helpers
                InputDecoration _dec(String label, {String? helper}) =>
                    InputDecoration(
                      labelText: label,
                      helperText: helper,
                      border: const OutlineInputBorder(),
                    );

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Text('Edit customer',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(ctx),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      TextField(controller: nameCtrl, decoration: _dec('Name')),
                      const SizedBox(height: 10),
                      TextField(controller: codeCtrl, decoration: _dec('Code')),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: SwitchListTile(
                              title: const Text('Cow enabled'),
                              contentPadding: EdgeInsets.zero,
                              value: ce,
                              onChanged: (v) => setModalState(() => ce = v),
                              
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SwitchListTile(
                              title: const Text('Buffalo enabled'),
                              contentPadding: EdgeInsets.zero,
                              value: be,
                              onChanged: (v) => setModalState(() => be = v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      DropdownButtonFormField<String>(
                        value: basis,
                        decoration: _dec('Price basis'),
                        items: const [
                          DropdownMenuItem(
                              value: 'rate', child: Text('Rate (₹/litre)')),
                          DropdownMenuItem(
                              value: 'fat', child: Text('Fat-based')),
                          DropdownMenuItem(
                              value: 'fat_snf', child: Text('Fat + SNF')),
                        ],
                        onChanged: (v) =>
                            setModalState(() => basis = v ?? 'rate'),
                      ),
                      const SizedBox(height: 10),

                      // Per-unit values row (meaning changes with basis)
                      if(basis != 'fat_snf') ...[
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: cowValCtrl,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: _dec('Cow Fat Rate'),
                                enabled: ce, 
                              ),
                            ),
                            const SizedBox(width: 10),
                          
                            Expanded(
                              child: TextField(
                                controller: bufValCtrl,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: _dec(
                                'Buffalo Fat Rate',
                              ),
                               enabled: be, 
                            ),
                          ),
                         
                        ],
                      ),
                        const SizedBox(height: 6),
                      ],
                   

                      if (basis == 'fatsnf') ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: cowSnfCtrl,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: _dec('Cow SNF value'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: bufSnfCtrl,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: _dec('Buffalo SNF value'),
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () async{
                           
                            final updated = {
                              ...seller!,
                              'name': nameCtrl.text.trim().isEmpty
                                  ? seller!['name']
                                  : nameCtrl.text.trim(),
                              'code': codeCtrl.text.trim().isEmpty
                                  ? seller!['code']
                                  : codeCtrl.text.trim(),
                                  
                              'cowEnabled': ce,
                              'buffaloEnabled': be,
                              'basis': basis, // 'rate' | 'fat' | 'fat_snf'
                              // When basis = rate → these are ₹/litre
                              // When basis = fat/fat_snf → these are ₹ per 1 FAT
                              'cowValue': _toNum(cowValCtrl.text.trim()),
                              'buffaloValue': _toNum(bufValCtrl.text.trim()),
                             
                              // Only meaningful for fat_snf
                              // 'cowSnfValue': basis == 'fat_snf'
                              //     ? _toNum(cowSnfCtrl.text.trim())
                              //     : 0,
                              // 'buffaloSnfValue': basis == 'fat_snf'
                              //     ? _toNum(bufSnfCtrl.text.trim())
                              //     : 0,
                            };

                            _applySellerDefaults(updated);
                            // Navigator.pop(ctx);                                 
                            print("Updated customer: $updated");
                            // TODO: persist to API if needed
                            // await ApiService.post('/customers/update', {...});
                            try {
                             final response = await ApiService.post(
                                 '/updateCustomer', updated);
                              final data = response.data;

                              if(data['status'] == true){
                                final customerId = data['id'];
                                print("Customer updated with ID: $customerId");
                                Get.snackbar("Success 🎉", "Customer has been updated successfully");                                  
                              } else {
                                Get.snackbar("Update Failed", data['message'] ?? "Something went wrong");
                              }
                                
                            } catch (e) {
                              print("Error updating customer: $e");
                            }
                          },
                          child: Text('save'.tr),
                        ),
                      ),
                      
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
  title: Text('milk_collection'.tr),
  centerTitle: false,
  actions: [
    if (seller != null)
      IconButton(
        icon: const Icon(Icons.edit),
        tooltip: 'edit_customer'.tr,
        onPressed: _openEditCustomerSheet,
      ),
    IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Add New',
      onPressed: () async {
    final type = await _selectCustomerType(context);
   if (type == "Cash Sell") {
  setState(() {
    isCashSell = true;
    seller = null;
  });
} else if (type != null) {
  Get.to(() => AddCustomerScreen(customerType: type));
}
  },
    ),
  ],
),

      // bottom action bar
    

    body: Stack(
    children: [
      ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          //////////// ---- Summary bar ---- \\\\\\\\\
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                Text('amount'.tr, style: TextStyle(color: Colors.green.shade700)),
                Text(zero ? '0.00' : amount.toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                Text('per_litre'.tr,
                    style: TextStyle(color: Colors.green.shade700)),
                Text(rate.toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // ---- Date + AM/PM ----
          Row(
            children: [
              _HeaderPill(
                icon: Icons.calendar_today_outlined,
                label: _fmt(date),
                onTap: pickDate,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SegmentedButton<String>(
                  segments: [
                    ButtonSegment(value: 'AM', label: Text('am'.tr)),
                    ButtonSegment(value: 'PM', label: Text('pm'.tr)),
                  ],
                  selected: {session},
                  onSelectionChanged: (s) {
      setState(() {
        session = s.first;
      });
      _loadRecentEntries(); // 🔥 reload entries after changing session
    },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ---- Seller ----
          _Card(
            child: ListTile(
              onTap: pickSeller,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                 child: Icon(
        seller?['customer_type'] == 'Seller'
            ? Icons.storefront          // 👨‍🌾 seller icon
            : Icons.shopping_cart,          // 🛒 purchaser icon
        color: seller?['customer_type'] == 'Seller'
            ? Colors.green
            : Colors.blue,
      ),
              ),
              title: Text(seller?['name'] ?? 'select_customer'.tr,
                  style: theme.textTheme.titleMedium),
              subtitle: seller == null
                  ? Text('tap_to_search'.tr)
                  : Text('${'code'.tr}: ${seller!['code']}',
                      style: theme.textTheme.bodySmall),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 12),

          // ---- Animal selector (images) ----
          _Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  child: SizedBox(
                    height: 60, // 👈 makes it smaller
                    child: Row(
                      children: [
                        Expanded(
                          child: _AnimalTile(
                            // label: 'cow'.tr,
                            asset: 'assets/images/cow-icon.png',
                            selected: animal == 'cow',
                            disabled: !cowEnabled,
                            onTap: () => _onAnimalChange('cow'),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: _AnimalTile(
                            // label: 'buffalo'.tr,
                            asset: 'assets/images/buffalo.png',
                            selected: animal == 'buffalo',
                            disabled: !buffaloEnabled,
                            onTap: () => _onAnimalChange('buffalo'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

          const SizedBox(height: 12),

          // ---- Entry form ----
          _Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _NumField(
                      label: 'milk_litres'.tr,
                      controller: litresCtrl,
                      enabled: !zero,
                      onChanged: (_) => _recompute(),
                      validator: (v) {
                        if (zero) return null;
                        final n = num.tryParse(v ?? '');
                        if (n == null || n <= 0) return 'enter_litres'.tr;
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    if (showRate) ...[
                      _NumField(
                        label: 'rate_per_litre'.tr,
                        controller: rateCtrl,
                        enabled: !zero,
                        onChanged: (_) => _recompute(),
                        validator: (v) {
                          if (zero) return null;
                          final n = num.tryParse(v ?? '');
                          if (n == null || n <= 0) return 'enter_rate'.tr;
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (showFat) ...[
                      _NumFieldFat(
                        label: 'fat'.tr,
                        controller: fatCtrl,
                        enabled: !zero,
                        isFat: true, // 👈 tells it to use fatAutoDotFormatter
                        onChanged: (_) => _recompute(),
                        validator: (v) {
                          if (zero) return null;
                          if (showFat && (v == null || v.trim().isEmpty)) {
                             return 'enter_fat'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (showSnf) ...[
                      // 👈 NEW
                      _NumFieldFat(
                        label: 'snf'.tr,
                        controller: snfCtrl,
                        enabled: !zero,
                        isFat:
                            true, // use same formatter (auto dot) for 1–2 decimals
                        onChanged: (_) => _recompute(),
                        validator: (v) {
                          if (zero) return null;
                          if (showSnf && (v == null || v.trim().isEmpty))
                            return 'enter_snf'.tr;
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                    _ReadOnlyField(
                      label: 'amount'.tr,
                      value: zero ? '0.00' : amount.toStringAsFixed(2),
                    ),
                    const SizedBox(height: 6),
                    SwitchListTile(
                      value: zero,
                      onChanged: onZeroChanged,
                      title: Text('zero'.tr),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 10),
                      ElevatedButton(
            onPressed: _isSubmitting ? null : save,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'save'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                      ),

                  ],
                ),
              ),
            ),
          ),
        
          //  if (_recentEntries.isNotEmpty) ...[
          //         const SizedBox(height: 24),
          //         Row(
          //           children: [
          //             Text(
          //               'recent_entries'.tr,
          //               style: theme.textTheme.titleMedium?.copyWith(
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //             const Spacer(),
          //             IconButton(
          //               icon: Icon(Icons.refresh, size: 20),
          //               onPressed: _loadRecentEntries,
          //               tooltip: 'refresh'.tr,
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 8),
          //       ],

if (_recentEntries.isNotEmpty)
  Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      height: 400, // you can adjust height
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: ListView(
        children: [
          // 🟢 BUY SECTION
          if (_recentEntries.any((e) => e['note'] == 'Buy')) ...[
            // Section title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.green.shade50,
               alignment: Alignment.center,
              child: const Text(
                'Buy Entries',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),

            // Table header
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Text('Ac No', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Milk', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Fat', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Rate', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),

            // Buy entries list
            ..._recentEntries
                .where((entry) => entry['note'] == 'Buy' )
                .map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text('${entry['Customer']?['code'] ?? 'Cash'} ${entry['Customer']?['name'] ?? ''}')),
                          Expanded(child: Text('${entry['litres'] ?? 0}')),
                          Expanded(child: Text('${entry['fat'] ?? 0}')),
                          Expanded(child: Text('${entry['rate'] ?? 0}')),
                          Expanded(
                            child: Text(
                              '${entry['amount'] ?? 0}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),

            // Buy Total row
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text('Total (Buy)', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text(
                      _recentEntries
                          .where((e) => e['note'] == 'Buy' )
                          .fold<double>(0, (sum, e) => sum + (double.tryParse('${e['litres']}') ?? 0))
                          .toStringAsFixed(2),
                    ),
                  ),
                    // 🧈 Total Fat
    Expanded(
  child: Text(
    (() {
      // Filter only 'Buy' entries
      final buyList = _recentEntries.where((e) => e['note'] == 'Buy' ).toList();
      if (buyList.isEmpty) return '0.00';

      // Sum up all fat values
      final totalFat = buyList.fold<double>(
        0,
        (sum, e) => sum + (double.tryParse(e['fat']?.toString() ?? '0') ?? 0),
      );

      // Calculate average fat
      final averageFat = totalFat / buyList.length;

      return averageFat.toStringAsFixed(2);
    })(),
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
),


    // 💰 Average Rate
   Expanded(
  child: Text(
    (() {
      // 🔹 Filter only entries with note == 'Buy'
      final buyList = _recentEntries.where((e) => e['note'] == 'Buy' ).toList();
      
      if (buyList.isEmpty) return '0.00'; // no entries = 0.00
      
      // 🔹 Sum up all rates safely
      final totalRate = buyList.fold<double>(
        0,
        (sum, e) => sum + (double.tryParse(e['rate']?.toString() ?? '0') ?? 0),
      );
      
      // 🔹 Calculate average
      final averageRate = totalRate / buyList.length;
      
      return averageRate.toStringAsFixed(2);
    })(),
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
),
                  Expanded(
                    child: Text(
                      _recentEntries
                          .where((e) => e['note'] == 'Buy' )
                          .fold<double>(0, (sum, e) => sum + (double.tryParse('${e['amount']}') ?? 0))
                          .toStringAsFixed(2),
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
          ],

          // 🔴 SALE SECTION
          if (_recentEntries.any((e) => (e['note'] == 'Sale' || e['note'] == 'Cash Sale'))) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.red.shade50,
               alignment: Alignment.center,
              child: const Text(
                'Sale Entries',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),

            // Table header
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Text('Ac No', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Milk', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Fat', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Rate', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),

            // Sale entries list
            ..._recentEntries
                .where((entry) => (entry['note'] == 'Sale'  || entry['note'] == 'Cash Sale') )
                .map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                         Expanded(
  flex: 2,
  child: Text(
    entry['Customer'] != null
        ? '${entry['Customer']['code']} ${entry['Customer']['name']}'
        : 'Cash Sale',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color:  Colors.black,
    ),
  ),
),

                          Expanded(child: Text('${entry['litres'] ?? 0}')),
                          Expanded(child: Text('${entry['fat'] ?? 0}')),
                          Expanded(child: Text('${entry['rate'] ?? 0}')),
                          Expanded(
                            child: Text(
                              '${entry['amount'] ?? 0}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text('Total (Sale)', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text(
                      _recentEntries
                          .where((e) => (e['note'] == 'Sale'  || e['note'] == 'Cash Sale') )
                          .fold<double>(0, (sum, e) => sum + (double.tryParse('${e['litres']}') ?? 0))
                          .toStringAsFixed(2),
                    ),
                  ),
                  Expanded(
  child: Text(
    (() {
      // 🔹 Filter today’s Sale and Cash Sale entries
      final saleList = _recentEntries.where((e) =>
          (e['note'] == 'Sale' || e['note'] == 'Cash Sale') ).toList();

      if (saleList.isEmpty) return '0.00';

      // 🔹 Sum the fat values
      final totalFat = saleList.fold<double>(
        0,
        (sum, e) => sum + (double.tryParse(e['fat']?.toString() ?? '0') ?? 0),
      );

      // 🔹 Calculate average fat
      final averageFat = totalFat / saleList.length;

      return averageFat.toStringAsFixed(2);
    })(),
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
),


    // 💰 Average Rate
   Expanded(
  child: Text(
    (() {
      // 🔹 Filter today's Sale or Cash Sale entries
      final saleList = _recentEntries.where((e) =>
          (e['note'] == 'Sale' || e['note'] == 'Cash Sale')).toList();

      if (saleList.isEmpty) return '0.00';

      // 🔹 Sum up the rates
      final totalRate = saleList.fold<double>(
        0,
        (sum, e) => sum + (double.tryParse(e['rate']?.toString() ?? '0') ?? 0),
      );

      // 🔹 Calculate average
      final averageRate = totalRate / saleList.length;

      return averageRate.toStringAsFixed(2);
    })(),
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
),

                  Expanded(
                    child: Text(
                      _recentEntries
                          .where((e) => (e['note'] == 'Sale' || e['note'] == 'Cash Sale') )
                          .fold<double>(0, (sum, e) => sum + (double.tryParse('${e['amount']}') ?? 0))
                          .toStringAsFixed(2),
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
          ],
        ],
      ),
    ),
  ),

  





          
        ],
        
      ),

      // 🔴 Floating delete button (now positioned correctly)
      Positioned(
        bottom: 30, // distance from bottom
        right: 20,  // distance from right
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          elevation: 6,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeleteMilkEntriesScreen(),
              ),
            );
          },
          child: const Icon(Icons.delete, color: Colors.white, size: 28),
        ),
      ),
    ],
  ),
      //listview of recent entries


      
    );
if (_recentEntries.isNotEmpty)
  Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      height: 200,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'today_entries'.tr,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_recentEntries.length} entries',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _loadingEntries
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _recentEntries.length,
                    itemBuilder: (context, index) {
                      final entry = _recentEntries[index];
                      return _RecentEntryItem(entry: entry);
                    },
                  ),
          ),
        ],
      ),
    ),
  );

  }

  String _fmt(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')} '
        '${_month[d.month]} ${d.year}';
  }
}

class _RecentEntryItem extends StatelessWidget {
  final Map<String, dynamic> entry;

  const _RecentEntryItem({required this.entry});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${entry['animal']?.toString().toUpperCase() ?? 'N/A'} - ${entry['litres']} L',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        'Date: ${entry['date']} | Fat: ${entry['fat']} | Rate: ₹${entry['rate']}',
      ),
      trailing: Text(
        '₹${entry['amount']}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}


const _month = [
  '',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

/// ---------- UI building blocks ----------

class _HeaderPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _HeaderPill(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.green),
            const SizedBox(width: 8),
            Text(label, style: theme.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(14),
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: child,
      ),
    );
  }
}

class _NumField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  const _NumField({
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}

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

class _NumFieldFat extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool isFat; // 👈 add this flag

  const _NumFieldFat({
    required this.label,
    required this.controller,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.isFat = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: isFat ? fatAutoDotFormatter : _numFormatter,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  const _ReadOnlyField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      child: Text(value, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

/// Animal tile with (optional) disabled state
class _AnimalTile extends StatelessWidget {
  // final String label;
  final String asset;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  const _AnimalTile({
    // required this.label,
    required this.asset,
    required this.selected,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = disabled
        ? Colors.grey.shade200
        : (selected ? Colors.green.withOpacity(.12) : Colors.grey.shade100);
    final border =
        disabled ? Colors.black12 : (selected ? Colors.green : Colors.black12);
    final textColor = disabled
        ? Colors.grey
        : (selected ? Colors.green.shade800 : Colors.black87);

    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, height: 40),
            // const SizedBox(height: 8),
            // Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}


/// Bottom-sheet Seller Picker (searchable)
class _SellerPicker extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> Function(String) fetch;
  const _SellerPicker({required this.fetch});

  @override
  State<_SellerPicker> createState() => _SellerPickerState();
}

class _SellerPickerState extends State<_SellerPicker> {
  final searchCtrl = TextEditingController();
  List<Map<String, dynamic>> items = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load('');
    searchCtrl.addListener(() => _load(searchCtrl.text));
  }

  Future<void> _load(String q) async {
    setState(() => loading = true);
    final data = await widget.fetch(q);
    setState(() {
      items = data;
      loading = false;
    });
  }

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // small drag handle
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 12),

          // 🔹 Customer Search Section
          TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              hintText: 'Search Customer',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Bulk Entry Section (Search-like button)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BulkEntryScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(12),
                // border: Border.all(color: Colors.blueAccent),
                color: Colors.blue.withOpacity(0.05),
              ),
              child: Row(
                children: [
                  const Icon(Icons.group_add, color: Colors.blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Bulk Entry Customers",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

            InkWell(
            onTap: () {
              Navigator.pop(context, {'type': 'cash_sell'});
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                children: [
                  const Icon(Icons.attach_money, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Cash Sell",
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),


          if (loading) const LinearProgressIndicator(minHeight: 2),

          // 🔹 Customer List
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final it = items[i];
                print("Customer Type: ${it}");
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(.1),
                     child: Icon(
        it?['customer_type'] == 'Seller'
            ? Icons.storefront          // 👨‍🌾 seller icon
            : Icons.shopping_cart,          // 🛒 purchaser icon
        color: it?['customer_type'] == 'Seller'
            ? Colors.green
            : Colors.blue,
      ),
                  ),
                  title: Text(it['name'] ?? ''),
                  subtitle: Text('${'code'.tr}: ${it['code'] ?? '-'}'),
                  onTap: () => Navigator.pop(context, it),
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
