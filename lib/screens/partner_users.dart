// lib/screens/partner_users_screen.dart

import 'package:admin_app_new/controller/partnerUser_controller.dart';
import 'package:admin_app_new/models/comanItem_model.dart';
import 'package:admin_app_new/models/partner_model.dart';
import 'package:admin_app_new/screens/partner_quote_projects.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'add_partner_user.dart';

class PartnerUsersScreen extends StatelessWidget {
  PartnerUsersScreen({super.key});


  PartnerUserController controller = Get.put(PartnerUserController());

  // Static list of users
  final List<Map<String, dynamic>> usersList = [
    {
      'name': 'Rajesh Patel',
      'email': 'rajesh.patel@example.com',
      'mobile': '+91 98765 43210',
      'type': 'Channel Partner',
      'district': 'Rajkot',
      'projectType': 'Residential',
      'category': 'Solar Rooftop',
      'subCategory': 'Residential 3 to 10 KW',
      'subProjectType': 'On Grid',
      'quotes': '24',
      'projects': '18',
      'revenue': '₹45,20,000',
    },
    {
      'name': 'Sunil Mehta',
      'email': 'sunil.mehta@example.com',
      'mobile': '+91 98765 43211',
      'type': 'Channel Partner',
      'district': 'Rajkot',
      'projectType': 'Commercial',
      'category': 'Solar Rooftop',
      'subCategory': 'Residential 3 to 10 KW',
      'subProjectType': 'Off Grid',
      'quotes': '32',
      'projects': '25',
      'revenue': '₹78,50,000',
    },
    {
      'name': 'Priya Shah',
      'email': 'priya.shah@example.com',
      'mobile': '+91 98765 43212',
      'type': 'Freelancer',
      'district': 'Surat',
      'projectType': 'Residential',
      'category': 'Solar Pump',
      'subCategory': 'Residential >3 KW',
      'subProjectType': 'Hybrid',
      'quotes': '15',
      'projects': '12',
      'revenue': '₹28,30,000',
    },
    // Add more users with filter fields...
  ];

  // Filter options
  final List<String> userTypes = ['All', 'Channel Partner', 'Freelancer'];


