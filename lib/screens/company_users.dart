// lib/screens/company_users_screen.dart

import 'package:admin_app_new/controller/comapny_user/add_companyUser_controller.dart';
import 'package:admin_app_new/models/comanItem_model.dart';
import 'package:admin_app_new/models/comapanyUser_model.dart';
import 'package:admin_app_new/screens/usercreted_by_companyuser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class CompanyUsersScreen extends StatefulWidget {
  const CompanyUsersScreen({super.key});

  @override
  State<CompanyUsersScreen> createState() => _CompanyUsersScreenState();
}

class _CompanyUsersScreenState extends State<CompanyUsersScreen> {
  AddCompanyuserController controller = Get.put(AddCompanyuserController());
  String? currentSelectedProjectType;
  String? currentProjectQuotationGoal;
  String? currentProjectDeadline;
  List<Map<String, dynamic>> selectedProjectTypes = [];

  final List<Map<String, dynamic>> projectTypes = [
    {'value': 'residential', 'label': 'Residential'},
    {'value': 'commercial', 'label': 'Commercial'},
    {'value': 'industrial', 'label': 'Industrial'},
    {'value': 'agricultural', 'label': 'Agricultural'},
    {'value': 'institutional', 'label': 'Institutional'},
    {'value': 'government', 'label': 'Government'},
  ];

