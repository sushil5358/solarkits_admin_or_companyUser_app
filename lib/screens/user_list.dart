// lib/screens/users_screen.dart
import 'package:admin_app_new/screens/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/customer_users_controller.dart';
import '../models/comman_model.dart';
import '../models/user_model.dart';
import 'error_401.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  CustomerUsersController controller = Get.put(CustomerUsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Parter Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.to(() => UnauthorizedScreen());
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showBottomSheet(context: context, builder: (context) {
                return BottomSheet(onClosing: () {

                }, builder: (context) {
                  return Container(

                  );
                },);
              },);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar


          const SizedBox(height: 11),

          // Filter Chips Section
          Obx(() {
            if (controller.loginType.isEmpty) {
              return const SizedBox.shrink();
            }
            return SizedBox(
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: controller.loginType.length,
                itemBuilder: (context, index) {
                  Common_Model login = controller.loginType[index];
                  // Trim and compare for better matching
                  bool isSelected = controller.selectedlogintype.value.trim() == login.name.trim();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(login.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          // Set the selected value
                          controller.selectedlogintype.value = login.name;
                          print("Selected: ${controller.selectedlogintype.value}");
                          controller.refreshUsers();
                        } else {
                          // Clear selection to show all users
                          controller.selectedlogintype.value = '';
                          controller.refreshUsers();
                        }
                      },
                      backgroundColor: Colors.grey.shade100,
                      selectedColor: Colors.green.shade100,
                      checkmarkColor: Colors.green.shade700,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.green.shade700 : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            );
          }),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                        value: 'channel_partner',
                        child: Text('Rajkot')),
                    DropdownMenuItem(value: 'freelancer',
                        child: Text('Surat')),
                  ],
                  onChanged: (value) {

                  },
                  decoration: const InputDecoration(
                    labelText: "Select District",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                  icon: Icon(Icons.arrow_drop_down,
                      color: Colors.green.shade600),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                        value: 'channel_partner',
                        child: Text('Residencial')),
                    DropdownMenuItem(value: 'freelancer',
                        child: Text('Commarcial')),
                  ],
                  onChanged: (value) {

                  },
                  decoration: const InputDecoration(
                    labelText: "Select Project Type",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                  icon: Icon(Icons.arrow_drop_down,
                      color: Colors.green.shade600),
                ),
              ),
            ],),
          ),

          // Users List
          Expanded(
            child: Obx(() {
              return FutureBuilder(
                key: ValueKey('${controller.refreshKey.value}_${controller.selectedlogintype.value}'),
                future: controller.getusers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    List<UserModel> users = snapshot.data ?? [];
                    if (users.isEmpty) {
                      return const Center(child: Text("No User Found"));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        UserModel user = users[index];
                        return _buildUserCard(user);
                      },
                    );
                  }
                  return const Center(child: Text("Something went wrong"));
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    return GestureDetector(
      onTap: () {
        Get.to(() => UserDetailsScreen(user: user,));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
          children: [
            Row(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade400,
                        Colors.green.shade600,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user.name.toString().isNotEmpty
                          ? user.name.toString().toUpperCase()[0]
                          : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if(user.email.isNotEmpty)
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
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
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user.mobile_number,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Stats Preview
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        user.lead_generated,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Leads',
                        style: TextStyle(
                          color: Colors.green.shade600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUserStat('Quotes', user.quote_generated),
                _buildUserStat('Projects', user.project_signup),
                _buildUserStat('Revenue', user.total_grand_total),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}