// lib/view/order_journey_screen.dart
import 'package:flutter/material.dart';
import '../../appColors.dart';
import '../../constants.dart';

class OrderJourneyScreen extends StatefulWidget {
  final Map<String, dynamic> order;
  const OrderJourneyScreen({super.key, required this.order});

  @override
  State<OrderJourneyScreen> createState() => _OrderJourneyScreenState();
}

class _OrderJourneyScreenState extends State<OrderJourneyScreen> {
  late List<Map<String, dynamic>> journeySteps;

  @override
  void initState() {
    super.initState();
    journeySteps = List<Map<String, dynamic>>.from(widget.order['journeySteps']);
  }

  int _getOverdueDays(String targetDateStr) {
    try {
      final targetDate = DateTime.parse(targetDateStr);
      final now = DateTime.now();
      if (now.isAfter(targetDate)) {
        return now.difference(targetDate).inDays;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: journeySteps.length,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          title: const Text(
            'Order Journey',
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
                  return Tab(
                    child: Row(
                      children: [
                        Icon(
                          _getStatusIcon(step['status']),
                          size: 16,
                          color: _getStatusColor(step['status']),
                        ),
                        const SizedBox(width: 8),
                        Text(step['name']),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                children: journeySteps.map((step) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: _buildStepContent(step),
                  );
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

  Widget _buildStepContent(Map<String, dynamic> step) {
    bool isCompleted = step['status'] == 'Approved' || step['status'] == 'Completed';
    bool isInProgress = step['status'] == 'In Progress';
    bool isPending = step['status'] == 'Pending';
    bool hasForm = step['formFilled'] == true;
    String? formType = step['formType'];
    int overdueDays = 2;

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Header
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getStatusColor(step['status']).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getStatusIcon(step['status']),
                  size: 28,
                  color: _getStatusColor(step['status']),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(step['status']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            step['status'],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(step['status']),
                            ),
                          ),
                        ),
                        if (true)
                          const SizedBox(width: 8),
                        if (overdueDays > 1 && !isCompleted)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.errorRed.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.warning, size: 12, color: AppColors.errorRed),
                                const SizedBox(width: 4),
                                Text(
                                  '$overdueDays days overdue',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.errorRed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),

          // Content based on step state
          if (isCompleted)
            _buildDocumentsList(step['documents'] ?? [])
          else if (!hasForm && !isPending && !isCompleted && step['formFilled'] == false)
            _buildFillFormSection(step, formType)
          else if (!hasForm && (isPending || isInProgress))
              _buildAwaitingSection(),
        ],
      ),
    );
  }

  Widget _buildDocumentsList(List<Map<String, dynamic>> documents) {
    if (documents.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: const Text(
          'No documents available for this step.',
          style: TextStyle(color: AppColors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
                child: const Icon(Icons.insert_drive_file, size: 24, color: AppColors.successGreen),
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
                      style: TextStyle(fontSize: 11, color: AppColors.grey),
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
                  onPressed: () => _downloadDocument(doc),
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

  Widget _buildFillFormSection(Map<String, dynamic> step, String? formType) {
    if (formType == 'document') {
      return _buildDocumentUploadForm(step);
    } else {
      return _buildTextForm(step);
    }
  }

  Widget _buildDocumentUploadForm(Map<String, dynamic> step) {
    TextEditingController remarksController = TextEditingController();
    String? selectedFileName;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.veryLightGrey,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: Column(
                children: [
                  const Icon(Icons.upload_file, size: 48, color: AppColors.successGreen),
                  const SizedBox(height: 8),
                  Text(
                    selectedFileName ?? 'No file selected',
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedFileName != null ? AppColors.successGreen : AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedFileName = 'document_${DateTime.now().millisecondsSinceEpoch}.pdf';
                      });
                    },
                    icon: const Icon(Icons.folder_open),
                    label: const Text('Browse File'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.successGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: remarksController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Remarks (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedFileName != null
                    ? () {
                  setState(() {
                    step['formFilled'] = true;
                    step['status'] = 'Completed';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Document uploaded successfully!'),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.successGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: AppColors.lightGrey,
                ),
                child: const Text(
                  'Submit Document',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextForm(Map<String, dynamic> step) {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController remarksController = TextEditingController();

    String field1Label = '';
    String field1Hint = '';
    String field2Label = '';
    String field2Hint = '';

    if (step['name'] == 'Feasibility Approval') {
      field1Label = 'Feasibility Report Number';
      field1Hint = 'Enter report number';
      field2Label = 'Approved KW';
      field2Hint = 'Enter approved KW';
    } else if (step['name'] == 'Installation Status') {
      field1Label = 'Installation Date';
      field1Hint = 'DD/MM/YYYY';
      field2Label = 'Installed KW';
      field2Hint = 'Enter installed KW';
    } else if (step['name'] == 'Meter Installation') {
      field1Label = 'Meter Number';
      field1Hint = 'Enter meter number';
      field2Label = 'Meter Reading';
      field2Hint = 'Enter initial reading';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller1,
          decoration: InputDecoration(
            labelText: field1Label,
            hintText: field1Hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.successGreen),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller2,
          decoration: InputDecoration(
            labelText: field2Label,
            hintText: field2Hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.successGreen),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: remarksController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Remarks (Optional)',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.successGreen),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                step['formFilled'] = true;
                step['status'] = 'Completed';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Form submitted successfully!'),
                  backgroundColor: AppColors.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Submit Form',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAwaitingSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondaryOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.hourglass_empty, color: AppColors.secondaryOrange),
              const SizedBox(width: 12),
              Expanded(
                child: const Text(
                  'Awaiting form submission from admin',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'Approved' || status == 'Completed') return AppColors.successGreen;
    if (status == 'In Progress') return AppColors.secondaryOrange;
    return AppColors.grey;
  }

  IconData _getStatusIcon(String status) {
    if (status == 'Approved' || status == 'Completed') return Icons.check_circle;
    if (status == 'In Progress') return Icons.hourglass_empty;
    return Icons.pending;
  }
}