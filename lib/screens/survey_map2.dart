//
// import 'dart:math';
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter_google_street_view/flutter_google_street_view.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../appColors.dart';
// import '../constants.dart';
// import '../controller/survey_map_controller2.dart';
//
//
//
// class SurveyMap2 extends StatefulWidget {
//   SurveyMap2({super.key});
//
//   @override
//   State<SurveyMap2> createState() => _SurveyMap2State();
// }
//
// class _SurveyMap2State extends State<SurveyMap2> {
//
//   final SurveyMapController2 controller = Get.put(SurveyMapController2());
//
//   double screenWidth = 0.0;
//   int selecting = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//     return Scaffold(
//       drawer: drawer(),
//       appBar: AppBar(
//         title: const Text("Survey"),
//         actions: [
//           IconButton(
//             icon: Obx(() =>
//                 Icon(
//                   controller.showStreetView.value ? Icons.map : Icons
//                       .streetview,
//                 )),
//             onPressed: () => controller.showStreetView.toggle(),
//           ),
//         ],
//       ),
//       body: Obx(() =>
//       controller.showStreetView.value
//           ? _buildStreetView()
//           : _buildMapView()),
//       floatingActionButton: _buildFAB(),
//     );
//   }
//
//   Widget _buildFAB() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30, bottom: 8),
//       child: Obx(
//               () =>
//           !controller.isSelectingArea.value ?
//           controller.showStreetView.value
//               ? const SizedBox()
//               : FloatingActionButton(
//             heroTag: "whatspp",
//             foregroundColor: Colors.white,
//             backgroundColor: AppColors.primaryBlue,
//             onPressed: () {
//               if (controller.buildingNamecontrol.text == "") {
//                 // showCustomSnackBar(
//                 //     context, message: "Please Add Building First",
//                 //     backgroundColor: Colors.redAccent);
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Add Building First')));
//               }
//               else {
//                 controller.isSelectingArea.value = true;
//               }
//             },
//             child: const Text("Select\n Area"),
//           ) : SizedBox()
//       ),
//     );
//   }
//
//   Widget _buildStreetView() {
//     // return FlutterGoogleStreetView(
//     //   panningGesturesEnabled: true,
//     //   initPos: controller.pickedLocation.value,
//     //   onStreetViewCreated: (controller) {
//     //     this.controller.streetViewController = controller;
//     //   },
//     // );
//
//     return SizedBox();
//   }
//
//   Widget _buildMapView() {
//     return Column(
//       children: [
//         Expanded(
//           child: Stack(
//             children: [
//               Obx(() =>
//                   GoogleMap(
//                     zoomGesturesEnabled: true,
//                     zoomControlsEnabled: false,
//                     mapType: MapType.satellite,
//                     initialCameraPosition: CameraPosition(
//                       target: controller.pickedLocation.value,
//                       zoom: 14,
//                     ),
//                     onMapCreated: (controller) =>
//                     this.controller.mapController = controller,
//                     onTap: (argument) {
//                       if (controller.isDrawingHandRail.value) {
//                         // Check if tap is near any border
//                         for (int i = 0; i < controller.polygonPoints.length; i++) {
//                           final nextIndex = (i + 1) % controller.polygonPoints.length;
//                           if (controller.isPointNearBorder(
//                               argument,
//                               controller.polygonPoints[i],
//                               controller.polygonPoints[nextIndex]
//                           )) {
//                             controller.toggleBorderSelection(i);
//                             return;
//                           }
//                         }
//                       } else if (controller.isSelectingArea.value) {
//                         _handleMapTap(argument);
//                       }
//                       controller.pickedLocation.value = argument;
//                     },
//                     // the quick
//                     markers: _buildMarkers()
//                         .union(_buildWalkwayMarkers()),
//                     // polygons: _buildPolygons2().union(_buildWalkwayPolygons()),
//                     polygons: _buildPolygons2().union(_buildWalkwayPolygons()),
//                     polylines: _buildTerraceBorderPolylines().union(_buildHandRailPolylines()),
//                     // polylines: controller.polylines.union(
//                     //     _buildHandRailPolylines()),
//                   )),
//               Obx(() =>
//               controller.isSelectingArea.value
//                   ? _buildAreaControls()
//                   : const SizedBox()),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Obx(
//                         () {
//                       return controller.editingTerraceIndex.value != -1 ? Card(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 10, bottom: 8),
//                             child: Column(
//                               children: [
//
//                                 CupertinoSlidingSegmentedControl(
//                                   groupValue: controller.editingTerraceIndex.value != -1
//                                       ? (controller.savedTerraces[controller.editingTerraceIndex.value].isHorizontal
//                                       ? "H"
//                                       : controller.savedTerraces[controller.editingTerraceIndex.value].isAlternate
//                                       ? "A"
//                                       : "V")
//                                       : controller.selectedvalue.value,
//                                   thumbColor: AppColors.primaryBlue,
//                                   children: const {
//                                     "H": Text("H"),
//                                     "V": Text("V"),
//                                     "A": Text("A"),
//                                   },
//                                   onValueChanged: (value) {
//                                     final isHorizontal = value == "H";
//                                     final isAlternate = value == "A";
//
//                                     if (controller.editingTerraceIndex.value != -1) {
//                                       final index = controller.editingTerraceIndex.value;
//                                       final terrace = controller.savedTerraces[index];
//
//                                       controller.solarPanelsPolygons.clear();
//
//                                       final newCenters = controller.calculatePanelCenters(
//                                         terrace.areaPoints,
//                                         isHorizontal,
//                                         terrace.padding,
//                                         terrace.rowSpacing,
//                                         isAlternate: isAlternate,
//                                       );
//
//                                       // Update terrace with new orientation
//                                       controller.savedTerraces[index] = terrace.copyWith(
//                                         isHorizontal: isHorizontal,
//                                         isAlternate: isAlternate,
//                                         panels: newCenters,
//                                       );
//
//                                       // Update displayed panels
//                                       controller.solarPanelsPolygons.value = controller.convertCentersToPolygons(
//                                         newCenters,
//                                         isHorizontal,
//                                         isAlternate: isAlternate,
//                                       );
//                                     }
//                                   },
//                                 ),
//
//                                 SizedBox(height: 8,),
//                                 SizedBox(height: 0),
//                                 // Padding Slider - Add Obx wrapper
//                                 Text("Padding", style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 12)),
//                                 SizedBox(
//                                   height: 20,
//                                   width: 100,
//                                   child: Obx(() =>
//                                       Slider( // Wrap with Obx
//                                         label: "${controller.paddingSliderValue
//                                             .value.toInt()}m",
//                                         max: 2,
//                                         min: 0,
//                                         thumbColor: AppColors.primaryBlue,
//                                         divisions: 4,
//                                         value: controller.paddingSliderValue
//                                             .value,
//                                         onChangeEnd: (value) {
//                                           controller.solarPanelsPolygons
//                                               .clear();
//                                           controller.paddingSliderValue.value =
//                                               value;
//                                           // Update both preview and terrace config
//                                           controller.savedTerraces[controller
//                                               .editingTerraceIndex.value] =
//                                               controller
//                                                   .savedTerraces[controller
//                                                   .editingTerraceIndex.value]
//                                                   .copyWith(
//                                                   padding: value
//                                               );
//                                           controller.updatePanelPositions();
//                                           controller.saveEditedTerrace();
//                                           controller.startEditingTerrace(
//                                               selecting);
//                                         },
//                                         onChanged: (value) {
//                                           controller.paddingSliderValue.value =
//                                               value;
//                                         },
//                                       )),
//                                 ),
//
//                                 // Row Spacing Slider - Keep Obx but fix value handling
//                                 if(controller.terraceType.value != "Slant Roof")
//                                   Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text("Row Spacing", style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12)),
//                                       SizedBox(
//                                         height: 20,
//                                         width: 100,
//                                         child: Obx(() =>
//                                             Slider(
//                                               label: "${controller
//                                                   .rowSpacingSlidervalue.value
//                                                   .toStringAsFixed(1)}m",
//                                               max: controller.sliderLimit.value,
//                                               min: 0,
//                                               thumbColor: AppColors.primaryBlue,
//                                               divisions: 10,
//                                               //
//                                               value: controller
//                                                   .rowSpacingSlidervalue.value,
//                                               onChangeEnd: (value) {
//                                                 controller.solarPanelsPolygons
//                                                     .clear();
//                                                 controller.rowSpacingSlidervalue
//                                                     .value = value;
//                                                 // Update both preview and terrace config
//                                                 controller
//                                                     .savedTerraces[controller
//                                                     .editingTerraceIndex
//                                                     .value] =
//                                                     controller
//                                                         .savedTerraces[controller
//                                                         .editingTerraceIndex
//                                                         .value].copyWith(
//                                                         rowSpacing: value
//                                                     );
//                                                 controller.saveEditedTerrace();
//                                                 controller.startEditingTerrace(
//                                                     selecting);
//                                                 controller
//                                                     .updatePanelPositions();
//
//
//                                               },
//                                               onChanged: (value) {
//                                                 controller.rowSpacingSlidervalue
//                                                     .value = value;
//                                               },
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 SizedBox(height: 8,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     Text("Panels:",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12
//                                         )
//                                     ),
//                                     Obx(() =>
//                                         Text(
//                                           "${controller.savedTerraces[controller
//                                               .editingTerraceIndex.value].panels
//                                               .length}",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.black87
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                                 SizedBox(height: 5,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     Text("Kw:",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12
//                                         )
//                                     ),
//                                     Obx(() =>
//                                         Text(
//                                           "${controller.savedTerraces[controller
//                                               .editingTerraceIndex.value].panels
//                                               .length * 545 / 1000}",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.black87
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )
//                       ) : SizedBox();
//                     },
//                   ),
//                 ),
//
//               ),
//
//               Positioned(
//                   top: 10,
//                   left: 10,
//                   child: Obx(() =>
//                   controller.editingTerraceIndex.value != -1
//                       ? Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildWalkwayControls(),
//                       addGril(),
//                     ],
//                   )
//                       : SizedBox(),
//                   ) // ADD WALKWAY CONTROLS
//
//               ),
//
//               Positioned(
//                 top: MediaQuery
//                     .of(context)
//                     .size
//                     .height * 0.07,
//                 left: 10,
//                 child: Obx(() =>
//                 controller.editingWalkwayIndex.value != -1
//                     ? _buildWalkwayEditControls()
//                     : SizedBox(),
//                 ),
//               ),
//
//
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   void _createNewBuilding(BuildContext context) {
//     final TextEditingController nameController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Text("Create New Building"),
//             content: Form(
//               key: controller.tableStructureKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction, //
//                       controller: nameController,
//                       decoration: InputDecoration(
//                         hintText: "Enter building name",
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please Enter Building Name";
//                         }
//                         else {
//                           return null;
//                         }
//                       },
//                     ),
//                     SizedBox(height: 10,),
//                     DropdownButtonFormField<String>(
//                       hint: Text(
//                         "Required Kilowatt", style: TextStyle(fontSize: 14,),),
//                       items: [
//                         "10 to 50 kw",
//                         "50 to 100 kw",
//                         "100 to 150 kw",
//                         "150 to 200 kw"
//                       ].map((e) {
//                         return DropdownMenuItem<String>(child: Text(e),
//                           value: e,);
//                       },).toList(),
//                       onChanged: (value) {
//
//                       },),
//
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   controller.isSelectingArea.value = false;
//                   Navigator.pop(context);
//                 },
//                 child: Text("Cancel"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   bool isvalidate = controller.tableStructureKey.currentState
//                       ?.validate() ?? false;
//                   if (isvalidate) {
//                     controller.currentBuilding.value = nameController.text;
//                     controller.buildingNamecontrol.text = nameController.text;
//                     controller.isSelectingArea.value = true;
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text("Create"),
//               ),
//             ],
//           ),
//     );
//   }
//
//
//
//   void _handleTerraceTap(int index) {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             content: SizedBox(
//               width: double.maxFinite,
//               child: SingleChildScrollView(
//                 child: Obx(() {
//                   final buildingGroups = <String, List<Terrace>>{};
//
//                   // Group terraces by building
//                   controller.savedTerraces.forEach((terrace) {
//                     final building = controller.terraceBuildings[terrace.id] ??
//                         'Unassigned';
//                     buildingGroups[building] ??= [];
//                     buildingGroups[building]!.add(terrace);
//                   });
//
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ...buildingGroups.entries.map((entry) =>
//                           Column(
//                             children: [
//
//                               ...entry.value.map((terrace) {
//                                 return _buildExistingTerraceCard(
//                                     terrace, index);
//                               }),
//                             ],
//                           )),
//                     ],
//                   );
//                 }),
//               ),
//             ),
//           ),
//     );
//   }
//
//
//
//   Widget _buildExistingTerraceCard(Terrace terrace, int indexx) {
//     final controller = Get.find<SurveyMapController2>();
//     final index = controller.savedTerraces.indexWhere((t) =>
//     t.id == terrace.id);
//
//     if (index == -1) return SizedBox();
//
//     return index == indexx ? Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Card(
//           color: Colors.white,
//           elevation: 4,
//           margin: EdgeInsets.symmetric(vertical: 4),
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Terrace ${index + 1}", // Now using proper index
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.delete, size: 20, color: Colors.red),
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) =>
//                                   AlertDialog(
//                                     title: Text(
//                                         "Are you sure Want to Delete ?"),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.pop(context),
//                                         child: Text("No"),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           controller.solarPanelsPolygons.value
//                                               .clear();
//                                           controller.savedTerraces.removeAt(
//                                               index);
//                                           controller.terraceBuildings.remove(
//                                               terrace.id);
//                                           controller.calculateAllPanels();
//                                           Navigator.pop(context);
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text("Yes"),
//                                       ),
//                                     ],
//                                   ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Area:"),
//                     Obx(() =>
//                         Text(
//                           controller.showInMeters.value
//                               ? '${controller.calculatePolygonArea(terrace
//                               .areaPoints).toStringAsFixed(
//                               2)} m²' // Direct access
//                               : '${(controller.calculatePolygonArea(
//                               terrace.areaPoints) * 10.764).toStringAsFixed(
//                               2)} ft²',
//                         )),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Panels:"),
//                     Text("${terrace.panels.length}"), // Direct access
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Kw:"),
//                     Text("${(terrace.panels.length * 545) / 1000}"),
//                     // Direct access
//                   ],
//                 ),
//                 // In _buildExistingTerraceCard widget
//                 if (terrace.hasGril)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // hand rail in meter
//                       Text("Hand Rail:"),
//                       Text("${controller.calculateHandRailLength(
//                           terrace.handRailPoints).toStringAsFixed(2)}m"),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 8,),
//         Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(onPressed: () {
//                 // Navigator.pop(context);
//                 Navigator.pop(context);
//                 // Show structre table
//                 structureTableDilog();
//               },
//                 child: Text("Edit Structure Table"),
//                 style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5))
//                 ),),
//             ),
//           ],
//         ),
//
//         Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(onPressed: () {
//                 selecting = index;
//                 controller.startEditingTerrace(index);
//                 Navigator.pop(context);
//               }, child: Text("Edit Solar Panel Placement"),
//                   style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5)),
//                       foregroundColor: Colors.white,
//                       backgroundColor: AppColors.primaryBlue
//
//                   )
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(onPressed: () {
//                 showDialog(context: context, builder: (context) {
//                   return AlertDialog(
//                     content: Center(child: Text("BOM"),),
//                   );
//                 },);
//               }, child: Text("BOM"),
//                   style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5)),
//                       foregroundColor: Colors.white,
//                       backgroundColor: AppColors.primaryBlue
//
//                   )
//               ),
//             ),
//           ],
//         )
//       ],
//     ) : SizedBox();
//   }
//
//
//   Widget infoCard(){
//     return InkWell(
//       onTap : (){},
//       child: Card(
//         elevation : 10,
//         color : Colors.white,
//         child: Badge(
//             backgroundColor: Colors.red,
//             child: Text("Info")),
//       ),
//     );
//   }
//
//
//
//   Set<Polygon> _buildPolygons2() {
//     final Set<Polygon> allPolygons = {};
//     final controller = Get.find<SurveyMapController2>();
//
//     // 1. Current working terrace (yellow outline)
//     if (controller.polygonPoints.length >= 3 &&
//         controller.selectedBuilding.value.isEmpty) {
//       allPolygons.add(Polygon(
//
//         polygonId: const PolygonId('current_area'),
//         points: List<LatLng>.from(controller.polygonPoints),
//         strokeWidth: 4,
//         strokeColor: Colors.yellow,
//         fillColor: Colors.yellow.withOpacity(0.15),
//         consumeTapEvents: true,
//       ));
//     }
//
//     // 2. Highlighted borders (ONLY shown during active hand rail editing)
//     if (controller.isDrawingHandRail.value &&
//         controller.polygonPoints.length >= 3) {
//       final borderPoints = <LatLng>[];
//       List<int> selectedIndices = [];
//
//       if (controller.editingTerraceIndex.value != -1) {
//         selectedIndices = controller
//             .savedTerraces[controller.editingTerraceIndex.value]
//             .selectedBorderIndices;
//       }
//
//       for (int i = 0; i < controller.polygonPoints.length; i++) {
//         final nextIndex = (i + 1) % controller.polygonPoints.length;
//         if (selectedIndices.contains(i)) {
//           borderPoints.add(controller.polygonPoints[i]);
//           borderPoints.add(controller.polygonPoints[nextIndex]);
//         }
//       }
//
//     }
//
//     // 3. Saved terraces and their components (EXCLUDING hand rails)
//     controller.savedTerraces.asMap().forEach((index, terrace) {
//       final buildingName = controller.terraceBuildings[terrace.id] ?? 'Unassigned';
//
//       if (controller.selectedBuilding.value.isNotEmpty &&
//           controller.selectedBuilding.value != buildingName) {
//         return;
//       }
//
//       final isSelected = controller.selectedBuilding.value == buildingName;
//
//       // Terrace boundary (blue/green)
//       allPolygons.add(Polygon(
//         consumeTapEvents: true,
//         polygonId: PolygonId('terrace_$index'),
//         points: List<LatLng>.from(terrace.areaPoints),
//         strokeWidth: isSelected ? 4 : 3,
//         strokeColor: isSelected ? Colors.green : Colors.blue,
//         fillColor: isSelected
//             ? Colors.green.withOpacity(0.25)
//             : Colors.blue.withOpacity(0.15),
//         onTap: () {
//           if (controller.editingTerraceIndex.value == -1) {
//             _handleTerraceTap(index);
//             var orintetion = controller.isHorizontal.value;
//
//             controller.isHorizontal.value = terrace.isHorizontal;
//             controller.paddingSliderValue.value = terrace.padding;
//             controller.rowSpacingSlidervalue.value = terrace.rowSpacing;
//           }
//         },
//       ));
//
//       // Walkways (orange)
//       allPolygons.addAll(terrace.walkways.map((walkway) => Polygon(
//         polygonId: PolygonId(walkway.id),
//         points: walkway.points,
//         strokeWidth: 1,
//         strokeColor: Colors.deepOrange,
//         fillColor: Colors.deepOrange.withOpacity(0.5),
//         consumeTapEvents: true,
//       )));
//
//       // Solar panels
//       allPolygons.addAll(controller.convertCentersToPolygons(
//         terrace.panels,
//         terrace.isHorizontal,
//       ));
//     });
//
//     // 4. Current working panels if not editing
//     if (controller.editingTerraceIndex.value == -1 &&
//         controller.polygonPoints.length >= 3 &&
//         controller.selectedBuilding.value.isEmpty) {
//       allPolygons.addAll(controller.solarPanelsPolygons);
//     }
//
//     return allPolygons;
//   }
//
//
//   void _handleMapTap(LatLng argument) {
//     if (controller.isSelectingArea.value) {
//       if (controller.editingTerraceIndex.value != -1) return;
//
//       if (controller.polygonPoints.isEmpty) {
//         controller.currentHandRailPoints.clear();
//         controller.isDrawingHandRail.value = false;
//         controller.isHandRailComplete.value = false;
//
//       }
//
//       controller.polygonPoints.add(argument);
//       controller.updatePolygon();
//     }
//   }
//
//
//
//   void _handleMarkerDrag(int index, LatLng newPosition) {
//     controller.polygonPoints[index] = newPosition;
//     controller.updatePolygon(forceUpdate: true);
//   }
//
//
//   Widget _buildAreaControls() {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: Column(
//         children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     color: Colors.white.withOpacity(0.6),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Obx(
//                                     () =>
//                                     CupertinoSlidingSegmentedControl(
//                                       backgroundColor: Colors.white54,
//                                       thumbColor: AppColors.primaryBlue,
//                                       groupValue: controller.selectedmaserType
//                                           .value,
//                                       children: {
//                                         "m": Text("m²"),
//                                         "f": Text("ft²")
//                                       },
//                                       onValueChanged: (value) {
//                                         controller.selectedmaserType.value =
//                                         value!;
//                                         if (value == "m") {
//                                           controller.showInMeters.value = true;
//                                         } else {
//                                           controller.showInMeters.value = false;
//                                         }
//                                         controller.updatePolygon(
//                                             forceUpdate: true);
//                                       },),
//                               ),
//                               SizedBox(width: 12,),
//                               Obx(() =>
//                                   Text(
//                                     'Area: ${controller.showInMeters.value
//                                         ? '${controller.polygonArea
//                                         .toStringAsFixed(2)} m²'
//                                         : '${(controller.polygonArea.value *
//                                         10.764).toStringAsFixed(2)} ft²'}',
//                                     style: const TextStyle(fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   )),
//                               SizedBox(width: 12,),
//                               InkWell(
//                                 onTap: () {
//                                   controller.saveEditedTerrace();
//                                   controller.isSelectingArea.value = false;
//                                   controller.clearPolygon();
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(color: AppColors.primaryBlue,
//                                       borderRadius: BorderRadius.circular(5)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: Center(child: Icon(Icons.clear),),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   children: [
//                                     if (controller.editingTerraceIndex.value !=
//                                         -1)
//                                       IconButton(
//                                         icon: Icon(Icons.undo_outlined),
//                                         onPressed: () {
//                                           controller.polygonPoints.value =
//                                               List.from(controller
//                                                   .originalTerracePoints);
//                                           controller.updatePolygon();
//                                         },
//                                       ),
//                                     SizedBox(width: 8,),
//                                     // ... keep existing controls ...
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         if (controller.currentHandRailPoints.length >= 2) {
//                                           controller.finishDrawingHandRail();
//                                         }
//                                         if (controller.polygonPoints.length >= 3) {
//
//                                           if (controller.editingTerraceIndex.value != -1) {
//
//                                             controller.saveEditedTerrace();
//                                           } else {
//                                             structureTableDilog();
//                                           }
//                                           if (controller.polygonPoints
//                                               .isNotEmpty) {
//                                             final bounds = controller
//                                                 .getPolygonBounds(
//                                                 controller.polygonPoints
//                                             );
//
//                                           }
//                                         }
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.orange,
//                                         foregroundColor: Colors.white,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(
//                                                 5)),
//                                       ),
//
//                                       child: Text(
//                                         controller.editingTerraceIndex.value !=
//                                             -1
//                                             ? "Save Changes"
//                                             : "Show Panels",
//                                         style: TextStyle(color: Colors.white),),
//                                     ),
//                                     if (controller.editingTerraceIndex.value != -1)
//                                       TextButton(
//                                         onPressed: controller.cancelEditing,
//                                         child: Text("Cancel", style: TextStyle(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.w700),),
//                                       ),
//                                     SizedBox(width: 8,),
//
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget editHandrail(){
//     return controller.editingTerraceIndex.value != -1 ? Card(
//       clipBehavior: Clip.antiAlias,
//       margin: EdgeInsets.all(4),
//       semanticContainer: true,
//       surfaceTintColor: Colors.blue,
//       color: Colors.white10,
//       shadowColor: Colors.black,
//       elevation: 10,
//       borderOnForeground: true, shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Text("Select Border of Terrace For Hand Rail"),
//             SizedBox(height: 5,),
//             Row(
//                 children :
//                 [
//                   ElevatedButton(
//                       onPressed: () {
//                         // save the selected border
//                       }, child: Text("Save")),
//                   ElevatedButton(
//                       onPressed: () {
//                         // calcle editing
//                       }, child: Text("Cancle"))
//                 ]
//             ),
//           ],
//         ),
//       ),
//     ) : ElevatedButton(onPressed: () {}, child: Text("Add/Edit Hand rail"));
//   }
//
//
//
//   structureTableDilog() {
//     showDialog(context: context, builder: (context) {
//       return AlertDialog(
//         title: Text("Structure Table"),
//         content: Form(
//           key: controller.tableStructureKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               DropdownButtonFormField<String>(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please Select Terrace Type";
//                   }
//                   else {
//                     return null;
//                   }
//                 },
//                 decoration: InputDecoration(labelText: "Terrace Type"),
//                 hint: Text("Select Terrace type"),
//                 items: ["Rcc Roof", "Slant Roof","Ground Mountain"].map((e) {
//                   return DropdownMenuItem<String>(
//                     value: e,
//                     child: Text(e),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   if (value != null)
//                     controller.terraceType.value = value;
//                 },
//               ),
//               SizedBox(height: 10,),
//               Obx(
//                     () {
//                   return controller.terraceType.value == "Rcc Roof" ? Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       DropdownButtonFormField<String>(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Select Number of Row";
//                           }
//                           else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(labelText: "Number of Row"),
//                         hint: Text("1"),
//                         items: ["1", "2", "3", "4", "5", "6"].map((e) {
//                           return DropdownMenuItem<String>(
//                             value: e,
//                             child: Text(e),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           if (value != null) {
//                             controller.rowSpacingInterval.value =
//                                 int.parse(value);
//                             // controller.calculateSolarPanels();
//                             controller.calculateSolarPanels1();
//                           }
//                         },
//                       ),
//                       SizedBox(height: 10,),
//                       TextFormField(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (value) {
//                           if (value == "0" || value == null || value.isEmpty) {
//                             return "Please Enter Front Leg Height";
//                           }
//                           else {
//                             return null;
//                           }
//                         },
//                         readOnly: true,
//                         controller: controller.frontLegController,
//                         decoration: InputDecoration(
//                             suffixIcon: Column(
//                               children: [
//                                 InkWell(
//                                     onTap: () {
//                                       int val = int.tryParse(
//                                           controller.frontLegController.text) ??
//                                           0;
//                                       val += 1;
//                                       controller.frontLegController.text =
//                                           val.toString();
//                                     },
//                                     child: Icon(Icons.arrow_drop_up_outlined)),
//                                 InkWell(
//                                     onTap: () {
//                                       int val = int.tryParse(
//                                           controller.frontLegController.text) ??
//                                           0;
//                                       val -= 1;
//                                       if (val <= 0) {
//                                         val = 0;
//                                       }
//                                       controller.frontLegController.text =
//                                           val.toString();
//                                     },
//                                     child: Icon(
//                                         Icons.arrow_drop_down_outlined)),
//                               ],
//                             ),
//                             labelText: "FrontLeg Height",
//                             border: OutlineInputBorder()),
//                       ),
//                       SizedBox(height: 10,), //
//                       TextFormField(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (value) {
//                           if (value == "0" || value == null || value.isEmpty) {
//                             return "Please Enter Back Leg Height";
//                           }
//                           else {
//                             return null;
//                           }
//                         },
//                         readOnly: true,
//                         controller: controller.backLegController,
//                         decoration: InputDecoration(
//                             suffixIcon: Column(
//                               children: [
//                                 InkWell(
//                                     onTap: () {
//                                       int val = int.tryParse(
//                                           controller.backLegController.text) ??
//                                           0;
//                                       val += 1;
//                                       controller.backLegController.text =
//                                           val.toString();
//                                       controller.sliderLimit.value = val * 1.5;
//                                     },
//                                     child: Icon(Icons.arrow_drop_up_outlined)),
//                                 InkWell(
//                                     onTap: () {
//                                       int val = int.tryParse(
//                                           controller.backLegController.text) ??
//                                           0;
//                                       val -= 1;
//                                       if (val <= 0) {
//                                         val = 0;
//                                       }
//                                       controller.backLegController.text =
//                                           val.toString();
//                                       controller.sliderLimit.value = val * 1.5;
//                                     },
//                                     child: Icon(
//                                         Icons.arrow_drop_down_outlined)),
//                               ],
//                             ),
//                             labelText: "BackLeg Height",
//                             border: OutlineInputBorder()),
//                       ),
//                     ],
//                   ) :
//                   controller.terraceType.value == "Slant Roof"  ?  Column(
//                     children: [
//                       DropdownButtonFormField<String>(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//
//                         decoration: InputDecoration(labelText: "Walkway Width"),
//                         // hint: Text("1"),
//                         items: [
//                           "270",
//                           "273",
//                           "305",
//                           "310",
//                           "350",
//                           "400",
//                           "500",
//                         ].map((e) {
//                           return DropdownMenuItem<String>(
//                             value: e,
//                             child: Text("$e MM"),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           if (value != null) {
//                             controller.selectedWalkwayWidth.value = value;
//                           }
//                         },
//                       ),
//                       SizedBox(height: 10,),
//                       DropdownButtonFormField<String>(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         decoration: InputDecoration(
//                             labelText: "Walkway Thickness"),
//                         // hint: Text("1"),
//                         items: ["25", "30", "38", "40"].map((e) {
//                           return DropdownMenuItem<String>(
//                             value: e,
//                             child: Text("$e MM"),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//
//                         },
//                       ),
//                     ],
//                   ) : Column(
//                     children: [
//                       Text("Ground mountain")
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () {
//             Navigator.pop(context);
//             controller.saveEditedTerrace();
//           }, child: Text("Cancle")),
//           SizedBox(width: 10,),
//           TextButton(onPressed: () {
//             bool isValidate = controller.tableStructureKey.currentState
//                 ?.validate() ?? false;
//             if (isValidate) {
//               controller.calculateSolarPanels1();
//               controller.saveCurrentTerrace();
//               Navigator.pop(context);
//
//
//               // navigator.push
//               // navigator.pop(context);
//             }
//           }, child: Text("Show Panels"))
//         ],
//       );
//     },);
//   }
//
//
//   _handleWhatsapp() {
//     // Implement whatsapp functionality
//     showDialog(context: context, builder: (context) {
//       return AlertDialog(
//         title: Text("Location"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Get Current Location of Coustmer From Whatsapp"),
//             SizedBox(height: 10,),
//             TextFormField(
//               maxLength: 10,
//               keyboardType: TextInputType.number,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               onChanged: (value) {},
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please Enter Whatsapp Number';
//                 } else if (value.length < 10) {
//                   return 'Please Enter Whatsapp Number';
//                 } else
//                   return null;
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(2.0),
//                   borderSide: BorderSide(
//                     color: Colors.grey,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(2.0),
//                   borderSide: BorderSide(
//                     color: Colors.grey,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(2.0),
//                   borderSide: BorderSide(
//                     color: Colors.blue,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                 labelText: 'Enter Whatsapp Number',
//                 contentPadding:
//                 EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15),
//               ),
//             ),
//             SizedBox(height: 10,),
//             ElevatedButton(onPressed: () {
//               controller.requestLocation();
//             },
//               child: Text("Get From Whatsapp"),
//               style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5))
//               ),)
//           ],
//         ),
//       );
//     },);
//   }
//
//
//   Widget drawer() {
//     return Drawer(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//       width: screenWidth * 0.5,
//       elevation: 8,
//       shadowColor: Colors.grey,
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(
//                       Icons.arrow_back, color: Colors.black, size: 30,)),
//                 SizedBox(height: 8,),
//                 Text("Pradeep sign",
//                   style: TextStyle(fontWeight: FontWeight.bold),),
//                 Text("+91 8793207849"),
//                 SizedBox(height: 15,),
//                 // Dropdown project type
//                 SizedBox(
//                   width: screenWidth * 0.4,
//                   child: DropdownButtonFormField<String>(
//                     hint: Text("ProjectType", style: TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),),
//                     items: ["Residencial", "commercial"].map((e) {
//                       return DropdownMenuItem<String>(child: Text(e),
//                         value: e,);
//                     },).toList(),
//                     onChanged: (value) {
//
//                     },),
//                 ),
//                 SizedBox(height: 8,),
//                 SizedBox(
//                   width: screenWidth * 0.4,
//                   child: DropdownButtonFormField<String>(
//                     hint: Text("Technology", style: TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),),
//                     items: ["Bifacial", "Topcon"].map((e) {
//                       return DropdownMenuItem<String>(child: Text(e),
//                         value: e,);
//                     },).toList(),
//                     onChanged: (value) {
//
//                     },),
//                 ),
//                 SizedBox(height: 8,),
//                 SizedBox(
//                   width: screenWidth * 0.4,
//                   child: DropdownButtonFormField<String>(
//                     hint: Text("Panel watt", style: TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),),
//                     items: ["540", "575"].map((e) {
//                       return DropdownMenuItem<String>(child: Text(e),
//                         value: e,);
//                     },).toList(),
//                     onChanged: (value) {
//
//                     },),
//                 ),
//                 SizedBox(height: 8,),
//                 SizedBox(
//                   width: screenWidth * 0.4,
//                   child: DropdownButtonFormField<String>(
//                     hint: Text("Kilowatt", style: TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),),
//                     items: ["2.27", "3.24", "4.20", "5.25"].map((e) {
//                       return DropdownMenuItem<String>(child: Text("${e} KW",),
//                         value: e,);
//                     },).toList(), onChanged: (value) {
//
//                   },),
//                 ),
//                 SizedBox(height: 8,),
//                 ElevatedButton(
//                   onPressed: () => _createNewBuilding(context),
//                   // Connect to building creation
//                   child: Text("New Building"),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                   ),
//                 ),
//                 Expanded(
//                   child: Obx(() {
//                     final buildingData = <String, double>{};
//
//                     controller.savedTerraces.forEach((terrace) {
//                       final buildingName = controller.terraceBuildings[terrace
//                           .id] ?? 'Unassigned';
//                       final kw = (terrace.panels.length * 545) / 1000;
//                       buildingData[buildingName] =
//                           (buildingData[buildingName] ?? 0) + kw;
//                     });
//
//                     return ListView(
//                       children: [
//                         ...buildingData.entries.map((entry) =>
//                             Card(
//                               elevation: 8,
//                               color: controller.selectedBuilding.value ==
//                                   entry.key
//                                   ? Colors.blue[100]
//                                   : Colors.white,
//                               child: InkWell(
//                                 onTap: () {
//                                   print("Entery.key ${entry.key}");
//                                   controller.toggleBuildingSelection(entry
//                                       .key); // show only selected building terraces
//                                 },
//                                 child: ListTile(
//                                   title: Text(entry.key),
//                                   subtitle:
//                                   Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text.rich(
//                                         TextSpan(
//                                           children: [
//                                             TextSpan(text: "${entry.value
//                                                 .toStringAsFixed(2)}KW"),
//                                             TextSpan(text: "\nRequired Kw : 50",
//                                                 style: TextStyle(
//                                                     color: Colors.green)),
//                                           ],
//                                         ),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment
//                                             .spaceEvenly,
//                                         children: [
//                                           InkWell(
//                                               onTap: () {
//                                                 _deleteBuilding(entry.key);
//                                               },
//                                               child: Icon(Icons.delete,
//                                                 color: Colors.red,)),
//                                           InkWell(
//                                               onTap: () {
//                                                 // show dilog here
//                                                 _showBuildingTerracesDialog(
//                                                     entry.key);
//                                               },
//
//                                               child: Icon(Icons.edit,
//                                                 color: Colors.blueAccent,)),
//                                           InkWell(
//                                             onTap: () {
//
//                                             },
//                                             child: Card(
//                                                 color: AppColors.primaryBlue,
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       5.0),
//                                                   child: Text("BOM",
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.white),),
//                                                 )),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//
//                                 ),
//                               ),
//                             )),
//                       ],
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   void _showBuildingTerracesDialog(String buildingName) {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Text("Terraces in $buildingName"),
//             content: SizedBox(
//               width: double.maxFinite,
//               child: SingleChildScrollView(
//                 child: Obx(() {
//                   // Filter terraces belonging to this building
//                   final buildingTerraces = controller.savedTerraces.where(
//                           (terrace) =>
//                       controller.terraceBuildings[terrace.id] == buildingName
//                   ).toList();
//
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//
//                       if (buildingTerraces.isEmpty)
//                         const Text("No terraces found"),
//                       DropdownButtonFormField<String>(
//                         hint: Text("Required Kilowatt",
//                           style: TextStyle(fontSize: 14,),),
//                         items: [
//                           "10 to 50 kw",
//                           "50 to 100 kw",
//                           "100 to 150 kw",
//                           "150 to 200 kw"
//                         ].map((e) {
//                           return DropdownMenuItem<String>(
//                             child: Text(e), value: e,);
//                         },).toList(),
//                         onChanged: (value) {
//
//                         },),
//                       ...buildingTerraces.map((terrace) {
//                         final index = controller.savedTerraces.indexOf(terrace);
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Terrace ${index + 1}",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         color: Colors.blue[700],
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.delete, size: 20,
//                                           color: Colors.red),
//                                       onPressed: () {
//                                         controller.savedTerraces.removeAt(
//                                             index);
//                                         controller.terraceBuildings.remove(
//                                             terrace.id);
//                                         controller.calculateAllPanels();
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     const Text("Area:"),
//                                     Obx(() =>
//                                         Text(
//                                           controller.showInMeters.value
//                                               ? '${controller
//                                               .calculatePolygonArea(
//                                               terrace.areaPoints)
//                                               .toStringAsFixed(2)} m²'
//                                               : '${(controller
//                                               .calculatePolygonArea(
//                                               terrace.areaPoints) * 10.764)
//                                               .toStringAsFixed(2)} ft²',
//                                         )),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     const Text("Panels:"),
//                                     Text("${terrace.panels.length}"),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     const Text("Kw:"),
//                                     Text("${(terrace.panels.length * 545) /
//                                         1000}"),
//                                   ],
//                                 ),
//                                 if(terrace.hasGril)
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text("Hand Rail"),
//                                       Text("${controller.calculateHandRailLength(
//                                           terrace.handRailPoints).toStringAsFixed(2)}m")
//                                     ],
//                                   )
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                     ],
//                   );
//                 }),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Close"),
//               ),
//             ],
//           ),
//     );
//   }
//
//   void _deleteBuilding(String buildingName) {
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Text("Delete Building?"),
//             content: Text(
//                 "Are you sure you want to delete '$buildingName' and all its terraces?"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("Cancel"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // Remove all terraces belonging to this building
//                   controller.savedTerraces.removeWhere((terrace) {
//                     final terraceBuilding = controller.terraceBuildings[terrace
//                         .id] ?? '';
//                     if (terraceBuilding == buildingName) {
//                       // Also remove the building association
//                       controller.terraceBuildings.remove(terrace.id);
//                       return true;
//                     }
//                     return false;
//                   });
//
//                   // Clear selection if it was this building
//                   if (controller.selectedBuilding.value == buildingName) {
//                     controller.selectedBuilding.value = '';
//                   }
//
//                   // Recalculate panels
//                   controller.calculateAllPanels();
//
//                   Navigator.pop(context);
//                 },
//                 child: Text("Delete", style: TextStyle(color: Colors.red)),
//               ),
//             ],
//           ),
//     );
//   }
//
//   Widget addGril() {
//     final controller = Get.find<SurveyMapController2>();
//
//     return Obx(() {
//       if (controller.terraceType.value != "Slant Roof") return SizedBox();
//
//       return Column(
//         children: [
//           if (controller.isDrawingHandRail.value)
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text("Tap borders in order to create hand rail",
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     SizedBox(height: 8),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: controller.finishDrawingHandRail,
//                           child: Text("Save"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () {
//                             controller.isDrawingHandRail.value = false;
//                             controller.currentHandRailPoints.clear();
//                           },
//                           child: Text("Cancel"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           // if (!controller.isDrawingHandRail.value)
//           //   ElevatedButton(
//           //     onPressed: controller.startDrawingHandRail,
//           //     child: Text("Add/Edit Hand Rail"),
//           //     style: ElevatedButton.styleFrom(
//           //       foregroundColor: Colors.white,
//           //       backgroundColor: AppColors.primaryBlue,
//           //     ),
//           //   ),
//         ],
//       );
//     });
//   }
//
//   // code for walk way
//   Widget _buildWalkwayControls() {
//     final controller = Get.find<SurveyMapController2>();
//
//     return Obx(() {
//       if (controller.terraceType.value != "Slant Roof") return SizedBox();
//
//       return Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               controller.addWalkway();
//               controller.updatePanelPositions();
//             },
//             child: Text("Add Walkway"),
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.white,
//               backgroundColor: AppColors.primaryBlue,
//             ),
//           ),
//
//           // if (controller.editingWalkwayIndex.value != -1)
//           //   _buildWalkwayEditControls(),
//         ],
//       );
//     });
//   }
//
//
//   Widget _buildWalkwayEditControls() {
//     final controller = Get.find<SurveyMapController2>();
//
//     return Obx(() {
//       if (controller.editingWalkwayIndex.value < 0 ||
//           controller.editingWalkwayIndex.value >=
//               controller.currentWalkways.length) {
//         return SizedBox();
//       }
//
//       final index = controller.editingWalkwayIndex.value;
//       final walkway = controller.currentWalkways[index];
//       final isHorizontal = walkway.isHorizontal;
//
//       // Calculate max length based on terrace dimensions
//       double maxLength;
//       if (walkway.isHorizontal) {
//         // For horizontal walkways, max length is terrace width
//         final terrace = controller.savedTerraces[controller.editingTerraceIndex.value];
//         final bounds = controller.getPolygonBounds(terrace.areaPoints);
//         maxLength = (bounds.northeast.longitude - bounds.southwest.longitude) *
//             111111 * cos(bounds.southwest.latitude * pi / 180);
//       } else {
//         // For vertical walkways, max length is terrace height
//         final terrace = controller.savedTerraces[controller.editingTerraceIndex.value];
//         final bounds = controller.getPolygonBounds(terrace.areaPoints);
//         maxLength = (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
//       }
//
//       // Ensure reasonable bounds
//       final minLength = 1.0;
//       maxLength = max(minLength * 1.1, maxLength); // Ensure max > min
//       final currentLength = walkway.length.clamp(minLength, maxLength);
//
//       return Card(
//         child: Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 8,right: 8,left: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Walkway ${index + 1}", style: TextStyle(fontSize: 14)),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8),
//
//
//               Padding(
//                 padding: const EdgeInsets.only(top: 0,right: 8,left: 8),
//                 child: Text("Length: ${walkway.length.toStringAsFixed(2)}m"),
//               ),
//               SizedBox(
//                 height: 50,
//                 width: 120,
//                 child: Slider(
//                   thumbColor: AppColors.primaryBlue,
//                   min: minLength,
//                   max: maxLength,
//                   value: currentLength,
//                   onChanged: (value) {
//                     controller.updateWalkwayLength(index, value);
//                   },
//                 ),
//               ),
//
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(width: 15,),
//                   CupertinoSlidingSegmentedControl(
//                     thumbColor: AppColors.primaryBlue,
//                     groupValue: isHorizontal ? "H" : "V",
//                     children: {"H": Text("H"), "V": Text("V")},
//                     onValueChanged: (value) {
//                       controller.toggleWalkwayOrientation(index);
//                       controller.updatePanelPositions();
//                     },
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.only(top: 0,right: 8,left: 8),
//                 child: Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       controller.removeWalkway(index);
//                       controller.editingWalkwayIndex.value = -1;
//                       controller.updatePanelPositions();
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         foregroundColor: Colors.white
//                     ),
//                     child: Text("Delete"),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//
//   Set<Polyline> _buildTerraceBorderPolylines() {
//     final controller = Get.find<SurveyMapController2>();
//     final polylines = <Polyline>{};
//
//     if (controller.polygonPoints.length >= 2) {
//       final points = List<LatLng>.from(controller.polygonPoints);
//       if (points.length >= 3 && points.first == points.last) {
//         points.removeLast();
//       }
//
//       // Only show special border styling during ACTIVE hand rail editing
//       if (controller.isDrawingHandRail.value) {
//         List<int> selectedIndices = [];
//         if (controller.editingTerraceIndex.value != -1) {
//           selectedIndices = controller
//               .savedTerraces[controller.editingTerraceIndex.value]
//               .selectedBorderIndices;
//         }
//
//         for (int i = 0; i < points.length; i++) {
//           final isSelected = selectedIndices.contains(i);
//           polylines.add(Polyline(
//             polylineId: PolylineId('terrace_border_$i'),
//             points: [points[i], points[(i + 1) % points.length]],
//             color: isSelected ? Colors.black : Colors.transparent, // Only show selected borders in black
//             width: isSelected ? 6 : 0,
//             consumeTapEvents: true,
//             onTap: () => controller.toggleBorderSelection(i),
//           ));
//         }
//       } else {
//         // Normal border styling (no hand rail editing)
//         for (int i = 0; i < points.length; i++) {
//           polylines.add(Polyline(
//             polylineId: PolylineId('terrace_border_$i'),
//             points: [points[i], points[(i + 1) % points.length]],
//             color: Colors.white.withOpacity(0.7), // Default white border
//             width: 2,
//             consumeTapEvents: false,
//           ));
//         }
//       }
//     }
//     return polylines;
//   }
//
//
//   Set<Polyline> _buildHandRailPolylines() {
//     final controller = Get.find<SurveyMapController2>();
//     final polylines = <Polyline>{};
//
//     // Draw each selected border as a separate segment
//     for (int i = 0; i < controller.currentHandRailPoints.length; i += 2) {
//       if (i + 1 < controller.currentHandRailPoints.length) {
//         polylines.add(Polyline(
//           polylineId: PolylineId('handrail_${i~/2}'),
//           points: [
//             controller.currentHandRailPoints[i],
//             controller.currentHandRailPoints[i+1]
//           ],
//           color: Colors.black,
//           width: 5,
//         ));
//       }
//     }
//
//     return polylines;
//   }
//
//
//   Set<Polygon> _buildWalkwayPolygons() {
//     final controller = Get.find<SurveyMapController2>();
//     final polygons = <Polygon>{};
//
//     for (final walkway in controller.currentWalkways) {
//       polygons.add(walkway.toPolygon());
//     }
//
//     return polygons;
//   }
//
//
//   LatLng _getWalkwayEndPoint(Walkway walkway) {
//     if (walkway.points.isEmpty) return LatLng(0, 0);
//
//     // For horizontal walkways, find midpoint of right edge
//     if (walkway.isHorizontal) {
//       // Points 1 and 2 are the right edge (assuming standard polygon creation order)
//       final p1 = walkway.points[1];
//       final p2 = walkway.points[2];
//       return LatLng(
//         (p1.latitude + p2.latitude) / 2,
//         (p1.longitude + p2.longitude) / 2,
//       );
//     }
//     // For vertical walkways, find midpoint of top edge
//     else {
//       // Points 0 and 1 are the top edge
//       final p1 = walkway.points[0];
//       final p2 = walkway.points[1];
//       return LatLng(
//         (p1.latitude + p2.latitude) / 2,
//         (p1.longitude + p2.longitude) / 2,
//       );
//     }
//   }
//
//   // testing
//   Set<Marker> _buildWalkwayMarkers() {
//     final controller = Get.find<SurveyMapController2>();
//     final markers = <Marker>{};
//
//     for (int i = 0; i < controller.currentWalkways.length; i++) {
//       final walkway = controller.currentWalkways[i];
//
//       // Find the midpoint of the "end edge" of the walkway
//       final endPoint = _getWalkwayEndPoint(walkway);
//
//       markers.add(Marker(
//         markerId: MarkerId('walkway_${walkway.id}'),
//         position: endPoint,
//         icon: controller.walkWayIcon.value,
//         draggable: true,
//         infoWindow: InfoWindow(
//           title: 'Walkway ${i + 1}',
//           snippet: 'Tap to edit',
//           onTap: () {
//             controller.editingWalkwayIndex.value = i;
//             controller.update();
//           },
//         ),
//         onDragStart: (value) {
//           HapticFeedback.vibrate();
//           controller.editingWalkwayIndex.value = i;
//         },
//         onDrag: (newPosition) {
//           // Calculate translation needed
//           final translation = LatLng(
//             newPosition.latitude - endPoint.latitude,
//             newPosition.longitude - endPoint.longitude,
//           );
//
//           // Apply same translation to all points
//           final newPoints = walkway.points.map((point) => LatLng(
//             point.latitude + translation.latitude,
//             point.longitude + translation.longitude,
//           )).toList();
//
//           controller.updateWalkwayPoints(i, newPoints);
//           controller.updatePanelPositions();
//         },
//         onDragEnd: (value) {
//           controller.updatePanelPositions();
//         },
//       ));
//     }
//
//     return markers;
//   }
//
//
//   Set<Marker> _buildMarkers() {
//     final controller = Get.find<SurveyMapController2>();
//     final markers = <Marker>{};
//
//     // Always show location marker
//     if(!controller.isSelectingArea.value){
//       markers.add(
//           Marker(
//             markerId: MarkerId("PickLocation"),
//             position: controller.pickedLocation.value,
//             icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//           ));
//     }
//     // Always show distance markers
//     markers.addAll(controller.distanceMarkers);
//
//     // Always show draggable boundary markers (your original functionality)
//     markers.addAll(controller.polygonPoints.asMap().entries.map((entry) {
//       final index = entry.key;
//       final point = entry.value;
//       return Marker(
//         draggable: true,
//         onDragStart: (_) => HapticFeedback.vibrate(),
//         onDrag: (newPosition) {
//           controller.polygonPoints[index] = newPosition;
//           controller.updatePolygon(forceUpdate: true);
//         },
//         onDragEnd: (newPosition) => _handleMarkerDrag(index, newPosition),
//         markerId: MarkerId('polygon_point_$index'),
//         position: point,
//         icon: controller.boundaryIcon.value, // Your original boundary icon
//         infoWindow: InfoWindow(
//           title: 'Point ${index + 1} ✖',
//           onTap: () {
//             controller.polygonPoints.removeAt(index);
//             controller.updatePolygon();
//           },
//         ),
//       );
//     }));
//
//     return markers;
//   }
//
// }
//
//
//
//


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../appColors.dart';
import '../constants.dart';
import '../controller/survey_map_controller2.dart';

class SurveyMap2 extends StatefulWidget {
  SurveyMap2({super.key});

  @override
  State<SurveyMap2> createState() => _SurveyMap2State();
}

class _SurveyMap2State extends State<SurveyMap2> {
  final SurveyMapController2 controller = Get.put(SurveyMapController2());

  double screenWidth = 0.0;
  int selecting = 0;


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: const Text("Survey"),
        actions: [
          IconButton(
            icon: Obx(() => Icon(controller.showStreetView.value ? Icons.map : Icons.streetview)),
            onPressed: () => controller.showStreetView.toggle(),
          ),
        ],
      ),
      body: Obx(() => controller.showStreetView.value ? _buildStreetView() : _buildMapView()),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildFAB() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 8),
      child: Obx(() => !controller.isSelectingArea.value
          ? (controller.showStreetView.value
          ? const SizedBox()
          : FloatingActionButton(
        heroTag: "whatspp",
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryBlue,
        onPressed: () {
          if (controller.buildingNamecontrol.text == "") {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Please Add Building First')));
          } else {
            controller.isSelectingArea.value = true;
          }
        },
        child: const Text("Select\n Area"),
      ))
          : const SizedBox()),
    );
  }

  Widget _buildStreetView() {
    return const SizedBox(); // Street view placeholder
  }

  Widget _buildMapView() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Obx(() => GoogleMap(
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.satellite,
                initialCameraPosition: CameraPosition(
                  target: controller.pickedLocation.value,
                  zoom: 14,
                ),
                onMapCreated: (mapCtrl) => controller.mapController = mapCtrl,
                onTap: (argument) {
                  if (controller.isDrawingHandRail.value) {
                    for (int i = 0; i < controller.polygonPoints.length; i++) {
                      final nextIndex = (i + 1) % controller.polygonPoints.length;
                      if (controller.isPointNearBorder(
                          argument,
                          controller.polygonPoints[i],
                          controller.polygonPoints[nextIndex])) {
                        controller.toggleBorderSelection(i);
                        return;
                      }
                    }
                  } else if (controller.isSelectingArea.value) {
                    _handleMapTap(argument);
                  }
                  controller.pickedLocation.value = argument;
                },
                markers: _buildMarkers().union(_buildWalkwayMarkers()),
                polygons: _buildPolygons2().union(_buildWalkwayPolygons()),
                polylines: _buildTerraceBorderPolylines().union(_buildHandRailPolylines()),
              )),
              Obx(() => controller.isSelectingArea.value ? _buildAreaControls() : const SizedBox()),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    if (controller.editingTerraceIndex.value != -1) {
                      final terrace = controller.savedTerraces[controller.editingTerraceIndex.value];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 8),
                          child: Column(
                            children: [
                              CupertinoSlidingSegmentedControl(
                                groupValue: terrace.isHorizontal
                                    ? "H"
                                    : terrace.isAlternate ? "A" : "V",
                                thumbColor: AppColors.primaryBlue,
                                children: const {"H": Text("H"), "V": Text("V"), "A": Text("A")},
                                onValueChanged: (value) {
                                  final isHorizontal = value == "H";
                                  final isAlternate = value == "A";
                                  final index = controller.editingTerraceIndex.value;
                                  final terrace = controller.savedTerraces[index];
                                  controller.solarPanelsPolygons.clear();
                                  final newCenters = controller.calculatePanelCenters(
                                    terrace.areaPoints,
                                    isHorizontal,
                                    terrace.padding,
                                    terrace.rowSpacing,
                                    isAlternate: isAlternate,
                                  );
                                  controller.savedTerraces[index] = terrace.copyWith(
                                    isHorizontal: isHorizontal,
                                    isAlternate: isAlternate,
                                    panels: newCenters,
                                  );
                                  controller.solarPanelsPolygons.value = controller.convertCentersToPolygons(
                                    newCenters,
                                    isHorizontal,
                                    isAlternate: isAlternate,
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              Text("Padding", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              SizedBox(
                                height: 20,
                                width: 100,
                                child: Obx(() => Slider(
                                  label: "${controller.paddingSliderValue.value.toInt()}m",
                                  max: 2,
                                  min: 0,
                                  thumbColor: AppColors.primaryBlue,
                                  divisions: 4,
                                  value: controller.paddingSliderValue.value,
                                  onChangeEnd: (value) {
                                    controller.solarPanelsPolygons.clear();
                                    controller.paddingSliderValue.value = value;
                                    controller.savedTerraces[controller.editingTerraceIndex.value] =
                                        controller.savedTerraces[controller.editingTerraceIndex.value]
                                            .copyWith(padding: value);
                                    controller.updatePanelPositions();
                                    controller.saveEditedTerrace();
                                    controller.startEditingTerrace(selecting);
                                  },
                                  onChanged: (value) => controller.paddingSliderValue.value = value,
                                )),
                              ),
                              if (controller.terraceType.value != "Slant Roof")
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Row Spacing", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    SizedBox(
                                      height: 20,
                                      width: 100,
                                      child: Obx(() => Slider(
                                        label: "${controller.rowSpacingSlidervalue.value.toStringAsFixed(1)}m",
                                        max: controller.sliderLimit.value,
                                        min: 0,
                                        thumbColor: AppColors.primaryBlue,
                                        divisions: 10,
                                        value: controller.rowSpacingSlidervalue.value,
                                        onChangeEnd: (value) {
                                          controller.solarPanelsPolygons.clear();
                                          controller.rowSpacingSlidervalue.value = value;
                                          controller.savedTerraces[controller.editingTerraceIndex.value] =
                                              controller.savedTerraces[controller.editingTerraceIndex.value]
                                                  .copyWith(rowSpacing: value);
                                          controller.saveEditedTerrace();
                                          controller.startEditingTerrace(selecting);
                                          controller.updatePanelPositions();
                                        },
                                        onChanged: (value) => controller.rowSpacingSlidervalue.value = value,
                                      )),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Panels:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Obx(() => Text(
                                      "${controller.savedTerraces[controller.editingTerraceIndex.value].panels.length}")),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Kw:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Obx(() => Text(
                                      "${controller.savedTerraces[controller.editingTerraceIndex.value].panels.length * 545 / 1000}")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Obx(() {
                  if (controller.editingTerraceIndex.value != -1) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWalkwayControls(),
                        addGril(),
                      ],
                    );
                  }
                  return const SizedBox();
                }),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.07,
                left: 10,
                child: Obx(() => controller.editingWalkwayIndex.value != -1
                    ? _buildWalkwayEditControls()
                    : const SizedBox()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _createNewBuilding(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create New Building"),
        content: Form(
          key: controller.tableStructureKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter building name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.isEmpty) ? "Please Enter Building Name" : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  hint: const Text("Required Kilowatt", style: TextStyle(fontSize: 14)),
                  items: ["10 to 50 kw", "50 to 100 kw", "100 to 150 kw", "150 to 200 kw"]
                      .map((e) => DropdownMenuItem<String>(child: Text(e), value: e))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.isSelectingArea.value = false;
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (controller.tableStructureKey.currentState?.validate() ?? false) {
                controller.currentBuilding.value = nameController.text;
                controller.buildingNamecontrol.text = nameController.text;
                controller.isSelectingArea.value = true;
                Navigator.pop(context);
              }
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  void _handleTerraceTap(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Obx(() {
              final buildingGroups = <String, List<Terrace>>{};
              for (final terrace in controller.savedTerraces) {
                final building = controller.terraceBuildings[terrace.id] ?? 'Unassigned';
                buildingGroups.putIfAbsent(building, () => []).add(terrace);
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: buildingGroups.entries
                    .expand((entry) => entry.value.map((terrace) => _buildExistingTerraceCard(terrace, index)))
                    .toList(),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildExistingTerraceCard(Terrace terrace, int indexx) {
    final index = controller.savedTerraces.indexWhere((t) => t.id == terrace.id);
    if (index == -1) return const SizedBox();
    return index == indexx
        ? Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Colors.white,
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Terrace ${index + 1}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Are you sure Want to Delete ?"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
                              TextButton(
                                onPressed: () {
                                  controller.solarPanelsPolygons.clear();
                                  controller.savedTerraces.removeAt(index);
                                  controller.terraceBuildings.remove(terrace.id);
                                  controller.calculateAllPanels();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Area:"),
                    Obx(() => Text(controller.showInMeters.value
                        ? '${controller.calculatePolygonArea(terrace.areaPoints).toStringAsFixed(2)} m²'
                        : '${(controller.calculatePolygonArea(terrace.areaPoints) * 10.764).toStringAsFixed(2)} ft²')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text("Panels:"), Text("${terrace.panels.length}")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text("Kw:"), Text("${(terrace.panels.length * 545) / 1000}")],
                ),
                if (terrace.hasGril)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Hand Rail:"),
                      Text(
                          "${controller.calculateHandRailLength(terrace.handRailPoints).toStringAsFixed(2)}m"),
                    ],
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  structureTableDilog();
                },
                child: const Text("Edit Structure Table"),
                style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  selecting = index;
                  controller.startEditingTerrace(index);
                  Navigator.pop(context);
                },
                child: const Text("Edit Solar Panel Placement"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(content: Center(child: Text("BOM"))));
                },
                child: const Text("BOM"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ],
    )
        : const SizedBox();
  }

  Set<Polygon> _buildPolygons2() {
    final allPolygons = <Polygon>{};
    if (controller.polygonPoints.length >= 3 && controller.selectedBuilding.value.isEmpty) {
      allPolygons.add(Polygon(
        polygonId: const PolygonId('current_area'),
        points: List<LatLng>.from(controller.polygonPoints),
        strokeWidth: 4,
        strokeColor: Colors.yellow,
        fillColor: Colors.yellow.withOpacity(0.15),
        consumeTapEvents: true,
      ));
    }

    for (int idx = 0; idx < controller.savedTerraces.length; idx++) {
      final terrace = controller.savedTerraces[idx];
      final buildingName = controller.terraceBuildings[terrace.id] ?? 'Unassigned';
      if (controller.selectedBuilding.value.isNotEmpty && controller.selectedBuilding.value != buildingName) continue;
      final isSelected = controller.selectedBuilding.value == buildingName;

      allPolygons.add(Polygon(
        consumeTapEvents: true,
        polygonId: PolygonId('terrace_$idx'),
        points: List<LatLng>.from(terrace.areaPoints),
        strokeWidth: isSelected ? 4 : 3,
        strokeColor: isSelected ? Colors.green : Colors.blue,
        fillColor: isSelected ? Colors.green.withOpacity(0.25) : Colors.blue.withOpacity(0.15),
        onTap: () {
          if (controller.editingTerraceIndex.value == -1) {
            _handleTerraceTap(idx);
            controller.isHorizontal.value = terrace.isHorizontal;
            controller.paddingSliderValue.value = terrace.padding;
            controller.rowSpacingSlidervalue.value = terrace.rowSpacing;
          }
        },
      ));

      allPolygons.addAll(terrace.walkways.map((walkway) => Polygon(
        polygonId: PolygonId(walkway.id),
        points: walkway.points,
        strokeWidth: 1,
        strokeColor: Colors.deepOrange,
        fillColor: Colors.deepOrange.withOpacity(0.5),
        consumeTapEvents: true,
      )));

      allPolygons.addAll(controller.convertCentersToPolygons(
          terrace.panels, terrace.isHorizontal, isAlternate: terrace.isAlternate));
    }

    if (controller.editingTerraceIndex.value == -1 &&
        controller.polygonPoints.length >= 3 &&
        controller.selectedBuilding.value.isEmpty) {
      allPolygons.addAll(controller.solarPanelsPolygons);
    }
    return allPolygons;
  }

  void _handleMapTap(LatLng argument) {
    if (controller.isSelectingArea.value) {
      if (controller.editingTerraceIndex.value != -1) return;
      if (controller.polygonPoints.isEmpty) {
        controller.currentHandRailPoints.clear();
        controller.isDrawingHandRail.value = false;
        controller.isHandRailComplete.value = false;
      }
      controller.polygonPoints.add(argument);
      controller.updatePolygon();
    }
  }

  void _handleMarkerDrag(int index, LatLng newPosition) {
    controller.polygonPoints[index] = newPosition;
    controller.updatePolygon(forceUpdate: true);
  }

  Widget _buildAreaControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white.withOpacity(0.6),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Obx(() => CupertinoSlidingSegmentedControl(
                                backgroundColor: Colors.white54,
                                thumbColor: AppColors.primaryBlue,
                                groupValue: controller.selectedmaserType.value,
                                children: const {"m": Text("m²"), "f": Text("ft²")},
                                onValueChanged: (value) {
                                  controller.selectedmaserType.value = value!;
                                  controller.showInMeters.value = (value == "m");
                                  controller.updatePolygon(forceUpdate: true);
                                },
                              )),
                              const SizedBox(width: 12),
                              Obx(() => Text(
                                  'Area: ${controller.showInMeters.value
                                      ? '${controller.polygonArea.toStringAsFixed(2)} m²'
                                      : '${(controller.polygonArea.value * 10.764).toStringAsFixed(2)} ft²'}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                              const SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  controller.saveEditedTerrace();
                                  controller.isSelectingArea.value = false;
                                  controller.clearPolygon();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(5)),
                                  child: const Padding(
                                      padding: EdgeInsets.all(5.0), child: Center(child: Icon(Icons.clear))),
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                if (controller.editingTerraceIndex.value != -1)
                                  IconButton(
                                    icon: const Icon(Icons.undo_outlined),
                                    onPressed: () {
                                      controller.polygonPoints.value = List.from(controller.originalTerracePoints);
                                      controller.updatePolygon();
                                    },
                                  ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    if (controller.currentHandRailPoints.length >= 2)
                                      controller.finishDrawingHandRail();
                                    if (controller.polygonPoints.length >= 3) {
                                      if (controller.editingTerraceIndex.value != -1) {
                                        controller.saveEditedTerrace();
                                      } else {
                                        structureTableDilog();
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange, foregroundColor: Colors.white),
                                  child: Text(controller.editingTerraceIndex.value != -1
                                      ? "Save Changes"
                                      : "Show Panels"),
                                ),
                                if (controller.editingTerraceIndex.value != -1)
                                  TextButton(
                                    onPressed: controller.cancelEditing,
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget addGril() {
    return Obx(() {
      if (controller.terraceType.value != "Slant Roof") return const SizedBox();
      return Column(
        children: [
          if (controller.isDrawingHandRail.value)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text("Tap borders in order to create hand rail",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: controller.finishDrawingHandRail,
                          child: const Text("Save"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, foregroundColor: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            controller.isDrawingHandRail.value = false;
                            controller.currentHandRailPoints.clear();
                          },
                          child: const Text("Cancel"),
                          style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildWalkwayControls() {
    return Obx(() {
      if (controller.terraceType.value != "Slant Roof") return const SizedBox();
      return ElevatedButton(
        onPressed: () {
          controller.addWalkway();
          controller.updatePanelPositions();
        },
        child: const Text("Add Walkway"),
        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: AppColors.primaryBlue),
      );
    });
  }

  Widget _buildWalkwayEditControls() {
    return Obx(() {
      final idx = controller.editingWalkwayIndex.value;
      if (idx < 0 || idx >= controller.currentWalkways.length) return const SizedBox();

      final walkway = controller.currentWalkways[idx];
      final isHorizontal = walkway.isHorizontal;

      double maxLength;
      final terrace = controller.savedTerraces[controller.editingTerraceIndex.value];
      final bounds = controller.getPolygonBounds(terrace.areaPoints);
      if (isHorizontal) {
        maxLength = (bounds.northeast.longitude - bounds.southwest.longitude) *
            111111 *
            cos(bounds.southwest.latitude * pi / 180);
      } else {
        maxLength = (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
      }
      maxLength = max(1.1, maxLength);
      final currentLength = walkway.length.clamp(1.0, maxLength);

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Walkway ${idx + 1}")]),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text("Length: ${walkway.length.toStringAsFixed(2)}m"),
              ),
              SizedBox(
                height: 50,
                width: 120,
                child: Slider(
                  thumbColor: AppColors.primaryBlue,
                  min: 1.0,
                  max: maxLength,
                  value: currentLength,
                  onChanged: (value) => controller.updateWalkwayLength(idx, value),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 15),
                  CupertinoSlidingSegmentedControl(
                    thumbColor: AppColors.primaryBlue,
                    groupValue: isHorizontal ? "H" : "V",
                    children: const {"H": Text("H"), "V": Text("V")},
                    onValueChanged: (value) {
                      controller.toggleWalkwayOrientation(idx);
                      controller.updatePanelPositions();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.removeWalkway(idx);
                      controller.editingWalkwayIndex.value = -1;
                      controller.updatePanelPositions();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                    child: const Text("Delete"),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Set<Polyline> _buildTerraceBorderPolylines() {
    final polylines = <Polyline>{};
    if (controller.polygonPoints.length >= 2) {
      var points = List<LatLng>.from(controller.polygonPoints);
      if (points.length >= 3 && points.first == points.last) points.removeLast();

      if (controller.isDrawingHandRail.value) {
        List<int> selectedIndices = [];
        if (controller.editingTerraceIndex.value != -1) {
          selectedIndices = controller.savedTerraces[controller.editingTerraceIndex.value].selectedBorderIndices;
        }
        for (int i = 0; i < points.length; i++) {
          final isSelected = selectedIndices.contains(i);
          polylines.add(Polyline(
            polylineId: PolylineId('terrace_border_$i'),
            points: [points[i], points[(i + 1) % points.length]],
            color: isSelected ? Colors.black : Colors.transparent,
            width: isSelected ? 6 : 0,
            consumeTapEvents: true,
            onTap: () => controller.toggleBorderSelection(i),
          ));
        }
      } else {
        for (int i = 0; i < points.length; i++) {
          polylines.add(Polyline(
            polylineId: PolylineId('terrace_border_$i'),
            points: [points[i], points[(i + 1) % points.length]],
            color: Colors.white.withOpacity(0.7),
            width: 2,
          ));
        }
      }
    }
    return polylines;
  }

  Set<Polyline> _buildHandRailPolylines() {
    final polylines = <Polyline>{};
    for (int i = 0; i < controller.currentHandRailPoints.length; i += 2) {
      if (i + 1 < controller.currentHandRailPoints.length) {
        polylines.add(Polyline(
          polylineId: PolylineId('handrail_${i ~/ 2}'),
          points: [controller.currentHandRailPoints[i], controller.currentHandRailPoints[i + 1]],
          color: Colors.black,
          width: 5,
        ));
      }
    }
    return polylines;
  }

  Set<Polygon> _buildWalkwayPolygons() => controller.currentWalkways.map((w) => w.toPolygon()).toSet();

  LatLng _getWalkwayEndPoint(Walkway walkway) {
    if (walkway.points.isEmpty) return const LatLng(0, 0);
    if (walkway.isHorizontal) {
      final p1 = walkway.points[1];
      final p2 = walkway.points[2];
      return LatLng((p1.latitude + p2.latitude) / 2, (p1.longitude + p2.longitude) / 2);
    } else {
      final p0 = walkway.points[0];
      final p1 = walkway.points[1];
      return LatLng((p0.latitude + p1.latitude) / 2, (p0.longitude + p1.longitude) / 2);
    }
  }

  Set<Marker> _buildWalkwayMarkers() {
    // Only show walkway handles when editing a terrace
    if (controller.editingTerraceIndex.value == -1) return {};

    final markers = <Marker>{};
    for (int i = 0; i < controller.currentWalkways.length; i++) {
      final walkway = controller.currentWalkways[i];
      final endPoint = _getWalkwayEndPoint(walkway);
      markers.add(Marker(
        markerId: MarkerId('walkway_${walkway.id}'),
        position: endPoint,
        icon: controller.walkWayIcon.value,
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        draggable: true,
        infoWindow: InfoWindow(
            title: 'Walkway ${i + 1}', snippet: 'Tap to edit', onTap: () => controller.editingWalkwayIndex.value = i),
        onDragStart: (_) => HapticFeedback.vibrate(),
        onDrag: (newPosition) {
          final translation = LatLng(
              newPosition.latitude - endPoint.latitude, newPosition.longitude - endPoint.longitude);
          final newPoints = walkway.points
              .map((p) => LatLng(p.latitude + translation.latitude, p.longitude + translation.longitude))
              .toList();
          controller.updateWalkwayPoints(i, newPoints);
          controller.updatePanelPositions();
        },
        onDragEnd: (_) => controller.updatePanelPositions(),
      ));
    }
    return markers;
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};
    if (!controller.isSelectingArea.value) {
      markers.add(Marker(
        markerId: const MarkerId("PickLocation"),
        position: controller.pickedLocation.value,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }
    markers.addAll(controller.distanceMarkers);
    markers.addAll(controller.polygonPoints.asMap().entries.map((entry) {
      final idx = entry.key;
      final point = entry.value;
      return Marker(
        draggable: true,
        onDragStart: (_) => HapticFeedback.vibrate(),
        onDrag: (newPos) {
          controller.polygonPoints[idx] = newPos;
          controller.updatePolygon(forceUpdate: true);
        },
        onDragEnd: (newPos) => _handleMarkerDrag(idx, newPos),
        markerId: MarkerId('polygon_point_$idx'),
        position: point,
        icon: controller.boundaryIcon.value,
        infoWindow: InfoWindow(
          title: 'Point ${idx + 1} ✖',
          onTap: () {
            controller.polygonPoints.removeAt(idx);
            controller.updatePolygon();
          },
        ),
      );
    }));
    return markers;
  }

  void structureTableDilog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Structure Table"),
        content: Form(
          key: controller.tableStructureKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => (v == null || v.isEmpty) ? "Please Select Terrace Type" : null,
                decoration: const InputDecoration(labelText: "Terrace Type"),
                hint: const Text("Select Terrace type"),
                items: ["Rcc Roof", "Slant Roof", "Ground Mountain"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => controller.terraceType.value = value!,
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.terraceType.value == "Rcc Roof") {
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) => (v == null || v.isEmpty) ? "Please Select Number of Row" : null,
                        decoration: const InputDecoration(labelText: "Number of Row"),
                        hint: const Text("1"),
                        items: ["1", "2", "3", "4", "5", "6"]
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.rowSpacingInterval.value = int.parse(value);
                            controller.calculateSolarPanels1();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        controller: controller.frontLegController,
                        decoration: InputDecoration(
                          suffixIcon: Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    int val = int.tryParse(controller.frontLegController.text) ?? 0;
                                    val++;
                                    controller.frontLegController.text = val.toString();
                                  },
                                  child: const Icon(Icons.arrow_drop_up_outlined)),
                              InkWell(
                                  onTap: () {
                                    int val = int.tryParse(controller.frontLegController.text) ?? 0;
                                    val--;
                                    if (val < 0) val = 0;
                                    controller.frontLegController.text = val.toString();
                                  },
                                  child: const Icon(Icons.arrow_drop_down_outlined)),
                            ],
                          ),
                          labelText: "FrontLeg Height",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        controller: controller.backLegController,
                        decoration: InputDecoration(
                          suffixIcon: Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    int val = int.tryParse(controller.backLegController.text) ?? 0;
                                    val++;
                                    controller.backLegController.text = val.toString();
                                    controller.sliderLimit.value = val * 1.5;
                                  },
                                  child: const Icon(Icons.arrow_drop_up_outlined)),
                              InkWell(
                                  onTap: () {
                                    int val = int.tryParse(controller.backLegController.text) ?? 0;
                                    val--;
                                    if (val < 0) val = 0;
                                    controller.backLegController.text = val.toString();
                                    controller.sliderLimit.value = val * 1.5;
                                  },
                                  child: const Icon(Icons.arrow_drop_down_outlined)),
                            ],
                          ),
                          labelText: "BackLeg Height",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                  );
                } else if (controller.terraceType.value == "Slant Roof") {
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: "Walkway Width"),
                        items: ["270", "273", "305", "310", "350", "400", "500"]
                            .map((e) => DropdownMenuItem(value: e, child: Text("$e MM")))
                            .toList(),
                        onChanged: (value) => controller.selectedWalkwayWidth.value = value!,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: "Walkway Thickness"),
                        items: ["25", "30", "38", "40"]
                            .map((e) => DropdownMenuItem(value: e, child: Text("$e MM")))
                            .toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  );
                } else {
                  return const Text("Ground mountain");
                }
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.saveEditedTerrace();
            },
            child: const Text("Cancel"),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              if (controller.tableStructureKey.currentState?.validate() ?? false) {
                controller.calculateSolarPanels1();
                controller.saveCurrentTerrace();
                Navigator.pop(context);
              }
            },
            child: const Text("Show Panels"),
          ),
        ],
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      width: screenWidth * 0.5,
      elevation: 8,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 30)),
              const SizedBox(height: 8),
              const Text("Pradeep sign", style: TextStyle(fontWeight: FontWeight.bold)),
              const Text("+91 8793207849"),
              const SizedBox(height: 15),
              SizedBox(
                width: screenWidth * 0.4,
                child: DropdownButtonFormField<String>(
                  hint: const Text("ProjectType", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  items: ["Residencial", "commercial"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: screenWidth * 0.4,
                child: DropdownButtonFormField<String>(
                  hint: const Text("Technology", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  items: ["Bifacial", "Topcon"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: screenWidth * 0.4,
                child: DropdownButtonFormField<String>(
                  hint: const Text("Panel watt", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  items: ["540", "575"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: screenWidth * 0.4,
                child: DropdownButtonFormField<String>(
                  hint: const Text("Kilowatt", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  items: ["2.27", "3.24", "4.20", "5.25"]
                      .map((e) => DropdownMenuItem(child: Text("$e KW"), value: e))
                      .toList(),
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _createNewBuilding(context),
                child: const Text("New Building"),
                style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
              ),
              Expanded(
                child: Obx(() {
                  final buildingData = <String, double>{};
                  for (final terrace in controller.savedTerraces) {
                    final building = controller.terraceBuildings[terrace.id] ?? 'Unassigned';
                    final kw = (terrace.panels.length * 545) / 1000;
                    buildingData[building] = (buildingData[building] ?? 0) + kw;
                  }
                  return ListView(
                    children: buildingData.entries.map((entry) => Card(
                      elevation: 8,
                      color: controller.selectedBuilding.value == entry.key ? Colors.blue[100] : Colors.white,
                      child: InkWell(
                        onTap: () => controller.toggleBuildingSelection(entry.key),
                        child: ListTile(
                          title: Text(entry.key),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(text: "${entry.value.toStringAsFixed(2)}KW"),
                                const TextSpan(text: "\nRequired Kw : 50", style: TextStyle(color: Colors.green)),
                              ])),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: () => _deleteBuilding(entry.key),
                                      child: const Icon(Icons.delete, color: Colors.red)),
                                  InkWell(
                                      onTap: () => _showBuildingTerracesDialog(entry.key),
                                      child: const Icon(Icons.edit, color: Colors.blueAccent)),
                                  InkWell(
                                    onTap: () {},
                                    child: Card(
                                      color: AppColors.primaryBlue,
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text("BOM", style: TextStyle(fontSize: 12, color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBuildingTerracesDialog(String buildingName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Terraces in $buildingName"),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Obx(() {
              final buildingTerraces = controller.savedTerraces
                  .where((t) => controller.terraceBuildings[t.id] == buildingName)
                  .toList();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (buildingTerraces.isEmpty) const Text("No terraces found"),
                  DropdownButtonFormField<String>(
                    hint: const Text("Required Kilowatt", style: TextStyle(fontSize: 14)),
                    items: ["10 to 50 kw", "50 to 100 kw", "100 to 150 kw", "150 to 200 kw"]
                        .map((e) => DropdownMenuItem(child: Text(e), value: e))
                        .toList(),
                    onChanged: (_) {},
                  ),
                  ...buildingTerraces.map((terrace) {
                    final idx = controller.savedTerraces.indexOf(terrace);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Terrace ${idx + 1}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[700])),
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                  onPressed: () {
                                    controller.savedTerraces.removeAt(idx);
                                    controller.terraceBuildings.remove(terrace.id);
                                    controller.calculateAllPanels();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Area:"),
                                Obx(() => Text(controller.showInMeters.value
                                    ? '${controller.calculatePolygonArea(terrace.areaPoints).toStringAsFixed(2)} m²'
                                    : '${(controller.calculatePolygonArea(terrace.areaPoints) * 10.764).toStringAsFixed(2)} ft²')),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text("Panels:"), Text("${terrace.panels.length}")],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text("Kw:"), Text("${(terrace.panels.length * 545) / 1000}")],
                            ),
                            if (terrace.hasGril)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Hand Rail"),
                                  Text("${controller.calculateHandRailLength(terrace.handRailPoints).toStringAsFixed(2)}m"),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            }),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
      ),
    );
  }

  void _deleteBuilding(String buildingName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Building?"),
        content: Text("Are you sure you want to delete '$buildingName' and all its terraces?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              controller.savedTerraces.removeWhere((terrace) {
                final terraceBuilding = controller.terraceBuildings[terrace.id] ?? '';
                if (terraceBuilding == buildingName) {
                  controller.terraceBuildings.remove(terrace.id);
                  return true;
                }
                return false;
              });
              if (controller.selectedBuilding.value == buildingName) controller.selectedBuilding.value = '';
              controller.calculateAllPanels();
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}