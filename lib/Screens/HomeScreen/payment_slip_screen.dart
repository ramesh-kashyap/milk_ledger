import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentSlip {
  final String name;
  final String code;
  final DateTime startDate;
  final DateTime endDate;
  final String item;
  final double sale;
  final double purchase;
  final double received;
  final double due;

  PaymentSlip({
    required this.name,
    required this.code,
    required this.startDate,
    required this.endDate,
    required this.item,
    required this.sale,
    required this.purchase,
    required this.received,
    required this.due,
  });
}

class PaymentScreen extends StatelessWidget {
  final PaymentSlip slip;

  const PaymentScreen({super.key, required this.slip});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment slip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${slip.name} (${slip.code})',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  '${dateFormat.format(slip.startDate)} to ${dateFormat.format(slip.endDate)}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(slip.item,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                Text('sale: ₹${slip.sale.toStringAsFixed(2)}'),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Purchase: ₹${slip.purchase.toStringAsFixed(2)}'),
                    Text('Grand Total: ₹${slip.purchase.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Received: ₹${slip.received}'),
                    Text('Due: ₹${slip.due}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