  String? currentDeadlineDate;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Company Users'),
          bottom: const TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Company Users', icon: Icon(Icons.people)),
              Tab(text: 'Add New User', icon: Icon(Icons.person_add)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
          ],
        ),
        body: TabBarView(children: [_buildSubAdminList(), _buildAddNewUser()]),
      ),
    );
  }

  // Show Filter Bottom Sheet
  void _showFilterBottomSheet(BuildContext context) {
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
                  .height * 0.7,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Data',
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
                          // Project Type Multi-Select


                          const Text(
                            'Select State',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
                              initialValue: controller.stateList.where((p0) {
                                return controller.selectedStateIds.contains(
                                    p0.id);
                              },).toList(),
                              items: controller.stateList
                                  .map((cat) {
                                return MultiSelectItem<CommonItemModel>(
                                    cat, cat.name);
                              })
                                  .toList(),
                              title: const Text('Select State'),
                              buttonText: const Text('Select State'),
                              buttonIcon: const Icon(Icons.business_center),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onConfirm: (List<CommonItemModel> val) {
                                String selectedIds = val.map((e) => e.id,).join(
                                    ',');
                                print('selectedIds $selectedIds');
                                controller.selectedStateIds.value = selectedIds;
                                controller.getDistrict();
                              },
                            );
                          }),
                          const SizedBox(height: 20),


                          // select district
                          const Text(
                            'Select Districts',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
                              initialValue: controller.distrcitList.where((p) {
                                return controller.selectedDistrictIds.value
                                    .contains(p.id);
                              },).toList(),
                              items: controller.distrcitList.map((element) {
                                return MultiSelectItem(element, element.name);
                              },).toList(),
                              title: const Text('Select Districts'),
                              buttonText: const Text('Select Districts'),
                              buttonIcon: const Icon(Icons.business_center),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onConfirm: (List<CommonItemModel> val) {
                                String selectedIds = val.map((e) => e.id,).join(
                                    ',');
                                controller.selectedDistrictIds.value =
                                    selectedIds;
                              },
                            );
                          }),
                          const SizedBox(height: 20),


                          // select partner types
                          const Text(
                            'Select Partner Types',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
                              initialValue: controller.partnerList.where((p0) {
                                return controller.selectedPartnerIds.value
                                    .contains(p0.id);
                              },).toList(),
                              items: controller.partnerList.map((element) {
                                return MultiSelectItem(element, element.name);
                              },).toList(),
                              title: const Text('Select Partner Types'),
                              buttonText: const Text('Select Partner Types'),
                              buttonIcon: const Icon(Icons.person),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onConfirm: (List<CommonItemModel> val) {
                                String selectedIds = val.map((e) => e.id,).join(
                                    ',');
                                controller.selectedPartnerIds.value =
                                    selectedIds;
                              },
                            );
                          }),
                          const SizedBox(height: 20),


                          // Category Multi-Select
                          const Text(
                            'Select Category',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
                              initialValue: controller.categoryList.where((e) {
                                return controller.selectedCategoryIds.contains(
                                    e.id);
                              },).toList(),
                              items: controller.categoryList
                                  .map((cat) {
                                return MultiSelectItem<CommonItemModel>(
                                    cat, cat.name);
                              })
                                  .toList(),
                              title: const Text('Select Category'),
                              buttonText: const Text('Select Category'),
                              buttonIcon: const Icon(Icons.category),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onConfirm: (List<CommonItemModel> e) {
                                String selectedIds = e.map((e) => e.id,).join(
                                    ',');
                                print('selectedIds $selectedIds');
                                controller.selectedCategoryIds.value =
                                    selectedIds;
                                controller.getSubCategory();
                              },
                            );
                          }),
                          const SizedBox(height: 20),

                          // Sub Category Multi-Select
                          const Text(
                            'Select Sub Category',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
                              initialValue: controller.subCategoryList.where((
                                  p0) {
                                return controller.selectedSubCategoryIds.value
                                    .contains(p0.id);
                              },).toList(),
                              items: controller.subCategoryList
                                  .map((cat) {
                                return MultiSelectItem<CommonItemModel>(
                                    cat, cat.name);
                              })
                                  .toList(),
                              title: const Text('Select Sub Category'),
                              buttonText: const Text('Select Sub Category'),
                              buttonIcon: const Icon(
                                  Icons.subdirectory_arrow_right),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onConfirm: (List<CommonItemModel> e) {
                                String selectedIds = e.map((e) => e.id,).join(
                                    ',');
                                print('selectedIds $selectedIds');
                                controller.selectedSubCategoryIds.value =
                                    selectedIds;
                                controller.getProjectTypes();
                              },
                            );
                          }),
                          const SizedBox(height: 20),

                          // project type multi-select
                          const Text(
                            'Select Project Type',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
                              initialValue: controller.projectTypeList_forFilter
                                  .where((p0) {
                                return controller.selectedProjectTypesIds.value
                                    .contains(p0.id);
                              },).toList(),
                              items: controller.projectTypeList_forFilter
                                  .map((cat) {
                                return MultiSelectItem<CommonItemModel>(
                                    cat, cat.name);
                              })
                                  .toList(),
                              title: const Text('Select Project Type'),
                              buttonText: const Text('Select Project Type'),
                              buttonIcon: const Icon(Icons.business_center),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onConfirm: (List<CommonItemModel> e) {
                                String selectedIds = e.map((e) => e.id,).join(
                                    ',');
                                print('selectedIds $selectedIds');
                                controller.selectedProjectTypesIds.value = selectedIds;

                                controller.getSubProjectTypes();
                              },
                            );
                          }),
                          const SizedBox(height: 20),


                          // sub project type multi-select
                          const Text(
                            'Select Sub Project Type',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
                              initialValue: controller.subProjectTypeList
                                  .where((p0) {
                                return controller.selectedSubProjectTypeIds
                                    .value.contains(p0.id);
                              },).toList(),
                              items: controller.subProjectTypeList
                                  .map((cat) {
                                return MultiSelectItem<CommonItemModel>(
                                    cat, cat.name);
                              })
                                  .toList(),
                              title: const Text('Select Sub Project Type'),
                              buttonText: const Text('Select Sub Project Type'),
                              buttonIcon: const Icon(Icons.electrical_services),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onConfirm: (List<CommonItemModel> e) {
                                String selectedIds = e.map((e) => e.id,).join(
                                    ',');
                                print('selectedIds $selectedIds');
                                controller.selectedSubProjectTypeIds.value =
                                    selectedIds;
                              },
                            );
                          }),
                          const SizedBox(height: 20),


                          // const Text(
                          //   'Select Project Type',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // const SizedBox(height: 8),
                          // MultiSelectDialogField(
                          //   items: [
                          //     MultiSelectItem('Residential', 'Residential'),
                          //     MultiSelectItem('Commercial', 'Commercial'),
                          //     MultiSelectItem('Industrial', 'Industrial'),
                          //   ],
                          //   title: const Text('Select Project Type'),
                          //   buttonText: const Text('Select Project Type'),
                          //   buttonIcon: const Icon(Icons.business_center),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.grey.shade300),
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   onConfirm: (List<String> p1) {},
                          // ),
                          // const SizedBox(height: 20),
                          //
                          // // Sub Project Type Multi-Select
                          // const Text(
                          //   'Select Sub Project Type',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // const SizedBox(height: 8),
                          // MultiSelectDialogField(
                          //   items: [
                          //     MultiSelectItem('Off Grid', 'Off Grid'),
                          //     MultiSelectItem('On Grid', 'On Grid'),
                          //     MultiSelectItem('Hybrid', 'Hybrid'),
                          //   ],
                          //   title: const Text('Select Sub Project Type'),
                          //   buttonText: const Text('Select Sub Project Type'),
                          //   buttonIcon: const Icon(Icons.electrical_services),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.grey.shade300),
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   onConfirm: (List<String> p1) {},
                          // ),
                          // const SizedBox(height: 20),
                          //
                          // // Category Multi-Select
                          // const Text(
                          //   'Select Category',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // const SizedBox(height: 8),
                          // MultiSelectDialogField(
                          //   items: [
                          //     MultiSelectItem('Solar Rooftop', 'Solar Rooftop'),
                          //     MultiSelectItem('Solar Pump', 'Solar Pump'),
                          //     MultiSelectItem('Solar Light', 'Solar Light'),
                          //   ],
                          //   title: const Text('Select Category'),
                          //   buttonText: const Text('Select Category'),
                          //   buttonIcon: const Icon(Icons.category),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.grey.shade300),
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   onConfirm: (List<String> p1) {},
                          // ),
                          // const SizedBox(height: 20),
                          //
                          // // Sub Category Multi-Select
                          // const Text(
                          //   'Select Sub Category',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // const SizedBox(height: 8),
                          // MultiSelectDialogField(
                          //   items: [
                          //     MultiSelectItem(
                          //       'Residential 3 to 10 KW',
                          //       'Residential 3 to 10 KW',
                          //     ),
                          //     MultiSelectItem(
                          //       'Residential >3 KW',
                          //       'Residential >3 KW',
                          //     ),
                          //     MultiSelectItem('Common Meter', 'Common Meter'),
                          //   ],
                          //   title: const Text('Select Sub Category'),
                          //   buttonText: const Text('Select Sub Category'),
                          //   buttonIcon: const Icon(
                          //     Icons.subdirectory_arrow_right,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.grey.shade300),
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   onConfirm: (List<String> p1) {},
                          // ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.selectedDistrictIds.value = '';
                            controller.selectedStateIds.value = '';
                            controller.selectedPartnerIds.value = '';
                            controller.selectedCategoryIds.value = '';
                            controller.selectedSubCategoryIds.value = '';
                            controller.selectedProjectTypesIds.value = '';
                            controller.selectedSubProjectTypeIds.value = '';
                            controller.getCompanyUsers();
                            Navigator.pop(context);
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
                            controller.getCompanyUsers();
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
                            'Apply Filters',
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

  Widget _buildDatePickerField(BuildContext context,
      String label,
      DateTime? selectedDate,
      Function(DateTime) onDateSelected,) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 2),
                Text(
                  selectedDate != null
                      ? '${selectedDate.day}/${selectedDate
                      .month}/${selectedDate.year}'
                      : 'Select Date',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: selectedDate != null
                        ? Colors.black87
                        : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            Icon(Icons.calendar_today, size: 16, color: Colors.green.shade600),
          ],
        ),
      ),
    );
  }

  // Sub Admin Users List
  Widget _buildSubAdminList() {
    return Column(
      children: [
        // Users List
        Obx(() {
          if (controller.companyUsers.isEmpty) {
            return const Expanded(
              child: Center(
                child: Text('No Users Found'),
              ),
            );
          }
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.companyUsers.length,
              itemBuilder: (context, index) {
                final user = controller.companyUsers[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to Created Users Screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CreatedUsersScreen(
                    //       salesUserName: user['name'],
                    //       createdUsers: user['createdUsers'],
                    //     ),
                    //   ),
                    // );
                  },
                  child: _buildUserCard(context, user, index),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildUserCard(BuildContext context,
      CompanyUser user,
      int index,) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.green.shade200,

          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main User Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.green.shade400, Colors.green.shade600]

                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user.fullName[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // User Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.fullName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.emailAddress,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.mobileNumber,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // User Stats Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // District Info
                // Row(
                //   children: [
                //     Icon(
                //       Icons.location_on,
                //       size: 14,
                //       color: Colors.grey.shade600,
                //     ),
                //     const SizedBox(width: 4),
                //     Text(
                //       user.district,
                //       style: TextStyle(
                //         fontSize: 11,
                //         color: Colors.grey.shade700,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),

                // Target Info
                Row(
                  children: [
                    Text(
                      'Target ${user.partnerMonthlyTargetKw} KW',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Users Created Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(
                top: BorderSide(color: Colors.green.shade100, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people_alt,
                      size: 16,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Partners Created',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.green.shade100, blurRadius: 4),
                    ],
                  ),
                  child: Text(
                    '${user.partnersCreatedCount} Patners',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                // View All Button
                TextButton(
                  onPressed: () {
                    // Navigate to Created Users Screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CreatedUsersScreen(
                    //       salesUserName: user['name'],
                    //       createdUsers: user['createdUsers'],
                    //     ),
                    //   ),
                    // );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                    minimumSize: const Size(0, 30),
                  ),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
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

  // Add New User Form
  Widget _buildAddNewUser() {
    // Partner Goals Controllers
    final TextEditingController monthlyTargetKWController =
    TextEditingController();
    final TextEditingController perKWCommissionController =
    TextEditingController();

    // Project Goal Controllers
    final TextEditingController quotationGoalController =
    TextEditingController();
    final TextEditingController projectMonthlyTargetController =
    TextEditingController();
    final TextEditingController projectPerKWCommissionController =
    TextEditingController();

    String? selectedUserTarget;
    String? selectedDeadlineDate;
    String? selectedStatus = 'active';

    // Multi-select user types with targets
    List<Map<String, dynamic>> selectedUserTypes = [];
    CommonItemModel? currentSelectedUserType;
    String? currentUserTarget;
    String? currentDeadlineDate;

    // Project types
    List<Map<String, dynamic>> selectedProjectTypes = [];
    CommonItemModel? currentSelectedProjectType;
    String? currentProjectQuotationGoal;
    String? currentProjectDeadline;

    bool isProjectGoalEnabled = false;
    bool isPartnerGoalEnabled = true; // New toggle for Partner Goals

    // Quote Permissions
    bool canCreateQuote = true;
    bool canEditQuote = false;
    bool canDeleteQuote = false;


    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade600, Colors.green.shade800],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add New Company User',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Create a new Company user with specific permissions',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green.shade100,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Personal Information Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Name Field
                    _buildFormField(
                      label: 'Full Name *',
                      controller: controller.nameController,
                      hint: 'Enter full name',
                      icon: Icons.person,
                    ),

                    const SizedBox(height: 12),

                    // Mobile Number Field
                    _buildFormField(
                      label: 'Mobile Number *',
                      controller: controller.mobileController,
                      hint: 'Enter mobile number',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 12),

                    // Email Field
                    _buildFormField(
                      label: 'Email Address *',
                      controller: controller.emailController,
                      hint: 'Enter email address',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 12),

                    // country
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select Country',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(() {
                                final String rawIds = controller.selectedcountryIds_form.value;
                                final List<String> selectedIds = rawIds.isEmpty ? [] : rawIds.split(',');
                                return MultiSelectDialogField<CommonItemModel>(
                                  chipDisplay: MultiSelectChipDisplay.none(),
                                  initialValue: controller.countryList_form.where((p) {
                                    return controller.selectedcountryIds_form.value
                                        .contains(p.id);
                                  },).toList(),
                                  items: controller.countryList_form.map((element) {
                                    return MultiSelectItem(element, element.name);
                                  },).toList(),
                                  title: const Text('Select Country'),
                                  buttonText:  Text(selectedIds.isEmpty ?'Select Country' : 'Selected (${selectedIds.length})'),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  onConfirm: (List<CommonItemModel> val) {
                                    String selectedIds = val.map((e) => e.id,).join(
                                        ',');
                                    controller.selectedcountryIds_form.value = selectedIds;
                                    controller.getState_forAddUser();
                                  },
                                );
                              }),
                            ],
                          ),
                        ),

                        SizedBox(width: 5,),
                        // state
                        Expanded(
                          child: Column(
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            children: [

                              const Text(
                                'Select State',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(() {
                                final String rawIds = controller.selectedStateIds_form.value;
                                final List<String> selectedIds = rawIds.isEmpty ? [] : rawIds.split(',');
                                // Now selectedIds.length is 0 when nothing is chosen.
                                return MultiSelectDialogField<CommonItemModel>(
                                  buttonIcon: null,
                                  chipDisplay: MultiSelectChipDisplay.none(),
                                  searchable: true,
                                  initialValue: controller.stateList_form
                                      .where((p) => selectedIds.contains(p.id))
                                      .toList(),
                                  items: controller.stateList_form
                                      .map((element) => MultiSelectItem(element, element.name))
                                      .toList(),
                                  title: const Text('Select State'),
                                  buttonText: Text(
                                    selectedIds.isEmpty ? 'Select State' : 'Selected (${selectedIds.length})',
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  onConfirm: (List<CommonItemModel> val) {
                                    controller.selectedStateIds_form.value = val.map((e) => e.id).join(',');
                                    controller.getCluster_forAddUser();
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),
                    // cluster
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select Cluster',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(() {
                                final String rawIds = controller.selectedClusterIds_form.value;
                                final List<String> selectedIds = rawIds.isEmpty ? [] : rawIds.split(',');
                                return MultiSelectDialogField<CommonItemModel>(
                                  chipDisplay: MultiSelectChipDisplay.none(),
                                  initialValue: controller.clusterList_form.where((p) {
                                    return controller.selectedClusterIds_form.value
                                        .contains(p.id);
                                  },).toList(),
                                  items: controller.clusterList_form.map((element) {
                                    return MultiSelectItem(element, element.name);
                                  },).toList(),
                                  title: const Text('Select Cluster'),
                                  buttonText:  Text(selectedIds.isEmpty ? 'Select Cluster' : 'Selected (${selectedIds.length})'),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  onConfirm: (List<CommonItemModel> val) {
                                    String selectedIds = val.map((e) => e.id,).join(',');
                                    controller.selectedClusterIds_form.value = selectedIds;
                                    controller.getDistrict_forAddUser();
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(width: 5,),
                        // district
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select District',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(() {
                                final String rawIds = controller.slectedDistrictIds_form.value;
                                final List<String> selectedIds = rawIds.isEmpty ? [] : rawIds.split(',');
                                return MultiSelectDialogField<CommonItemModel>(
                                  chipDisplay: MultiSelectChipDisplay.none(),
                                  initialValue: controller.districtList_form.where((p) {
                                    return controller.slectedDistrictIds_form.value
                                        .contains(p.id);
                                  },).toList(),
                                  items: controller.districtList_form.map((element) {
                                    return MultiSelectItem(element, element.name);
                                  },).toList(),
                                  title: const Text('Select District'),
                                  buttonText:  Text(selectedIds.isEmpty ?  'Select District' : 'Selected (${selectedIds.length})'),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  onConfirm: (List<CommonItemModel> val) {
                                    String selectedIds = val.map((e) => e.id,).join(
                                        ',');
                                    controller.slectedDistrictIds_form.value = selectedIds;
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Partner Goals Section with Toggle
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isPartnerGoalEnabled
                        ? Colors.green.shade200
                        : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: isPartnerGoalEnabled
                                  ? Colors.green.shade700
                                  : Colors.grey.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Partner Goals',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isPartnerGoalEnabled
                                    ? Colors.green
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: isPartnerGoalEnabled,
                          onChanged: (value) {
                            setState(() {
                              isPartnerGoalEnabled = value;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.grey.shade400,
                        ),
                      ],
                    ),

                    if (isPartnerGoalEnabled) ...[
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),

                      // Monthly Target KW and Per KW Commission in one row
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: 'Monthly Target KW *',
                              controller: monthlyTargetKWController,
                              hint: 'Enter KW',
                              icon: Icons.solar_power,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildFormField(
                              label: 'Per KW Commission *',
                              controller: perKWCommissionController,
                              hint: 'Enter amount',
                              icon: Icons.currency_rupee,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // User Type Can Create with Multi-Select and User Target
                      const Text(
                        'Partners Types Can Create *',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Add User Type Row
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // Row for Dropdown and User Target
                            Row(
                              children: [
                                // Partner Type Dropdown
                                Expanded(
                                  flex: 2,
                                  child: Obx(() {
                                    return DropdownButtonFormField(
                                      hint: const Text('Select Partner'),
                                      isExpanded: true,
                                      items: controller.partnerList.map((
                                          element,) {
                                        return DropdownMenuItem(
                                          value: element,
                                          child: Text(element.name),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          currentSelectedUserType = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(width: 12),
                                // User Target Field
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Partner Target',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.people,
                                        size: 16,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      currentUserTarget = value;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // Deadline Date Picker (Full Width)
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    currentDeadlineDate = DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(pickedDate);
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                      color: Colors.green.shade700,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      currentDeadlineDate ??
                                          'Select Deadline Date',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: currentDeadlineDate != null
                                            ? Colors.black87
                                            : Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Add Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed:
                                (currentSelectedUserType != null &&
                                    currentUserTarget != null &&
                                    currentUserTarget!.isNotEmpty &&
                                    currentDeadlineDate != null)
                                    ? () {
                                  setState(() {
                                    selectedUserTypes.add({
                                      'type_id':
                                      currentSelectedUserType!.id,
                                      // store ID for API
                                      'type_name':
                                      currentSelectedUserType!.name,
                                      // store name
                                      'target': currentUserTarget,
                                      'deadline': currentDeadlineDate,
                                    });
                                    // Reset fields
                                    currentSelectedUserType = null;
                                    currentUserTarget = null;
                                    currentDeadlineDate = null;
                                  });
                                }
                                    : null,
                                // onPressed: (currentSelectedUserType != null &&
                                //     currentUserTarget != null &&
                                //     currentUserTarget!.isNotEmpty &&
                                //     currentDeadlineDate != null)
                                //     ? () {
                                //   setState(() {
                                //     selectedUserTypes.add({
                                //       'type': currentSelectedUserType,
                                //       'type_label': availableUserTypes
                                //           .firstWhere((t) =>
                                //       t['value'] ==
                                //           currentSelectedUserType)['label'],
                                //       'target': currentUserTarget,
                                //       'deadline': currentDeadlineDate,
                                //     });
                                //     currentSelectedUserType = null;
                                //     currentUserTarget = null;
                                //     currentDeadlineDate = null;
                                //   });
                                // }
                                //     : null,
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Add Partner Type'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Selected User Types Chips
                            if (selectedUserTypes.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Added Partner Types:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: selectedUserTypes.map((item) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade50,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: Colors.green.shade200,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item['type_name'],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                    Colors.green.shade700,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  'Target: ${item['target']} Users | Deadline: ${item['deadline']}',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                    Colors.green.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 8),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedUserTypes.remove(
                                                    item,
                                                  );
                                                });
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.green.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Quote Permissions Section
                      Row(
                        children: [
                          Icon(
                            Icons.fact_check,
                            color: Colors.green.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Quote Permissions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            // Quote Create
                            const Text(
                              'Quote Create',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Checkbox(
                              activeColor: Colors.green,
                              value: canCreateQuote,
                              onChanged: (value) {
                                setState(() {
                                  canCreateQuote = value ?? false;
                                });
                              },
                            ),

                            // Quote Edit

                            // Quote Delete
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Text(
                              'Quote Edit',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Checkbox(
                              activeColor: Colors.green,
                              value: canEditQuote,
                              onChanged: (value) {
                                setState(() {
                                  canEditQuote = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Text(
                              'Quote Delete',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Checkbox(
                              activeColor: Colors.green,
                              value: canDeleteQuote,
                              onChanged: (value) {
                                setState(() {
                                  canDeleteQuote = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Project Goal Section with Switch
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isProjectGoalEnabled
                        ? Colors.green.shade200
                        : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.business_center,
                              color: isProjectGoalEnabled
                                  ? Colors.green.shade700
                                  : Colors.grey.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Project Goal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isProjectGoalEnabled
                                    ? Colors.green
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: isProjectGoalEnabled,
                          onChanged: (value) {
                            setState(() {
                              isProjectGoalEnabled = value;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.grey.shade400,
                        ),
                      ],
                    ),

                    if (isProjectGoalEnabled) ...[
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: 'Monthly Target KW *',
                              controller: projectMonthlyTargetController,
                              hint: 'Enter KW',
                              icon: Icons.solar_power,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildFormField(
                              label: 'Per KW Commission *',
                              controller: projectPerKWCommissionController,
                              hint: 'Enter amount',
                              icon: Icons.currency_rupee,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Select Project Type Section
                      const Text(
                        'Select Project Type *',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Add Project Type Row
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // Row for Dropdown and Quotation Goal
                            Row(
                              children: [
                                // Project Type Dropdown
                                Expanded(
                                  flex: 2,
                                  child: Obx(() {
                                    return DropdownButtonFormField<
                                        CommonItemModel
                                    >(
                                      hint: const Text('Select Project Type'),
                                      isExpanded: true,
                                      items: controller.projectTypeList.map((
                                          element,) {
                                        return DropdownMenuItem(
                                          value: element,
                                          child: Text(element.name),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          currentSelectedProjectType = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(width: 12),
                                // Quotation Goal Field
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Quotation Goal',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.receipt,
                                        size: 16,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      currentProjectQuotationGoal = value;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // Deadline Date Picker for Project Type
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    currentProjectDeadline = DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(pickedDate);
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                      color: Colors.green.shade700,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      currentProjectDeadline ??
                                          'Select Deadline Date',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: currentProjectDeadline != null
                                            ? Colors.black87
                                            : Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Add Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed:
                                (currentSelectedProjectType != null &&
                                    currentProjectQuotationGoal != null &&
                                    currentProjectQuotationGoal!
                                        .isNotEmpty &&
                                    currentProjectDeadline != null)
                                    ? () {
                                  setState(() {
                                    selectedProjectTypes.add({
                                      'type_id': currentSelectedProjectType!.id,
                                      'type_name': currentSelectedProjectType!
                                          .name,
                                      'quotationGoal': currentProjectQuotationGoal,
                                      'deadline': currentProjectDeadline,
                                    });
                                    currentSelectedProjectType = null;
                                    currentProjectQuotationGoal = null;
                                    currentProjectDeadline = null;
                                  });

                                  print('selectedProjectTypes $selectedProjectTypes');
                                }
                                    : null,
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Add Project Type'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Selected Project Types Chips
                            if (selectedProjectTypes.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Added Project Types:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: selectedProjectTypes.map((item) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade50,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: Colors.green.shade200,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item['type_name'],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                    Colors.green.shade700,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  'Goal: ${item['quotationGoal']} Quotes | Deadline: ${item['deadline']}',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                    Colors.green.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 8),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedProjectTypes.remove(
                                                    item,
                                                  );
                                                });
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.green.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        'Note: These goals are in addition to partner goals',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Validation Message
              // if ((isPartnerGoalEnabled && (nameController.text.isEmpty ||
              //     mobileController.text.isEmpty ||
              //     emailController.text.isEmpty ||
              //     districtController.text.isEmpty ||
              //     monthlyTargetKWController.text.isEmpty ||
              //     perKWCommissionController.text.isEmpty ||
              //     selectedUserTypes.isEmpty)) ||
              //     (isProjectGoalEnabled &&
              //         (projectMonthlyTargetController.text.isEmpty ||
              //             projectPerKWCommissionController.text.isEmpty ||
              //             selectedProjectTypes.isEmpty)))
              //   Container(
              //     padding: const EdgeInsets.all(12),
              //     decoration: BoxDecoration(
              //       color: Colors.orange.shade50,
              //       borderRadius: BorderRadius.circular(12),
              //       border: Border.all(color: Colors.orange.shade200),
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(Icons.info_outline, color: Colors.orange.shade700,
              //             size: 20),
              //         const SizedBox(width: 8),
              //         Expanded(
              //           child: Text(
              //             isProjectGoalEnabled || isPartnerGoalEnabled
              //                 ? 'Please fill all required fields and add at least one type'
              //                 : 'Please fill all required fields',
              //             style: TextStyle(
              //               color: Colors.orange.shade700,
              //               fontSize: 13,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              const SizedBox(height: 16),

              // Create Button
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
                  // Inside StatefulBuilder, after all variables, find the ElevatedButton's onPressed
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                    // Validation (same as before)
                    if (controller.nameController.text
                        .trim()
                        .isEmpty ||
                        controller.mobileController.text
                            .trim()
                            .isEmpty ) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please fill all personal information',
                          ),
                        ),
                      );
                      return;
                    }

                    if (isPartnerGoalEnabled) {
                      if (monthlyTargetKWController.text
                          .trim()
                          .isEmpty ||
                          perKWCommissionController.text
                              .trim()
                              .isEmpty ||
                          selectedUserTypes.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill all Partner Goals fields and add at least one partner type',
                            ),
                          ),
                        );
                        return;
                      }
                    }

                    if (isProjectGoalEnabled) {
                      if (projectMonthlyTargetController.text
                          .trim()
                          .isEmpty ||
                          projectPerKWCommissionController.text
                              .trim()
                              .isEmpty ||
                          selectedProjectTypes.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill all Project Goal fields and add at least one project type',
                            ),
                          ),
                        );
                        return;
                      }
                    }

                    // Prepare data
                    List<Map<String, dynamic>> partnerTypesGoals =
                    selectedUserTypes.map((item) {
                      return {
                        "type": item['type_id'],
                        "count":
                        int.tryParse(item['target'] ?? '0') ?? 0,
                        "deadline": item['deadline'],
                      };
                    }).toList();

                    List<Map<String, dynamic>> projectTypesGoals =
                    selectedProjectTypes.map((item) {
                      return {
                        "type": item['type_id'],
                        "count":
                        int.tryParse(
                          item['quotationGoal'] ?? '0',
                        ) ??
                            0,
                        "deadline": item['deadline'],
                      };
                    }).toList();

                    // Call controller method
                    bool success = await controller.addCompanyUser(
                      name: controller.nameController.text.trim(),
                      number: controller.mobileController.text.trim(),
                      email: controller.emailController.text.trim(),
                      district: controller.districtController.text.trim(),
                      isPartnerGoalsEnabled: isPartnerGoalEnabled,
                      partnerMonthlyTargetKw: monthlyTargetKWController
                          .text
                          .trim(),
                      partnerPerKwCommission: perKWCommissionController
                          .text
                          .trim(),
                      partnerQuotePermissionsCreate: canCreateQuote,
                      partnerQuotePermissionsEdit: canEditQuote,
                      partnerQuotePermissionsDelete: canDeleteQuote,
                      partnerTypesGoals: partnerTypesGoals,
                      isProjectGoalEnabled: isProjectGoalEnabled,
                      projectMonthlyTargetKw:
                      projectMonthlyTargetController.text.trim(),
                      projectPerKwCommission:
                      projectPerKWCommissionController.text.trim(),
                      projectTypesGoals: projectTypesGoals,
                      selectedCountryIds: controller.selectedcountryIds_form.value,
                       selectedStateIds: controller.selectedStateIds_form.value,
                      selectedClusterIds: controller.selectedClusterIds_form.value,
                      selectedDistrictIds: controller.slectedDistrictIds_form.value,
                      context: context,
                    );

                    if (success) {
                      setState(() {
                        // Clear personal information controllers
                        controller.nameController.clear();
                        controller.mobileController.clear();
                        controller.emailController.clear();
                        controller.districtController.clear();

                        // Clear partner goals controllers
                        monthlyTargetKWController.clear();
                        perKWCommissionController.clear();

                        // Clear project goals controllers
                        projectMonthlyTargetController.clear();
                        projectPerKWCommissionController.clear();

                        // Reset lists
                        selectedUserTypes.clear();
                        selectedProjectTypes.clear();

                        // Reset toggles to default
                        isPartnerGoalEnabled = true;
                        isProjectGoalEnabled = false;

                        // Reset permissions to default
                        canCreateQuote = true;
                        canEditQuote = false;
                        canDeleteQuote = false;

                        // Clear any selected temporary variables
                        currentSelectedUserType = null;
                        currentUserTarget = null;
                        currentDeadlineDate = null;
                        currentSelectedProjectType = null;
                        currentProjectQuotationGoal = null;
                        currentProjectDeadline = null;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Obx(
                        () =>
                    controller.isLoading.value
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Create Company User',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Widget _buildAddNewUser() {
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String label,
      IconData icon,
      Color color,
      bool isSelected,
      VoidCallback onTap,) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey.shade500,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            title: const Icon(
                Icons.check_circle, color: Colors.green, size: 60),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Company User Created!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'New Company user has been created successfully.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
