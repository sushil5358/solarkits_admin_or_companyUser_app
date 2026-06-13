// lib/screens/user_details_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../controller/user_detail_controller.dart';
import '../models/lead_model.dart';
import '../models/project_model.dart';
import '../models/quote_model.dart';
import '../models/user_model.dart';
import '../sevices/hexcolor.dart';

class UserDetailsScreen extends StatefulWidget {
  UserModel user;

  UserDetailsScreen({super.key, required this.user});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserDetailController controller = Get.put(UserDetailController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("user.reference_id ${widget.user.reference_id}");
    controller.getLeads(widget.user.reference_id);
    controller.getquote(widget.user.reference_id);
    controller.getprojects(widget.user.reference_id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('User Details'),
          bottom:  TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.leaderboard),child: Text("Leads ${widget.user.lead_generated}"),),
              Tab(icon: Icon(Icons.receipt), child: Text("Quotes ${widget.user.quote_generated}")),
              Tab(icon: Icon(Icons.solar_power), child: Text("Projects ${widget.user.project_signup}")),
            ],
          ),
        ),
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Select District",
                  border: OutlineInputBorder()
                ),
                items: ["Rajkot","Surat","Ahemdabad"].map((e) {
                  return DropdownMenuItem(child: Text(e),value: e,);
                },).toList(), onChanged: (value) {

              },),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: "Select Project Type",
                    border: OutlineInputBorder()
                ),
                items: ["Comman Meter","Commercial","Residencial"].map((e) {
                  return DropdownMenuItem(child: Text(e),value: e,);
                },).toList(), onChanged: (value) {

              },),
            ),

            const SizedBox(height: 10,),
            // User Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.greenAccent],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "${widget.user.name.toUpperCase()[0]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if(widget.user.email != "")
                          Row(
                            children: [
                              Icon(Icons.email, size: 16,
                                  color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                widget.user.email,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16,
                                color: Colors.grey.shade600),
                            const SizedBox(width: 4),
                            Text(
                              widget.user.mobile_number,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Stats Cards
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   child: Row(
            //     children: [
            //       _buildDetailStatCard(
            //         'Total Leads',
            //         widget.user.lead_generated,
            //         Icons.leaderboard,
            //         Colors.orange,
            //       ),
            //       const SizedBox(width: 12),
            //       _buildDetailStatCard(
            //         'Total Quotes',
            //         widget.user.quote_generated,
            //         Icons.receipt,
            //         Colors.purple,
            //       ),
            //       const SizedBox(width: 12),
            //       _buildDetailStatCard(
            //         'Projects',
            //         widget.user.project_signup,
            //         Icons.solar_power,
            //         Colors.green,
            //       ),
            //     ],
            //   ),
            // ),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() {
                    return _buildLeadsTab();
                  }),
                  Obx(() {
                    return _buildQuotesTab();
                  }),
                  Obx(() {
                    return _buildProjectsTab();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailStatCard(String title, String value, IconData icon,
      Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadsTab() {
    if (controller.leads.isEmpty) {
      return Center(child: Text("No Leads Found",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),);
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.leads.length,
        itemBuilder: (context, index) {
          LeadModel lead = controller.leads[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lead.reg_no,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 8,
                    //     vertical: 4,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: index % 3 == 0
                    //         ? Colors.blue.shade50
                    //         : index % 3 == 1
                    //         ? Colors.orange.shade50
                    //         : Colors.green.shade50,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Text(
                    //     index % 3 == 0
                    //         ? 'New'
                    //         : index % 3 == 1
                    //         ? 'Contacted'
                    //         : 'Converted',
                    //     style: TextStyle(
                    //       color: index % 3 == 0
                    //           ? Colors.blue.shade700
                    //           : index % 3 == 1
                    //           ? Colors.orange.shade700
                    //           : Colors.green.shade700,
                    //       fontSize: 11,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildLeadInfo(
                        'Customer',
                        lead.name,
                        Icons.person,
                      ),
                    ),

                    Expanded(
                      child: _buildLeadInfo(
                        'Contact',
                        lead.phone,
                        Icons.phone,
                      ),
                    ),
                    // Expanded(
                    //   child: _buildLeadInfo(
                    //     'System Size',
                    //     '5kW',
                    //     Icons.solar_power,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildLeadInfo(
                        'Created',
                        lead.created_date,
                        Icons.calendar_today,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Widget _buildLeadInfo(String label, String value, IconData icon) {

    String dateOnly = '';
    if(label == "Created"){
      String dateString = value.toString();
      DateTime dateTime = DateTime.parse(dateString);
      dateOnly = DateFormat('yyyy-MM-dd').format(dateTime);
      print(dateOnly);
    }

    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade500),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 10,
                ),
              ),
              Text(
                label == "Created" ? dateOnly :value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuotesTab() {
    if (controller.quoteList.isEmpty) {
      return Center(child: Text("No Quote Found",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),);
    } else {



      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.quoteList.length,
        itemBuilder: (context, index) {
          QuotationModel quote = controller.quoteList[index];

          String dateString = quote.quotation_date.toString(); // "12 November 2025 12:25"
          String dateOnly = '';

          try {
            // Parse the API date format
            DateFormat inputFormat = DateFormat('dd MMMM yyyy HH:mm');
            DateTime dateTime = inputFormat.parse(dateString);

            // Convert to desired format
            dateOnly = DateFormat('yyyy-MM-dd').format(dateTime);
            // Or if you want to keep it as "12 November 2025", use:
            // dateOnly = DateFormat('dd MMMM yyyy').format(dateTime);
          } catch (e) {
            print('Error parsing date: $e');
            dateOnly = dateString.split(' ').sublist(0, 3).join(' ');
          }
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      quote.quotation_no,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 8,
                    //     vertical: 4,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: index % 2 == 0
                    //         ? Colors.amber.shade50
                    //         : Colors.green.shade50,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Text(
                    //     index % 2 == 0 ? 'Pending' : 'Accepted',
                    //     style: TextStyle(
                    //       color: index % 2 == 0
                    //           ? Colors.amber.shade700
                    //           : Colors.green.shade700,
                    //       fontSize: 11,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      quote.lead_customer_name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '₨ ${quote.grand_total}',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14,
                        color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      'Created : $dateOnly',
                      style: TextStyle(
                          color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Widget _buildProjectsTab() {
    if(controller.projectList.isEmpty){
       return Center(child: Text("No Leads Found",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),);
    }else{
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.projectList.length,
        itemBuilder: (context, index) {
          ProjectModel project = controller.projectList[index];
          String dateString = project.created_date.toString(); // "12 November 2025 12:25"
          String dateOnly = '';

          try {
            // Parse the API date format
            DateFormat inputFormat = DateFormat('dd MMMM yyyy HH:mm');
            DateTime dateTime = inputFormat.parse(dateString);

            // Convert to desired format
            dateOnly = DateFormat('yyyy-MM-dd').format(dateTime);
            // Or if you want to keep it as "12 November 2025", use:
            // dateOnly = DateFormat('dd MMMM yyyy').format(dateTime);
          } catch (e) {
            print('Error parsing date: $e');
            dateOnly = dateString.split(' ').sublist(0, 3).join(' ');
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.project_no,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: HexColor(project.current_project_status_color),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        project.current_project_status,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  project.customer_name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  'KW: ${project.required_kw}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Created $dateOnly',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    Text(
                      '₨ ${project.grnad_total}',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    }

  }
}