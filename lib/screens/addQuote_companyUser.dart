
import 'package:admin_app_new/screens/unified_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';

import 'all_quotes/admin_quotes.dart';

class AddquoteCompanyuser extends StatefulWidget {
  const AddquoteCompanyuser({super.key});

  @override
  State<AddquoteCompanyuser> createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddquoteCompanyuser> {
  // Controllers
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerNumberController = TextEditingController();
  final TextEditingController _structureInstallationController = TextEditingController();
  final TextEditingController _installationController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _marginController = TextEditingController();
  final TextEditingController _companyMarginController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // Dropdown selections
  String? _selectedProjectType;
  String? _selectedTechnology;
  String? _selectedPanelWatt;
  String? _selectedNumberOfPanels;
  String? _selectedKW;
  String? _selectedCombo;
  String? _selectedSolarPanel;
  String? _selectedInverter;
  String? _selectedBosKit;
  String? _selectedTerraceType;
  String? _selectedFileType;
  String? _selectedLoanType;

  // Radio and Checkbox selections
  String? _loanOption = '2';
  String? _selectedOption = '1';
  bool _showAdvancedOptions = false;
  bool _showComboCompare = true;
  bool _showCustomize = false;
  bool _showChannelPartnerCharges = false;

  // Sample data for dropdowns
  final List<Map<String, dynamic>> projectTypes = [
    {'id': '1', 'name': 'Residential'},
    {'id': '2', 'name': 'Commercial'},
    {'id': '3', 'name': 'Industrial'},
  ];

  final List<Map<String, dynamic>> technologies = [
    {'id': '1', 'name': 'Mono PERC'},
    {'id': '2', 'name': 'Polycrystalline'},
    {'id': '3', 'name': 'Bifacial'},
    {'id': '4', 'name': 'Half-Cut'},
  ];

  final List<Map<String, dynamic>> panelWatts = [
    {'id': '1', 'watt': '540Wp'},
    {'id': '2', 'watt': '545Wp'},
    {'id': '3', 'watt': '550Wp'},
    {'id': '4', 'watt': '555Wp'},
  ];

  final List<String> numberOfPanels = ['12', '18', '24', '30', '36', '42', '48'];

  final List<Map<String, dynamic>> kwList = [
    {'id': '1', 'kilowat': '5', 'panel_full_name': '5kW Solar System - Mono PERC'},
    {'id': '2', 'kilowat': '10', 'panel_full_name': '10kW Solar System - Polycrystalline'},
    {'id': '3', 'kilowat': '15', 'panel_full_name': '15kW Solar System - Bifacial'},
    {'id': '4', 'kilowat': '20', 'panel_full_name': '20kW Solar System - Half-Cut'},
  ];

  final List<Map<String, dynamic>> combos = [
    {'id': '1', 'name': 'Combo Kit A - 5kW', 'price': '350000'},
    {'id': '2', 'name': 'Combo Kit B - 10kW', 'price': '650000'},
    {'id': '3', 'name': 'Combo Kit C - 15kW', 'price': '950000'},
  ];

  final List<Map<String, dynamic>> solarPanels = [
    {'id': '1', 'name': 'Solar Panel - 540Wp', 'price': '15000'},
    {'id': '2', 'name': 'Solar Panel - 545Wp', 'price': '16000'},
    {'id': '3', 'name': 'Solar Panel - 550Wp', 'price': '17000'},
  ];

  final List<Map<String, dynamic>> inverters = [
    {'id': '1', 'name': 'Inverter - 5kW', 'price': '45000'},
    {'id': '2', 'name': 'Inverter - 10kW', 'price': '85000'},
    {'id': '3', 'name': 'Inverter - 15kW', 'price': '125000'},
  ];

  final List<Map<String, dynamic>> bosKits = [
    {'id': '1', 'name': 'BOS Kit Standard', 'price': '25000'},
    {'id': '2', 'name': 'BOS Kit Premium', 'price': '35000'},
  ];

  final List<Map<String, dynamic>> terraceTypes = [
    {'id': '1', 'name': 'RCC Terrace'},
    {'id': '2', 'name': 'Sheet Terrace'},
    {'id': '3', 'name': 'Ground Mount'},
  ];

  final List<String> timeSlots = [
    '8 AM - 10 AM',
    '10 AM - 12 PM',
    '12 PM - 2 PM',
    '2 PM - 4 PM',
    '4 PM - 6 PM',
    '6 PM - 8 PM',
  ];

  String _selectedTimeSlot = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Quick Quote'),
        centerTitle: true,
        actions: [
          // Combo or Customize toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _showKitTypeDialog();
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.solar_power, size: 24, color: Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Customer Name Field
            _buildTextField(
              controller: _customerNameController,
              label: 'Customer Name *',
              hint: 'Enter customer name',
              icon: Icons.person,
            ),
            const SizedBox(height: 15),

            // Customer Number Field
            _buildTextField(
              controller: _customerNumberController,
              label: 'Customer Number *',
              hint: 'Enter mobile number',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),





            _buildDropdownField(
              label: 'Select Category *',
              hint: 'Select Category',
              value: _selectedProjectType,
              items: ['Solar rooftop','Solar pump','Solar light'].map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedProjectType = value),
            ),
            const SizedBox(height: 15),


            _buildDropdownField(
              label: 'Select Sub Category *',
              hint: 'Select Sub Category',
              value: _selectedProjectType,
              items: ['Residencial','Commercial'].map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedProjectType = value),
            ),
            const SizedBox(height: 15),

