// lib/view/loan_eligibility_screen.dart
import 'package:admin_app_new/screens/loan_customers_list.dart';
import 'package:admin_app_new/screens/unfied_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

import 'appColors.dart';

class LoanEligibilityScreen extends StatefulWidget {
  final Map<String, dynamic>? loanData;
  const LoanEligibilityScreen({super.key, this.loanData});

  @override
  State<LoanEligibilityScreen> createState() => _LoanEligibilityScreenState();
}

class _LoanEligibilityScreenState extends State<LoanEligibilityScreen> {
  // Dropdown selections
  String? selectedLoanType;
  String? selectedKw;
  final List<String> kwOptions = ['1 KW', '2 KW', '3 KW', '4 KW', '5 KW', '6 KW', '7 KW', '8 KW', '9 KW', '10 KW', '12 KW', '15 KW', '20 KW'];
  final List<String> loanTypeOptions = ['NBFC', 'BANK'];

  // Controllers
  final TextEditingController loanAmountController = TextEditingController();

  // Slider values
  double monthlyEmi = 5000;
  double downPaymentPercentage = 15;

  // Loan provider selection
  int? selectedProviderIndex;

  // Loan providers data
  final List<Map<String, dynamic>> loanProviders = [
    {
      'name': 'SBI Green Loan',
      'logo': Icons.account_balance,
      'interestRate': '8.5%',
      'downPayment': '15%',
      'minChance': 30,
    },
    {
      'name': 'HDFC Solar Loan',
      'logo': Icons.account_balance,
      'interestRate': '9.0%',
      'downPayment': '10%',
      'minChance': 40,
    },
    {
      'name': 'ICICI Eco Loan',
      'logo': Icons.eco,
      'interestRate': '8.0%',
      'downPayment': '20%',
      'minChance': 50,
    },
    {
      'name': 'Axis Bank Solar',
      'logo': Icons.account_balance_outlined,
      'interestRate': '9.5%',
      'downPayment': '5%',
      'minChance': 60,
    },
    {
      'name': 'Yes Bank Green',
      'logo': Icons.nature,
      'interestRate': '8.2%',
      'downPayment': '0%',
      'minChance': 70,
    },
  ];

  // Calculated values
  double get downPayment {
    double amount = double.tryParse(loanAmountController.text) ?? 0;
    return amount * (downPaymentPercentage / 100);
  }

  double get loanAmount {
    double amount = double.tryParse(loanAmountController.text) ?? 0;
    return amount - downPayment;
  }

  double get loanChance {
    double amount = double.tryParse(loanAmountController.text) ?? 0;
    double chance = 100;

    // EMI affordability factor
    if (monthlyEmi > 8000) chance -= 30;
    else if (monthlyEmi > 6000) chance -= 15;
    else if (monthlyEmi > 4000) chance -= 5;

    // Loan amount factor
    if (amount > 1500000) chance -= 15;
    else if (amount > 1000000) chance -= 10;
    else if (amount > 500000) chance -= 5;

    // Down payment factor
    if (downPaymentPercentage >= 30) chance += 15;
    else if (downPaymentPercentage >= 20) chance += 10;
    else if (downPaymentPercentage >= 15) chance += 5;
    else if (downPaymentPercentage < 10) chance -= 10;

    return chance.clamp(15, 98).toDouble();
  }

  bool get isEligible => loanChance > 50;

  String get loanChanceMessage {
    double chance = loanChance;
    if (chance >= 80) return 'Excellent';
    if (chance >= 60) return 'Good';
    if (chance >= 40) return 'Fair';
    if (chance >= 20) return 'Low';
    return 'Poor';
  }

  Color get loanChanceColor {
    double chance = loanChance;
    if (chance >= 80) return AppColors.successGreen;
    if (chance >= 60) return AppColors.primaryBlue;
    if (chance >= 40) return AppColors.secondaryOrange;
    if (chance >= 20) return Colors.deepOrange;
    return AppColors.errorRed;
  }

  @override
  void initState() {
    super.initState();
    loanAmountController.text = '500000';
  }

