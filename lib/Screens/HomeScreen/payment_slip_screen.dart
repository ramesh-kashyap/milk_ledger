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
    this.name = "Sachin", // ✅ default
    this.code = "SLIP123",     // ✅ default
    DateTime? startDate,   // ✅ allow null but fallback
    DateTime? endDate,
    this.item = "No Item",
    this.sale = 0.0,
    this.purchase = 0.0,
    this.received = 0.0,
    this.due = 0.0,
  })  : startDate = startDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now();
}


class PaymentScreen extends StatelessWidget {
  final PaymentSlip? slip; // ✅ made nullable

  const PaymentScreen({super.key, this.slip}); // ✅ removed required

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    // ✅ If no slip is passed, show empty screen message
    if (slip == null) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text(
            'Payment Slip',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Center(
          child: Text(
            "No payment slip available",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    // ✅ If slip is available, show the details
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          'Payment Slip',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  '${slip!.name} (${slip!.code})',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${dateFormat.format(slip!.startDate)} → ${dateFormat.format(slip!.endDate)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const Divider(height: 28, thickness: 1),

                // Item
                Text(
                  slip!.item,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Sale
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Sale"),
                    Text("₹${slip!.sale.toStringAsFixed(2)}"),
                  ],
                ),
                const SizedBox(height: 8),
                // Purchase + Grand total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Purchase"),
                    Text("₹${slip!.purchase.toStringAsFixed(2)}"),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Grand Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹${slip!.purchase.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const Divider(height: 28, thickness: 1),

                // Received + Due
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Received"),
                    Text("₹${slip!.received.toStringAsFixed(2)}"),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Due"),
                    Text(
                      "₹${slip!.due.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: slip!.due > 0 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
