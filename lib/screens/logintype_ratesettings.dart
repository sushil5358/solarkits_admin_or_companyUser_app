// lib/screens/user_rate_edit_screen.dart

import 'package:admin_app_new/screens/projecttype_ratesettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class UserRateEditScreen extends StatefulWidget {
  final String loginType;

  const UserRateEditScreen({super.key, required this.loginType});

  @override
  State<UserRateEditScreen> createState() => _UserRateEditScreenState();
}

class _UserRateEditScreenState extends State<UserRateEditScreen> {
  List<String> _selectedDistricts = [];
  List<String> _selectedProjectTypes = [];
  String? _selectedRateProjectType;

  final TextEditingController _companyMarginController = TextEditingController();
  final TextEditingController _userMarginController = TextEditingController();
  final TextEditingController _structureChargesController = TextEditingController();
  final TextEditingController _installationChargesController = TextEditingController();

  final List<String> _districts = [
    'Mumbai', 'Delhi NCR', 'Bangalore', 'Ahmedabad',
    'Chennai', 'Hyderabad', 'Pune', 'Kolkata', 'Jaipur', 'Lucknow'
  ];

  final List<String> _projectTypes = [
    'Residential', 'Commercial', 'Industrial', 'Agricultural', 'Institutional', 'Government'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('${widget.loginType} Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade600, Colors.green.shade800],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.loginType,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Configure settings for this user type',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Allocated Districts
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      const Text(
                        'Allocated States',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MultiSelectDialogField(
                    items: ['Gujrat','Bihar','delhi','Punjab'].map((district) {
                      return MultiSelectItem(district, district);
                    }).toList(),
                    title: const Text('Select States'),
                    // selectedItems: _selectedDistricts,
                    onConfirm: (values) {
                      setState(() {
                        _selectedDistricts = values;
                      });
                    },
                    buttonText: const Text('Select States'),
                    buttonIcon: const Icon(Icons.location_on),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      const Text(
                        'Allocated Districts',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MultiSelectDialogField(
                    items: _districts.map((district) {
                      return MultiSelectItem(district, district);
                    }).toList(),
                    title: const Text('Select Districts'),
                    // selectedItems: _selectedDistricts,
                    onConfirm: (values) {
                      setState(() {
                        _selectedDistricts = values;
                      });
                    },
                    buttonText: const Text('Select Districts'),
                    buttonIcon: const Icon(Icons.location_on),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_selectedDistricts.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedDistricts.map((district) {
                        return Chip(
                          label: Text(district),
                          backgroundColor: Colors.blue.shade50,
                          deleteIcon: const Icon(Icons.close, size: 16),
                          onDeleted: () {
                            setState(() {
                              _selectedDistricts.remove(district);
                            });
                          },
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Project Types
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  MultiSelectDialogField(
                    items: ['Recidencial','Commercial'].map((type) {
                      return MultiSelectItem(type, type);
                    }).toList(),
                    title: const Text('Select Sub Category'),
                    // selectedItems: _selectedProjectTypes,
                    onConfirm: (values) {

                    },
                    buttonText: const Text('Select Sub Category'),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MultiSelectDialogField(
                    items: ['Solar Rooftop','Solar Pump','Solar Light'].map((type) {
                      return MultiSelectItem(type, type);
                    }).toList(),
                    title: const Text('Select Category'),
                    // selectedItems: _selectedProjectTypes,
                    onConfirm: (values) {

                    },
                    buttonText: const Text('Select Category'),
                    decoration: BoxDecoration(

                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MultiSelectDialogField(
                    items: _projectTypes.map((type) {
                      return MultiSelectItem(type, type);
                    }).toList(),
                    title: const Text('Select Project Types'),
                    // selectedItems: _selectedProjectTypes,
                    onConfirm: (values) {
                      setState(() {
                        _selectedProjectTypes = values;
                      });
                    },
                    buttonText: const Text('Select Project Types'),
                    buttonIcon: const Icon(Icons.arrow_downward_sharp),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MultiSelectDialogField(
                    items: ['Off Grid','On Grid','Hybrid'].map((type) {
                      return MultiSelectItem(type, type);
                    }).toList(),
                    title: const Text('Select Sub Project Type'),
                    // selectedItems: _selectedProjectTypes,
                    onConfirm: (values) {

                    },
                    buttonText: const Text('Select Sub Project Type'),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),




                  const SizedBox(height: 12),


                ],
              ),
            ),
            const SizedBox(height: 16),


            ListView.builder(
              shrinkWrap: true,  // Add this
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedProjectTypes.length,
              itemBuilder: (context, index) {
                var projecttype = _selectedProjectTypes[index];
                return InkWell(
                  onTap:  () {
                    Get.to(()=>ProjecttypeRatesettings(margin: '1',));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Left colored bar
                        Container(
                          width: 4,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                        ),

                        // Icon
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.paste_outlined,
                              color: Colors.green,
                              size: 22,
                            ),
                          ),
                        ),

                        // Name and Stats
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                projecttype,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),

                            ],
                          ),
                        ),

                        // Arrow Icon
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );

            },),



            // Rate Settings
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.shade100,
            //         blurRadius: 10,
            //         offset: const Offset(0, 2),
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           Icon(Icons.currency_rupee, color: Colors.green.shade700),
            //           const SizedBox(width: 8),
            //           const Text(
            //             'Rate Settings',
            //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 16),
            //
            //       // Project Type Dropdown
            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.grey.shade300),
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         child: DropdownButtonFormField<String>(
            //           value: _selectedRateProjectType,
            //           hint: const Text('Select Project Type'),
            //           isExpanded: true,
            //           items: _projectTypes.map((type) {
            //             return DropdownMenuItem(value: type, child: Text(type));
            //           }).toList(),
            //           onChanged: (value) {
            //             setState(() {
            //               _selectedRateProjectType = value;
            //             });
            //           },
            //           decoration: const InputDecoration(
            //             border: InputBorder.none,
            //             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //             prefixIcon: Icon(Icons.category, size: 20),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(height: 20),
            //
            //       // Rate Fields
            //       _buildRateField(
            //         controller: _companyMarginController,
            //         label: 'Company Margin (₹)',
            //         hint: 'Enter Company Margin',
            //         icon: Icons.business_center,
            //         suffix: '%',
            //       ),
            //       const SizedBox(height: 16),
            //
            //       _buildRateField(
            //         controller: _userMarginController,
            //         label: 'User Suggestive Margin (₹)',
            //         hint: 'Enter amount',
            //         icon: Icons.trending_up,
            //         suffix: '₹',
            //       ),
            //       const SizedBox(height: 16),
            //
            //       _buildRateField(
            //         controller: _structureChargesController,
            //         label: 'Structure Charges (₹)',
            //         hint: 'Enter amount ',
            //         icon: Icons.build,
            //         suffix: '₹',
            //       ),
            //       const SizedBox(height: 16),
            //
            //       _buildRateField(
            //         controller: _installationChargesController,
            //         label: 'Installation Charges (₹)',
            //         hint: 'Enter amount',
            //         icon: Icons.handyman,
            //         suffix: '₹',
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 24),

            // Update Button
            Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade700],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200,
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings updated successfully!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Update Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade600),
            suffixText: suffix,
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
}