  // Selected filters
  final RxString selectedType = 'All'.obs;
  final RxList<String> selectedDistricts = <String>[].obs;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxList<String> selectedProjectTypes = <String>[].obs;
  final RxList<String> selectedSubCategories = <String>[].obs;
  final RxList<String> selectedSubProjectTypes = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Partner Users',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AddPartnerUserScreen());
        },
        backgroundColor: Colors.green.shade600,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add User',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          // Filter Chips Section - User Types
          Obx(() {
            return Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: controller.partnerTypeList.map((partner) {
                    final isSelected = controller.selectedPartnerTypeId.value == partner.id;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(
                          partner.name,
                          style: TextStyle(
                            color: isSelected ? Colors.green[800] : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,

                        // --- Green Theme ---
                        selectedColor: Colors.green.withOpacity(0.15),
                        checkmarkColor: Colors.green[700],
                        backgroundColor: Colors.grey[100],

                        // --- Square with minor rounded corners ---
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Adjust the '8.0' to make it more or less rounded
                          side: BorderSide(
                            color: isSelected ? Colors.green : Colors.grey[300]!,
                            width: 1,
                          ),
                        ),

                        onSelected: (bool selected) {
                          if (selected) {
                            controller.selectedPartnerTypeId.value = partner.id;
                          } else {
                            controller.selectedPartnerTypeId.value = '';
                          }
                          controller.getPartners();
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }),
          // Obx(() {
          //   return SizedBox(
          //     height: 50,
          //     child:
          //     ListView.builder(
          //       padding: const EdgeInsets.symmetric(horizontal: 16),
          //       scrollDirection: Axis.horizontal,
          //       itemCount: controller.partnerTypeList.length,
          //       itemBuilder: (context, index) {
          //         final type = controller.partnerTypeList[index];
          //         bool isSelected = controller.selectedPartnerTypeId.value ==
          //             type.id;
          //
          //         return Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 4),
          //           child: FilterChip(
          //             key: ValueKey('${type.id}_$isSelected'),
          //             label: Text(type.name),
          //             selected: isSelected,
          //             onSelected: (selected) {
          //               print('type.id ${type.id}');
          //               print(
          //                   'controller.selectedPartnerTypeId.value ${controller
          //                       .selectedPartnerTypeId.value}');
          //               controller.selectedPartnerTypeId.value = type.id;
          //
          //               print('type.id ${type.id}');
          //               print(
          //                   'controller.selectedPartnerTypeId.value ${controller
          //                       .selectedPartnerTypeId.value}');
          //               controller.getPartners();
          //             },
          //             backgroundColor: Colors.grey.shade100,
          //             selectedColor: Colors.green.shade100,
          //             checkmarkColor: Colors.green.shade700,
          //             labelStyle: TextStyle(
          //               color: isSelected ? Colors.green.shade700 : Colors.grey
          //                   .shade700,
          //               fontWeight: isSelected ? FontWeight.bold : FontWeight
          //                   .normal,
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //
          //   );
          // }),


          const SizedBox(height: 12),

          // Users List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Partners',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Obx(() {
                    return Text(
                      '${controller.partnerList.length} Users',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),



          const SizedBox(height: 12),


          Obx(() {
            if(controller.isLoading.value){
              return Expanded(child: Center(child: CircularProgressIndicator(color: Colors.green,),));
            }
            return Expanded(
              child: controller.partnerList.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Partner Users Found',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the + button to add a new partner',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.partnerList.length,
                itemBuilder: (context, index) {
                  final user = controller.partnerList[index];
                  return _buildUserCard(user);
                },
              ),
            );
          }),
        ],
      ),

    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    // Temporary selections
    List<String> tempDistricts = List.from(selectedDistricts);
    List<String> tempCategories = List.from(selectedCategories);
    List<String> tempProjectTypes = List.from(selectedProjectTypes);
    List<String> tempSubCategories = List.from(selectedSubCategories);
    List<String> tempSubProjectTypes = List.from(selectedSubProjectTypes);

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
          builder: (context, setState) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.85,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Users',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // District Multi-Select
                          MultiSelectDialogField<CommonItemModel>(
                            items: controller.districtList.map((district) {
                              return MultiSelectItem(district, district.name);
                            }).toList(),
                            title: const Text('Select Districts'),
                            // selectedItems: tempDistricts,
                            onConfirm: (values) {

                            },
                            buttonText: const Text('Select Districts'),
                            buttonIcon: const Icon(Icons.location_on),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Category Multi-Select
                          MultiSelectDialogField<CommonItemModel>(
                            items: controller.categoryList.map((category) {
                              return MultiSelectItem(category, category.name);
                            }).toList(),
                            title: const Text('Select Categories'),
                            // selectedItems: tempCategories,
                            onConfirm: (values) {

                            },
                            buttonText: const Text('Select Categories'),
                            buttonIcon: const Icon(Icons.category),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Sub Category Multi-Select
                          MultiSelectDialogField<CommonItemModel>(
                            items: controller.subCategoryList.map((
                                subCategory) {
                              return MultiSelectItem(
                                  subCategory, subCategory.name);
                            }).toList(),
                            title: const Text('Select Sub Categories'),
                            // selectedItems: tempSubCategories,
                            onConfirm: (values) {

                            },
                            buttonText: const Text('Select Sub Categories'),
                            buttonIcon: const Icon(
                                Icons.subdirectory_arrow_right),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Project Type Multi-Select
                          MultiSelectDialogField(
                            items: controller.projectTypeList.map((type) {
                              return MultiSelectItem(type, type.name);
                            }).toList(),
                            title: const Text('Select Project Types'),
                            // selectedItems: tempProjectTypes,
                            onConfirm: (values) {

                            },
                            buttonText: const Text('Select Project Types'),
                            buttonIcon: const Icon(Icons.business_center),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Sub Project Type Multi-Select
                          MultiSelectDialogField(
                            items: controller.subProjectTypeList.map((subType) {
                              return MultiSelectItem(subType, subType.name);
                            }).toList(),
                            title: const Text('Select Sub Project Types'),
                            // selectedItems: tempSubProjectTypes,
                            onConfirm: (values) {

                            },
                            buttonText: const Text('Select Sub Project Types'),
                            buttonIcon: const Icon(Icons.electrical_services),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              tempDistricts.clear();
                              tempCategories.clear();
                              tempProjectTypes.clear();
                              tempSubCategories.clear();
                              tempSubProjectTypes.clear();
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red.shade400),
                            foregroundColor: Colors.red.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Clear All'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            selectedDistricts.value = tempDistricts;
                            selectedCategories.value = tempCategories;
                            selectedProjectTypes.value = tempProjectTypes;
                            selectedSubCategories.value = tempSubCategories;
                            selectedSubProjectTypes.value = tempSubProjectTypes;
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Show Results',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMultiSelectSection({
    required String title,
    required List<String> items,
    required List<String> selectedItems,
    required Function(List<String>) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return FilterChip(
              label: Text(item),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onChanged([...selectedItems, item]);
                } else {
                  onChanged(selectedItems.where((i) => i != item).toList());
                }
              },
              backgroundColor: Colors.grey.shade100,
              selectedColor: Colors.green.shade100,
              checkmarkColor: Colors.green.shade700,
              labelStyle: TextStyle(
                color: isSelected ? Colors.green.shade700 : Colors.grey
                    .shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Widget _buildMultiSelectSection({
  //   required String title,
  //   required List<String> items,
  //   required List<String> selectedItems,
  //   required Function(List<String>) onChanged,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: const TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       Wrap(
  //         spacing: 8,
  //         runSpacing: 8,
  //         children: items.map((item) {
  //           final isSelected = selectedItems.contains(item);
  //           return FilterChip(
  //             label: Text(item),
  //             selected: isSelected,
  //             onSelected: (selected) {
  //               if (selected) {
  //                 onChanged([...selectedItems, item]);
  //               } else {
  //                 onChanged(selectedItems.where((i) => i != item).toList());
  //               }
  //             },
  //             backgroundColor: Colors.grey.shade100,
  //             selectedColor: Colors.green.shade100,
  //             checkmarkColor: Colors.green.shade700,
  //             labelStyle: TextStyle(
  //               color: isSelected ? Colors.green.shade700 : Colors.grey.shade700,
  //               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildUserCard(PartnerUserModel user) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => PartnerUserDetailsScreen(user: user));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Top Row with Avatar and User Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar with Gradient
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade400,
                        Colors.green.shade700,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user.fullName.toString()[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // User Info - Expanded to take available space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Email Row
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              user.email,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Mobile Row
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              user.mobileNumber,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Type Row
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              user.gstPartnerTypeName,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade200, height: 1),
            const SizedBox(height: 12),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _buildUserStat(
                    'Quotes',
                    user.totalQuotes.toString(),
                    Icons.description_outlined,
                  ),
                ),
                Expanded(
                  child: _buildUserStat(
                    'Projects',
                    user.totalProjects.toString(),
                    Icons.build_outlined,
                  ),
                ),
                Expanded(
                  child: _buildUserStat(
                    'Revenue',
                    user.totalRevenue.toString(),
                    Icons.currency_rupee,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStat(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.green.shade600,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}