// // lib/screens/signup_leads_screen.dart
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../controller/signup_lead_controller.dart';
// import '../models/dropdown_model.dart';
// import '../models/user_model.dart';
//
//
// class SignupLeadsScreen extends StatelessWidget {
//   SignupLeadsScreen({super.key});
//
//   SignupLeadController controller = Get.put(SignupLeadController());
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         backgroundColor: Colors.grey[50],
//         appBar: AppBar(
//           title: const Text('Signup Leads'),
//           bottom: const TabBar(
//             indicatorColor: Colors.green,
//             labelColor: Colors.green,
//             unselectedLabelColor: Colors.grey,
//             tabs: [
//               Tab(text: 'Pending Approval', icon: Icon(Icons.pending)),
//               Tab(text: 'Approved', icon: Icon(Icons.check_circle)),
//               Tab(text: 'Rejected', icon: Icon(Icons.cancel)),
//             ],
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: const Icon(Icons.filter_list),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             // Stats Summary
//             Container(
//               padding: const EdgeInsets.all(16),
//               color: Colors.white,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildStatChip(
//                       'Total Signups', '156', Icons.people, Colors.blue),
//                   _buildStatChip('Pending', '43', Icons.pending, Colors.orange),
//                   _buildStatChip(
//                       'Approved', '98', Icons.check_circle, Colors.green),
//                   _buildStatChip('Rejected', '15', Icons.cancel, Colors.red),
//                 ],
//               ),
//             ),
//
//             // Tab Views
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   _buildPendingLeadsList(),
//                   _buildApprovedLeadsList(),
//                   _buildRejectedLeadsList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(onPressed: () {
//
//         },),
//       ),
//     );
//   }
//
//   Widget _buildStatChip(String label, String value, IconData icon,
//       Color color) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: color, size: 20),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.grey.shade600,
//             fontSize: 11,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Pending Leads List
//   Widget _buildPendingLeadsList() {
//     final List<Map<String, dynamic>> pendingLeads = [
//       {
//         'id': 'SL001',
//         'name': 'Rahul Sharma',
//         'email': 'rahul.sharma@email.com',
//         'phone': '+91 98765 43210',
//         'profession': 'Solar Consultant',
//         'state': 'Maharashtra',
//         'district': 'Mumbai',
//         'aadhar': '1234-5678-9012',
//         'signupDate': '2024-03-13',
//         'status': 'pending',
//       },
//       {
//         'id': 'SL002',
//         'name': 'Priya Patel',
//         'email': 'priya.patel@email.com',
//         'phone': '+91 98765 43211',
//         'profession': 'Electrician',
//         'state': 'Gujarat',
//         'district': 'Ahmedabad',
//         'aadhar': '2345-6789-0123',
//         'signupDate': '2024-03-12',
//         'status': 'pending',
//       },
//       {
//         'id': 'SL003',
//         'name': 'Amit Kumar',
//         'email': 'amit.kumar@email.com',
//         'phone': '+91 98765 43212',
//         'profession': 'Business Owner',
//         'state': 'Delhi',
//         'district': 'New Delhi',
//         'aadhar': '3456-7890-1234',
//         'signupDate': '2024-03-11',
//         'status': 'pending',
//       },
//       {
//         'id': 'SL004',
//         'name': 'Sunita Reddy',
//         'email': 'sunita.reddy@email.com',
//         'phone': '+91 98765 43213',
//         'profession': 'Solar Installer',
//         'state': 'Telangana',
//         'district': 'Hyderabad',
//         'aadhar': '4567-8901-2345',
//         'signupDate': '2024-03-10',
//         'status': 'pending',
//       },
//     ];
//
//     return FutureBuilder(
//       future: controller.getSignupLeads(),
//       builder: (context, Snapshot) {
//         if(Snapshot.connectionState == ConnectionState.waiting){
//           return Center(child: CircularProgressIndicator(),);
//
//         }else if(Snapshot.hasData){
//           List<UserModel> users = Snapshot.data ?? [];
//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return GestureDetector(
//                 onTap: () {
//                   _showUserDetailDialog(context, user);
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.orange.shade100),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade100,
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [Colors.orange.shade400, Colors.orange
//                                     .shade600
//                                 ],
//                               ),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 user.name.toUpperCase()[0],
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       user.name,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 8,
//                                         vertical: 2,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: Colors.orange.shade50,
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Container(
//                                             width: 6,
//                                             height: 6,
//                                             decoration: const BoxDecoration(
//                                               color: Colors.orange,
//                                               shape: BoxShape.circle,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 4),
//                                           Text(
//                                             'Pending',
//                                             style: TextStyle(
//                                               color: Colors.orange.shade700,
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 4),
//                                 if(user.email != "")
//                                 Text(
//                                   user.email,
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   user.mobile_number,
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 16,
//                             color: Colors.grey.shade400,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildInfoChip(Icons.person, 'profession'),
//                           _buildInfoChip(Icons.location_on, 'district'),
//                           _buildInfoChip(Icons.calendar_today, 'signupDate'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }else if(Snapshot.data!.isEmpty){
//           return Center(child: Text("No Signup Leads Found"),);
//         }else{
//           return Center(child: Text("Something Went Wrong"),);
//         }
//
//       }
//     );
//   }
//
//   Widget _buildInfoChip(IconData icon, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: Colors.grey.shade600),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey.shade700,
//               fontSize: 11,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // User Detail Dialog with Admin Dropdowns
//   Future<void> _showUserDetailDialog(BuildContext context,
//        userData) {
//     String? selectedLoginType;
//     String? selectedWorkingDistrict;
//     String? selectedProjectType;
//
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) =>
//           StatefulBuilder(
//             builder: (context, setState) =>
//                 Container(
//                   height: MediaQuery
//                       .of(context)
//                       .size
//                       .height * 0.9,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       // Handle Bar
//                       Container(
//                         margin: const EdgeInsets.only(top: 12),
//                         width: 40,
//                         height: 4,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade300,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),
//
//                       // Header
//                       Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [Colors.green, Colors.greenAccent],
//                                 ),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   userData['name'][0],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     userData['name'],
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     'User ID: ${userData['id']}',
//                                     style: TextStyle(
//                                       color: Colors.grey.shade600,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // User Details Section
//                       Expanded(
//                         child: SingleChildScrollView(
//                           padding: const EdgeInsets.all(20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // User Provided Information
//                               Container(
//                                 padding: const EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade50,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(
//                                       color: Colors.grey.shade200),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'User Information',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.green,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 16),
//                                     _buildDetailRow(Icons.email, 'Email',
//                                         userData['email']),
//                                     _buildDetailRow(
//                                         Icons.phone, 'Mobile Number',
//                                         userData['phone']),
//                                     _buildDetailRow(Icons.work, 'Profession',
//                                         userData['profession']),
//                                     _buildDetailRow(
//                                         Icons.location_city, 'State',
//                                         userData['state']),
//                                     _buildDetailRow(Icons.map, 'District',
//                                         userData['district']),
//                                     _buildDetailRow(
//                                         Icons.credit_card, 'Aadhar Number',
//                                         userData['aadhar']),
//                                     _buildDetailRow(
//                                         Icons.calendar_today, 'Signup Date',
//                                         userData['signupDate']),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(height: 20),
//
//                               // Admin Fillable Fields with Dropdowns
//                               Container(
//                                 padding: const EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(
//                                       color: Colors.green.shade200),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.green.shade50,
//                                       blurRadius: 10,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(Icons.admin_panel_settings,
//                                             color: Colors.green.shade700),
//                                         const SizedBox(width: 8),
//                                         const Text(
//                                           'Admin Action Required',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 20),
//
//
//                                     const Text(
//                                       'Solar Experience',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey.shade300),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Obx(() {
//                                         return DropdownButtonFormField<
//                                             DropdownModel>(
//                                           value: null,
//                                           hint: const Text('Select Experience'),
//                                           isExpanded: true,
//                                           items: controller.experienceList.value
//                                               .map((e) {
//                                             return DropdownMenuItem<
//                                                 DropdownModel>(child: Text(
//                                                 "${e.solar_experience} Years"),
//                                               value: e,);
//                                           },).toList(),
//                                           onChanged: (value) {
//
//                                           },
//                                           decoration: const InputDecoration(
//                                             border: InputBorder.none,
//                                             contentPadding: EdgeInsets
//                                                 .symmetric(
//                                                 horizontal: 16, vertical: 8),
//                                           ),
//                                           icon: Icon(Icons.arrow_drop_down,
//                                               color: Colors.green.shade600),
//                                         );
//                                       }),
//                                     ),
//
//                                     const SizedBox(height: 16),
//
//
//                                     // Business type dropdown
//                                     const Text(
//                                       'Business type',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey.shade300),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Obx(() {
//                                         return DropdownButtonFormField<
//                                             DropdownModel>(
//                                           hint: const Text(
//                                               'Select Business type'),
//                                           isExpanded: true,
//                                           items: controller.businessList.value
//                                               .map((e) {
//                                             return DropdownMenuItem<
//                                                 DropdownModel>(
//                                               child: Text("${e.business_type}"),
//                                               value: e,);
//                                           },).toList(),
//                                           onChanged: (value) {
//                                             setState(() {
//                                               // selectedLoginType = value;
//                                             });
//                                           },
//                                           decoration: const InputDecoration(
//                                             border: InputBorder.none,
//                                             contentPadding: EdgeInsets
//                                                 .symmetric(
//                                                 horizontal: 16, vertical: 8),
//                                           ),
//                                           icon: Icon(Icons.arrow_drop_down,
//                                               color: Colors.green.shade600),
//                                         );
//                                       }),
//                                     ),
//
//                                     const SizedBox(height: 16),
//
//
//                                     // Business type dropdown
//                                     const Text(
//                                       'Profession Type',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey.shade300),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Obx(() {
//                                         return DropdownButtonFormField<DropdownModel>(
//
//                                           hint: const Text(
//                                               'Select Profession type'),
//                                           isExpanded: true,
//                                           items: controller.professionList.value.map((e) {
//                                             return DropdownMenuItem<DropdownModel>(child: Text(e.professional_type),value: e,);
//                                           },).toList(),
//                                           onChanged: (value) {
//                                             setState(() {
//                                               // selectedLoginType = value;
//                                             });
//                                           },
//                                           decoration: const InputDecoration(
//                                             border: InputBorder.none,
//                                             contentPadding: EdgeInsets
//                                                 .symmetric(
//                                                 horizontal: 16, vertical: 8),
//                                           ),
//                                           icon: Icon(Icons.arrow_drop_down,
//                                               color: Colors.green.shade600),
//                                         );
//                                       }),
//                                     ),
//
//                                     const SizedBox(height: 16),
//
//                                     Row(
//                                       children: [
//                                         Radio(
//                                           activeColor: Colors.green,
//                                           value: true,
//                                           groupValue: "shopType",
//                                           onChanged: (value) {
//
//                                           },),
//                                         Text("Shop", style: TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 14,
//                                         ),),
//                                         Radio(value: false,
//                                           groupValue: "shopType",
//                                           onChanged: (value) {
//
//                                           },),
//                                         Text("Office", style: TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 14,
//                                         ),),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 8,),
//
//
//                                     Row(
//                                       children: [
//                                         Text("GST :", style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 14,
//                                         ),),
//                                         const SizedBox(width: 5,),
//                                         Radio(value: true,
//                                           groupValue: "gst",
//                                           onChanged: (value) {
//
//                                           },),
//                                         Text("Yes", style: TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 14,
//                                         ),),
//                                         Radio(value: false,
//                                           groupValue: "gst",
//                                           onChanged: (value) {
//
//                                           },),
//                                         Text("NO", style: TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 14,
//                                         ),),
//                                       ],
//                                     ),
//
//
//                                     const SizedBox(height: 16),
//
//
//                                     // Login Type Dropdown
//                                     const Text(
//                                       'Login Type *',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey.shade300),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: DropdownButtonFormField<String>(
//                                         value: selectedLoginType,
//                                         hint: const Text('Select Login Type'),
//                                         isExpanded: true,
//                                         items: const [
//                                           DropdownMenuItem(
//                                               value: 'channel_partner',
//                                               child: Text('Channel Partner')),
//                                           DropdownMenuItem(value: 'freelancer',
//                                               child: Text('Freelancer')),
//                                           DropdownMenuItem(value: 'dealer',
//                                               child: Text('Dealer')),
//                                           DropdownMenuItem(value: 'distributor',
//                                               child: Text('Distributor')),
//                                           DropdownMenuItem(value: 'sub_dealer',
//                                               child: Text('Sub-Dealer')),
//                                           DropdownMenuItem(value: 'sales_agent',
//                                               child: Text('Sales Agent')),
//                                         ],
//                                         onChanged: (value) {
//                                           setState(() {
//                                             selectedLoginType = value;
//                                           });
//                                         },
//                                         decoration: const InputDecoration(
//                                           border: InputBorder.none,
//                                           contentPadding: EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 8),
//                                         ),
//                                         icon: Icon(Icons.arrow_drop_down,
//                                             color: Colors.green.shade600),
//                                       ),
//                                     ),
//
//                                     const SizedBox(height: 16),
//
//                                     // Working District Dropdown
//                                     const Text(
//                                       'Working District *',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey.shade300),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: DropdownButtonFormField<String>(
//                                         value: selectedWorkingDistrict,
//                                         hint: const Text(
//                                             'Select Working District'),
//                                         isExpanded: true,
//                                         items: const [
//                                           DropdownMenuItem(value: 'mumbai',
//                                               child: Text('Mumbai')),
//                                           DropdownMenuItem(value: 'delhi',
//                                               child: Text('Delhi NCR')),
//                                           DropdownMenuItem(value: 'bangalore',
//                                               child: Text('Bangalore')),
//                                           DropdownMenuItem(value: 'chennai',
//                                               child: Text('Chennai')),
//                                           DropdownMenuItem(value: 'kolkata',
//                                               child: Text('Kolkata')),
//                                           DropdownMenuItem(value: 'hyderabad',
//                                               child: Text('Hyderabad')),
//                                           DropdownMenuItem(value: 'pune',
//                                               child: Text('Pune')),
//                                           DropdownMenuItem(value: 'ahmedabad',
//                                               child: Text('Ahmedabad')),
//                                           DropdownMenuItem(value: 'jaipur',
//                                               child: Text('Jaipur')),
//                                           DropdownMenuItem(value: 'lucknow',
//                                               child: Text('Lucknow')),
//                                           DropdownMenuItem(value: 'chandigarh',
//                                               child: Text('Chandigarh')),
//                                           DropdownMenuItem(value: 'bhopal',
//                                               child: Text('Bhopal')),
//                                         ],
//                                         onChanged: (value) {
//                                           setState(() {
//                                             selectedWorkingDistrict = value;
//                                           });
//                                         },
//                                         decoration: const InputDecoration(
//                                           border: InputBorder.none,
//                                           contentPadding: EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 8),
//                                         ),
//                                         icon: Icon(Icons.arrow_drop_down,
//                                             color: Colors.green.shade600),
//                                       ),
//                                     ),
//
//                                     const SizedBox(height: 16),
//
//                                     // Project Type Dropdown
//                                     const Text(
//                                       'Working Project Type *',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey.shade300),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: DropdownButtonFormField<String>(
//                                         value: selectedProjectType,
//                                         hint: const Text('Select Project Type'),
//                                         isExpanded: true,
//                                         items: const [
//                                           DropdownMenuItem(value: 'residential',
//                                               child: Text('Residential')),
//                                           DropdownMenuItem(value: 'commercial',
//                                               child: Text('Commercial')),
//                                         ],
//                                         onChanged: (value) {
//                                           setState(() {
//                                             selectedProjectType = value;
//                                           });
//                                         },
//                                         decoration: const InputDecoration(
//                                           border: InputBorder.none,
//                                           contentPadding: EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 8),
//                                         ),
//                                         icon: Icon(Icons.arrow_drop_down,
//                                             color: Colors.green.shade600),
//                                       ),
//                                     ),
//
//                                     const SizedBox(height: 24),
//
//                                     // Validation Message
//                                     if (selectedLoginType == null ||
//                                         selectedWorkingDistrict == null ||
//                                         selectedProjectType == null)
//                                       Container(
//                                         padding: const EdgeInsets.all(12),
//                                         decoration: BoxDecoration(
//                                           color: Colors.orange.shade50,
//                                           borderRadius: BorderRadius.circular(
//                                               12),
//                                           border: Border.all(
//                                               color: Colors.orange.shade200),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Icon(Icons.info_outline,
//                                                 color: Colors.orange.shade700,
//                                                 size: 20),
//                                             const SizedBox(width: 8),
//                                             Expanded(
//                                               child: Text(
//                                                 'Please fill all required fields to approve user',
//                                                 style: TextStyle(
//                                                   color: Colors.orange.shade700,
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//
//                                     const SizedBox(height: 16),
//
//                                     // Action Buttons
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: ElevatedButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                               _showApprovalDialog(
//                                                   context, 'rejected',
//                                                   userData['name']);
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.red
//                                                   .shade50,
//                                               foregroundColor: Colors.red
//                                                   .shade700,
//                                               elevation: 0,
//                                               padding: const EdgeInsets
//                                                   .symmetric(vertical: 14),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius
//                                                     .circular(12),
//                                                 side: BorderSide(
//                                                     color: Colors.red.shade200),
//                                               ),
//                                             ),
//                                             child: const Text('Reject'),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 12),
//                                         Expanded(
//                                           child: ElevatedButton(
//                                             onPressed: (selectedLoginType !=
//                                                 null &&
//                                                 selectedWorkingDistrict !=
//                                                     null &&
//                                                 selectedProjectType != null)
//                                                 ? () {
//                                               Navigator.pop(context);
//                                               _showApprovalDialog(
//                                                   context, 'approved',
//                                                   userData['name']);
//                                             }
//                                                 : null,
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.green,
//                                               foregroundColor: Colors.white,
//                                               disabledBackgroundColor: Colors
//                                                   .grey.shade300,
//                                               padding: const EdgeInsets
//                                                   .symmetric(vertical: 14),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius
//                                                     .circular(12),
//                                               ),
//                                             ),
//                                             child: const Text(
//                                                 'Approve & Submit'),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//
//                                     const SizedBox(height: 8),
//
//                                     Text(
//                                       '* All fields are required for user activation',
//                                       style: TextStyle(
//                                         color: Colors.grey.shade500,
//                                         fontSize: 11,
//                                         fontStyle: FontStyle.italic,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//           ),
//     );
//   }
//
//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 18, color: Colors.grey.shade500),
//           const SizedBox(width: 12),
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showApprovalDialog(BuildContext context, String status,
//       String userName) {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20)),
//             title: Icon(
//               status == 'approved' ? Icons.check_circle : Icons.cancel,
//               color: status == 'approved' ? Colors.green : Colors.red,
//               size: 50,
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   status == 'approved' ? 'User Approved!' : 'User Rejected',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: status == 'approved' ? Colors.green : Colors.red,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   status == 'approved'
//                       ? '$userName can now login to SolarKits app as ${_getLoginTypeLabel(
//                       status)}'
//                       : '$userName has been rejected',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }
//
//   String _getLoginTypeLabel(String? loginType) {
//     switch (loginType) {
//       case 'channel_partner':
//         return 'Channel Partner';
//       case 'freelancer':
//         return 'Freelancer';
//       case 'dealer':
//         return 'Dealer';
//       case 'distributor':
//         return 'Distributor';
//       default:
//         return 'User';
//     }
//   }
//
//   // Approved Leads List
//   Widget _buildApprovedLeadsList() {
//     final List<Map<String, dynamic>> approvedLeads = [
//       {
//         'name': 'Rajesh Kumar',
//         'email': 'rajesh.k@email.com',
//         'phone': '+91 98765 43220',
//         'loginType': 'Channel Partner',
//         'workingDistrict': 'Mumbai',
//         'projectType': 'Commercial',
//         'approvedDate': '2024-03-10',
//       },
//       {
//         'name': 'Neha Singh',
//         'email': 'neha.s@email.com',
//         'phone': '+91 98765 43221',
//         'loginType': 'Dealer',
//         'workingDistrict': 'Delhi NCR',
//         'projectType': 'Residential',
//         'approvedDate': '2024-03-09',
//       },
//       {
//         'name': 'Suresh Patel',
//         'email': 'suresh.p@email.com',
//         'phone': '+91 98765 43222',
//         'loginType': 'Freelancer',
//         'workingDistrict': 'Ahmedabad',
//         'projectType': 'Industrial',
//         'approvedDate': '2024-03-08',
//       },
//       {
//         'name': 'Anita Sharma',
//         'email': 'anita.s@email.com',
//         'phone': '+91 98765 43223',
//         'loginType': 'Distributor',
//         'workingDistrict': 'Bangalore',
//         'projectType': 'Agricultural',
//         'approvedDate': '2024-03-07',
//       },
//     ];
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: approvedLeads.length,
//       itemBuilder: (context, index) {
//         final lead = approvedLeads[index];
//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.green.shade100),
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Colors.green, Colors.greenAccent],
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                       child: Text(
//                         lead['name'][0],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               lead['name'],
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 2,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.green.shade50,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: const Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(Icons.check_circle, color: Colors.green,
//                                       size: 12),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     'Active',
//                                     style: TextStyle(
//                                       color: Colors.green,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           lead['email'],
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildApprovedInfo(
//                         lead['loginType'], Icons.business_center),
//                     _buildApprovedInfo(
//                         lead['workingDistrict'], Icons.location_on),
//                     _buildApprovedInfo(lead['projectType'], Icons.category),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Icon(Icons.calendar_today, size: 12,
//                       color: Colors.grey.shade500),
//                   const SizedBox(width: 4),
//                   Text(
//                     'Approved: ${lead['approvedDate']}',
//                     style: TextStyle(
//                       color: Colors.grey.shade500,
//                       fontSize: 11,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildApprovedInfo(String value, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, size: 14, color: Colors.green.shade600),
//         const SizedBox(width: 4),
//         Text(
//           value,
//           style: TextStyle(
//             color: Colors.green.shade700,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Rejected Leads List
//   Widget _buildRejectedLeadsList() {
//     final List<Map<String, dynamic>> rejectedLeads = [
//       {
//         'name': 'Vikram Mehta',
//         'email': 'vikram.m@email.com',
//         'phone': '+91 98765 43230',
//         'reason': 'Incomplete documentation',
//         'rejectedDate': '2024-03-08',
//       },
//       {
//         'name': 'Anita Desai',
//         'email': 'anita.d@email.com',
//         'phone': '+91 98765 43231',
//         'reason': 'Invalid Aadhar details',
//         'rejectedDate': '2024-03-07',
//       },
//       {
//         'name': 'Ravi Kumar',
//         'email': 'ravi.k@email.com',
//         'phone': '+91 98765 43232',
//         'reason': 'Duplicate application',
//         'rejectedDate': '2024-03-06',
//       },
//     ];
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: rejectedLeads.length,
//       itemBuilder: (context, index) {
//         final lead = rejectedLeads[index];
//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.red.shade100),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.red.shade400, Colors.red.shade600],
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Text(
//                     lead['name'][0],
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       lead['name'],
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       lead['email'],
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 12,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.red.shade50,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         'Reason: ${lead['reason']}',
//                         style: TextStyle(
//                           color: Colors.red.shade700,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     lead['rejectedDate'],
//                     style: TextStyle(
//                       color: Colors.grey.shade500,
//                       fontSize: 11,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Icon(Icons.cancel, color: Colors.red.shade300, size: 16),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }