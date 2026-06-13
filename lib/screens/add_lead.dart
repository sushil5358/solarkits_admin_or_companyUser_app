// lib/screens/add_lead_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddLeadScreen extends StatefulWidget {
  final String? leadId;

  const AddLeadScreen({super.key, this.leadId});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  // Controllers for text fields
  final TextEditingController _personOrCompanyController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Dropdown selections
  String? _selectedDistrict;
  String? _selectedCity;
  String? _selectedProjectType;
  String? _selectedSubType;
  String? _selectedLeadSource;
  String? _selectedKW;

  // Lists for dropdowns
  List<Map<String, dynamic>> districts = [];
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> projectTypes = [];
  List<Map<String, dynamic>> subTypes = [];
  List<Map<String, dynamic>> leadSources = [];
  List<Map<String, dynamic>> kwList = [];

  // Advanced options
  bool _showAdvancedOptions = false;
  String _selectedSubTypeOption = '1';
  int _electricityBill = 0;
  double _sliderValue = 0.0;
  double _minRange = 0.0;
  double _maxRange = 20000.0;
  bool _isSameAsMobile = false;


  // Status
  bool _isEditMode = false;
  int _currentStep = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.leadId != null;
    _loadInitialData();
  }

  @override
  void dispose() {
    _personOrCompanyController.dispose();
    _mobileController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _referenceController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {

    // Load districts (sample data - replace with API call)
    await Future.delayed(const Duration(milliseconds: 500));
    districts = [
      {'id': '1', 'name': 'Mumbai'},
      {'id': '2', 'name': 'Delhi NCR'},
      {'id': '3', 'name': 'Bangalore'},
      {'id': '4', 'name': 'Ahmedabad'},
      {'id': '5', 'name': 'Chennai'},
      {'id': '6', 'name': 'Hyderabad'},
      {'id': '7', 'name': 'Pune'},
      {'id': '8', 'name': 'Kolkata'},
    ];

    // Load project types
    projectTypes = [
      {'id': '1', 'name': 'Residential', 'minRange': '0', 'maxRange': '20000', 'tax': '5', 'slot': '10'},
      {'id': '2', 'name': 'Commercial', 'minRange': '0', 'maxRange': '200000', 'tax': '12', 'slot': '10'},
      {'id': '3', 'name': 'Industrial', 'minRange': '0', 'maxRange': '500000', 'tax': '18', 'slot': '10'},
    ];

    // Load lead sources
    leadSources = [
      {'id': '1', 'name': 'Whatsapp marketing'},
      {'id': '2', 'name': 'Facebook'},
      {'id': '3', 'name': 'Youtube'},
      {'id': '4', 'name': 'Email marketing'},
      {'id': '5', 'name': 'Referral'},
      {'id': '6', 'name': 'Website'},
      {'id': '7', 'name': 'Walk-in'},
    ];


  }

  Future<void> _loadCities(String districtId) async {

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 300));
    cities = [
      {'id': '1', 'name': 'Andheri East', 'districtId': '1'},
      {'id': '2', 'name': 'Bandra West', 'districtId': '1'},
      {'id': '3', 'name': 'Connaught Place', 'districtId': '2'},
      {'id': '4', 'name': 'Saket', 'districtId': '2'},
      {'id': '5', 'name': 'Indiranagar', 'districtId': '3'},
      {'id': '6', 'name': 'Koramangala', 'districtId': '3'},
    ].where((c) => c['districtId'] == districtId).toList();

  }

  Future<void> _loadSubTypes(String projectTypeId) async {

    await Future.delayed(const Duration(milliseconds: 300));
    subTypes = [
      {'id': '1', 'name': 'On Grid'},
      {'id': '2', 'name': 'Off Grid'},
      {'id': '3', 'name': 'Hybrid'},
    ];

  }

  Future<void> _loadKWList(String projectTypeId, int billAmount) async {

    await Future.delayed(const Duration(milliseconds: 300));
    kwList = [
      {'id': '1', 'kilowat': '5', 'panel_full_name': '5kW Solar System - Mono PERC'},
      {'id': '2', 'kilowat': '10', 'panel_full_name': '10kW Solar System - Polycrystalline'},
      {'id': '3', 'kilowat': '15', 'panel_full_name': '15kW Solar System - Bifacial'},
      {'id': '4', 'kilowat': '20', 'panel_full_name': '20kW Solar System - Half-Cut'},
      {'id': '5', 'kilowat': '25', 'panel_full_name': '25kW Solar System - Mono PERC'},
    ];

  }

  void _updateSliderRange() {
    var selectedType = projectTypes.firstWhere(
          (e) => e['id'] == _selectedProjectType,
      orElse: () => {'minRange': '0', 'maxRange': '20000'},
    );
    _minRange = double.parse(selectedType['minRange'].toString());
    _maxRange = double.parse(selectedType['maxRange'].toString());
    if (_sliderValue < _minRange) _sliderValue = _minRange;
    if (_sliderValue > _maxRange) _sliderValue = _maxRange;
  }

  void _onDistrictChanged(String? districtId) {
    setState(() {
      _selectedDistrict = districtId;
      _selectedCity = null;
      cities = [];
    });
    if (districtId != null) {
      _loadCities(districtId);
    }
  }

  void _onProjectTypeChanged(String? typeId) {
    setState(() {
      _selectedProjectType = typeId;
      _selectedSubType = null;
      _selectedKW = null;
      _sliderValue = 0;
      _electricityBill = 0;
      _updateSliderRange();
    });
    if (typeId != null) {
      _loadSubTypes(typeId);
    }
  }

  void _onBillSliderChanged(double value) {
    setState(() {
      _sliderValue = value;
      _electricityBill = value.toInt();
    });
    if (_selectedProjectType != null) {
      _loadKWList(_selectedProjectType!, _electricityBill);
    }
  }

  void _validateAndSave() {
    if (_personOrCompanyController.text.isEmpty) {
      _showSnackbar('Please enter person/company name');
      return;
    }
    if (_mobileController.text.isEmpty) {
      _showSnackbar('Please enter mobile number');
      return;
    }
    if (_mobileController.text.length != 10) {
      _showSnackbar('Please enter valid 10-digit mobile number');
      return;
    }
    if (_selectedDistrict == null) {
      _showSnackbar('Please select district');
      return;
    }
    if (_selectedProjectType == null) {
      _showSnackbar('Please select project type');
      return;
    }
    if (_selectedKW == null) {
      _showSnackbar('Please select kilowatt (KW)');
      return;
    }

    // Success - navigate back
    _showSuccessDialog();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Lead Created!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text('Lead has been created successfully.', textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    ).then((_) => Navigator.pop(context, true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Lead' : 'Add New Lead'),
        centerTitle: true,
        actions: [
          if (_isEditMode)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                // Delete lead logic
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Person/Company Name
              _buildTextField(
                controller: _personOrCompanyController,
                label: 'Person Or Company Name *',
                icon: Icons.person,
                hint: 'Enter name',
              ),
              const SizedBox(height: 16),

              // Mobile Number
              _buildTextField(
                controller: _mobileController,
                label: 'Mobile Number *',
                icon: Icons.phone,
                hint: 'Enter 10-digit mobile number',
                keyboardType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
              ),
              const SizedBox(height: 16),

              // WhatsApp Number with Same as Mobile checkbox
              _buildTextField(
                controller: _whatsappController,
                label: 'WhatsApp Number (Optional)',
                icon: Icons.message,
                hint: 'Enter WhatsApp number',
                keyboardType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],

              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The quick brown fox jumps over the lazy dog
                  Checkbox(
                    value: _isSameAsMobile,
                    onChanged: (value) {
                      setState(() {
                        _isSameAsMobile = value ?? false;
                        if (_isSameAsMobile) {
                          _whatsappController.text = _mobileController.text;
                        } else {
                          _whatsappController.clear();
                        }
                      });
                    },
                  ),
                  const Text('Same as Mobile', style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 16),

              // Email
              _buildTextField(
                controller: _emailController,
                label: 'Email (Optional)',
                icon: Icons.email,
                hint: 'Enter email address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // District Dropdown
              _buildDropdownField(
                label: 'District *',
                icon: Icons.location_city,
                value: _selectedDistrict,
                items: districts.map<DropdownMenuItem<String>>((d) {  // Explicit type
                  return DropdownMenuItem<String>(
                    value: d['id'].toString(),
                    child: Text(d['name']),
                  );
                }).toList(),
                onChanged: _onDistrictChanged,
              ),
              const SizedBox(height: 16),

              // City Dropdown
              _buildDropdownField(
                label: 'City (Optional)',
                icon: Icons.location_on,
                value: _selectedCity,
                items: cities.map<DropdownMenuItem<String>>((c) {  // Explicit type
                  return DropdownMenuItem<String>(
                    value: c['id'].toString(),
                    child: Text(c['name']),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCity = value),
                enabled: _selectedDistrict != null,
              ),
              const SizedBox(height: 16),

              // Project Type Dropdown
              _buildDropdownField(
                label: 'Project Type *',
                icon: Icons.solar_power,
                value: _selectedProjectType,
                items: projectTypes.map<DropdownMenuItem<String>>((p) {  // Explicit type
                  return DropdownMenuItem<String>(
                    value: p['id'].toString(),
                    child: Text(p['name']),
                  );
                }).toList(),
                onChanged: _onProjectTypeChanged,
              ),
              const SizedBox(height: 16),

              // Lead Source Dropdown
              _buildDropdownField(
                label: 'Lead Source *',
                icon: Icons.source,
                value: _selectedLeadSource,
                items: leadSources.map<DropdownMenuItem<String>>((l) {  // Explicit type
                  return DropdownMenuItem<String>(
                    value: l['name'].toString(),
                    child: Text(l['name']),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedLeadSource = value),
              ),

              // Advanced Options Toggle
              if (_selectedProjectType != null)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () => setState(() => _showAdvancedOptions = !_showAdvancedOptions),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _showAdvancedOptions ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Show Advanced Options',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Advanced Options Content
              if (_showAdvancedOptions) ...[
                const SizedBox(height: 16),

                // Sub Type Selection
                if (subTypes.isNotEmpty) ...[
                  const Text(
                    'Select Sub Type',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 20,
                    children: subTypes.map((type) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: type['id'],
                            groupValue: _selectedSubTypeOption,
                            onChanged: (value) {
                              setState(() => _selectedSubTypeOption = value!);
                            },
                            activeColor: Colors.green,
                          ),
                          Text(type['name'], style: const TextStyle(fontSize: 12)),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Electricity Bill Slider
                const Text(
                  'Select Electricity Bill Payment (Monthly)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '₹$_electricityBill',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Slider(
                  activeColor: Colors.orange,
                  inactiveColor: Colors.grey.shade300,
                  value: _sliderValue,
                  min: _minRange,
                  max: _maxRange,
                  divisions: 10,
                  onChanged: _onBillSliderChanged,
                  label: '₹${_sliderValue.toInt()}',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₹${_minRange.toInt()}'),
                      Text('₹${_maxRange.toInt()}'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // KW Dropdown
                _buildDropdownField(
                  label: 'Kilowatt (KW) *',
                  icon: Icons.electric_bolt,
                  value: _selectedKW,
                  items: kwList.map<DropdownMenuItem<String>>((k) {  // Explicit type
                    return DropdownMenuItem<String>(
                      value: k['id'].toString(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${k['kilowat']} KW',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            k['panel_full_name'],
                            style: const TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedKW = value),
                ),
                const SizedBox(height: 16),


                // Address

              ],

              const SizedBox(height: 24),

              // Submit Button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade700],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: _validateAndSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isEditMode ? 'Update Lead' : 'Create Lead',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    Widget? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade600),
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
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
    required IconData icon,
    required List<DropdownMenuItem<String>> items,  // Changed to String type
    required Function(String?) onChanged,
    String? value,
    bool enabled = true,
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
            items: items,  // Now correctly typed
            onChanged: enabled ? onChanged : null,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade600),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down, color: enabled ? Colors.green.shade600 : Colors.grey),
          ),
        ),
      ],
    );
  }
}