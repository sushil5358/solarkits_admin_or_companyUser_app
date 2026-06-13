// lib/view/loan_customer_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../constants.dart';
import 'loan/add_new_loan.dart';

class LoanCustomerListScreen extends StatefulWidget {
  const LoanCustomerListScreen({super.key});

  @override
  State<LoanCustomerListScreen> createState() => _LoanCustomerListScreenState();
}

class _LoanCustomerListScreenState extends State<LoanCustomerListScreen> {
  List<Map<String, dynamic>> loanCustomers = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'mobile': '+91 98765 43210',
      'pincode': '360001',
      'district': 'Rajkot',
      'city': 'Rajkot',
      'aadharNumber': '1234-5678-9012',
      'panNumber': 'ABCDE1234F',
      'electricityBillNumber': 'EB-2024-001',
      'monthlyBill': '5000',
      'selectedKw': '5 KW',
      'date': '20 Apr 2024',
    },
    {
      'id': '2',
      'name': 'Priya Mehta',
      'mobile': '+91 98765 43211',
      'pincode': '395001',
      'district': 'Surat',
      'city': 'Surat',
      'aadharNumber': '2345-6789-0123',
      'panNumber': 'FGHIJ5678K',
      'electricityBillNumber': 'EB-2024-002',
      'monthlyBill': '6000',
      'selectedKw': '8 KW',
      'date': '18 Apr 2024',
    },
    {
      'id': '3',
      'name': 'Amit Desai',
      'mobile': '+91 98765 43212',
      'pincode': '390001',
      'district': 'Vadodara',
      'city': 'Vadodara',
      'aadharNumber': '3456-7890-1234',
      'panNumber': 'KLMNO9012P',
      'electricityBillNumber': 'EB-2024-003',
      'monthlyBill': '4500',
      'selectedKw': '3 KW',
      'date': '15 Apr 2024',
    },
    {
      'id': '4',
      'name': 'Neha Gupta',
      'mobile': '+91 98765 43213',
      'pincode': '382001',
      'district': 'Ahmedabad',
      'city': 'Ahmedabad',
      'aadharNumber': '4567-8901-2345',
      'panNumber': 'PQRST3456U',
      'electricityBillNumber': 'EB-2024-004',
      'monthlyBill': '7000',
      'selectedKw': '10 KW',
      'date': '22 Apr 2024',
    },
    {
      'id': '5',
      'name': 'Vikram Singh',
      'mobile': '+91 98765 43214',
      'pincode': '364001',
      'district': 'Bhavnagar',
      'city': 'Bhavnagar',
      'aadharNumber': '5678-9012-3456',
      'panNumber': 'VWXYZ7890A',
      'electricityBillNumber': 'EB-2024-005',
      'monthlyBill': '5500',
      'selectedKw': '6 KW',
      'date': '19 Apr 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    void _showFilterBottomSheet(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.7,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter Data',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Project Type Multi-Select

                            const Text(
                              'Select Districts',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Rajkot', 'Rajkot'),
                                MultiSelectItem('Vadodra', 'Vadodra'),
                                MultiSelectItem('Surat', 'Surat'),
                              ],
                              title: const Text('Select Districts'),
                              buttonText: const Text('Select Districts'),
                              buttonIcon: const Icon(Icons.business_center),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),


                            const Text(
                              'Select Partner Types',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Franchise', 'Franchise'),
                                MultiSelectItem('Channel Partner', 'Channel Partner'),
                                MultiSelectItem('Freelancer', 'Freelancer'),
                              ],
                              title: const Text('Select Partner Types'),
                              buttonText: const Text('Select Partner Types'),
                              buttonIcon: const Icon(Icons.person),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),



                            const Text(
                              'Select Project Type',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Residential', 'Residential'),
                                MultiSelectItem('Commercial', 'Commercial'),
                                MultiSelectItem('Industrial', 'Industrial'),
                              ],
                              title: const Text('Select Project Type'),
                              buttonText: const Text('Select Project Type'),
                              buttonIcon: const Icon(Icons.business_center),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),

                            // Sub Project Type Multi-Select
                            const Text(
                              'Select Sub Project Type',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Off Grid', 'Off Grid'),
                                MultiSelectItem('On Grid', 'On Grid'),
                                MultiSelectItem('Hybrid', 'Hybrid'),
                              ],
                              title: const Text('Select Sub Project Type'),
                              buttonText: const Text('Select Sub Project Type'),
                              buttonIcon: const Icon(Icons.electrical_services),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),

                            // Category Multi-Select
                            const Text(
                              'Select Category',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Solar Rooftop', 'Solar Rooftop'),
                                MultiSelectItem('Solar Pump', 'Solar Pump'),
                                MultiSelectItem('Solar Light', 'Solar Light'),
                              ],
                              title: const Text('Select Category'),
                              buttonText: const Text('Select Category'),
                              buttonIcon: const Icon(Icons.category),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),

                            // Sub Category Multi-Select
                            const Text(
                              'Select Sub Category',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Residential 3 to 10 KW', 'Residential 3 to 10 KW'),
                                MultiSelectItem('Residential >3 KW', 'Residential >3 KW'),
                                MultiSelectItem('Common Meter', 'Common Meter'),
                              ],
                              title: const Text('Select Sub Category'),
                              buttonText: const Text('Select Sub Category'),
                              buttonIcon: const Icon(Icons.subdirectory_arrow_right),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.red.shade400),
                              foregroundColor: Colors.red.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
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
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Apply Filters',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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


    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Loan Customers',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.green),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
        ],
      ),
      body: loanCustomers.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No loan customers found',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + button to add new customer',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: loanCustomers.length,
        itemBuilder: (context, index) {
          final customer = loanCustomers[index];
          return _buildCustomerCard(customer);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>AddLoanQuote());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const AddLoanScreen(),
          //   ),
          // );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Customer Name
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade50, Colors.green.shade100],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.green.shade600],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      customer['name'][0],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                        customer['name'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 12, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            customer['mobile'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Three dots menu
                PopupMenuButton<String>(
                  color: Colors.white,
                  icon: Icon(Icons.more_vert, color: Colors.grey[600], size: 20),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: "edit",
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Edit Customer', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: "delete",
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete Customer', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (String choice) {
                    if (choice == "edit") {
                      _showEditDialog(context, customer);
                    } else if (choice == "delete") {
                      _showDeleteConfirmation(context, customer);
                    }
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Aadhar and PAN Number Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.credit_card, size: 14, color: Colors.green),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                customer['aadharNumber'],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.assignment_ind, size: 14, color: Colors.green),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                customer['panNumber'],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Location Row
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.green),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${customer['district']}, ${customer['city']} - ${customer['pincode']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Electricity Bill and Monthly Bill Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.receipt, size: 14, color: Colors.green),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                customer['electricityBillNumber'],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[700],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.currency_rupee, size: 14, color: Colors.orange),
                            const SizedBox(width: 6),
                            Text(
                              '₹${customer['monthlyBill']}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // System Size and Date Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.solar_power, size: 14, color: Colors.green),
                            const SizedBox(width: 6),
                            Text(
                              customer['selectedKw'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 6),
                            Text(
                              customer['date'],
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.edit, color: Colors.green.shade700, size: 28),
            const SizedBox(width: 8),
            const Text(
              'Edit Customer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit customer details feature coming soon!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: const Icon(Icons.warning_amber, color: Colors.red, size: 50),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete Customer?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              'Remove "${customer['name']}"? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                loanCustomers.remove(customer);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Customer deleted successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}