  @override
  void dispose() {
    loanAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableProviders = loanProviders.where((p) => loanChance >= p['minChance']).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => LoanCustomerListScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Save\nAs Draft', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ),
          )
        ],
        title: const Text(
          'Loan Eligibility',
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Card
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowGrey,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Loan Type, KW, Loan Amount (responsive)
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 500) {
                                return Column(
                                  children: [
                                    _buildDropdownField('Loan Type', selectedLoanType, loanTypeOptions, (value) => setState(() => selectedLoanType = value)),
                                    const SizedBox(height: 12),
                                    _buildDropdownField('System Size', selectedKw, kwOptions, (value) => setState(() => selectedKw = value)),
                                    const SizedBox(height: 12),
                                    _buildLoanAmountField(),
                                  ],
                                );
                              } else {
                                return Row(
                                  children: [
                                    Expanded(child: _buildDropdownField('Loan Type', selectedLoanType, loanTypeOptions, (value) => setState(() => selectedLoanType = value))),
                                    const SizedBox(width: 12),
                                    Expanded(child: _buildDropdownField('System Size', selectedKw, kwOptions, (value) => setState(() => selectedKw = value))),
                                    const SizedBox(width: 12),
                                    Expanded(child: _buildLoanAmountField()),
                                  ],
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 20),

                          // Monthly EMI Slider
                          _buildSliderRow('Monthly EMI (₹)', monthlyEmi, 1000, 10000, (val) => setState(() => monthlyEmi = val),
                              label: '₹${_formatNumber(monthlyEmi)}', color: AppColors.primaryBlue),
                          const SizedBox(height: 20),

                          // Down Payment Percentage Slider
                          _buildSliderRow('Down Payment (%)', downPaymentPercentage, 5, 50, (val) => setState(() => downPaymentPercentage = val),
                              label: '${downPaymentPercentage.toStringAsFixed(0)}%', color: AppColors.secondaryOrange),
                          const SizedBox(height: 24),

                          // Loan Details with Chance Circle
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.veryLightGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth < 450) {
                                  return Column(
                                    children: [
                                      Column(
                                        children: [
                                          _buildLoanDetailRow('Loan Amount', '₹${_formatNumber(loanAmount)}'),
                                          const SizedBox(height: 8),
                                          _buildLoanDetailRow('Down Payment', '₹${_formatNumber(downPayment)} (${downPaymentPercentage.toStringAsFixed(0)}%)'),
                                          const SizedBox(height: 8),
                                          _buildLoanDetailRow('Monthly EMI', '₹${_formatNumber(monthlyEmi)}'),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      _buildChanceCircle(),
                                    ],
                                  );
                                } else {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            _buildLoanDetailRow('Loan Amount', '₹${_formatNumber(loanAmount)}'),
                                            const SizedBox(height: 8),
                                            _buildLoanDetailRow('Down Payment', '₹${_formatNumber(downPayment)} (${downPaymentPercentage.toStringAsFixed(0)}%)'),
                                            const SizedBox(height: 8),
                                            _buildLoanDetailRow('Monthly EMI', '₹${_formatNumber(monthlyEmi)}'),
                                          ],
                                        ),
                                      ),
                                      _buildChanceCircle(),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ------------------- LOAN PROVIDERS SECTION -------------------
                  if (loanChance >= 30 && availableProviders.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Select Loan Provider',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...availableProviders.map((provider) {
                      final index = loanProviders.indexOf(provider);
                      final isSelected = selectedProviderIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedProviderIndex = index),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.successGreen.withOpacity(0.08)
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(color: AppColors.successGreen, width: 1.5)
                                : Border.all(color: AppColors.lightGrey),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowGrey,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.successGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(provider['logo'], size: 28, color: AppColors.successGreen),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider['name'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Interest: ${provider['interestRate']}  •  Down Payment: ${provider['downPayment']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle, color: AppColors.successGreen, size: 24),
                            ],
                          ),
                        ),
                      );
                    }),
                  ] else if (loanChance >= 30 && availableProviders.isEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowGrey,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'No loan providers available for your current eligibility.\nTry adjusting the values.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: AppColors.grey),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Action Buttons at bottom
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowGrey,
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isEligible
                        ? () {
                      if (loanChance >= 30 && selectedProviderIndex == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a loan provider'),
                            backgroundColor: AppColors.errorRed,
                          ),
                        );
                        return;
                      }
                      // Get.to(() => LoanProcessingScreen());
                    }
                        : null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: isEligible ? AppColors.successGreen : AppColors.lightGrey),
                      foregroundColor: isEligible ? AppColors.successGreen : AppColors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Apply For Loan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isEligible
                        ? () {
                      if (loanChance >= 30 && selectedProviderIndex == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a loan provider'),
                            backgroundColor: AppColors.errorRed,
                          ),
                        );
                        return;
                      }
                      Get.to(() => UnifiedSurveyScreen(willQuote: 'no'));
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEligible ? AppColors.successGreen : AppColors.lightGrey,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Survey',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isEligible ? Colors.white : AppColors.grey,
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

  // Helper widgets
  Widget _buildDropdownField(String label, String? value, List<String> options, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.black87)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select $label'),
              value: value,
              items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt, style: const TextStyle(fontSize: 13)))).toList(),
              onChanged: onChanged,
              icon: Icon(Icons.arrow_drop_down, color: AppColors.successGreen),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Loan Amount (₹)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.black87)),
        const SizedBox(height: 6),
        TextField(
          controller: loanAmountController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.currency_rupee, size: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.lightGrey)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.successGreen)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildSliderRow(String title, double value, double min, double max, Function(double) onChanged, {required String label, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.black87)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: ((max - min) / 5).round(),
                activeColor: color,
                inactiveColor: AppColors.lightGrey,
                onChanged: onChanged,
              ),
            ),
            SizedBox(width: 60, child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color))),
          ],
        ),
      ],
    );
  }

  Widget _buildChanceCircle() {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(left: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(
              value: loanChance / 100,
              strokeWidth: 8,
              backgroundColor: AppColors.lightGrey,
              valueColor: AlwaysStoppedAnimation<Color>(loanChanceColor),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${loanChance.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black87)),
              Text(loanChanceMessage, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: loanChanceColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoanDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.darkGrey)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black87),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }
}