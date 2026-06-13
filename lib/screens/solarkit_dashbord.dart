// lib/screens/solar_kits_content.dart
// lib/screens/solar_kits_content.dart

import 'package:admin_app_new/screens/price_table.dart';
import 'package:admin_app_new/screens/project_management/project_management_screen.dart';
import 'package:admin_app_new/screens/projects_screen_admin.dart';
import 'package:admin_app_new/screens/survey_list_screen.dart';
import 'package:admin_app_new/screens/loan/track_loan.dart';
import 'package:admin_app_new/screens/unfied_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';


import '../appColors.dart';
import '../controller/solarkitContent_controller.dart';
import '../models/comanItem_model.dart';
import 'add_lead.dart';
import 'add_quotation_companyUser.dart';
import 'all_quotes/admin_quotes.dart';
import 'combo_kits.dart';
import 'loan_customers_list.dart';

class SolarKitsContent extends StatelessWidget {

  SolarKitsContent({super.key});

  SolarkitcontentController controller = Get.put(SolarkitcontentController());


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


                          // Category Multi-Select
                          const Text(
                            'Select Category',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
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
                                controller.selectedCategoryIds.value = selectedIds;
                                controller.getProjectTypes();
                              },
                            );
                          }),
                          const SizedBox(height: 20),

                          const Text(
                            'Select Project Type',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
                              items: controller.projectTypeList
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
                                controller.selectedProjectTypesIds.value =
                                    selectedIds;
                                controller.getSubProjectTypes();
                              },
                            );
                          }),
                          const SizedBox(height: 20),


                          const Text(
                            'Select Sub Project Type',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return MultiSelectDialogField(
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

                              },
                            );
                          }),
                          const SizedBox(height: 20),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Generate Quote'),
        centerTitle: true,
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showQuoteOptionsDialog(context);
        },
        icon: Icon(Icons.add),
        backgroundColor: AppColors.successGreen,
        foregroundColor: Colors.white,
        label: Text('Add Quote'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Overview
            // const Text(
            //   'Quick Overview',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 12),
            // Row(
            //   children: [
            //     _buildStatCard(
            //         'Total Quotes', '100/89', Icons.receipt, Colors.purple),
            //     const SizedBox(width: 12),
            //     _buildStatCard('Active Projects', '50/45', Icons.solar_power,
            //         Colors.green),
            //   ],
            // ),


            // Quick Overview Section
            const Text(
              'Quick Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Total Quotes Card - Only show total quotes
                Expanded(
                  child: _buildStatCard(
                    'Total Quotes',
                    '89',
                    Icons.receipt,
                    Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                // Active Projects Card - Show with goal progress
                Expanded(
                  child: _buildProjectGoalCard(
                    title: 'Active Projects',
                    completedCount: '45',
                    totalGoalCount: '50',
                    deadlineDate: '30 Jun 2024',
                    icon: Icons.solar_power,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Menu Grid - Three options
            const Text(
              'Select Module',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: [
                _buildMenuCard(
                  context,
                  title: 'Quotations',
                  icon: Icons.receipt,
                  color: Colors.purple,
                  count: '89',
                  description: 'Manage all quotations',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuotesManagementScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  title: 'Projects',
                  icon: Icons.solar_power,
                  color: Colors.green,
                  count: '45',
                  description: 'Manage all projects',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProjectsManagementScreen(),
                      ),
                    );
                  },
                ),


                _buildMenuCard(
                  context,
                  title: 'Loan',
                  icon: Icons.account_balance_outlined,
                  color: Colors.blue,
                  count: '45',
                  description: 'Check Loan Eligibility',
                  onTap: () {
                    Get.to(() => LoanCustomerListScreen());
                  },
                ),

                _buildMenuCard(
                  context,
                  title: 'Project Management',
                  icon: Icons.article_outlined,
                  color: Colors.orange,
                  count: '45',
                  description: 'Manage your Orders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProjectListScreen(),
                      ),
                    );
                  },
                ),

              ],
            ),

            const SizedBox(height: 24),

            // Recent Activity Section
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         'Recent Activity',
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(height: 12),
            //       _buildRecentActivityItem(
            //         'New lead added',
            //         'Rahul Sharma - 10kW System',
            //         '2 min ago',
            //         Icons.leaderboard,
            //         Colors.blue,
            //       ),
            //       _buildRecentActivityItem(
            //         'Quote generated',
            //         'QT-2024-001 for Green Energy',
            //         '1 hour ago',
            //         Icons.receipt,
            //         Colors.purple,
            //       ),
            //       _buildRecentActivityItem(
            //         'Project completed',
            //         'PRJ-2024-002 - Sunrise Industries',
            //         '3 hours ago',
            //         Icons.solar_power,
            //         Colors.green,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _showQuoteOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) =>
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.white,
                    AppColors.veryLightGrey,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with gradient
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.successGreen,
                          AppColors.successGreen.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_comment,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Create New Quote',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Choose the type of quote you want to create',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Quick Quote Option
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  AddQuoteScreen(quoteId: '',)),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
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
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.secondaryOrange,
                                    AppColors.secondaryOrange.withOpacity(0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.flash_on,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Quick Quote',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Create a quick quotation instantly',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryOrange.withOpacity(
                                    0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: AppColors.secondaryOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Survey Quote Option
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              UnifiedSurveyScreen(willQuote: 'yes',)),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
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
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.successGreen,
                                    AppColors.successGreen.withOpacity(0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.article_outlined,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Survey Quote',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Create quote based on site survey',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.successGreen.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: AppColors.successGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
    );
  }


  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade900],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.solar_power,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Solar Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'admin@solarapp.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Track Loan Option
                ListTile(
                  leading: Icon(Icons.account_balance_outlined,
                      color: Colors.blue.shade700),
                  title: const Text('Track Loan'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigator.pop(context); // Close drawer
                    Get.to(() => const TrackLoanScreen());
                  },
                ),
                const Divider(height: 1),

                // Combo Kits Option
                ListTile(
                  leading: Icon(Icons.grid_on, color: Colors.green.shade700),
                  title: const Text('Combo Kits'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigator.pop(context); // Close drawer
                    // Navigate to Combo Kits screen
                    Get.to(() => const ComboKitsScreen());
                  },
                ),
                const Divider(height: 1),
                // Add this to your drawer options
                ListTile(
                  leading: Icon(Icons.table_chart, color: Colors.blue.shade700),
                  title: const Text('Price Table'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Get.to(() => const PriceTableScreen());
                  },
                ),
                const Divider(height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon,
      Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
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
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectGoalCard({
    required String title,
    required String completedCount,
    required String totalGoalCount,
    required String deadlineDate,
    required IconData icon,
    required Color color,
  }) {
    // Parse counts to integers
    int completed = int.tryParse(completedCount) ?? 0;
    int totalGoal = int.tryParse(totalGoalCount) ?? 0;

    // Calculate percentage
    double percentage = totalGoal > 0 ? completed / totalGoal : 0;

    return Container(
      padding: const EdgeInsets.all(12),
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
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
          // Count
          Text(
            '$completed / $totalGoal',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey.shade200,
              color: color,
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 4),
          // Deadline
          Text(
            'Goal: $deadlineDate',
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String count,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 40,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivityItem(String title, String description, String time,
      IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}



