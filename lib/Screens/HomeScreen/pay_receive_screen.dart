import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
class PayReceiveScreen extends StatefulWidget {
  const PayReceiveScreen({Key? key}) : super(key: key);

  @override
  State<PayReceiveScreen> createState() => _PayReceiveScreenState();
}

class _PayReceiveScreenState extends State<PayReceiveScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _acNoCtrl = TextEditingController();
  final TextEditingController _codeCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _remarkCtrl = TextEditingController();
int? selectedCustomerId;
  DateTime _billDate = DateTime.now();
  String? _mode;
final TextEditingController _nameCtrl = TextEditingController();

@override
void initState() {
  super.initState();
_fetchDetailsByAcNo();
  // Listen for changes in Code field
 
}
  // Colors
  final Color background = const Color(0xFFF7F8FA);
  final Color primaryBlue = const Color(0xFF0A5CA8);
  final Color borderBlack = Colors.black;
  final Color accentGreen = const Color(0xFF3E8E3E);
List<Map<String, dynamic>> customers = [];
String? selectedCustomerName;
void _onSave() async {
  if (!_formKey.currentState!.validate()) return;

  // Prepare payload
  final payload = {
    'ac_no':  _nameCtrl.text.trim(),
    'code': _codeCtrl.text.trim(),
    'amount': _amountCtrl.text.trim(),
    'bill_date': DateFormat('yyyy-MM-dd').format(_billDate),
    
    'remark': _remarkCtrl.text.trim(),
 
  };

  try {
    final response = await ApiService.post('/transactions', payload);
        print('Response: ${response}');
    if (response.data['success'] == true) {
      // Success dialog
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: Text(response.data['message'] ?? 'Transaction saved successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back or reset screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

      // Clear form
      setState(() {
        _acNoCtrl.clear();
        _codeCtrl.clear();
        _amountCtrl.clear();
        _remarkCtrl.clear();
        selectedCustomerId = null;
      });

    } else {
      // Error from backend
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.data['message'] ?? 'Failed to save transaction')),
      );
    }
  } catch (e) {
    // Network or other error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  Future<void> _fetchDetailsByAcNo() async {
  
   final response = await ApiService.get('/get-code');
print('Response: ${response}');

    try {
   if ( response.data['success'] == true) {
    setState(() {
      customers = List<Map<String, dynamic>>.from(response.data['data']);
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

  @override
  void dispose() {
    _acNoCtrl.dispose();
    _codeCtrl.dispose();
    _amountCtrl.dispose();
    _remarkCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _billDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: accentGreen),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null) setState(() => _billDate = picked);
  }

//   void _onSave() {
//     if (!_formKey.currentState!.validate()) return;

//     final payload = {
//       'ac_no': _acNoCtrl.text.trim(),
//       'code': _codeCtrl.text.trim(),
//       'amount': _amountCtrl.text.trim(),
//       'bill_date': DateFormat('yyyy-MM-dd').format(_billDate),
//       'mode': _mode,
//       'remark': _remarkCtrl.text.trim(),
//     };

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Saving'),
//         content: Text(payload.toString()),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

  InputDecoration _inputDec({String? label, Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderBlack, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderBlack, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderBlack, width: 1.6),
      ),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pay/Receive',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: _onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
            ),
            child: const Text(
              'SAVE',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
             border: Border.all(
    color: Colors.grey.shade400, // light grey border
    width: 1.2,
  ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Ac No + Code
                Row(
                  children: [
                  Expanded(
  flex: 3,
  child: DropdownButtonFormField<int>(
    value: selectedCustomerId,
    decoration: _inputDec(label: 'Select Name'),
    items: customers.map((customer) {
      return DropdownMenuItem<int>(
        value: customer['id'], // use unique id
        child: Text(customer['name']), // show name
      );
    }).toList(),
    onChanged: (value) {
      setState(() {
        selectedCustomerId = value;
        final selectedCustomer = customers.firstWhere((c) => c['id'] == value);
        _codeCtrl.text = selectedCustomer['code'] ?? '';
          _nameCtrl.text = selectedCustomer['name'] ?? '';
      });
    },
    validator: (v) => (v == null) ? 'Select Name' : null,
  ),
),


                    const SizedBox(width: 10),
            Expanded(
  flex: 1,
  child: TextFormField(
    controller: _codeCtrl,
    textAlign: TextAlign.center,
    decoration: _inputDec(label: 'Code'),
    keyboardType: TextInputType.number,
    onChanged: (value) {
      final match = customers.firstWhere(
        (c) => c['code'] == value,
        orElse: () => {},
      );

      if (match.isNotEmpty) {
        setState(() {

          selectedCustomerId = match['id'];
           _nameCtrl.text = match['name']; 
        });
      }else {
        // If code not found, clear selection
        setState(() {
          selectedCustomerId = null;
          _nameCtrl.clear();
        });
      }
    },
  ),
),


                  ],
                ),

                const SizedBox(height: 14),

                // Amount
                TextFormField(
                  controller: _amountCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: _inputDec(label: 'Amount'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Enter amount';
                    final n = num.tryParse(v);
                    if (n == null) return 'Invalid amount';
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Bill Date
                GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: DateFormat('dd MMM yyyy').format(_billDate),
                      ),
                      decoration: _inputDec(
                        label: 'Bill Date',
                        suffix: Icon(Icons.calendar_today_outlined, color: borderBlack),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Mode Select
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mode Select',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                // DropdownButtonFormField<String>(
                //   value: _mode,
                //   hint: const Text('Select mode'),
                //   decoration: _inputDec(),
                //   items: const [
                //     DropdownMenuItem(value: 'cash', child: Text('Cash')),
                //     DropdownMenuItem(value: 'bank', child: Text('Bank')),
                //     DropdownMenuItem(value: 'upi', child: Text('UPI')),
                //     DropdownMenuItem(value: 'cheque', child: Text('Cheque')),
                //   ],
                //   onChanged: (v) => setState(() => _mode = v),
                //   validator: (v) =>
                //       (v == null || v.isEmpty) ? 'Select payment mode' : null,
                // ),

                const SizedBox(height: 18),

                // Remark
                TextFormField(
                  controller: _remarkCtrl,
                  maxLines: 4,
                  decoration: _inputDec(label: 'Remark'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
