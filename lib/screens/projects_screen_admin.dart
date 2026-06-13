// // lib/screens/projects_management_screen.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
//
// class ProjectsManagementScreen extends StatefulWidget {
//   const ProjectsManagementScreen({super.key});
//
//   @override
//   State<ProjectsManagementScreen> createState() => _ProjectsManagementScreenState();
// }
//
// class _ProjectsManagementScreenState extends State<ProjectsManagementScreen> {
//   final ScrollController _scrollController = ScrollController();
//
//   // Filter variables
//   String? _selectedStatus;
//   String? _selectedUserType;
//   int _filterCount = 0;
//
//   // Sample data
//   List<Map<String, dynamic>> projects = [
//     {
//       'id': '1',
//       'projectNo': 'PRJ-2024-001',
//       'leadNo': 'LD-2024-001',
//       'customerName': 'Rahul Sharma',
//       'customerPhone': '+91 98765 43210',
//       'customerEmail': 'rahul@greenenergy.com',
//       'projectType': 'Residential',
//       'systemSize': '10 kW',
//       'noOfPanels': '24',
//       'status': 'At Warehouse',
//       'statusColor': '#2196F3',
//       'progress': 0.65,
//       'amount': '4,50,000',
//       'grandTotal': '4,50,000',
//       'createdDate': '2024-03-20',
//       'createdBy': 'Rajesh Kumar',
//       'panelBrandImage': '',
//       'inverterBrandImage': '',
//       'projectTypeImage': '',
//       'quoteId': 'QT-2024-001',
//       'gst': '12',
//       'gstAmount': '48,214',
//       'mnreSubsidy': '0',
//       'structureCharge': '15,000',
//       'installationCharge': '10,000',
//       'marginCharge': '5,000',
//       'fileType': 'Loan',
//       'projectStage': 1, // 1: At Warehouse, 2: Ready to Deliver, 3: In Transit, 4: Delivered
//     },
//     {
//       'id': '2',
//       'projectNo': 'PRJ-2024-002',
//       'leadNo': 'LD-2024-002',
//       'customerName': 'Priya Patel',
//       'customerPhone': '+91 98765 43211',
//       'customerEmail': 'priya@sunrise.com',
//       'projectType': 'Commercial',
//       'systemSize': '25 kW',
//       'noOfPanels': '60',
//       'status': 'Delivered',
//       'statusColor': '#4CAF50',
//       'progress': 1.0,
//       'amount': '11,25,000',
//       'grandTotal': '11,25,000',
//       'createdDate': '2024-03-19',
//       'createdBy': 'Priya Singh',
//       'panelBrandImage': '',
//       'inverterBrandImage': '',
//       'projectTypeImage': '',
//       'quoteId': 'QT-2024-002',
//       'gst': '12',
//       'gstAmount': '1,20,535',
//       'mnreSubsidy': '0',
//       'structureCharge': '25,000',
//       'installationCharge': '15,000',
//       'marginCharge': '10,000',
//       'fileType': 'Loan',
//       'projectStage': 4,
//     },
//     {
//       'id': '3',
//       'projectNo': 'PRJ-2024-003',
//       'leadNo': 'LD-2024-003',
//       'customerName': 'Amit Kumar',
//       'customerPhone': '+91 98765 43212',
//       'customerEmail': 'amit@ecohomes.com',
//       'projectType': 'Residential',
//       'systemSize': '5 kW',
//       'noOfPanels': '12',
//       'status': 'Ready to Deliver',
//       'statusColor': '#FF9800',
//       'progress': 0.2,
//       'amount': '2,25,000',
//       'grandTotal': '2,25,000',
//       'createdDate': '2024-03-18',
//       'createdBy': 'Amit Sharma',
//       'panelBrandImage': '',
//       'inverterBrandImage': '',
//       'projectTypeImage': '',
//       'quoteId': 'QT-2024-003',
//       'gst': '12',
//       'gstAmount': '24,107',
//       'mnreSubsidy': '0',
//       'structureCharge': '10,000',
//       'installationCharge': '8,000',
//       'marginCharge': '3,000',
//       'fileType': 'Cash',
//       'projectStage': 2,
//     },
//     {
//       'id': '4',
//       'projectNo': 'PRJ-2024-004',
//       'leadNo': 'LD-2024-004',
//       'customerName': 'Sunita Reddy',
//       'customerPhone': '+91 98765 43213',
//       'customerEmail': 'sunita@greenenergy.com',
//       'projectType': 'Commercial',
//       'systemSize': '50 kW',
//       'noOfPanels': '120',
//       'status': 'In Transit',
//       'statusColor': '#9C27B0',
//       'progress': 0.8,
//       'amount': '22,50,000',
//       'grandTotal': '22,50,000',
//       'createdDate': '2024-03-15',
//       'createdBy': 'Rajesh Kumar',
//       'panelBrandImage': '',
//       'inverterBrandImage': '',
//       'projectTypeImage': '',
//       'quoteId': 'QT-2024-004',
//       'gst': '12',
//       'gstAmount': '2,41,071',
//       'mnreSubsidy': '0',
//       'structureCharge': '50,000',
//       'installationCharge': '25,000',
//       'marginCharge': '15,000',
//       'fileType': 'Loan',
//       'projectStage': 3,
//     },
//   ];
//
//   final List<Map<String, dynamic>> statusTypes = [
//     {'id': '1', 'name': 'At Warehouse'},
//     {'id': '2', 'name': 'Ready to Deliver'},
//     {'id': '3', 'name': 'In Transit'},
//     {'id': '4', 'name': 'Delivered'},
//   ];
//
//   final List<Map<String, dynamic>> userTypes = [
//     {'id': '1', 'name': 'Channel Partner'},
//     {'id': '2', 'name': 'Freelancer'},
//     {'id': '3', 'name': 'Dealer'},
//     {'id': '4', 'name': 'Distributor'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         title: const Text(
//           'Project Management',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//             color: Color(0xDE000000),
//           ),
//         ),
//         centerTitle: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.filter_list, color: Colors.black),
//                 onPressed: () {
//                   _showFilterBottomSheet(context);
//                 },
//               ),
//               if (_filterCount > 0)
//                 Positioned(
//                   top: 5,
//                   right: 5,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: Color(0xFFF44336),
//                       shape: BoxShape.circle,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     child: Text(
//                       '$_filterCount',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//       body: projects.isEmpty
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.solar_power, size: 80, color: const Color(0xFFBDBDBD)),
//             const SizedBox(height: 16),
//             Text(
//               'No projects yet',
//               style: TextStyle(fontSize: 18, color: const Color(0xFF9E9E9E)),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Projects will appear here once created',
//               style: TextStyle(fontSize: 12, color: const Color(0xFF9E9E9E)),
//             ),
//           ],
//         ),
//       )
//           : RefreshIndicator(
//         onRefresh: () async {
//           await Future.delayed(const Duration(seconds: 1));
//         },
//         child: ListView.builder(
//           controller: _scrollController,
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(12),
//           itemCount: projects.length,
//           itemBuilder: (context, index) {
//             final project = projects[index];
//             return _buildProjectCard(project, index);
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProjectCard(Map<String, dynamic> project, int index) {
//     Color statusColor;
//     try {
//       statusColor = Color(int.parse(project['statusColor'].replaceFirst('#', '0xff')));
//     } catch (e) {
//       statusColor = const Color(0xFF2196F3);
//     }
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade100,
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header Row
//                 Row(
//                   children: [
//                     // Avatar
//                     Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [Colors.green.shade400, Colors.green.shade600],
//                         ),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           project['customerName'][0],
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//
//                     // Customer Details
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             project['customerName'],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xDE000000),
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Row(
//                             children: [
//                               Icon(Icons.phone, size: 12, color: const Color(0xFF9E9E9E)),
//                               const SizedBox(width: 4),
//                               Text(
//                                 project['customerPhone'],
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   color: const Color(0xFF9E9E9E),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 2),
//                           Row(
//                             children: [
//                               Icon(Icons.email, size: 12, color: const Color(0xFF9E9E9E)),
//                               const SizedBox(width: 4),
//                               Text(
//                                 project['customerEmail'],
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   color: const Color(0xFF9E9E9E),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Project Details Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Project #${project['projectNo']}',
//                       style: TextStyle(fontSize: 11, color: const Color(0xFF9E9E9E)),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: statusColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         project['status'],
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w500,
//                           color: statusColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 // System Details
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade50,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.solar_power, size: 12, color: Colors.green),
//                           const SizedBox(width: 4),
//                           Text(
//                             project['systemSize'],
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.green.shade700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.shade50,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.grid_on, size: 12, color: Colors.orange),
//                           const SizedBox(width: 4),
//                           Text(
//                             '${project['noOfPanels']} Panels',
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.orange.shade700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Date and Created By
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.calendar_today, size: 10, color: const Color(0xFF9E9E9E)),
//                         const SizedBox(width: 4),
//                         Text(
//                           'Started: ${project['createdDate']}',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: const Color(0xFF9E9E9E),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                   ],
//                 ),
//
//                 const SizedBox(height: 12),
//                 const Divider(color: Color(0xFFE0E0E0)),
//                 const SizedBox(height: 12),
//
//                 // Project Journey Tracker
//                 _buildProjectJourney(project['projectStage']),
//
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Icon(Icons.fire_truck, size: 12, color: const Color(0xFF9E9E9E)),
//                     const SizedBox(width: 4),
//                     Text(
//                       'Expected Delivery Time : 6 Days',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                         color: const Color(0xFF9E9E9E),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(color: Color(0xFFE0E0E0)),
//                 const SizedBox(height: 12),
//
//                 // Amount and View Details
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Total Amount',
//                           style: TextStyle(fontSize: 11, color: const Color(0xFF9E9E9E)),
//                         ),
//                         Text(
//                           '₹${project['grandTotal']}',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                     TextButton(
//                       onPressed: () => _showProjectDetailsDialog(project),
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         minimumSize: const Size(0, 0),
//                       ),
//                       child: Text(
//                         'View Details',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: const Color(0xFF2196F3),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Popup Menu
//           // Positioned(
//           //   top: 8,
//           //   right: 8,
//           //   child: PopupMenuButton<String>(
//           //     color: Colors.white,
//           //     icon: Icon(Icons.more_vert, color: const Color(0xFF757575), size: 20),
//           //     itemBuilder: (BuildContext context) {
//           //       return [
//           //         const PopupMenuItem<String>(
//           //           value: "track",
//           //           child: Row(
//           //             children: [
//           //               Icon(Icons.track_changes, size: 16, color: Color(0xFF2196F3)),
//           //               SizedBox(width: 8),
//           //               Text('Track Project', style: TextStyle(fontSize: 12, color: Color(0xDE000000))),
//           //             ],
//           //           ),
//           //         ),
//           //         const PopupMenuItem<String>(
//           //           value: "edit",
//           //           child: Row(
//           //             children: [
//           //               Icon(Icons.edit, size: 16, color: Color(0xFFFF9800)),
//           //               SizedBox(width: 8),
//           //               Text('Edit Project', style: TextStyle(fontSize: 12, color: Color(0xDE000000))),
//           //             ],
//           //           ),
//           //         ),
//           //         const PopupMenuItem<String>(
//           //           value: "support",
//           //           child: Row(
//           //             children: [
//           //               Icon(Icons.support_agent, size: 16, color: Color(0xFF2196F3)),
//           //               SizedBox(width: 8),
//           //               Text('Support', style: TextStyle(fontSize: 12, color: Color(0xDE000000))),
//           //             ],
//           //           ),
//           //         ),
//           //       ];
//           //     },
//           //     onSelected: (String choice) {
//           //       if (choice == "track") {
//           //         _showTrackingDialog(project);
//           //       } else if (choice == "edit") {
//           //         _showEditDialog(project);
//           //       } else if (choice == "support") {
//           //         _showSupportDialog(project);
//           //       }
//           //     },
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProjectJourney(int currentStage) {
//     final List<Map<String, dynamic>> stages = [
//       {'label': 'At Warehouse', 'icon': Icons.warehouse, 'stage': 1},
//       {'label': 'Ready to Deliver', 'icon': Icons.inventory, 'stage': 2},
//       {'label': 'In Transit', 'icon': Icons.local_shipping, 'stage': 3},
//       {'label': 'Delivered', 'icon': Icons.home, 'stage': 4},
//     ];
//
//     return Row(
//       children: stages.asMap().entries.map((entry) {
//         int idx = entry.key;
//         var stage = entry.value;
//         bool isCompleted = currentStage > stage['stage'];
//         bool isCurrent = currentStage == stage['stage'];
//
//         return Expanded(
//           child: SizedBox(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     if (idx > 0)
//                       Expanded(
//                         child: Container(
//                           height: 2,
//                           color: isCompleted ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
//                         ),
//                       ),
//                     // Icon
//                     Container(
//                       width: 32,
//                       height: 32,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: isCompleted || isCurrent
//                             ? (isCompleted ? const Color(0xFF4CAF50) : const Color(0xFF2196F3))
//                             : const Color(0xFFE0E0E0),
//                       ),
//                       child: Icon(
//                         stage['icon'],
//                         size: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                     if (idx < stages.length - 1)
//                       Expanded(
//                         child: Container(
//                           height: 2,
//                           color: isCompleted ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
//                         ),
//                       ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 // Label
//                 Text(
//                   stage['label'],
//                   style: TextStyle(
//                     fontSize: 9,
//                     fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
//                     color: isCompleted || isCurrent ? const Color(0xFF2196F3) : const Color(0xFF9E9E9E),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   void _showFilterBottomSheet(BuildContext context) {
//     String? localSelectedStatus = _selectedStatus;
//     String? localSelectedUserType = _selectedUserType;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       builder: (context) => StatefulBuilder(
//         builder: (context, setStateSheet) {
//           return Container(
//             height: MediaQuery.of(context).size.height * 0.5,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: Column(
//               children: [
//                 // Handle Bar
//                 Container(
//                   margin: const EdgeInsets.only(top: 12),
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFE0E0E0),
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//
//                 // Header
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Filter Projects',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xDE000000),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.close, color: Color(0xFF9E9E9E)),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Status Dropdown
//                         const Text(
//                           'Order Status',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xDE000000),
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xFFE0E0E0)),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: DropdownButtonFormField<String>(
//                             value: localSelectedStatus,
//                             hint: const Text('Select Status', style: TextStyle(color: Color(0xFF9E9E9E))),
//                             isExpanded: true,
//                             items: statusTypes.map((status) {
//                               Color statusColor;
//                               switch (status['id']) {
//                                 case '1':
//                                   statusColor = const Color(0xFF2196F3);
//                                   break;
//                                 case '2':
//                                   statusColor = const Color(0xFFFF9800);
//                                   break;
//                                 case '3':
//                                   statusColor = const Color(0xFF9C27B0);
//                                   break;
//                                 default:
//                                   statusColor = const Color(0xFF4CAF50);
//                               }
//                               return DropdownMenuItem(
//                                 value: status['id'].toString(),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       width: 8,
//                                       height: 8,
//                                       decoration: BoxDecoration(
//                                         color: statusColor,
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(status['name']),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               setStateSheet(() {
//                                 localSelectedStatus = value;
//                               });
//                             },
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         const Text(
//                           'Select Project Type',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         MultiSelectDialogField(
//                           items:  [
//                             MultiSelectItem('Residential', 'Residential'),
//                             MultiSelectItem('Commercial', 'Commercial'),
//                             MultiSelectItem('Industrial', 'Industrial'),
//                           ],
//                           title: const Text('Select Project Type'),
//                           buttonText: const Text('Select Project Type'),
//                           buttonIcon: const Icon(Icons.business_center),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(12),
//                           ), onConfirm: (List<String> p1) {  },
//                         ),
//                         const SizedBox(height: 20),
//
//                         // Category Multi-Select
//                         const Text(
//                           'Select Category',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         MultiSelectDialogField(
//                           items:  [
//                             MultiSelectItem('Solar Rooftop', 'Solar Rooftop'),
//                             MultiSelectItem('Solar Pump', 'Solar Pump'),
//                             MultiSelectItem('Solar Light', 'Solar Light'),
//                           ],
//                           title: const Text('Select Category'),
//                           buttonText: const Text('Select Category'),
//                           buttonIcon: const Icon(Icons.category),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(12),
//                           ), onConfirm: (List<String> p1) {  },
//                         ),
//                         const SizedBox(height: 20),
//
//                         // Sub Category Multi-Select
//                         const Text(
//                           'Select Sub Category',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         MultiSelectDialogField(
//                           items:  [
//                             MultiSelectItem('Residential 3 to 10 KW', 'Residential 3 to 10 KW'),
//                             MultiSelectItem('Residential >3 KW', 'Residential >3 KW'),
//                             MultiSelectItem('Common Meter', 'Common Meter'),
//                           ],
//                           title: const Text('Select Sub Category'),
//                           buttonText: const Text('Select Sub Category'),
//                           buttonIcon: const Icon(Icons.subdirectory_arrow_right),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(12),
//                           ), onConfirm: (List<String> p1) {  },
//                         ),
//                         const SizedBox(height: 20),
//
//                         // Sub Project Type Multi-Select
//                         const Text(
//                           'Select Sub Project Type',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         MultiSelectDialogField(
//                           items:  [
//                             MultiSelectItem('Off Grid', 'Off Grid'),
//                             MultiSelectItem('On Grid', 'On Grid'),
//                             MultiSelectItem('Hybrid', 'Hybrid'),
//                           ],
//                           title: const Text('Select Sub Project Type'),
//                           buttonText: const Text('Select Sub Project Type'),
//                           buttonIcon: const Icon(Icons.electrical_services),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(12),
//                           ), onConfirm: (List<String> p1) {  },
//                         ),
//
//                         const SizedBox(height: 24),
//
//                         // User Type Dropdown
//
//
//                         const SizedBox(height: 32),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Apply and Clear Buttons
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFFE0E0E0),
//                         blurRadius: 10,
//                         offset: const Offset(0, -5),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {
//                             setStateSheet(() {
//                               localSelectedStatus = null;
//                               localSelectedUserType = null;
//                             });
//                           },
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             side: const BorderSide(color: Color(0xFFE0E0E0)),
//                           ),
//                           child: const Text('Clear All', style: TextStyle(color: Color(0xFF757575))),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               _selectedStatus = localSelectedStatus;
//                               _selectedUserType = localSelectedUserType;
//                               _filterCount = (localSelectedStatus != null ? 1 : 0) +
//                                   (localSelectedUserType != null ? 1 : 0);
//                             });
//                             Navigator.pop(context);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Filters applied'),
//                                 backgroundColor: Color(0xFF4CAF50),
//                                 behavior: SnackBarBehavior.floating,
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text('Apply Filters', style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _showProjectDetailsDialog(Map<String, dynamic> project) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.9,
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Project Summary',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF2196F3),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Panel Details
//               _buildDetailRow(
//                 '${project['noOfPanels']} Panel (${project['systemSize']})',
//                 '₹${project['amount']}/-',
//               ),
//               const SizedBox(height: 10),
//
//               // Charges Section (only for Loan files)
//               if (project['fileType'] != 'Cash') ...[
//                 _buildDetailRow(
//                   '- Structure & Installation Charges',
//                   '₹${int.parse(project['structureCharge']) + int.parse(project['installationCharge'])}/-',
//                   isSmall: true,
//                 ),
//                 const SizedBox(height: 6),
//                 _buildDetailRow(
//                   '- Add Your Margin',
//                   '₹${project['marginCharge']}/-',
//                   isSmall: true,
//                 ),
//                 const SizedBox(height: 10),
//               ],
//
//               const Divider(color: Color(0xFFE0E0E0)),
//
//               // Subsidy Amount
//               _buildDetailRow(
//                 'Total Subsidy Amount',
//                 '₹${project['mnreSubsidy']}/-',
//               ),
//               const SizedBox(height: 5),
//               const Text(
//                 '*This amount credited to customer bank account after meter installed',
//                 style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
//               ),
//
//               const Divider(color: Color(0xFFE0E0E0)),
//
//               // GST Amount
//               if (project['fileType'] != 'Cash' && project['gst'] != '0')
//                 _buildDetailRow(
//                   'GST Amount (${project['gst']}%)',
//                   '₹${project['gstAmount']}/-',
//                   valueColor: const Color(0xFF4CAF50),
//                 ),
//
//               if (project['fileType'] != 'Cash' && project['gst'] != '0')
//                 const Divider(color: Color(0xFFE0E0E0)),
//
//               // Total Amount
//               _buildDetailRow(
//                 'Total Pending Amount',
//                 '₹${project['grandTotal']}/-',
//                 isBold: true,
//                 valueColor: const Color(0xFF4CAF50),
//               ),
//
//               const SizedBox(height: 20),
//
//               // OK Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF2196F3),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text('OK', style: TextStyle(fontSize: 16, color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showTrackingDialog(Map<String, dynamic> project) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Track Project',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF2196F3),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFAFAFA),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     _buildTrackingRow('At Warehouse', project['createdDate'], project['projectStage'] >= 1),
//                     _buildTrackingRow('Ready to Deliver', project['createdDate'], project['projectStage'] >= 2),
//                     _buildTrackingRow('In Transit', 'Expected: ${project['createdDate']}', project['projectStage'] >= 3),
//                     _buildTrackingRow('Delivered', project['createdDate'], project['projectStage'] >= 4),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF2196F3),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   child: const Text('Close', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showEditDialog(Map<String, dynamic> project) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Edit Project',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2196F3)),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text('Edit project details feature coming soon!', style: TextStyle(color: Color(0xDE000000))),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close', style: TextStyle(color: Color(0xFF9E9E9E))),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showSupportDialog(Map<String, dynamic> project) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Customer Support',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2196F3)),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text('Need help with this project?', style: TextStyle(color: Color(0xDE000000))),
//             const SizedBox(height: 16),
//             ListTile(
//               leading: const Icon(Icons.phone, color: Color(0xFF2196F3)),
//               title: const Text('Call Support'),
//               subtitle: const Text('+91 1800 123 4567'),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.email, color: Color(0xFF2196F3)),
//               title: const Text('Email Support'),
//               subtitle: const Text('support@solarmarketplace.com'),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.chat, color: Color(0xFF2196F3)),
//               title: const Text('Live Chat'),
//               subtitle: const Text('Available 9 AM - 6 PM'),
//               onTap: () => Navigator.pop(context),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close', style: TextStyle(color: Color(0xFF9E9E9E))),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrackingRow(String title, String date, bool isCompleted) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Icon(
//             isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
//             color: isCompleted ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E),
//             size: 20,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
//                     color: isCompleted ? const Color(0xDE000000) : const Color(0xFF9E9E9E),
//                   ),
//                 ),
//                 if (isCompleted)
//                   Text(
//                     date,
//                     style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value, {
//     bool isSmall = false,
//     bool isBold = false,
//     Color? valueColor,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isSmall ? 11 : 14,
//             fontWeight: isBold ? FontWeight.w700 : (isSmall ? FontWeight.w400 : FontWeight.w500),
//             color: const Color(0xFF757575),
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isSmall ? 11 : 14,
//             fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
//             color: valueColor ?? const Color(0xFF757575),
//           ),
//         ),
//       ],
//     );
//   }
// }



// lib/view/projects_management_screen.dart
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../appColors.dart';
import '../constants.dart';

class ProjectsManagementScreen extends StatefulWidget {
  const ProjectsManagementScreen({super.key});

  @override
  State<ProjectsManagementScreen> createState() => _ProjectsManagementScreenState();
}

class _ProjectsManagementScreenState extends State<ProjectsManagementScreen> {
  List<Map<String, dynamic>> orders = [
    {
      'id': '1',
      'orderNo': 'ORD-2024-001',
      'customer': 'Green Energy Solutions',
      'customerName': 'Rahul Sharma',
      'mobile': '+91 98765 43210',
      'email': 'rahul@greenenergy.com',
      'amount': '4,50,000',
      'status': 'Payment Pending',
      'statusColor': '#FF9800',
      'date': '2024-03-20',
      'deliveryDate': '2024-04-05',
      'kw': '10',
      'panelCount': '24',
      'panelTech': 'Mono PERC',
      'comboType': 'Combo Kit',
      'grandTotal': '4,50,000',
      'orderStage': 0,
      'paymentCompleted': false,
    },
    {
      'id': '2',
      'orderNo': 'ORD-2024-002',
      'customer': 'Sun Power Systems',
      'customerName': 'Priya Mehta',
      'mobile': '+91 98765 43211',
      'email': 'priya@sunpower.com',
      'amount': '7,80,000',
      'status': 'Payment Pending',
      'statusColor': '#FF9800',
      'date': '2024-03-22',
      'deliveryDate': '2024-04-10',
      'kw': '15',
      'panelCount': '36',
      'panelTech': 'Mono PERC',
      'comboType': 'Premium Kit',
      'grandTotal': '7,80,000',
      'orderStage': 0,
      'paymentCompleted': false,
    },
    {
      'id': '3',
      'orderNo': 'ORD-2024-003',
      'customer': 'Eco Solar India',
      'customerName': 'Amit Desai',
      'mobile': '+91 98765 43212',
      'email': 'amit@ecosolar.com',
      'amount': '3,20,000',
      'status': 'Order Created',
      'statusColor': '#2196F3',
      'date': '2024-03-25',
      'deliveryDate': '2024-04-08',
      'kw': '5',
      'panelCount': '12',
      'panelTech': 'Poly Crystalline',
      'comboType': 'Basic Kit',
      'grandTotal': '3,20,000',
      'orderStage': 1,
      'paymentCompleted': true,
    },
    {
      'id': '4',
      'orderNo': 'ORD-2024-004',
      'customer': 'SolarTech Solutions',
      'customerName': 'Meera Shah',
      'mobile': '+91 98765 43213',
      'email': 'meera@solartech.com',
      'amount': '12,50,000',
      'status': 'At Warehouse',
      'statusColor': '#FF9800',
      'date': '2024-03-18',
      'deliveryDate': '2024-04-02',
      'kw': '20',
      'panelCount': '48',
      'panelTech': 'Mono PERC',
      'comboType': 'Heavy Duty Kit',
      'grandTotal': '12,50,000',
      'orderStage': 2,
      'paymentCompleted': true,
    },
    {
      'id': '5',
      'orderNo': 'ORD-2024-005',
      'customer': 'Shipped Order',
      'customerName': 'Vikram Singh',
      'mobile': '+91 98765 43214',
      'email': 'vikram@example.com',
      'amount': '6,80,000',
      'status': 'Ready to Deliver',
      'statusColor': '#9C27B0',
      'date': '2024-03-28',
      'deliveryDate': '2024-04-12',
      'kw': '12',
      'panelCount': '30',
      'panelTech': 'Mono PERC',
      'comboType': 'Premium Kit',
      'grandTotal': '6,80,000',
      'orderStage': 3,
      'paymentCompleted': true,
    },
    {
      'id': '6',
      'orderNo': 'ORD-2024-006',
      'customer': 'Delivered Order',
      'customerName': 'Neha Gupta',
      'mobile': '+91 98765 43215',
      'email': 'neha@example.com',
      'amount': '9,20,000',
      'status': 'In Transit',
      'statusColor': '#FF9800',
      'date': '2024-03-30',
      'deliveryDate': '2024-04-15',
      'kw': '15',
      'panelCount': '36',
      'panelTech': 'Mono PERC',
      'comboType': 'Heavy Duty Kit',
      'grandTotal': '9,20,000',
      'orderStage': 4,
      'paymentCompleted': true,
    },
    {
      'id': '7',
      'orderNo': 'ORD-2024-007',
      'customer': 'Delivered Order',
      'customerName': 'Rakesh Patel',
      'mobile': '+91 98765 43216',
      'email': 'rakesh@example.com',
      'amount': '11,50,000',
      'status': 'Delivered',
      'statusColor': '#4CAF50',
      'date': '2024-04-01',
      'deliveryDate': '2024-04-16',
      'kw': '18',
      'panelCount': '42',
      'panelTech': 'Mono PERC',
      'comboType': 'Premium Kit',
      'grandTotal': '11,50,000',
      'orderStage': 5,
      'paymentCompleted': true,
    },
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: const Text(
          'Projects Management',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.black87,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.white,
        elevation: 1,
        shadowColor: AppColors.shadowGrey.withOpacity(0.3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: orders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(
              'No orders yet',
              style: TextStyle(fontSize: 18, color: AppColors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Your orders will appear here',
              style: TextStyle(fontSize: 12, color: AppColors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderCard(order, index);
        },
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

  Widget _buildOrderCard(Map<String, dynamic> order, int index) {
    Color statusColor;
    try {
      statusColor = Color(int.parse(order['statusColor'].replaceFirst('#', '0xff')));
    } catch (e) {
      statusColor = AppColors.primaryBlue;
    }

    bool isPaymentPending = !order['paymentCompleted'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppDecorations.cardDecoration.copyWith(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: AppDecorations.avatarDecoration,
                      child: Center(
                        child: Text(
                          order['customerName'][0],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
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
                            order['customerName'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            order['customer'],
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 12, color: AppColors.grey),
                              const SizedBox(width: 4),
                              Text(
                                order['mobile'],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order['status'],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${order['orderNo']}',
                      style: TextStyle(fontSize: 11, color: AppColors.grey),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${order['kw']} KW | ${order['panelCount']} Panels',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryOrange,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 10, color: AppColors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Ordered: ${order['date']}',
                          style: TextStyle(fontSize: 10, color: AppColors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.local_shipping, size: 10, color: AppColors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Expected: ${order['deliveryDate']}',
                          style: TextStyle(fontSize: 10, color: AppColors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: AppColors.dividerGrey),
                const SizedBox(height: 12),

                if (isPaymentPending)
                  _buildPaymentSection(order)
                else
                  _buildOrderJourney(order['orderStage']),

                const SizedBox(height: 12),
                const Divider(color: AppColors.dividerGrey),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(fontSize: 11, color: AppColors.grey),
                        ),
                        Text(
                          '₹${order['grandTotal']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.successGreen,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => _showOrderDetailsDialog(order),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: PopupMenuButton<String>(
              color: AppColors.white,
              icon: Icon(Icons.more_vert, color: AppColors.darkGrey, size: 20),
              itemBuilder: (BuildContext context) {
                List<MapEntry<String, IconData>> items = [];

                if (isPaymentPending) {
                  items.add(const MapEntry('pay', Icons.payment));
                } else {
                  items.add(const MapEntry('track', Icons.track_changes));
                }
                items.add(const MapEntry('support', Icons.support_agent));

                if (!isPaymentPending && order['orderStage'] < 5) {
                  items.add(const MapEntry('cancel', Icons.cancel_outlined));
                }

                return items.map((item) {
                  IconData iconData = item.value;
                  String label = item.key;
                  Color iconColor = label == 'cancel' ? AppColors.errorRed :
                  (label == 'pay' ? AppColors.successGreen : AppColors.successGreen);

                  String displayText = label == 'pay' ? 'Pay Now' :
                  label == 'track' ? 'Track Order' :
                  label == 'cancel' ? 'Cancel Order' : 'Support';

                  return PopupMenuItem<String>(
                    value: label,
                    child: Row(
                      children: [
                        Icon(iconData, size: 16, color: iconColor),
                        const SizedBox(width: 8),
                        Text(
                          displayText,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
              onSelected: (String choice) {
                if (choice == "pay") {
                  _showPaymentDialog(order);
                } else if (choice == "track") {
                  _showTrackingDialog(order);
                } else if (choice == "cancel") {
                  _showCancelConfirmation(order);
                } else if (choice == "support") {
                  _showSupportDialog(order);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(Map<String, dynamic> order) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.secondaryOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.secondaryOrange.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondaryOrange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.payment,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Required',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                    ),
                    Text(
                      'Complete your payment to confirm the order',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showPaymentDialog(order);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderJourney(int currentStage) {
    final List<Map<String, dynamic>> stages = [
      {'label': 'Order Created', 'icon': Icons.check_circle_outline, 'stage': 1},
      {'label': 'At Warehouse', 'icon': Icons.warehouse, 'stage': 2},
      {'label': 'Will Deliver', 'icon': Icons.inventory_2, 'stage': 3},
      {'label': 'In Transit', 'icon': Icons.local_shipping, 'stage': 4},
      {'label': 'Delivered', 'icon': Icons.home, 'stage': 5},
    ];

    return Row(
      children: stages.asMap().entries.map((entry) {
        int idx = entry.key;
        var stage = entry.value;
        bool isCompleted = currentStage > stage['stage'];
        bool isCurrent = currentStage == stage['stage'];

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (idx > 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isCompleted ? AppColors.successGreen : AppColors.lightGrey,
                      ),
                    ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted || isCurrent
                          ? (isCompleted ? AppColors.successGreen : AppColors.successGreen)
                          : AppColors.lightGrey,
                    ),
                    child: Icon(
                      stage['icon'],
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  if (idx < stages.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isCompleted ? AppColors.successGreen : AppColors.lightGrey,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 70,
                child: Text(
                  stage['label'],
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted || isCurrent ? AppColors.successGreen : AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showPaymentDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Make Payment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.veryLightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Order Number', order['orderNo']),
                  _buildDetailRow('Customer', order['customerName']),
                  _buildDetailRow('Total Amount', '₹${order['grandTotal']}'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildPaymentMethod('UPI', Icons.qr_code),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPaymentMethod('Card', Icons.credit_card),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPaymentMethod('Net Banking', Icons.account_balance),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                order['paymentCompleted'] = true;
                order['status'] = 'Order Created';
                order['statusColor'] = '#2196F3';
                order['orderStage'] = 1;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment successful! Order confirmed.'),
                  backgroundColor: AppColors.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successGreen,
            ),
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColors.successGreen),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetailsDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.successGreen,
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Order Number', order['orderNo']),
              _buildDetailRow('Customer', order['customerName']),
              _buildDetailRow('Company', order['customer']),
              _buildDetailRow('Mobile', order['mobile']),
              _buildDetailRow('Email', order['email']),
              _buildDetailRow('Amount', '₹${order['amount']}'),
              _buildDetailRow('Status', order['status']),
              _buildDetailRow('Order Date', order['date']),
              _buildDetailRow('Expected Delivery', order['deliveryDate']),
              _buildDetailRow('System Size', '${order['kw']} KW'),
              _buildDetailRow('Panels', '${order['panelCount']} Panels'),
              _buildDetailRow('Panel Tech', order['panelTech']),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.successGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTrackingDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Track Order',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.successGreen,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.veryLightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildTrackingRow('Order Created', order['date'], order['orderStage'] >= 1),
                    _buildTrackingRow('At Warehouse', order['date'], order['orderStage'] >= 2),
                    _buildTrackingRow('Ready to Deliver', order['deliveryDate'], order['orderStage'] >= 3),
                    _buildTrackingRow('In Transit', order['deliveryDate'], order['orderStage'] >= 4),
                    _buildTrackingRow('Delivered', order['deliveryDate'], order['orderStage'] >= 5),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.successGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingRow(String title, String date, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? AppColors.successGreen : AppColors.grey,
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted ? AppColors.black87 : AppColors.grey,
                  ),
                ),
                if (isCompleted && title != 'Order Created')
                  Text(
                    date,
                    style: const TextStyle(fontSize: 10, color: AppColors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelConfirmation(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.white,
        title: const Text(
          'Cancel Order',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.errorRed),
        ),
        content: Text(
          'Are you sure you want to cancel order #${order['orderNo']}?',
          style: const TextStyle(color: AppColors.black87),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No', style: TextStyle(color: AppColors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order cancelled successfully!'), backgroundColor: AppColors.successGreen),
              );
            },
            child: const Text('Yes', style: TextStyle(color: AppColors.errorRed)),
          ),
        ],
      ),
    );
  }

  void _showSupportDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.white,
        title: const Text(
          'Customer Support',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Need help with your order?', style: TextStyle(color: AppColors.black87)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.phone, color: AppColors.primaryBlue),
              title: const Text('Call Support'),
              subtitle: const Text('+91 1800 123 4567'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppColors.primaryBlue),
              title: const Text('Email Support'),
              subtitle: const Text('support@solarmarketplace.com'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: AppColors.primaryBlue),
              title: const Text('Live Chat'),
              subtitle: const Text('Available 9 AM - 6 PM'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: AppColors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black87),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}