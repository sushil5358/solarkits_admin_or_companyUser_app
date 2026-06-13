// lib/view/project_list_screen.dart
import 'package:admin_app_new/screens/project_management/pending_project_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../constants.dart';
import '../../appColors.dart';
import 'completed_order_screen.dart';


class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  List<Map<String, dynamic>> projects = [
    {
      'id': '1',
      'name': 'Solar Project',
      'category': 'Residential',
      'projectType': 'Rooftop Solar',
      'location': 'Gujarat',
      'customerName': 'Rahul Sharma',
      'startDate': '2024-04-01',
      'totalOrders': 5,
    },
    {
      'id': '2',
      'name': 'Green Energy',
      'category': 'Commercial',
      'projectType': 'Ground Mount',
      'location': 'Gujarat',
      'customerName': 'Priya Mehta',
      'startDate': '2024-04-10',
      'totalOrders': 3,
    },
    {
      'id': '3',
      'name': 'Solar Mission',
      'category': 'Industrial',
      'projectType': 'Rooftop Solar',
      'location': 'Gujarat',
      'customerName': 'Amit Desai',
      'startDate': '2024-03-15',
      'totalOrders': 8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          title: const Text(
            'Projects',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.black87,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 1,
          shadowColor: AppColors.shadowGrey.withOpacity(0.3),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
              onPressed: () => _showFilterBottomSheet(),
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.successGreen,
            labelColor: AppColors.successGreen,
            unselectedLabelColor: AppColors.grey,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pending Tab
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return _buildProjectCard(project);
              },
            ),
            // Completed Tab
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return _buildProjectCardCompleted(project);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
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
          builder: (context, setStateSheet) {
            List<String> selectedCategories = [];
            List<String> selectedSubCategories = [];
            List<String> selectedProjectTypes = [];
            List<String> selectedSubProjectTypes = [];

            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter Options',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
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

                    MultiSelectDialogField(
                      items: [
                        'Residential',
                        'Commercial',
                        'Industrial',
                        'Agricultural',
                        'Government',
                      ].map((category) => MultiSelectItem(category, category)).toList(),
                      title: const Text('Select Category'),
                      onConfirm: (values) {
                        setStateSheet(() {
                          selectedCategories = values;
                        });
                      },
                      buttonText: const Text('Select Category'),
                      buttonIcon: const Icon(Icons.category),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: AppColors.successGreen,
                      selectedItemsTextStyle: const TextStyle(
                        color: AppColors.successGreen,
                      ),
                    ),
                    const SizedBox(height: 16),

                    MultiSelectDialogField(
                      items: [
                        'Rooftop Solar',
                        'Ground Mount',
                        'Floating Solar',
                        'Hybrid System',
                        'Off-Grid System',
                      ].map((sub) => MultiSelectItem(sub, sub)).toList(),
                      title: const Text('Select Sub Category'),
                      onConfirm: (values) {
                        setStateSheet(() {
                          selectedSubCategories = values;
                        });
                      },
                      buttonText: const Text('Select Sub Category'),
                      buttonIcon: const Icon(Icons.subdirectory_arrow_right),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: AppColors.secondaryOrange,
                      selectedItemsTextStyle: const TextStyle(
                        color: AppColors.secondaryOrange,
                      ),
                    ),
                    const SizedBox(height: 16),

                    MultiSelectDialogField(
                      items: [
                        'Residential 3 to 10 KW',
                        'Residential < 3 KW',
                        'Commercial',
                      ].map((pt) => MultiSelectItem(pt, pt)).toList(),
                      title: const Text('Select Project Type'),
                      onConfirm: (values) {
                        setStateSheet(() {
                          selectedProjectTypes = values;
                        });
                      },
                      buttonText: const Text('Select Project Type'),
                      buttonIcon: const Icon(Icons.business_center),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: AppColors.successGreen,
                      selectedItemsTextStyle: const TextStyle(
                        color: AppColors.successGreen,
                      ),
                    ),
                    const SizedBox(height: 16),

                    MultiSelectDialogField(
                      items: [
                        'On Grid',
                        'Off Grid',
                        'Hybrid',
                      ].map((spt) => MultiSelectItem(spt, spt)).toList(),
                      title: const Text('Select Sub Project Type'),
                      onConfirm: (values) {
                        setStateSheet(() {
                          selectedSubProjectTypes = values;
                        });
                      },
                      buttonText: const Text('Select Sub Project Type'),
                      buttonIcon: const Icon(Icons.subdirectory_arrow_right),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: AppColors.successGreen,
                      selectedItemsTextStyle: const TextStyle(
                        color: AppColors.successGreen,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setStateSheet(() {
                                selectedCategories.clear();
                                selectedSubCategories.clear();
                                selectedProjectTypes.clear();
                                selectedSubProjectTypes.clear();
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.errorRed),
                              foregroundColor: AppColors.errorRed,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.successGreen,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Badge(
      label: const Text('3'),
      backgroundColor: Colors.red,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectOrdersScreen(project: project),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowGrey,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.business_center,
                        size: 28,
                        color: AppColors.successGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            project['location'],
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem('Category', project['category'], Icons.category),
                    ),
                    Expanded(
                      child: _buildInfoItem('Discom', 'PGVCL', Icons.bolt),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(color: AppColors.dividerGrey),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: AppColors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Started: ${project['startDate']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.receipt, size: 14, color: AppColors.secondaryOrange),
                        const SizedBox(width: 4),
                        Text(
                          '${project['totalOrders']} Orders',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCardCompleted(Map<String, dynamic> project) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompletedOrdersScreen(project: project),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowGrey,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.successGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.business_center,
                      size: 28,
                      color: AppColors.successGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project['location'],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem('Category', project['category'], Icons.category),
                  ),
                  Expanded(
                    child: _buildInfoItem('Discom', 'PGVCL', Icons.bolt),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: AppColors.dividerGrey),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: AppColors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Started: ${project['startDate']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.receipt, size: 14, color: AppColors.secondaryOrange),
                      const SizedBox(width: 4),
                      Text(
                        '${project['totalOrders']} Orders',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 14, color: AppColors.grey),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}