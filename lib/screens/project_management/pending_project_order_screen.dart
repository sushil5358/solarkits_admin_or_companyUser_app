// lib/view/project_orders_screen.dart
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../appColors.dart';
import '../../constants.dart';
import 'order_journy_screen.dart';


class ProjectOrdersScreen extends StatefulWidget {
  final Map<String, dynamic> project;

  const ProjectOrdersScreen({super.key, required this.project});

  @override
  State<ProjectOrdersScreen> createState() => _ProjectOrdersScreenState();
}

class _ProjectOrdersScreenState extends State<ProjectOrdersScreen> {
  List<Map<String, dynamic>> orders = [
    {
      'id': '1',
      'orderNo': 'ORD-2024-001',
      'customerName': 'Rahul Sharma',
      'orderDate': '2024-04-01',
      'amount': '₹4,50,000',
      'kw': '10 KW',
      'status': 'Created',
      'statusColor': '#2196F3',
      'overdue' : '6',
      'journeySteps': [
        {
          'name': 'Feasibility Approval',
          'status': 'Pending',
          'formFilled': false,
          'documents': [
            {'name': 'Feasibility Report', 'fileName': 'feasibility_report.pdf', 'size': '2.5 MB'},
            {'name': 'Site Inspection Report', 'fileName': 'site_inspection.pdf', 'size': '1.8 MB'},
            {'name': 'Technical Approval', 'fileName': 'technical_approval.pdf', 'size': '1.2 MB'},
          ]
        },
        {
          'name': 'Installation Status',
          'status': 'Pending',
          'formFilled': false,
          'documents': [
            {'name': 'Installation Photo', 'fileName': 'installation_photo.jpg', 'size': '3.2 MB'},
            {'name': 'Equipment List', 'fileName': 'equipment_list.pdf', 'size': '0.5 MB'},
            {'name': 'Wiring Diagram', 'fileName': 'wiring_diagram.pdf', 'size': '1.1 MB'},
          ]
        },
        {
          'name': 'Meter Installation',
          'status': 'Pending',
          'formFilled': false,
          'documents': [
            {'name': 'Electricity Bill', 'fileName': 'electricity_bill.pdf', 'size': '0.8 MB'},
            {'name': 'Property Document', 'fileName': 'property_document.pdf', 'size': '2.1 MB'},
            {'name': 'PAN Card', 'fileName': 'pan_card.pdf', 'size': '0.3 MB'},
            {'name': 'Aadhar Card', 'fileName': 'aadhar_card.pdf', 'size': '0.4 MB'},
          ]
        },
      ],
    },
    {
      'id': '2',
      'orderNo': 'ORD-2024-002',
      'customerName': 'Priya Mehta',
      'orderDate': '2024-04-05',
      'amount': '₹7,80,000',
      'kw': '15 KW',
      'status': 'Feasibility Approved',
      'statusColor': '#FF9800',
      'overdue' : '8',
      'journeySteps': [
        {
          'name': 'Feasibility Approval',
          'status': 'Approved',
          'formFilled': true,
          'formUrl': 'https://example.com/form1.pdf',
          'documents': [
            {'name': 'Feasibility Report', 'fileName': 'feasibility_report.pdf', 'size': '2.5 MB'},
            {'name': 'Site Inspection Report', 'fileName': 'site_inspection.pdf', 'size': '1.8 MB'},
            {'name': 'Technical Approval', 'fileName': 'technical_approval.pdf', 'size': '1.2 MB'},
          ]
        },
        {
          'name': 'Installation Status',
          'status': 'In Progress',
          'formFilled': false,
        },
        {
          'name': 'Meter Installation',
          'status': 'Pending',
          'formFilled': false,
        },
      ],
    },
    {
      'id': '3',
      'orderNo': 'ORD-2024-003',
      'customerName': 'Amit Desai',
      'orderDate': '2024-04-10',
      'amount': '₹3,20,000',
      'kw': '5 KW',
      'status': 'Installation Completed',
      'statusColor': '#4CAF50',
      'overdue' : '10',
      'journeySteps': [
        {
          'name': 'Feasibility Approval',
          'status': 'Approved',
          'formFilled': true,
          'formUrl': 'https://example.com/form1.pdf',
          'documents': [
            {'name': 'Feasibility Report', 'fileName': 'feasibility_report.pdf', 'size': '2.5 MB'},
            {'name': 'Site Inspection Report', 'fileName': 'site_inspection.pdf', 'size': '1.8 MB'},
            {'name': 'Technical Approval', 'fileName': 'technical_approval.pdf', 'size': '1.2 MB'},
          ]
        },
        {
          'name': 'Installation Status',
          'status': 'Completed',
          'formFilled': true,
          'formUrl': 'https://example.com/form2.pdf',
          'documents': [
            {'name': 'Installation Photo', 'fileName': 'installation_photo.jpg', 'size': '3.2 MB'},
            {'name': 'Equipment List', 'fileName': 'equipment_list.pdf', 'size': '0.5 MB'},
            {'name': 'Wiring Diagram', 'fileName': 'wiring_diagram.pdf', 'size': '1.1 MB'},
          ]
        },
        {
          'name': 'Meter Installation',
          'status': 'Pending',
          'formFilled': false,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: Text(
          widget.project['name'],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ],
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 1,
        shadowColor: AppColors.shadowGrey.withOpacity(0.3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: orders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 80,
              color: AppColors.lightGrey,
            ),
            const SizedBox(height: 16),
            Text(
              'No orders found',
              style: TextStyle(fontSize: 18, color: AppColors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Orders will appear here once created',
              style: TextStyle(fontSize: 12, color: AppColors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderCard(order);
        },
      ),
    );
  }

  void _showFilterBottomSheet() {
    List<String> selectedSteps = [];

    List<String> stepOptions = [
      'Feasibility Approval',
      'Installation Status',
      'Meter Installation',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter by Journey Step',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),

                  MultiSelectDialogField(
                    items: stepOptions.map((step) {
                      return MultiSelectItem(step, step);
                    }).toList(),
                    title: const Text('Select Journey Steps'),
                    onConfirm: (values) {

                    },
                    buttonText: const Text('Select Steps'),
                    buttonIcon: const Icon(Icons.timeline),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    selectedColor: AppColors.successGreen,
                    selectedItemsTextStyle: const TextStyle(
                      color: AppColors.successGreen,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.errorRed),
                            foregroundColor: AppColors.errorRed,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Clear All'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.successGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Apply Filters'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor;
    try {
      statusColor = Color(
        int.parse(order['statusColor'].replaceFirst('#', '0xff')),
      );
    } catch (e) {
      statusColor = AppColors.primaryBlue;
    }

    return Badge(
      label: Text(order['overdue']),
      backgroundColor: Colors.red,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderJourneyScreen(order: order),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order['status'],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildOrderInfo(
                        'Order Date',
                        order['orderDate'],
                        Icons.calendar_today,
                      ),
                    ),
                    Expanded(
                      child: _buildOrderInfo(
                        'System Size',
                        order['kw'],
                        Icons.solar_power,
                      ),
                    ),
                    Expanded(
                      child: _buildOrderInfo(
                        'Amount',
                        order['amount'],
                        Icons.currency_rupee,
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
        Text(label, style: TextStyle(fontSize: 9, color: AppColors.grey)),
      ],
    );
  }
}