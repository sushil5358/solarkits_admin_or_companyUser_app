// lib/screens/partner_user_details_screen.dart


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'add_quotation_companyUser.dart';
import 'editQuote_companyuser.dart';

class PartnerUserDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const PartnerUserDetailsScreen({super.key, required this.user});

  @override
  State<PartnerUserDetailsScreen> createState() => _PartnerUserDetailsScreenState();
}

class _PartnerUserDetailsScreenState extends State<PartnerUserDetailsScreen> {
  // Static data for quotes
  final List<Map<String, dynamic>> quotesList = [
    {
      'quotation_no': 'QT-2024-001',
      'lead_customer_name': 'Rajesh Patel',
      'grand_total': '4,50,000',
      'quotation_date': '2024-03-15 10:30',
      'status': 'Accepted',
    },
    {
      'quotation_no': 'QT-2024-002',
      'lead_customer_name': 'Sunita Mehta',
      'grand_total': '7,80,000',
      'quotation_date': '2024-03-20 14:45',
      'status': 'Pending',
    },
    {
      'quotation_no': 'QT-2024-003',
      'lead_customer_name': 'Amit Desai',
      'grand_total': '12,50,000',
      'quotation_date': '2024-04-05 09:15',
      'status': 'Accepted',
    },
    {
      'quotation_no': 'QT-2024-004',
      'lead_customer_name': 'Neha Gupta',
      'grand_total': '3,20,000',
      'quotation_date': '2024-04-10 16:20',
      'status': 'Rejected',
    },
    {
      'quotation_no': 'QT-2024-005',
      'lead_customer_name': 'Vikram Singh',
      'grand_total': '9,40,000',
      'quotation_date': '2024-04-18 11:00',
      'status': 'Pending',
    },
  ];

  // Static data for projects
  final List<Map<String, dynamic>> projectsList = [
    {
      'project_no': 'PR-2024-001',
      'customer_name': 'Rajesh Patel',
      'required_kw': '5kW',
      'grnad_total': '4,50,000',
      'created_date': '2024-04-01 10:00',
      'current_project_status': 'Intransits',
      'current_project_status_color': '#2196F3',
    },
    {
      'project_no': 'PR-2024-002',
      'customer_name': 'Amit Desai',
      'required_kw': '10kW',
      'grnad_total': '12,50,000',
      'created_date': '2024-04-10 14:30',
      'current_project_status': 'At Warehouse',
      'current_project_status_color': '#FF9800',
    },

    {
      'project_no': 'PR-2024-003',
      'customer_name': 'Sunita Mehta',
      'required_kw': '8kW',
      'grnad_total': '7,80,000',
      'created_date': '2024-04-15 09:45',
      'current_project_status': 'Deliverd',
      'current_project_status_color': '#4CAF50',
    },
    {
      'project_no': 'PR-2024-004',
      'customer_name': 'Vikram Singh',
      'required_kw': '7kW',
      'grnad_total': '9,40,000',
      'created_date': '2024-04-20 16:15',
      'current_project_status': 'Deliverd',
      'current_project_status_color': '#4CAF50',
    },
  ];

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
                  // Header
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
                          // District Multi-Select
                          const Text(
                            'Select District',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          MultiSelectDialogField(
                            items:  [
                              MultiSelectItem('Rajkot', 'Rajkot'),
                              MultiSelectItem('Surat', 'Surat'),
                              MultiSelectItem('Ahmedabad', 'Ahmedabad'),
                              MultiSelectItem('Vadodara', 'Vadodara'),
                              MultiSelectItem('Bhavnagar', 'Bhavnagar'),
                              MultiSelectItem('Jamnagar', 'Jamnagar'),
                            ],
                            title: const Text('Select District'),
                            buttonText: const Text('Select District'),
                            buttonIcon: const Icon(Icons.location_on),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ), onConfirm: (List<String> p1) {  },
                          ),
                          const SizedBox(height: 20),

                          // Project Type Multi-Select


                          // Category Multi-Select
                          const Text(
                            'Select Category',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
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
                          const SizedBox(height: 20),


                          const Text(
                            'Select Project Type',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
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
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Buttons Row
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(onPressed: () {
          Get.to(()=>AddQuoteScreen(quoteId: '',));
          
        },
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text("Add Quote",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Partner Details'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.receipt), child: Text("Quotes")),
              Tab(icon: Icon(Icons.solar_power), child: Text("Projects")),
            ],
          ),
        ),
        body: Column(
          children: [
            // User Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.greenAccent],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.user['name'].toString()[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if(widget.user['email'] != "")
                          Row(
                            children: [
                              Icon(Icons.email, size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                widget.user['email'],
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: Colors.grey.shade600),
                            const SizedBox(width: 4),
                            Text(
                              widget.user['mobile'],
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                children: [
                  _buildQuotesTab(),
                  _buildProjectsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotesTab() {
    if (quotesList.isEmpty) {
      return const Center(
        child: Text(
          "No Quote Found",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quotesList.length,
        itemBuilder: (context, index) {
          final quote = quotesList[index];

          String dateString = quote['quotation_date'].toString();
          String dateOnly = '';

          try {
            DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm');
            DateTime dateTime = inputFormat.parse(dateString);
            dateOnly = DateFormat('yyyy-MM-dd').format(dateTime);
          } catch (e) {
            dateOnly = dateString.split(' ').first;
          }

          return InkWell(
            onTap: () {
              Get.to(()=>EditquoteCompanyuser(margin: 1,));
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            quote['quotation_no'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            quote['lead_customer_name'],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '₨ ${quote['grand_total']}',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            'Created : $dateOnly',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: PopupMenuButton<String>(
                    color: Colors.white,
                    icon: Icon(Icons.more_vert, color: const Color(0xFF757575), size: 20),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: "Delete",
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 16, color: Color(0xFF2196F3)),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(fontSize: 12, color: Color(0xDE000000))),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: "View",
                          child: Row(
                            children: [
                              Icon(Icons.remove_red_eye, size: 16, color: Color(0xFFFF9800)),
                              SizedBox(width: 8),
                              Text('View PDF', style: TextStyle(fontSize: 12, color: Color(0xDE000000))),
                            ],
                          ),
                        ),

                      ];
                    },
                    onSelected: (String choice) {
                      if (choice == "Delete") {

                      } else if (choice == "View") {


                      } else if (choice == "support") {

                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Widget _buildProjectsTab() {
    if (projectsList.isEmpty) {
      return const Center(
        child: Text(
          "No Projects Found",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: projectsList.length,
        itemBuilder: (context, index) {
          final project = projectsList[index];

          String dateString = project['created_date'].toString();
          String dateOnly = '';

          try {
            DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm');
            DateTime dateTime = inputFormat.parse(dateString);
            dateOnly = DateFormat('yyyy-MM-dd').format(dateTime);
          } catch (e) {
            dateOnly = dateString.split(' ').first;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project['project_no'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color(int.parse(project['current_project_status_color'].substring(1, 7), radix: 16) + 0xFF000000),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        project['current_project_status'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  project['customer_name'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  'KW: ${project['required_kw']}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Created $dateOnly',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    Text(
                      '₨ ${project['grnad_total']}',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    }
  }
}