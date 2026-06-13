// lib/view/completed_orders_screen.dart
import 'package:flutter/material.dart';
import '../../appColors.dart';
import '../../constants.dart';
import 'completed_order_journy.dart';

class CompletedOrdersScreen extends StatefulWidget {
  final Map<String, dynamic> project;
  const CompletedOrdersScreen({super.key, required this.project});

  @override
  State<CompletedOrdersScreen> createState() => _CompletedOrdersScreenState();
}

class _CompletedOrdersScreenState extends State<CompletedOrdersScreen> {
  List<Map<String, dynamic>> completedOrders = [
    {
      'id': '1',
      'orderNo': 'ORD-2024-001',
      'customerName': 'Rahul Sharma',
      'orderDate': '2024-04-01',
      'amount': '₹4,50,000',
      'kw': '10 KW',
      'journeySteps': [
        {'name': 'Feasibility Approval', 'fileUrl': 'https://example.com/feasibility.pdf'},
        {'name': 'Installation Status', 'fileUrl': 'https://example.com/installation.pdf'},
        {'name': 'Meter Installation', 'fileUrl': 'https://example.com/meter.pdf'},
      ],
    },
    {
      'id': '2',
      'orderNo': 'ORD-2024-002',
      'customerName': 'Priya Mehta',
      'orderDate': '2024-04-05',
      'amount': '₹7,80,000',
      'kw': '15 KW',
      'journeySteps': [
        {'name': 'Feasibility Approval', 'fileUrl': 'https://example.com/feasibility2.pdf'},
        {'name': 'Installation Status', 'fileUrl': 'https://example.com/installation2.pdf'},
        {'name': 'Meter Installation', 'fileUrl': 'https://example.com/meter2.pdf'},
      ],
    },
    {
      'id': '3',
      'orderNo': 'ORD-2024-003',
      'customerName': 'Amit Desai',
      'orderDate': '2024-04-10',
      'amount': '₹3,20,000',
      'kw': '5 KW',
      'journeySteps': [
        {'name': 'Feasibility Approval', 'fileUrl': 'https://example.com/feasibility3.pdf'},
        {'name': 'Installation Status', 'fileUrl': 'https://example.com/installation3.pdf'},
        {'name': 'Meter Installation', 'fileUrl': 'https://example.com/meter3.pdf'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: Text(
          '${widget.project['name']} - Orders',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 1,
        shadowColor: AppColors.shadowGrey.withOpacity(0.3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: completedOrders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 80, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(
              'No completed orders found',
              style: TextStyle(fontSize: 18, color: AppColors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Completed orders will appear here',
              style: TextStyle(fontSize: 12, color: AppColors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: completedOrders.length,
        itemBuilder: (context, index) {
          final order = completedOrders[index];
          return _buildOrderCard(order);
        },
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompletedOrderJourneyScreen(order: order),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowGrey,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.successGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        order['customerName'][0],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['orderNo'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          order['customerName'],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.successGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.successGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildOrderInfo('Order Date', order['orderDate'], Icons.calendar_today),
                  ),
                  Expanded(
                    child: _buildOrderInfo('System Size', order['kw'], Icons.solar_power),
                  ),
                  Expanded(
                    child: _buildOrderInfo('Amount', order['amount'], Icons.currency_rupee),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 14, color: AppColors.grey),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}