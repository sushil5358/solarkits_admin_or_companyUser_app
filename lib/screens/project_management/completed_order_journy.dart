// lib/view/completed_order_journey_screen.dart
import 'package:flutter/material.dart';
import '../../appColors.dart';
import '../../constants.dart';

class CompletedOrderJourneyScreen extends StatefulWidget {
  final Map<String, dynamic> order;
  const CompletedOrderJourneyScreen({super.key, required this.order});

  @override
  State<CompletedOrderJourneyScreen> createState() => _CompletedOrderJourneyScreenState();
}

class _CompletedOrderJourneyScreenState extends State<CompletedOrderJourneyScreen> {
  // Define journey steps with multiple documents per step
  final List<Map<String, dynamic>> journeySteps = [
    {
      'name': 'Feasibility Approval',
      'documents': [
        {'name': 'Feasibility Report', 'fileName': 'feasibility_report.pdf', 'size': '2.5 MB'},
        {'name': 'Site Inspection Report', 'fileName': 'site_inspection.pdf', 'size': '1.8 MB'},
        {'name': 'Technical Approval', 'fileName': 'technical_approval.pdf', 'size': '1.2 MB'},
      ]
    },
    {
      'name': 'Installation Status',
      'documents': [
        {'name': 'Installation Photo', 'fileName': 'installation_photo.jpg', 'size': '3.2 MB'},
        {'name': 'Equipment List', 'fileName': 'equipment_list.pdf', 'size': '0.5 MB'},
        {'name': 'Wiring Diagram', 'fileName': 'wiring_diagram.pdf', 'size': '1.1 MB'},
      ]
    },
    {
      'name': 'Meter Installation',
      'documents': [
        {'name': 'Electricity Bill', 'fileName': 'electricity_bill.pdf', 'size': '0.8 MB'},
        {'name': 'Property Document', 'fileName': 'property_document.pdf', 'size': '2.1 MB'},
        {'name': 'PAN Card', 'fileName': 'pan_card.pdf', 'size': '0.3 MB'},
        {'name': 'Aadhar Card', 'fileName': 'aadhar_card.pdf', 'size': '0.4 MB'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: journeySteps.length,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          title: const Text(
            'Completed Documents',
            style: TextStyle(
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
        body: Column(
          children: [
            // Order Info Card
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.successGreen.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            widget.order['customerName'][0],
                            style: const TextStyle(
                              fontSize: 20,
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
                              widget.order['orderNo'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.order['customerName'],
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoChip('Order Date', widget.order['orderDate'], Icons.calendar_today),
                      ),
                      Expanded(
                        child: _buildInfoChip('System Size', widget.order['kw'], Icons.solar_power),
                      ),
                      Expanded(
                        child: _buildInfoChip('Amount', widget.order['amount'], Icons.currency_rupee),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                isScrollable: true,
                indicatorColor: AppColors.successGreen,
                labelColor: AppColors.successGreen,
                unselectedLabelColor: AppColors.grey,
                tabs: journeySteps.map((step) {
                  return Tab(text: step['name']);
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // Tab Bar View - shows list of documents for selected step
            Expanded(
              child: TabBarView(
                children: journeySteps.map((step) {
                  return _buildDocumentsList(step['documents']);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, IconData icon) {
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

  Widget _buildDocumentsList(List<Map<String, dynamic>> documents) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final doc = documents[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowGrey,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.insert_drive_file,
                  size: 24,
                  color: AppColors.successGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${doc['fileName']} • ${doc['size']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.successGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {
                    _downloadDocument(doc);
                  },
                  icon: const Icon(Icons.download, size: 20, color: Colors.white),
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _downloadDocument(Map<String, dynamic> doc) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading ${doc['name']}...'),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }
}