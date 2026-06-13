
import 'package:admin_app_new/screens/partner_users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/otp_controller.dart';


class PartnerAgreementScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const PartnerAgreementScreen({super.key, required this.userData});

  @override
  State<PartnerAgreementScreen> createState() => _PartnerAgreementScreenState();
}

class _PartnerAgreementScreenState extends State<PartnerAgreementScreen> {
  bool isAgreed = false;
  final OtpController otpController = Get.put(OtpController());

  @override
  void dispose() {
    Get.delete<OtpController>();
    super.dispose();
  }

  void _sendOtp() {
    otpController.startTimer();
    _showOtpDialog();
  }

  void _showOtpDialog() {
    List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
    List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());
    String enteredOtp = '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.security,
                        size: 28,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Please enter the 6-digit OTP sent to',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.userData['mobile'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // OTP Input Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: otpControllers[index],
                                focusNode: otpFocusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.green, width: 2),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < 5) {
                                    FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
                                  } else if (value.isEmpty && index > 0) {
                                    FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
                                  }

                                  enteredOtp = otpControllers.map((c) => c.text).join();
                                  if (enteredOtp.length == 6) {
                                    _verifyOtpAndClose(enteredOtp, context);
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),

                    // Resend OTP Row with Timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive OTP? ",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Obx(() => GestureDetector(
                          onTap: otpController.canResendOtp.value ? () {
                            otpController.resendOtp();
                            // Clear OTP fields
                            for (var controller in otpControllers) {
                              controller.clear();
                            }
                            enteredOtp = '';
                            if (otpFocusNodes.isNotEmpty) {
                              FocusScope.of(context).requestFocus(otpFocusNodes[0]);
                            }
                          } : null,
                          child: Text(
                            otpController.canResendOtp.value ? 'Resend OTP' : '${otpController.timerSeconds.value}s',
                            style: TextStyle(
                              fontSize: 11,
                              color: otpController.canResendOtp.value ? Colors.blue : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      // Clean up
      for (var controller in otpControllers) {
        controller.dispose();
      }
      for (var focusNode in otpFocusNodes) {
        focusNode.dispose();
      }
    });
  }

  void _verifyOtpAndClose(String otp, BuildContext dialogContext) {
    if (otp == '000000') {
      otpController.resetTimer();
      // Unfocus any focused text field to stop caret updates
      FocusScope.of(dialogContext).unfocus();
      // Close the OTP dialog
      Navigator.of(dialogContext).pop();
      // Wait for dialog to fully close and overlay to be removed
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          Get.snackbar(
            'Success',
            'Agreement completed! Partner user created successfully.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          // Navigate after snackbar
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Get.offAll(() =>  PartnerUsersScreen());
            }
          });
        }
      });
    } else {
      ScaffoldMessenger.of(dialogContext).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please try again.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _shareAgreement() {
    Get.snackbar(
      'Share Agreement',
      'Agreement link has been sent to ${widget.userData['email']}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Partner Agreement',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareAgreement,
            tooltip: 'Share Agreement',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Partner Details Card
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
                      Icon(Icons.person, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      const Text(
                        'Partner Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow('Name', widget.userData['name']),
                  _buildDetailRow('Email', widget.userData['email']),
                  _buildDetailRow('Mobile', widget.userData['mobile']),
                  _buildDetailRow('Partner Type', widget.userData['partnerType']),
                  _buildDetailRow('Profession', widget.userData['professionType']),
                  _buildDetailRow('Shop/Office', widget.userData['shopType']),
                  _buildDetailRow('GST', widget.userData['hasGst']),
                  if (widget.userData['hasGst'] == 'Yes')
                    _buildDetailRow('Business Type', widget.userData['businessType'] ?? 'Not Selected'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Agreement Content
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
                      Icon(Icons.assignment, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      const Text(
                        'Partner Agreement',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  _buildAgreementSection(
                    title: '1. Terms of Partnership',
                    content: 'The partner agrees to promote and sell SolarKits products in their designated area.',
                  ),
                  const SizedBox(height: 12),

                  _buildAgreementSection(
                    title: '2. Commission Structure',
                    content: 'Commission will be calculated based on the system size (KW) sold.',
                  ),
                  const SizedBox(height: 12),

                  _buildAgreementSection(
                    title: '3. Territory Rights',
                    content: 'The partner has exclusive rights to operate in their allocated district(s).',
                  ),
                  const SizedBox(height: 12),

                  _buildAgreementSection(
                    title: '4. Performance Expectations',
                    content: 'Partner is expected to meet minimum monthly targets as agreed.',
                  ),
                  const SizedBox(height: 12),

                  _buildAgreementSection(
                    title: '5. Confidentiality',
                    content: 'Partner agrees to keep all pricing, customer data, and business strategies confidential.',
                  ),
                  const SizedBox(height: 12),

                  _buildAgreementSection(
                    title: '6. Termination',
                    content: 'Either party may terminate this agreement with 30 days written notice.',
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Accept Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isAgreed,
                        onChanged: (value) {
                          setState(() {
                            isAgreed = value ?? false;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      Expanded(
                        child: Text(
                          'I have read and agree to the terms and conditions',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isAgreed ? Colors.green.shade700 : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (isAgreed)
                    const SizedBox(height: 16),
                  if (isAgreed)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _sendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Send OTP for Verification',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreementSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}