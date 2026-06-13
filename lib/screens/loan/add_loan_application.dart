// lib/view/loan_model_screen.dart
import 'dart:io';

import 'package:admin_app_new/loan_eligibility.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';



class AddLoanApplication extends StatefulWidget {
  const AddLoanApplication({super.key});

  @override
  State<AddLoanApplication> createState() => _AddLoanApplicationState();
}

class _AddLoanApplicationState extends State<AddLoanApplication> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController electricityBillController = TextEditingController();

  // Dropdown selections
  String? selectedDistrict;
  String? selectedCity;
  String? selectedKw;

  // Aadhar verification
  bool isAadharVerified = false;
  bool isAadharLoading = false;

  // Pan verification
  bool isPanVerified = false;
  bool isPanLoading = false;

  // Electricity bill verification
  bool isBillVerified = false;
  bool isBillLoading = false;

  // File paths for uploaded images
  String? aadharFrontImage;
  String? aadharBackImage;
  String? panImage;
  String? billImage;

  // Monthly bill slider
  double monthlyBill = 1000;

  // District and city options
  final List<String> districts = [
    'Select District',
    'Ahmedabad',
    'Rajkot',
    'Surat',
    'Vadodara',
    'Bhavnagar',
    'Jamnagar',
    'Junagadh',
    'Gandhinagar',
  ];

  final Map<String, List<String>> citiesByDistrict = {
    'Ahmedabad': ['Ahmedabad', 'Gandhinagar', 'Sanand'],
    'Rajkot': ['Rajkot', 'Morbi', 'Gondal'],
    'Surat': ['Surat', 'Navsari', 'Vapi'],
    'Vadodara': ['Vadodara', 'Bharuch', 'Ankleshwar'],
    'Bhavnagar': ['Bhavnagar', 'Botad', 'Palitana'],
    'Jamnagar': ['Jamnagar', 'Khambhalia', 'Dwarka'],
    'Junagadh': ['Junagadh', 'Veraval', 'Mangrol'],
    'Gandhinagar': ['Gandhinagar', 'Kalol', 'Mansa'],
  };

  final List<String> kwOptions = ['1 KW', '2 KW', '3 KW', '4 KW', '5 KW', '6 KW', '7 KW', '8 KW', '9 KW', '10 KW', '12 KW', '15 KW', '20 KW'];

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    pincodeController.dispose();
    aadharController.dispose();
    panController.dispose();
    electricityBillController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(String type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        switch(type) {
          case 'aadhar_front':
            aadharFrontImage = image.path;
            break;
          case 'aadhar_back':
            aadharBackImage = image.path;
            break;
          case 'pan':
            panImage = image.path;
            break;
          case 'bill':
            billImage = image.path;
            break;
        }
      });
    }
  }

  void _verifyAadhar() {
    if (aadharController.text.length == 12) {
      setState(() {
        isAadharLoading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isAadharLoading = false;
          isAadharVerified = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aadhar verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid 12-digit Aadhar number'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _verifyPan() {
    String pan = panController.text.toUpperCase();
    RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

    if (panRegex.hasMatch(pan)) {
      setState(() {
        isPanLoading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isPanLoading = false;
          isPanVerified = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PAN verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid PAN number'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _verifyBill() {
    if (electricityBillController.text.isNotEmpty) {
      setState(() {
        isBillLoading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isBillLoading = false;
          isBillVerified = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Electricity Bill verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter electricity bill number'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _saveAndNext() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter name'), backgroundColor: Colors.red),
      );
      return;
    }
    if (mobileController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid mobile number'), backgroundColor: Colors.red),
      );
      return;
    }
    if (selectedDistrict == null || selectedDistrict == 'Select District') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select district'), backgroundColor: Colors.red),
      );
      return;
    }
    if (selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select city'), backgroundColor: Colors.red),
      );
      return;
    }
    if (!isAadharVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please verify Aadhar number'), backgroundColor: Colors.red),
      );
      return;
    }
    if (aadharFrontImage == null || aadharBackImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload Aadhar front and back photos'), backgroundColor: Colors.red),
      );
      return;
    }
    if (!isPanVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please verify PAN number'), backgroundColor: Colors.red),
      );
      return;
    }
    if (panImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload PAN photo'), backgroundColor: Colors.red),
      );
      return;
    }
    if (!isBillVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please verify electricity bill'), backgroundColor: Colors.red),
      );
      return;
    }
    if (selectedKw == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select KW'), backgroundColor: Colors.red),
      );
      return;
    }

    // All validations passed
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Loan Application',
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personal Information Section
            // _buildSectionTitle('Personal Information'),
            // const SizedBox(height: 12),
            // _buildTextField(
            //   controller: nameController,
            //   label: 'Full Name',
            //   hint: 'Enter your full name',
            //   icon: Icons.person,
            // ),
            // const SizedBox(height: 12),
            // _buildTextField(
            //   controller: mobileController,
            //   label: 'Mobile Number',
            //   hint: 'Enter 10-digit mobile number',
            //   icon: Icons.phone,
            //   keyboardType: TextInputType.phone,
            // ),
            // const SizedBox(height: 12),
            // _buildTextField(
            //   controller: pincodeController,
            //   label: 'Pincode',
            //   hint: 'Enter pincode',
            //   icon: Icons.location_on,
            //   keyboardType: TextInputType.number,
            // ),
            // const SizedBox(height: 12),
            //
            // // Location Section
            // _buildSectionTitle('Location Details'),
            // const SizedBox(height: 12),
            // _buildDropdownField(
            //   label: 'Select District',
            //   value: selectedDistrict,
            //   items: districts.map((district) {
            //     return DropdownMenuItem(
            //       value: district,
            //       child: Text(district),
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedDistrict = value;
            //       selectedCity = null;
            //     });
            //   },
            // ),
            // const SizedBox(height: 12),
            // _buildDropdownField(
            //   label: 'Select City',
            //   value: selectedCity,
            //   items: selectedDistrict != null && selectedDistrict != 'Select District'
            //       ? citiesByDistrict[selectedDistrict!]?.map((city) {
            //     return DropdownMenuItem(
            //       value: city,
            //       child: Text(city),
            //     );
            //   }).toList() ?? []
            //       : [],
            //   onChanged: (value) {
            //     setState(() {
            //       selectedCity = value;
            //     });
            //   },
            //   enabled: selectedDistrict != null && selectedDistrict != 'Select District',
            // ),
            const SizedBox(height: 16),

            // Aadhar Section
            _buildSectionTitle('Aadhar Details'),
            const SizedBox(height: 12),
            _buildVerificationField(
              controller: aadharController,
              label: 'Aadhar Number',
              hint: 'Enter 12-digit Aadhar number',
              icon: Icons.credit_card,
              isVerified: isAadharVerified,
              isLoading: isAadharLoading,
              onVerify: _verifyAadhar,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildUploadCard(
                    title: 'Front Side',
                    imagePath: aadharFrontImage,
                    onTap: () => _pickImage('aadhar_front'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildUploadCard(
                    title: 'Back Side',
                    imagePath: aadharBackImage,
                    onTap: () => _pickImage('aadhar_back'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // PAN Section
            _buildSectionTitle('PAN Details'),
            const SizedBox(height: 12),
            _buildVerificationField(
              controller: panController,
              label: 'PAN Number',
              hint: 'Enter PAN number',
              icon: Icons.assignment_ind,
              isVerified: isPanVerified,
              isLoading: isPanLoading,
              onVerify: _verifyPan,
              upperCase: true,
            ),
            const SizedBox(height: 12),
            _buildUploadCard(
              title: 'Upload PAN Photo',
              imagePath: panImage,
              onTap: () => _pickImage('pan'),
            ),
            const SizedBox(height: 16),

            // Electricity Bill Section
            _buildSectionTitle('Electricity Bill Details'),
            const SizedBox(height: 12),
            _buildVerificationField(
              controller: electricityBillController,
              label: 'Electricity Bill Number',
              hint: 'Enter electricity bill number',
              icon: Icons.receipt,
              isVerified: isBillVerified,
              isLoading: isBillLoading,
              onVerify: _verifyBill,
            ),
            const SizedBox(height: 12),
            _buildUploadCard(
              title: 'Upload Bill Photo',
              imagePath: billImage,
              onTap: () => _pickImage('bill'),
            ),
            const SizedBox(height: 24),

            // Save & Next Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Get.to(()=>LoanProductSelectionScreen());
                  Get.to(LoanEligibilityScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save & Next',
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

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          color: Colors.green,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    String? value,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        items: items,
        onChanged: enabled ? onChanged : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        icon: Icon(Icons.arrow_drop_down, color: Colors.green),
        dropdownColor: Colors.white,
      ),
    );
  }

  Widget _buildVerificationField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isVerified,
    required bool isLoading,
    required VoidCallback onVerify,
    TextInputType keyboardType = TextInputType.text,
    bool upperCase = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.green),
          suffixIcon: isVerified
              ? const Icon(Icons.verified, color: Colors.green)
              : isLoading
              ? SizedBox(
            width: 20,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.green,
              ),
            ),
          )
              : TextButton(
            onPressed: onVerify,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Text(
              'Verify',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        onChanged: (value) {
          if (upperCase) {
            controller.text = value.toUpperCase();
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          }
          setState(() {
            if (label == 'Aadhar Number') isAadharVerified = false;
            if (label == 'PAN Number') isPanVerified = false;
            if (label == 'Electricity Bill Number') isBillVerified = false;
          });
        },
      ),
    );
  }

  Widget _buildUploadCard({
    required String title,
    required String? imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(imagePath),
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Icon(
                Icons.cloud_upload,
                size: 40,
                color: Colors.green,
              ),
            const SizedBox(height: 8),
            Text(
              imagePath != null ? 'Uploaded' : title,
              style: TextStyle(
                fontSize: 12,
                color: imagePath != null ? Colors.green : Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}