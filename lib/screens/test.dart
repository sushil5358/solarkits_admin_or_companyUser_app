import 'package:flutter/material.dart';

class QuotationsScreen extends StatelessWidget {
  const QuotationsScreen({super.key});

  final List<Map<String, String>> quotes = const [
    {
      'quoteNo': 'QT-2024-001',
      'customerName': 'Rahul Sharma',
      'customer': 'Green Energy Solutions',
      'mobile': '+91 98765 43210',
      'kw': '10',
      'panelCount': '24',
      'grandTotal': '4,50,000',
      'status': 'New',
    },
    {
      'quoteNo': 'QT-2024-002',
      'customerName': 'Priya Mehta',
      'customer': 'Sun Power Systems',
      'mobile': '+91 98765 43211',
      'kw': '15',
      'panelCount': '36',
      'grandTotal': '7,80,000',
      'status': 'Approved',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Quotations'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return _buildCard(quotes[index]);
        },
      ),
    );
  }

  Widget _buildCard(Map<String, String> quote) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          // Row 1: Name and Status
          Row(
            children: [
              Expanded(
                child: Text(
                  quote['customerName']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                color: Colors.orange,
                child: Text(
                  quote['status']!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Row 2: Company
          Text(quote['customer']!),
          const SizedBox(height: 8),
          // Row 3: Mobile
          Text(quote['mobile']!),
          const SizedBox(height: 8),
          // Row 4: Quote No and KW
          Row(
            children: [
              Text('Quote #${quote['quoteNo']}'),
              const Spacer(),
              Text('${quote['kw']} KW | ${quote['panelCount']} Panels'),
            ],
          ),
          const Divider(),
          // Row 5: Amount and Button
          Row(
            children: [
              Column(
                children: [
                  const Text('Total Amount'),
                  Text('₹${quote['grandTotal']}'),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Order'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}