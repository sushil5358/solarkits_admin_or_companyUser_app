// Main Dashboard Content (Original Dashboard)

import 'package:admin_app_new/screens/partner_users.dart';
import 'package:admin_app_new/screens/report_screen.dart';
import 'package:admin_app_new/screens/user_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../controller/maindashbord_controller.dart';
import 'all_settings.dart';
import 'announcement_screen.dart';
import 'company_user_ratesettings.dart';
import 'company_users.dart';
import 'login_screen.dart';
import 'login_setting.dart';
import 'offer_screen.dart';

class MainDashboardContent extends StatelessWidget {
  const MainDashboardContent({super.key});

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
              height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
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
                          // District Multi-Select
                          const Text(
                            'Select District',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          MultiSelectDialogField(
                            items:  [
                              MultiSelectItem('Rajkot', 'Rajkot'),
                              MultiSelectItem('Surat', 'Surat'),
                              MultiSelectItem('Ahmedabad', 'Ahmedabad'),
                              MultiSelectItem('Vadodara', 'Vadodara'),
                              MultiSelectItem('Bhavnagar', 'Bhavnagar'),
                              MultiSelectItem('Jamnagar', 'Jamnagar'),
                            ],
                            title: const Text('Select District'),
                            buttonText: const Text('Select District'),
                            buttonIcon: const Icon(Icons.location_on),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ), onConfirm: (List<String> p1) {  },
                          ),


                          // Project Type Multi-Select

                          const SizedBox(height: 20),

                          // Partner Type Multi-Select
                          const Text('Select User Types :',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          const SizedBox(height: 5,),
                          const SizedBox(height: 8),
                          MultiSelectDialogField(
                            items: [
                              MultiSelectItem('Freelancer', 'Freelancer'),
                              MultiSelectItem('Franchise', 'Franchise'),
                              MultiSelectItem('Channel Partner', 'Channel Partner'),
                              MultiSelectItem('Dealer', 'Dealer'),
                              MultiSelectItem('Distributor', 'Distributor'),
                            ],
                            title: const Text('Select Partner Type'),
                            buttonText: const Text('Select Partner Type'),
                            buttonIcon: const Icon(Icons.people),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ), onConfirm: (List<String> p1) {  },
                          ),
                          const SizedBox(height: 20),

                          // Company User Multi-Select
                          MultiSelectDialogField(
                            items:  [
                              MultiSelectItem('Nayan', 'Nayan'),
                              MultiSelectItem('Amandeep', 'Amandeep'),
                              MultiSelectItem('Rajesh', 'Rajesh'),
                              MultiSelectItem('Priya', 'Priya'),
                              MultiSelectItem('Amit', 'Amit'),
                            ],
                            title: const Text('Select Company User'),
                            buttonText: const Text('Select Company User'),
                            buttonIcon: const Icon(Icons.business),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ), onConfirm: (List<String> p1) {  },
                          ),
                          const SizedBox(height: 20),

                          // Category Multi-Select
                          const Text('Select Project Types :',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          SizedBox(height: 5,),

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
                          const SizedBox(height: 20),


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
    MaindashbordController controller = Get.put(MaindashbordController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                          () => CupertinoSlidingSegmentedControl(
                        backgroundColor: Colors.green,
                        groupValue: controller.usertype.value,
                        children: const {
                          "partner": Text("Partner"),
                          "projects": Text("Projects")
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
                    'Welcome back, Admin!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Here\'s what\'s happening with SolarKits today',
                    style: TextStyle(
                      color: Colors.green.shade100,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildWelcomeStat(
                        'Your Role',
                        'Super Admin',
                        Icons.admin_panel_settings,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Stats Cards
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                Obx(
                      () => _buildStatCard(
                    controller.usertype == 'partner' ? 'Total Partner\nUsers' : 'Total Company\nUsers',
                    '156',
                    Icons.people,
                    Colors.blue,
                    '+12 this week',
                  ),
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
            const SizedBox(height: 20),

            // Top Performers
            const Text(
              'Top Performings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTopPerformers(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {

    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green.shade600, Colors.green.shade800],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.solar_power,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SolarKits Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'v1.0.0',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    Icons.dashboard,
                    'Dashboard',
                        () => Navigator.pop(context),
                    isSelected: true,
                  ),
                  /// lod app partner users
                  // _buildDrawerItem(
                  //   Icons.people,
                  //   'Partner Users',
                  //       () {
                  //     Navigator.pop(context);
                  //     Get.to(() => UsersScreen());
                  //   },
                  // ),
                  _buildDrawerItem(
                    Icons.people_alt_outlined,
                    'Partner Users',
                        () {
                      Navigator.pop(context);
                      Get.to(() => PartnerUsersScreen());
                    },
                  ),
                  _buildDrawerItem(
                    Icons.supervised_user_circle_sharp,
                    'Company Users',
                        () {
                      Navigator.pop(context);
                      Get.to(() => const CompanyUsersScreen());
                    },
                  ),
                  _buildDrawerItem(
                    Icons.campaign,
                    'Announcements',
                        () {
                      Navigator.pop(context);
                      Get.to(() => const AnnouncementScreen());
                    },
                  ),
                  _buildDrawerItem(
                    Icons.local_offer,
                    'Offers',
                        () {
                      Navigator.pop(context);
                      Get.to(() => const OfferScreen());
                    },
                  ),
                  _buildDrawerItem(
                    Icons.bar_chart,
                    'Reports',
                        () {
                      Navigator.pop(context);
                      Get.to(() => const ReportsScreen());
                    },
                  ),
                  _buildDrawerItem(
                    Icons.settings,
                    'Settings',
                        () {
                      Navigator.pop(context);
                      Get.to(() => const SettingsScreen());
                    },
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    Icons.logout,
                    'Logout',
                        () {
                      Get.offAll(() => const LoginScreen());
                    },
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap,
      {bool isSelected = false, Color? color}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.green : (color ?? Colors.grey.shade600),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.green : (color ?? Colors.black87),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }

  Widget _buildWelcomeStat(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon,
      Color color, String subtitle) {
    return Container(
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
    );
  }

  Widget _buildTopPerformers() {
    final List<Map<String, dynamic>> performers = [
      {'name': 'Sarah Smith', 'leads': 45, 'quotes': 32, 'projects': 28},
      {'name': 'John Doe', 'leads': 38, 'quotes': 25, 'projects': 20},
      {'name': 'Mike Johnson', 'leads': 32, 'quotes': 22, 'projects': 18},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: performers.length,
      itemBuilder: (context, index) {
        final Map<String, dynamic> performer = performers[index];

        final String name = performer['name'] as String? ?? '';
        final int quotes = performer['quotes'] as int? ?? 0;
        final int projects = performer['projects'] as int? ?? 0;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildPerformerStat('Quotes', quotes),
                        const SizedBox(width: 12),
                        _buildPerformerStat('Projects', projects),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.star,
                color: index == 0 ? Colors.amber : Colors.grey.shade300,
                size: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPerformerStat(String label, int value) {
    return Row(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}