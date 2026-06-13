// lib/view/loan_processing_screen.dart
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../constants.dart';
import '../../appColors.dart';


class TrackLoanScreen extends StatefulWidget {
  const TrackLoanScreen({super.key});

  @override
  State<TrackLoanScreen> createState() => _TrackLoanScreenState();
}

class _TrackLoanScreenState extends State<TrackLoanScreen> {
  // Loan providers data with full details
  final Map<String, Map<String, dynamic>> loanProvidersData = {
    'SBI Green Loan': {
      'logo': Icons.account_balance,
      'name': 'SBI Green Loan',
      'interestRate': '8.5%',
      'downPayment': '15%',
      'tenure': 'Up to 20 years',
      'processingFee': '0.5%',
      'color': '#2196F3',
    },
    'HDFC Solar Loan': {
      'logo': Icons.account_balance,
      'name': 'HDFC Solar Loan',
      'interestRate': '9.0%',
      'downPayment': '10%',
      'tenure': 'Up to 15 years',
      'processingFee': '1.0%',
      'color': '#004D40',
    },
    'ICICI Eco Loan': {
      'logo': Icons.eco,
      'name': 'ICICI Eco Loan',
      'interestRate': '8.0%',
      'downPayment': '20%',
      'tenure': 'Up to 20 years',
      'processingFee': '0.75%',
      'color': '#FF6F00',
    },
    'Axis Bank Solar': {
      'logo': Icons.account_balance_outlined,
      'name': 'Axis Bank Solar',
      'interestRate': '9.5%',
      'downPayment': '5%',
      'tenure': 'Up to 12 years',
      'processingFee': '1.25%',
      'color': '#9C27B0',
    },
    'Yes Bank Green': {
      'logo': Icons.nature,
      'name': 'Yes Bank Green',
      'interestRate': '8.2%',
      'downPayment': '0%',
      'tenure': 'Up to 18 years',
      'processingFee': '0.9%',
      'color': '#4CAF50',
    },
  };

  List<Map<String, dynamic>> inProcessLoans = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'mobile': '+91 98765 43210',
      'loanAmount': '₹5,00,000',
      'monthlyInterest': '8.5%',
      'monthlyEmi': '₹12,500',
      'systemSize': '5 KW',
      'applicationDate': '20 Apr 2024',
      'status': 'Document Verification',
      'progress': 40,
      'loanProvider': 'SBI Green Loan',
    },
    {
      'id': '2',
      'name': 'Neha Gupta',
      'mobile': '+91 98765 43213',
      'loanAmount': '₹8,00,000',
      'monthlyInterest': '9.0%',
      'monthlyEmi': '₹18,500',
      'systemSize': '8 KW',
      'applicationDate': '22 Apr 2024',
      'status': 'Credit Check',
      'progress': 60,
      'loanProvider': 'HDFC Solar Loan',
    },
    {
      'id': '3',
      'name': 'Amit Desai',
      'mobile': '+91 98765 43212',
      'loanAmount': '₹3,50,000',
      'monthlyInterest': '8.0%',
      'monthlyEmi': '₹8,750',
      'systemSize': '3 KW',
      'applicationDate': '15 Apr 2024',
      'status': 'Approval Pending',
      'progress': 75,
      'loanProvider': 'ICICI Eco Loan',
    },
  ];

  List<Map<String, dynamic>> loanStatus = [
    {
      'id': '1',
      'name': 'Priya Mehta',
      'mobile': '+91 98765 43211',
      'loanAmount': '₹7,80,000',
      'monthlyInterest': '8.5%',
      'monthlyEmi': '₹19,500',
      'systemSize': '8 KW',
      'applicationDate': '18 Apr 2024',
      'loanStatus': 'Approved',
      'statusColor': '#4CAF50',
      'sanctionLetter': true,
      'loanProvider': 'Axis Bank Solar',
    },
    {
      'id': '2',
      'name': 'Vikram Singh',
      'mobile': '+91 98765 43214',
      'loanAmount': '₹10,00,000',
      'monthlyInterest': '9.5%',
      'monthlyEmi': '₹25,000',
      'systemSize': '10 KW',
      'applicationDate': '19 Apr 2024',
      'loanStatus': 'Rejected',
      'statusColor': '#F44336',
      'sanctionLetter': false,
      'loanProvider': 'Yes Bank Green',
    },
    {
      'id': '3',
      'name': 'Sunil Mehta',
      'mobile': '+91 98765 43215',
      'loanAmount': '₹6,50,000',
      'monthlyInterest': '8.0%',
      'monthlyEmi': '₹16,250',
      'systemSize': '6 KW',
      'applicationDate': '21 Apr 2024',
      'loanStatus': 'Approved',
      'statusColor': '#4CAF50',
      'sanctionLetter': true,
      'loanProvider': 'SBI Green Loan',
    },
    {
      'id': '4',
      'name': 'Meera Shah',
      'mobile': '+91 98765 43216',
      'loanAmount': '₹4,20,000',
      'monthlyInterest': '8.5%',
      'monthlyEmi': '₹10,500',
      'systemSize': '4 KW',
      'applicationDate': '23 Apr 2024',
      'loanStatus': 'Rejected',
      'statusColor': '#F44336',
      'sanctionLetter': false,
      'loanProvider': 'ICICI Eco Loan',
    },
  ];

  List<Map<String, dynamic>> downPaymentLoans = [
    {
      'id': '1',
      'name': 'Priya Mehta',
      'mobile': '+91 98765 43211',
      'loanAmount': '₹7,80,000',
      'downPaymentAmount': '₹1,17,000',
      'remainingAmount': '₹6,63,000',
      'monthlyInterest': '8.5%',
      'monthlyEmi': '₹19,500',
      'systemSize': '8 KW',
      'sanctionDate': '25 Apr 2024',
      'paymentStatus': 'Pending',
      'loanProvider': 'HDFC Solar Loan',
    },
    {
      'id': '2',
      'name': 'Sunil Mehta',
      'mobile': '+91 98765 43215',
      'loanAmount': '₹6,50,000',
      'downPaymentAmount': '₹97,500',
      'remainingAmount': '₹5,52,500',
      'monthlyInterest': '8.0%',
      'monthlyEmi': '₹16,250',
      'systemSize': '6 KW',
      'sanctionDate': '26 Apr 2024',
      'paymentStatus': 'Pending',
      'loanProvider': 'Yes Bank Green',
    },
    {
      'id': '3',
      'name': 'Rahul Sharma',
      'mobile': '+91 98765 43210',
      'loanAmount': '₹5,00,000',
      'downPaymentAmount': '₹75,000',
      'remainingAmount': '₹4,25,000',
      'monthlyInterest': '8.5%',
      'monthlyEmi': '₹12,500',
      'systemSize': '5 KW',
      'sanctionDate': '24 Apr 2024',
      'paymentStatus': 'Completed',
      'loanProvider': 'Axis Bank Solar',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
              onPressed: () {
                _showFilterBottomSheet();
              },
            ),
          ],
          title: const Text(
            'Track Loan',
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
          bottom: const TabBar(
            indicatorColor: AppColors.successGreen,
            labelColor: AppColors.successGreen,
            unselectedLabelColor: AppColors.grey,
            tabs: [
              Tab(text: 'In Process'),
              Tab(text: 'Loan Status'),
              Tab(text: 'Down Payment'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // In Process Tab
            inProcessLoans.isEmpty
                ? _buildEmptyState('No loans in process', Icons.hourglass_empty)
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: inProcessLoans.length,
              itemBuilder: (context, index) {
                final loan = inProcessLoans[index];
                return _buildInProcessCard(loan);
              },
            ),
            // Loan Status Tab
            loanStatus.isEmpty
                ? _buildEmptyState('No loan applications', Icons.description)
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: loanStatus.length,
              itemBuilder: (context, index) {
                final loan = loanStatus[index];
                return _buildLoanStatusCard(loan);
              },
            ),
            // Down Payment Tab
            downPaymentLoans.isEmpty
                ? _buildEmptyState('No down payment pending', Icons.currency_rupee)
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: downPaymentLoans.length,
              itemBuilder: (context, index) {
                final loan = downPaymentLoans[index];
                return _buildDownPaymentCard(loan);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
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
          builder: (context, setStateSheet) {
            List<String> selectedCategories = [];
            List<String> selectedSubCategories = [];
            List<String> selectedProjectTypes = [];
            List<String> selectedSubProjectTypes = [];

            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter Options',
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
                      items: [
                        'Residential',
                        'Commercial',
                        'Industrial',
                        'Agricultural',
                        'Government',
                      ].map((category) => MultiSelectItem(category, category)).toList(),
                      title: const Text('Select Category'),
                      onConfirm: (values) {
                        setStateSheet(() {
                          selectedCategories = values;
                        });
                      },
                      buttonText: const Text('Select Category'),
                      buttonIcon: const Icon(Icons.category),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: AppColors.successGreen,
                      selectedItemsTextStyle: const TextStyle(
                        color: AppColors.successGreen,
                      ),
                    ),
                    const SizedBox(height: 16),

                    MultiSelectDialogField(
                      items: [
                        'Rooftop Solar',
                        'Ground Mount',
                        'Floating Solar',
                        'Hybrid System',
                        'Off-Grid System',
                      ].map((sub) => MultiSelectItem(sub, sub)).toList(),
                      title: const Text('Select Sub Category'),
                      onConfirm: (values) {
                        setStateSheet(() {
                          selectedSubCategories = values;
                        });
                      },
                      buttonText: const Text('Select Sub Category'),
                      buttonIcon: const Icon(Icons.subdirectory_arrow_right),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: AppColors.secondaryOrange,
                      selectedItemsTextStyle: const TextStyle(
                        color: AppColors.secondaryOrange,
                      ),
                    ),
                    const SizedBox(height: 16),

                    MultiSelectDialogField(
                      items: [
                        'Residential 3 to 10 KW',
                        'Residential < 3 KW',
                        'Commercial',
                      ].map((pt) => MultiSelectItem(pt, pt)).toList(),
                      title: const Text('Select Project Type'),
                      onConfirm: (values) {

                      },
                      buttonText: const Text('Select Project Type'),
                      buttonIcon: const Icon(Icons.business_center),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: AppColors.successGreen,
                      selectedItemsTextStyle: const TextStyle(
                        color: AppColors.successGreen,
                      ),
                    ),
                    const SizedBox(height: 16),

                    MultiSelectDialogField(
                      items: [
                        'On Grid',
                        'Off Grid',
                        'Hybrid',
                      ].map((spt) => MultiSelectItem(spt, spt)).toList(),
                      title: const Text('Select Sub Project Type'),
                      onConfirm: (values) {
                        setStateSheet(() {
                          selectedSubProjectTypes = values;
                        });
                      },
                      buttonText: const Text('Select Sub Project Type'),
                      buttonIcon: const Icon(Icons.subdirectory_arrow_right),
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
                              setStateSheet(() {
                                selectedCategories.clear();
                                selectedSubCategories.clear();
                                selectedProjectTypes.clear();
                                selectedSubProjectTypes.clear();
                              });
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
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.successGreen,
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
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: AppColors.lightGrey),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getProviderDetails(String providerName) {
    return loanProvidersData[providerName] ?? {
      'logo': Icons.account_balance,
      'name': providerName,
      'interestRate': 'N/A',
      'downPayment': 'N/A',
      'tenure': 'N/A',
      'processingFee': 'N/A',
      'color': '#757575',
    };
  }

  Widget _buildLoanProviderCard(String providerName) {
    final provider = _getProviderDetails(providerName);
    Color providerColor;
    try {
      providerColor = Color(int.parse(provider['color'].replaceFirst('#', '0xff')));
    } catch (e) {
      providerColor = AppColors.primaryBlue;
    }

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: providerColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: providerColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: providerColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(provider['logo'], size: 22, color: providerColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider['name'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: providerColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Rate: ${provider['interestRate']} • Down: ${provider['downPayment']}',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: providerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              provider['interestRate'],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: providerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tab 3 - Down Payment Card
  Widget _buildDownPaymentCard(Map<String, dynamic> loan) {
    bool isCompleted = loan['paymentStatus'] == 'Completed';

    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.successGreen.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      loan['name'][0],
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
                        loan['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        loan['mobile'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.successGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 12, color: AppColors.successGreen),
                        const SizedBox(width: 4),
                        Text(
                          'Paid',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.successGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        'Loan Amount',
                        loan['loanAmount'],
                        Icons.currency_rupee,
                        AppColors.primaryBlue,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        'Down Payment',
                        loan['downPaymentAmount'],
                        Icons.download,
                        AppColors.secondaryOrange,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        'Remaining',
                        loan['remainingAmount'],
                        Icons.currency_rupee,
                        AppColors.successGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        'Monthly EMI',
                        loan['monthlyEmi'],
                        Icons.calendar_month,
                        AppColors.primaryBlue,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        'System Size',
                        loan['systemSize'],
                        Icons.solar_power,
                        AppColors.successGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _buildLoanProviderCard(loan['loanProvider']),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(Icons.description, size: 12, color: AppColors.grey),
                    const SizedBox(width: 6),
                    Text(
                      'Sanction Letter Signed: ${loan['sanctionDate']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                if (!isCompleted)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showPaymentDialog(loan);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.successGreen,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Pay Down Payment',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tab 1 - In Process Card
  Widget _buildInProcessCard(Map<String, dynamic> loan) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.successGreen.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      loan['name'][0],
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
                        loan['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        loan['mobile'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        'Loan Amount',
                        loan['loanAmount'],
                        Icons.currency_rupee,
                        AppColors.successGreen,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        'kilo Watt',
                        '3.14',
                        Icons.electric_bolt,
                        AppColors.secondaryOrange,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        'Monthly EMI',
                        loan['monthlyEmi'],
                        Icons.calendar_month,
                        AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                _buildLoanProviderCard(loan['loanProvider']),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 12, color: AppColors.grey),
                        const SizedBox(width: 4),
                        Text(
                          loan['applicationDate'],
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
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

  // Tab 2 - Loan Status Card
  Widget _buildLoanStatusCard(Map<String, dynamic> loan) {
    Color statusColor;
    try {
      statusColor = Color(int.parse(loan['statusColor'].replaceFirst('#', '0xff')));
    } catch (e) {
      statusColor = loan['loanStatus'] == 'Approved'
          ? AppColors.successGreen
          : AppColors.errorRed;
    }

    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      loan['name'][0],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
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
                        loan['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        loan['mobile'],
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    loan['loanStatus'],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        'Loan Amount',
                        loan['loanAmount'],
                        Icons.currency_rupee,
                        AppColors.successGreen,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        'Kilo Watt',
                        '3.24',
                        Icons.electric_bolt,
                        AppColors.secondaryOrange,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        'Monthly EMI',
                        loan['monthlyEmi'],
                        Icons.calendar_month,
                        AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _buildLoanProviderCard(loan['loanProvider']),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 12, color: AppColors.grey),
                        const SizedBox(width: 4),
                        Text(
                          loan['applicationDate'],
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                if (loan['loanStatus'] == 'Approved' && loan['sanctionLetter'] == true)
                  const SizedBox(height: 12),
                if (loan['loanStatus'] == 'Approved' && loan['sanctionLetter'] == true)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showSanctionLetterDialog(loan);
                      },
                      icon: const Icon(Icons.description, size: 16),
                      label: const Text('Sign Sanction Letter'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.successGreen,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
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

  void _showPaymentDialog(Map<String, dynamic> loan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Make Down Payment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.veryLightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Customer', loan['name']),
                  _buildDetailRow('Down Payment', loan['downPaymentAmount']),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildPaymentMethod('UPI', Icons.qr_code)),
                const SizedBox(width: 12),
                Expanded(child: _buildPaymentMethod('Card', Icons.credit_card)),
                const SizedBox(width: 12),
                Expanded(child: _buildPaymentMethod('Net Banking', Icons.account_balance)),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                loan['paymentStatus'] = 'Completed';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Down payment successful!'),
                  backgroundColor: AppColors.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successGreen,
            ),
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColors.successGreen),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showSanctionLetterDialog(Map<String, dynamic> loan) {
    final provider = _getProviderDetails(loan['loanProvider']);
    Color providerColor;
    try {
      providerColor = Color(int.parse(provider['color'].replaceFirst('#', '0xff')));
    } catch (e) {
      providerColor = AppColors.primaryBlue;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Sanction Letter',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.description, size: 60, color: AppColors.successGreen),
            const SizedBox(height: 16),
            Text(
              'Loan Sanction Letter for ${loan['name']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.veryLightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Customer Name', loan['name']),
                  _buildDetailRow('Loan Amount', loan['loanAmount']),
                  _buildDetailRow('Interest Rate', loan['monthlyInterest']),
                  _buildDetailRow('Monthly EMI', loan['monthlyEmi']),
                  _buildDetailRow('System Size', loan['systemSize']),
                  const Divider(),
                  _buildDetailRow('Provider', provider['name']),
                  _buildDetailRow('Provider Rate', provider['interestRate']),
                  _buildDetailRow('Down Payment', provider['downPayment']),
                  _buildDetailRow('Tenure', provider['tenure']),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'I agree to the terms and conditions of the loan',
              style: TextStyle(fontSize: 11, color: AppColors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sanction letter signed successfully!'),
                  backgroundColor: AppColors.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successGreen,
            ),
            child: const Text('Sign & Download'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.darkGrey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.black87,
            ),
          ),
        ],
      ),
    );
  }
}