            // Project Type Dropdown
            _buildDropdownField(
              label: 'Project Type *',
              hint: 'Select Project Type',
              value: _selectedProjectType,
              items: projectTypes.map((item) {
                return DropdownMenuItem<String>(
                  value: item['id'].toString(),
                  child: Text(item['name']),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedProjectType = value),
            ),
            const SizedBox(height: 15),

            _buildDropdownField(
              label: 'Select Sub Project Type *',
              hint: 'Select Sub Project Type',
              value: _selectedProjectType,
              items: ['On Grid','Off Grid','Hybrid'].map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedProjectType = value),
            ),
            const SizedBox(height: 15),

            // Technology Dropdown
            _buildDropdownField(
              label: 'Select Technology',
              hint: 'Select Technology',
              value: _selectedTechnology,
              items: technologies.map((item) {
                return DropdownMenuItem<String>(
                  value: item['id'].toString(),
                  child: Text(item['name']),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedTechnology = value),
            ),
            const SizedBox(height: 15),

            // Solar Panel Watt Dropdown
            _buildDropdownField(
              label: 'Solar Panel Watt',
              hint: 'Select Solar panel watt',
              value: _selectedPanelWatt,
              items: panelWatts.map((item) {
                return DropdownMenuItem<String>(
                  value: item['id'].toString(),
                  child: Text(item['watt']),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedPanelWatt = value),
            ),
            const SizedBox(height: 15),

            // Number of Panels Dropdown
            _buildDropdownField(
              label: 'Number of Solar Panels',
              hint: 'Select number of panels',
              value: _selectedNumberOfPanels,
              items: numberOfPanels.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedNumberOfPanels = value),
            ),
            const SizedBox(height: 15),

            // KW Dropdown
            _buildDropdownField(
              label: 'Kilowatt (KW)',
              hint: 'Select KW',
              value: _selectedKW,
              items: kwList.map((item) {
                return DropdownMenuItem<String>(
                  value: item['id'].toString(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item['kilowat']} KW', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(item['panel_full_name'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedKW = value),
            ),
            const SizedBox(height: 20),

            // (A) Choose Combo or Compare - Collapsible
            if(_showComboCompare)
              _buildCollapsibleSection(
                title: '(A) Choose Combo or Compare',
                isExpanded: _showComboCompare,
                onToggle: () => setState(() => _showComboCompare = !_showComboCompare),
                content: Column(
                  children: [
                    // Loan Option Radio
                    const SizedBox(height: 15),

                    // Combo Dropdown
                    _buildDropdownField(
                      label: 'Select Combo',
                      hint: 'Select Combo',
                      value: _selectedCombo,
                      items: combos.map((item) {
                        return DropdownMenuItem<String>(
                          value: item['id'].toString(),
                          child: Text(item['name']),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedCombo = value),
                    ),
                    const SizedBox(height: 10),

                    // Selected Combo Display
                    Wrap(
                      spacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'Combo Kit A - 5kW',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),



            // (A) Choose Customize - Collapsible
            if(_showCustomize)
              _buildCollapsibleSection(
                title: '(A) Choose Customize',
                isExpanded: _showCustomize,
                onToggle: () => setState(() => _showCustomize = !_showCustomize),
                content: Column(
                  children: [
                    // Solar Panel Dropdown
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildDropdownField(
                            label: 'Solar Panel',
                            hint: 'Select Solar Panel',
                            value: _selectedSolarPanel,
                            items: solarPanels.map((item) {
                              return DropdownMenuItem<String>(
                                value: item['id'].toString(),
                                child: Text(item['name']),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() => _selectedSolarPanel = value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.solar_power, size: 30, color: Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Inverter Dropdown
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildDropdownField(
                            label: 'Inverter',
                            hint: 'Select Inverter',
                            value: _selectedInverter,
                            items: inverters.map((item) {
                              return DropdownMenuItem<String>(
                                value: item['id'].toString(),
                                child: Text(item['name']),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() => _selectedInverter = value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.electrical_services, size: 30, color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // BOS Kit Dropdown
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildDropdownField(
                            label: 'BOS KIT',
                            hint: 'Select BOS Kit',
                            value: _selectedBosKit,
                            items: bosKits.map((item) {
                              return DropdownMenuItem<String>(
                                value: item['id'].toString(),
                                child: Text(item['name']),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() => _selectedBosKit = value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.build, size: 30, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Calculate Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Calculate'),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Customized Kit Preview
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.solar_power, size: 30, color: Colors.orange),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('24 Panel (10 KW)', style: TextStyle(fontWeight: FontWeight.bold)),
                                const Text('₹4,50,000/-', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                Text('(Including GST)', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('View Details', style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // (B) Channel Partner Charges - Collapsible
            _buildCollapsibleSection(
              title: '(B) Channel Partner Charges',
              isExpanded: _showChannelPartnerCharges,
              onToggle: () => setState(() => _showChannelPartnerCharges = !_showChannelPartnerCharges),
              content: Column(
                children: [
                  // Terrace Type Dropdown
                  _buildDropdownField(
                    label: 'Select Terrace Type',
                    hint: 'Select Terrace Type',
                    value: _selectedTerraceType,
                    items: terraceTypes.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'].toString(),
                        child: Text(item['name']),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedTerraceType = value),
                  ),
                  const SizedBox(height: 15),

                  // Structure and Installation Charges in one row
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _structureInstallationController,
                          label: 'Structure Charges',
                          hint: 'Enter amount',
                          icon: Icons.build,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          controller: _installationController,
                          label: 'Installation Charges',
                          hint: 'Enter amount',
                          icon: Icons.handyman,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Suggestive: ₹25,000', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                        Text('Suggestive: ₹15,000', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Margin/Commission


                  // Company Margin (for Franchise)

                  // Discount Field

                  // Sub Total Display
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow('Sub Total:', '₹0'),
                        _buildSummaryRow('GST (18%):', '₹0'),
                        _buildSummaryRow('Round Off:', '0'),
                        const Divider(),
                        _buildSummaryRow('Grand Total:', '₹0', isBold: true),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('(Including GST)', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Submit Button
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.green.shade400, Colors.green.shade700]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () {
                  _showSurveyConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text('Quick Quote', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade600),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    String? value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            hint: Text(hint),
            items: items,
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsibleSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget content,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Icon(isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    color: isExpanded ? Colors.blue.shade700 : Colors.grey.shade600),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isExpanded ? Colors.blue.shade700 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) content,
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
        ],
      ),
    );
  }

  void _showSurveyConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.article_outlined,
                size: 30,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Site Survey Required?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: Text(
          'Do you want to schedule a site survey for this quote?',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showScheduleDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'No, Skip',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.to(()=>UnifiedSurveyWrapper());
                    // Navigate to Survey Map Screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const SurveyMap(),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Yes, Survey',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(20),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Schedule Follow Up',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text('Choose Date',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        );
                        if (picked != null) {
                          // _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Select Date',
                        suffixIcon: const Icon(Icons.calendar_today, color: Colors.green),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Choose Time',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: timeSlots.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTimeSlot = timeSlots[index];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedTimeSlot == timeSlots[index]
                                      ? Colors.green
                                      : Colors.grey[300]!,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: _selectedTimeSlot == timeSlots[index]
                                    ? Colors.green.withOpacity(0.05)
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  timeSlots[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _selectedTimeSlot == timeSlots[index]
                                        ? Colors.green
                                        : Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Remark',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _remarkController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Tap to add note here...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Quote created successfully!'),
                                backgroundColor: Colors.green),
                          );
                          Get.to(()=>QuotesManagementScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Set Schedule'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showKitTypeDialog() {
    // Local state for the dialog
    bool localIsCombo = _showComboCompare;
    String localFileType = 'Cash';
    String localLoanType = 'NBFC';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Select Solar Kit Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.clear, color: Colors.black, size: 28),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Kit Type Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDialogOption(
                        title: 'Combo Kit',
                        icon: Icons.solar_power,
                        isSelected: localIsCombo,
                        onTap: () => setStateDialog(() => localIsCombo = true),
                      ),
                      _buildDialogOption(
                        title: 'Customize Kit',
                        icon: Icons.build_circle,
                        isSelected: !localIsCombo,
                        onTap: () => setStateDialog(() => localIsCombo = false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // File Type Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Select File Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDialogOption(
                        title: 'Cash File',
                        icon: Icons.currency_rupee,
                        isSelected: localFileType == 'Cash',
                        onTap: () => setStateDialog(() => localFileType = 'Cash'),
                      ),
                      _buildDialogOption(
                        title: 'Loan File',
                        icon: Icons.account_balance,
                        isSelected: localFileType == 'Loan',
                        onTap: () => setStateDialog(() => localFileType = 'Loan'),
                      ),
                    ],
                  ),

                  // Loan Type Selection (only if Loan File is selected)
                  if (localFileType == 'Loan') ...[
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Select Loan Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDialogOption(
                          title: 'NBFC Loan',
                          icon: Icons.business,
                          isSelected: localLoanType == 'NBFC',
                          onTap: () => setStateDialog(() => localLoanType = 'NBFC'),
                        ),
                        _buildDialogOption(
                          title: 'Bank Loan',
                          icon: Icons.account_balance,
                          isSelected: localLoanType == 'Bank',
                          onTap: () => setStateDialog(() => localLoanType = 'Bank'),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showComboCompare = localIsCombo;
                        _showCustomize = !localIsCombo;
                        _selectedFileType = localFileType;
                        _selectedLoanType = localLoanType;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${localIsCombo ? "Combo Kit" : "Customize Kit"}, ${localFileType} File'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("OK", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDialogOption({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.green : Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.green.shade50 : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: isSelected ? Colors.green : Colors.grey),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}