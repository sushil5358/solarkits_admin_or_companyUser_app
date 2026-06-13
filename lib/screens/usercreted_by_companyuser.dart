// Created Users Screen - Separate Screen

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../controller/maindashbord_controller.dart';
import 'admins_user_detail.dart';
import 'companyuser_quotes_projects.dart';



class CreatedUsersScreen extends StatelessWidget {
  final String salesUserName;
  final List<Map<String, dynamic>> createdUsers;

  const CreatedUsersScreen({
    super.key,
    required this.salesUserName,
    required this.createdUsers,
  });

  @override
  Widget build(BuildContext context) {

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
                height: MediaQuery.of(context).size.height * 0.7,
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
                              'Select Districts',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Rajkot', 'Rajkot'),
                                MultiSelectItem('Vadodra', 'Vadodra'),
                                MultiSelectItem('Surat', 'Surat'),
                              ],
                              title: const Text('Select Districts'),
                              buttonText: const Text('Select Districts'),
                              buttonIcon: const Icon(Icons.business_center),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),


                            const Text(
                              'Select Partner Types',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Franchise', 'Franchise'),
                                MultiSelectItem('Channel Partner', 'Channel Partner'),
                                MultiSelectItem('Freelancer', 'Freelancer'),
                              ],
                              title: const Text('Select Partner Types'),
                              buttonText: const Text('Select Partner Types'),
                              buttonIcon: const Icon(Icons.person),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),



                            const Text(
                              'Select Project Type',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Residential', 'Residential'),
                                MultiSelectItem('Commercial', 'Commercial'),
                                MultiSelectItem('Industrial', 'Industrial'),
                              ],
                              title: const Text('Select Project Type'),
                              buttonText: const Text('Select Project Type'),
                              buttonIcon: const Icon(Icons.business_center),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),

                            // Sub Project Type Multi-Select
                            const Text(
                              'Select Sub Project Type',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Off Grid', 'Off Grid'),
                                MultiSelectItem('On Grid', 'On Grid'),
                                MultiSelectItem('Hybrid', 'Hybrid'),
                              ],
                              title: const Text('Select Sub Project Type'),
                              buttonText: const Text('Select Sub Project Type'),
                              buttonIcon: const Icon(Icons.electrical_services),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),

                            // Category Multi-Select
                            const Text(
                              'Select Category',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Solar Rooftop', 'Solar Rooftop'),
                                MultiSelectItem('Solar Pump', 'Solar Pump'),
                                MultiSelectItem('Solar Light', 'Solar Light'),
                              ],
                              title: const Text('Select Category'),
                              buttonText: const Text('Select Category'),
                              buttonIcon: const Icon(Icons.category),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
                            const SizedBox(height: 20),

                            // Sub Category Multi-Select
                            const Text(
                              'Select Sub Category',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDialogField(
                              items:  [
                                MultiSelectItem('Residential 3 to 10 KW', 'Residential 3 to 10 KW'),
                                MultiSelectItem('Residential >3 KW', 'Residential >3 KW'),
                                MultiSelectItem('Common Meter', 'Common Meter'),
                              ],
                              title: const Text('Select Sub Category'),
                              buttonText: const Text('Select Sub Category'),
                              buttonIcon: const Icon(Icons.subdirectory_arrow_right),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ), onConfirm: (List<String> p1) {  },
                            ),
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
    MaindashbordController controller = Get.put(MaindashbordController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Partners Created by $salesUserName'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Segmented Control
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                          () => CupertinoSlidingSegmentedControl(
                        backgroundColor: Colors.grey.shade200,
                        groupValue: controller.usertype.value,
                        children: {
                          "partner": Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: const Text("Partner"),
                          ),
                          "projects": Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: const Text("Projects"),
                          ),
                        },
                        onValueChanged: (value) {
                          controller.usertype.value = value!;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Welcome Card

            const SizedBox(height: 15),
            //
            // // District Dropdown
            // DropdownButtonFormField<String>(
            //   isExpanded: true,
            //   items: const [
            //     DropdownMenuItem(value: 'rajkot', child: Text('Rajkot')),
            //     DropdownMenuItem(value: 'surat', child: Text('Surat')),
            //     DropdownMenuItem(value: 'ahmedabad', child: Text('Ahmedabad')),
            //     DropdownMenuItem(value: 'vadodara', child: Text('Vadodara')),
            //   ],
            //   onChanged: (value) {},
            //   decoration: const InputDecoration(
            //     labelText: "Select District",
            //     border: OutlineInputBorder(),
            //     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   ),
            //   icon: Icon(Icons.arrow_drop_down, color: Colors.green.shade600),
            // ),
            //
            // const SizedBox(height: 10),
            //
            // // Project Type Dropdown
            // DropdownButtonFormField<String>(
            //   isExpanded: true,
            //   items: const [
            //     DropdownMenuItem(value: 'residential', child: Text('Residential')),
            //     DropdownMenuItem(value: 'commercial', child: Text('Commercial')),
            //     DropdownMenuItem(value: 'industrial', child: Text('Industrial')),
            //   ],
            //   onChanged: (value) {},
            //   decoration: const InputDecoration(
            //     labelText: "Select Project Type",
            //     border: OutlineInputBorder(),
            //     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   ),
            //   icon: Icon(Icons.arrow_drop_down, color: Colors.green.shade600),
            // ),
            //
            // Obx(()=> SizedBox(height: controller.usertype != "partner" ? 0:10)),
            // Obx(
            //       () {
            //     return controller.usertype != "partner" ? Container(): DropdownButtonFormField<String>(
            //       isExpanded: true,
            //       items: const [
            //         DropdownMenuItem(
            //             value: 'channel_partner',
            //             child: Text('Freelancer')),
            //         DropdownMenuItem(value: 'freelancer',
            //             child: Text('franchise')),
            //       ],
            //       onChanged: (value) {
            //
            //       },
            //       decoration: const InputDecoration(
            //         labelText: "Select Partner Type",
            //         border: OutlineInputBorder(),
            //         contentPadding: EdgeInsets.symmetric(
            //             horizontal: 16, vertical: 8),
            //       ),
            //       icon: Icon(Icons.arrow_drop_down,
            //           color: Colors.green.shade600),
            //     );
            //   },
            // ),
            //
            // const SizedBox(height: 10),
            //
            // // Company User Dropdown
            // DropdownButtonFormField<String>(
            //   isExpanded: true,
            //   items: const [
            //     DropdownMenuItem(value: 'nayan', child: Text('Nayan')),
            //     DropdownMenuItem(value: 'amandeep', child: Text('Amandeep')),
            //     DropdownMenuItem(value: 'rajesh', child: Text('Rajesh')),
            //   ],
            //   onChanged: (value) {},
            //   decoration: const InputDecoration(
            //     labelText: "Select Company User",
            //     border: OutlineInputBorder(),
            //     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   ),
            //   icon: Icon(Icons.arrow_drop_down, color: Colors.green.shade600),
            // ),

            const SizedBox(height: 10),

            // Stats Cards
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Stats Grid - Fixed without Expanded
            Obx(
              ()=> GridView.count(

                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [


                      if(controller.usertype.value == "partner")
                _buildStatCard(
                        'Total Parter\nUsers',
                        '156',
                        Icons.people,
                        Colors.blue,
                        '+12 this week',
                      ),


                  _buildStatCard(
                    'Total Quotes',
                    '534',
                    Icons.receipt,
                    Colors.purple,
                    '68% conversion',
                  ),
                  _buildStatCard(
                    'Projects',
                    '267',
                    Icons.solar_power,
                    Colors.green,
                    '₨ 2.4M revenue',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Top Performing Users
            Obx(
              ()=> controller.usertype.value == "partner" ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Created Partners',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Partners List - Fixed without Expanded
                  createdUsers.isEmpty
                      ? Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No partners created yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This sales user hasn\'t created any partners',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: createdUsers.length,
                    itemBuilder: (context, index) {
                      final user = createdUsers[index];
                      return _buildPartnerCard(context, user, index);
                    },
                  ),
                ],
              ) : SizedBox()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon,
      Color color, String subtitle) {
    MaindashbordController controller = Get.find();


    return InkWell(
      onTap: () {

        if (controller.usertype.value != "partner") {
          Get.to(()=>companyUserQuote_projects());
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.green.shade600,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildPartnerCard(BuildContext context, Map<String, dynamic> user, int index) {
    Color typeColor;
    switch (user['type']) {
      case 'Channel Partner':
        typeColor = Colors.green;
        break;
      case 'Freelancer':
        typeColor = Colors.orange;
        break;
      case 'Dealer':
        typeColor = Colors.purple;
        break;
      default:
        typeColor = Colors.blue;
    }

    return InkWell(
      onTap: () {
        Get.to(()=>CreatedUserDetailScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
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
            // Main Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [typeColor, typeColor.withOpacity(0.7)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        user['name'][0],
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
                        Text(
                          user['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: typeColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    user['type'],
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: typeColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 10,
                                      color: Colors.grey.shade500,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      user['date'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Call Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Call functionality
                      },
                      icon: Icon(Icons.call, color: Colors.green.shade700, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(maxWidth: 32, maxHeight: 32),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // WhatsApp functionality
                      },
                      icon: Icon(Icons.message, color: Colors.blue.shade700, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(maxWidth: 32, maxHeight: 32),
                    ),
                  ),
                ],
              ),
            ),

            // Additional Details
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
                  Row(
                    children: [
                      Icon(Icons.email, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        user['email'],
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        user['mobile'],
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}