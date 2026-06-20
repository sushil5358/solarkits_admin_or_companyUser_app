// lib/screens/add_partner_user_screen.dart

import 'package:admin_app_new/controller/add_partnerUser_controller.dart';
import 'package:admin_app_new/models/comanItem_model.dart';
import 'package:admin_app_new/screens/partner_agreement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPartnerUserScreen extends StatefulWidget {
  const AddPartnerUserScreen({super.key});

  @override
  State<AddPartnerUserScreen> createState() => _AddPartnerUserScreenState();
}

class _AddPartnerUserScreenState extends State<AddPartnerUserScreen> {

  AddPartneruserController controller = Get.put(AddPartneruserController());

  // Controllers for text fields


  // Focus nodes for better UX
  final FocusNode aadharFocusNode = FocusNode();

  // Observable values for dropdowns
  final RxString selectedState = ''.obs;
  final RxString selectedDistrict = ''.obs;
  final RxString selectedPartnerType = ''.obs;
  final RxString selectedProfessionType = ''.obs;


  // Aadhar verification state
  final RxBool isAadharVerified = false.obs;
  final RxBool isAadharValid = false.obs;
  final RxString aadharErrorMessage = ''.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Static profession list
  final List<String> professionTypes = [
    'Solar Consultant',
    'Electrician',
    'Contractor',
    'Engineer',
    'Business Owner',
    'Sales Professional',
    'Technician',
    'Project Manager',
  ];

  // Static data for dropdowns
  final Map<String, List<String>> statesDistricts = {
    'Gujarat': [
      'Rajkot',
      'Surat',
      'Ahmedabad',
      'Vadodara',
      'Bhavnagar',
      'Jamnagar',
      'Junagadh',
      'Gandhinagar'
    ],
    'Maharashtra': [
      'Mumbai',
      'Pune',
      'Nagpur',
      'Nashik',
      'Thane',
      'Aurangabad'
    ],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Ajmer', 'Bikaner'],
    'Madhya Pradesh': ['Bhopal', 'Indore', 'Jabalpur', 'Gwalior', 'Ujjain'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Agra', 'Varanasi', 'Prayagraj'],
    'Delhi': ['New Delhi', 'South Delhi', 'North Delhi', 'East Delhi'],
  };

  final List<String> partnerTypes = [
    'Channel Partner',
    'Freelancer',
    'Distributor',
    'Installer',
    'Retailer',
  ];

  @override
  void initState() {
    super.initState();

    ever(controller.isLoading, (loading) {
      if (loading) {
        showLoadingDialog();
      } else {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
    });
    // Add listener to aadhar text field

    // Set initial selected state
    selectedState.value = 'Gujarat';
    selectedDistrict.value = 'Rajkot';
    selectedPartnerType.value = 'Channel Partner';
    selectedProfessionType.value = 'Solar Consultant';
  }

  @override
  void dispose() {
    aadharFocusNode.dispose();
    super.dispose();
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Add New Partner User',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Obx(() =>
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.fKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Field
                  _buildLabel('Full Name', Icons.person_outline),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: _buildInputDecoration(
                      hintText: 'Enter full name',
                      prefixIcon: Icons.person_outline,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please Enter Full Name';
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  _buildLabel('Email Address', Icons.email_outlined),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _buildInputDecoration(
                      hintText: 'Enter email address',
                      prefixIcon: Icons.email_outlined,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please Enter Email';
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Mobile Number Field
                  _buildLabel('Mobile Number', Icons.phone_android),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.mobileNumberController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: _buildInputDecoration(
                      hintText: 'Enter 10-digit mobile number',
                      prefixIcon: Icons.phone_android,
                    ).copyWith(counterText: ''),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please Enter mobile number';
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // State Dropdown
                  // _buildLabel('State', Icons.location_on_outlined),
                  // const SizedBox(height: 8),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(12),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.shade100,
                  //         blurRadius: 8,
                  //         offset: const Offset(0, 2),
                  //       ),
                  //     ],
                  //   ),
                  //   child: DropdownButtonFormField<String>(
                  //     value: selectedState.value.isEmpty ? null : selectedState.value,
                  //     isExpanded: true,
                  //     hint: const Text('Select State'),
                  //     items: statesDistricts.keys.map((String state) {
                  //       return DropdownMenuItem<String>(
                  //         value: state,
                  //         child: Text(state),
                  //       );
                  //     }).toList(),
                  //     onChanged: (value) {
                  //       if (value != null) {
                  //         selectedState.value = value;
                  //         // Reset district when state changes
                  //         selectedDistrict.value = statesDistricts[value]!.first;
                  //       }
                  //     },
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       contentPadding: const EdgeInsets.symmetric(
                  //         horizontal: 16,
                  //         vertical: 14,
                  //       ),
                  //       prefixIcon: Icon(
                  //         Icons.location_on_outlined,
                  //         color: Colors.green.shade600,
                  //       ),
                  //     ),
                  //     icon: Icon(Icons.arrow_drop_down, color: Colors.green.shade600),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),

                  // District Dropdown
                  _buildLabel('District', Icons.map_outlined),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      CommonItemModel? selected = controller.districtList
                          .firstWhereOrNull((element) {
                        return element.id ==
                            controller.selectedDistrictIds.value;
                      },);
                      return DropdownButtonFormField<CommonItemModel>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(value == null || value.id.isEmpty){
                            return 'Please Select District';
                          }
                          return null;
                        },
                        value: selected,
                        isExpanded: true,
                        hint: const Text('Select District'),
                        items: controller.districtList.map((element) {
                          return DropdownMenuItem(
                            child: Text(element.name), value: element,);
                        },).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedDistrictIds.value = value.id;
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.map_outlined,
                            color: Colors.green.shade600,
                          ),
                        ),
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.green.shade600),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Aadhar Number Field with Verify Button
                  _buildLabel('Aadhar Number', Icons.credit_card_outlined),
                  const SizedBox(height: 8),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please Enter Aadhar Number';
                      }
                      return null;
                    },
                    controller: controller.adharNumberController,
                    focusNode: aadharFocusNode,
                    keyboardType: TextInputType.number,
                    maxLength: 14,
                    // 12 digits + 2 spaces
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'XXXX XXXX XXXX',
                      prefixIcon: Icon(
                        Icons.credit_card_outlined,
                        color: isAadharVerified.value
                            ? Colors.green.shade600
                            : Colors.grey.shade600,
                      ),
                      suffixIcon: isAadharValid.value &&
                          !isAadharVerified.value
                          ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: isLoading.value ? null : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(70, 36),
                          ),
                          child: isLoading.value
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text('Verify'),
                        ),
                      )
                          : isAadharVerified.value
                          ? Icon(
                        Icons.verified,
                        color: Colors.green.shade600,
                      )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.green.shade600,
                            width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Colors.red, width: 1),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      counterText: '',
                    ),
                    style: const TextStyle(fontSize: 16),
                    onChanged: (value) {

                    },
                  ),
                  if (aadharErrorMessage.value.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 12),
                      child: Text(
                        aadharErrorMessage.value,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade600,
                        ),
                      ),
                    ),
                  if (isAadharVerified.value)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Aadhar verified successfully',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),

                  _buildLabel('Industry Type', Icons.work_outline),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      CommonItemModel? selected = controller.industryTypeList
                          .firstWhereOrNull((element) {
                        return element.id ==
                            controller.selectedIndustryType.value;
                      },);
                      return DropdownButtonFormField<CommonItemModel>(
                        value: selected,
                        isExpanded: true,
                        hint: const Text('Select Industry Type'),
                        items: controller.industryTypeList.map((element) {
                          return DropdownMenuItem(
                            child: Text(element.name), value: element,);
                        },).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedIndustryType.value = value.id;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(value == null || value.id.isEmpty){
                            return 'Please Select Industry Type';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.work_outline,
                            color: Colors.green.shade600,
                          ),
                        ),
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.green.shade600),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),


                  // Profession Type Dropdown (NEW FIELD)
                  _buildLabel('Profession Type', Icons.work_outline),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      CommonItemModel? selected = controller
                          .professionTypeList.firstWhereOrNull((element) {
                        return element.id ==
                            controller.selectedProfessionType.value;
                      },);
                      return DropdownButtonFormField<CommonItemModel>(
                        initialValue: selected,
                        isExpanded: true,
                        hint: const Text('Select Profession Type'),
                        items: controller.professionTypeList.map((type) {
                          return DropdownMenuItem<CommonItemModel>(
                            value: type,
                            child: Text(type.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedProfessionType.value = value.id;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(value == null || value.id.isEmpty){
                            return 'Please Select Profession Type';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.work_outline,
                            color: Colors.green.shade600,
                          ),
                        ),
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.green.shade600),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Shop/Office Radio (NEW FIELD)
                  const Text(
                    'Shop / Office',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: Colors.green,
                            value: 'Shop',
                            groupValue: controller.shopType.value,
                            onChanged: (value) {
                              if (value != null) {
                                controller.shopType.value = value;
                              }
                            },
                          ),
                          const Text(
                            'Shop',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: Colors.green,
                            value: 'Office',
                            groupValue: controller.shopType.value,
                            onChanged: (value) {
                              if (value != null) {
                                controller.shopType.value = value;
                              }
                            },
                          ),
                          const Text(
                            'Office',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // GST Radio (NEW FIELD)
                  Row(
                    children: [
                      const Text(
                        'GST :',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: Colors.green,
                            value: 'Yes',
                            groupValue: controller.hasGst.value,
                            onChanged: (value) {
                              if (value != null) {
                                controller.hasGst.value = value;
                              }
                            },
                          ),
                          const Text(
                            'Yes',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: Colors.green,
                            value: 'No',
                            groupValue: controller.hasGst.value,
                            onChanged: (value) {
                              if (value != null) {
                                controller.hasGst.value = value;
                                controller.selectedBusinessType.value = '';
                              }
                            },
                          ),
                          const Text(
                            'No',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if(controller.hasGst.value == 'Yes')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Business Type', Icons.business_center_outlined),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Obx(() {
                            CommonItemModel? selected = controller
                                .businessTypeList.firstWhereOrNull((element) {
                              return element.id ==
                                  controller.selectedBusinessType.value;
                            },);
                            return DropdownButtonFormField<CommonItemModel>(
                              isExpanded: true,
                              initialValue: selected,
                              hint: const Text('Select Business Type'),
                              items: controller.businessTypeList.map((
                                  element) {
                                return DropdownMenuItem<CommonItemModel>(
                                    value: element,
                                    child: Text(element.name));
                              },).toList(),
                              onChanged: (value) {
                                if(value != null){
                                  controller.selectedBusinessType.value = value.id;
                                  controller.selectedPartnerType.value = '';
                                  controller.getPartnerType();
                                }

                              },

                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if(value == null || value.id.isEmpty){
                                  return 'Please Select Business Type';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.business_outlined,
                                  color: Colors.green.shade600,
                                ),
                              ),
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.green.shade600),
                            );
                          }),
                        ),
                        const SizedBox(height: 10,),
                        _buildLabel('GST Number', Icons.credit_card_outlined),
                        const SizedBox(height: 8),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Please Enter GST Number';
                            }
                            return null;
                          },
                          controller: controller.gstNumberController,
                          // 12 digits + 2 spaces
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter GST Number',
                            prefixIcon: Icon(
                              Icons.credit_card_outlined,
                              color: isAadharVerified.value
                                  ? Colors.green.shade600
                                  : Colors.grey.shade600,
                            ),
                            suffixIcon:  Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ElevatedButton(
                                onPressed: isLoading.value ? null : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(70, 36),
                                ),
                                child: isLoading.value
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                    : const Text('Verify'),
                              ),
                            ),
                            //     : isAadharVerified.value
                            //     ? Icon(
                            //   Icons.verified,
                            //   color: Colors.green.shade600,
                            // )
                            //     : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.green.shade600,
                                  width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            counterText: '',
                          ),
                          style: const TextStyle(fontSize: 16),
                          onChanged: (value) {

                          },
                        ),

                      ],
                    ),


                  const SizedBox(height: 20),
                  // Partner Type Dropdown
                  _buildLabel('Partner Type', Icons.business_center_outlined),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(() {
                     CommonItemModel? selected =  controller.partnerTypeList.firstWhereOrNull((element) {
                        return element.id == controller.selectedPartnerType.value;
                      },);
                      return DropdownButtonFormField<CommonItemModel>(
                        initialValue: selected,
                        isExpanded: true,
                        hint: const Text('Select Partner Type'),
                        items: controller.partnerTypeList.map(( type) {
                          return DropdownMenuItem<CommonItemModel>(
                            value: type,
                            child: Text(type.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedPartnerType.value = value.id;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(value == null || value.id.isEmpty){
                            return 'Please Select Partner Type';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.business_center_outlined,
                            color: Colors.green.shade600,
                          ),
                        ),
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.green.shade600),
                      );
                    }),
                  ),

                  const SizedBox(height: 40),

                  // Create User Button
                  // save & next button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        bool validate = controller.fKey.currentState?.validate() ?? false;
                        if(validate){
                          controller.addPartnerUser();


                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         PartnerAgreementScreen(
                        //           userData: {
                        //             'name': controller.nameController.text
                        //                 .trim(),
                        //             'email': controller.emailController.text
                        //                 .trim(),
                        //             'mobile': controller
                        //                 .mobileNumberController.text.trim(),
                        //             'aadhar': controller.adharNumberController
                        //                 .text.trim(),
                        //             'state': selectedState.value,
                        //             'district': selectedDistrict.value,
                        //             'professionType': selectedProfessionType
                        //                 .value,
                        //             'shopType': controller.shopType.value,
                        //             'hasGst': controller.hasGst.value,
                        //             'partnerType': selectedPartnerType.value,
                        //           },
                        //         ),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Save & Next',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildLabel(String label, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.green.shade700,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '*',
          style: TextStyle(
            color: Colors.red.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon, color: Colors.green.shade600),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.green.shade600, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    );
  }
}