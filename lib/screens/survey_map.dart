import 'dart:math';
import 'package:admin_app_new/screens/survey_list_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../appColors.dart';
import '../controller/survey_map_controller.dart';
import '../models/comman_model.dart';
import '../models/project_type_model.dart';
import 'custome_snackbar.dart';


class SurveyMap extends StatefulWidget {
  const SurveyMap({
    super.key,
  });

  @override
  State<SurveyMap> createState() => _SurveyMapState();
}

class _SurveyMapState extends State<SurveyMap> {
  final SurveyMapController controller = Get.put(SurveyMapController());

  double screenWidth = 0.0;
  int selecting = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print("init called");
    // controller.get_Type(widget.districtId,widget.cpId);
    controller.GetCpId();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("on dispose ---------");
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Survey"),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
              controller.showStreetView.value
                  ? Icons.map
                  : Icons.streetview,
            )),
            onPressed: () => controller.showStreetView.toggle(),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SizedBox(
          //       height: 30,
          //       width: 30,
          //       child: InkWell(
          //           onTap: () {
          //             _handleWhatsapp();
          //           },
          //           child: Icon(Icons.share))),
          // ),
        ],
      ),
      body: Obx(() => controller.showStreetView.value
          ? _buildStreetView()
          : _buildMapView()),
      floatingActionButton: _buildFAB(),
    );
  }

  exitDilog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          //contentPadding: EdgeInsets.symmetric(horizontal: 5),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Are you sure want to go back?",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    height: 28.21875 / 18,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.orange),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          SystemNavigator.pop();
                        },
                        child: Text(
                          'YES',
                          style: TextStyle(color: Colors.orange),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFAB() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 8),
      child: Obx(() => !controller.isSelectingArea.value
          ? controller.showStreetView.value
          ? const SizedBox()
          : FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.secondaryOrange,
        onPressed: () {
          if (controller.buildingNamecontrol.text == "") {
            showCustomSnackBar(context,
                message: "Please Add Building First",
                backgroundColor: Colors.redAccent);
            scaffoldKey.currentState!.openDrawer();
          } else {
            controller.isSelectingArea.value = true;
          }
        },
        child: const Text("Select\n Area"),
      )
          : SizedBox()),
    );
  }

  // flutter streetview  for street view
  Widget _buildStreetView() {
    return SizedBox();
    // return FlutterGoogleStreetView(
    //
    //  userNavigationEnabled: true,
    //  zoomGesturesEnabled: true,
    //  panningGesturesEnabled: true,
    //  initPos: controller.pickedLocation.value,
    //  onStreetViewCreated: (controller) {
    //    this.controller.streetViewController = controller;
    //  },
    //  );
  }

  Widget _buildMapView() {
    return Column(
      // column
      children: [
        Expanded(
          child: Stack(
            children: [
              Obx(() => GoogleMap(
                mapToolbarEnabled: true,
                compassEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.satellite,

                onCameraMove: (position) {
                  controller.onCameraMove(position);
                },

                initialCameraPosition: CameraPosition(
                  target: controller.pickedLocation.value,
                  zoom: 14,
                ),
                onMapCreated: (controller) =>
                this.controller.mapController = controller,
                onTap: (argument) {
                  // if (controller.isDrawingHandRail.value) {
                  //   // Check if tap is near any border
                  //   for (int i = 0; i < controller.polygonPoints.length; i++) {
                  //     final nextIndex = (i + 1) % controller.polygonPoints.length;
                  //     if (controller.isPointNearBorder(
                  //         argument,
                  //         controller.polygonPoints[i],
                  //         controller.polygonPoints[nextIndex]
                  //     )) {
                  //       controller.toggleBorderSelection(i);
                  //       return;
                  //     }
                  //   }
                  // } else if (controller.isSelectingArea.value) {
                  //   _handleMapTap(argument);
                  // }
                  // controller.pickedLocation.value = argument;
                  // controller.pickedLocation.vlaue = argument;
                  //

                  if (controller.isDrawingHandRail.value) {
                    // Check if tap is near any border
                    for (int i = 0;
                    i < controller.polygonPoints.length;
                    i++) {
                      final nextIndex =
                          (i + 1) % controller.polygonPoints.length;
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
                  } else if (controller.editingTerraceIndex.value != -1) {
                    // Check if tap is on drag handle
                    controller.startDraggingPanel(
                        argument,
                        controller
                            .savedTerraces[
                        controller.editingTerraceIndex.value]
                            .areaPoints);
                  }
                  controller.pickedLocation.value = argument;
                },

                markers: _buildMarkers().union(_buildWalkwayMarkers()),
                // polygons: _buildPolygons2().union(_buildWalkwayPolygons()),
                // polygons: _buildPolygons2().union(_buildWalkwayPolygons()),
                polygons: controller
                    .getDraggableSolarPanelsPolygons(
                    controller.editingTerraceIndex.value != -1
                        ? controller
                        .savedTerraces[
                    controller.editingTerraceIndex.value]
                        .areaPoints
                        : [])
                    .union(_buildPolygons2())
                    .union(_buildWalkwayPolygons())
                    .union(controller.solarPanelsPolygons.value),
                polylines: _buildTerraceBorderPolylines()
                    .union(_buildHandRailPolylines()),
                // polylines: controller.polylines.union(
                //     _buildHandRailPolylines()),
              )),
              Obx(() => controller.isSelectingArea.value
                  ? _buildAreaControls()
                  : const SizedBox()),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                        () {
                      return controller.editingTerraceIndex.value != -1
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                              color: AppColors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 8, right: 5, left: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Panel Layout",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CupertinoSlidingSegmentedControl(
                                      groupValue: controller
                                          .editingTerraceIndex
                                          .value !=
                                          -1
                                          ? (controller
                                          .savedTerraces[controller
                                          .editingTerraceIndex
                                          .value]
                                          .isHorizontal
                                          ? "H"
                                          : controller
                                          .savedTerraces[controller
                                          .editingTerraceIndex
                                          .value]
                                          .isAlternate
                                          ? "A"
                                          : "V")
                                          : controller.selectedvalue.value,
                                      thumbColor: AppColors.primaryBlue,
                                      children: const {
                                        "H": Text("H"),
                                        "V": Text("V"),
                                      },
                                      onValueChanged: (value) {
                                        print(value);
                                        controller.isRowSelected.value =
                                        false;
                                        controller.panelOrientation.value =
                                        value!;
                                        final isHorizontal = value == "H";
                                        final isAlternate = value == "A";

                                        if (controller
                                            .editingTerraceIndex.value !=
                                            -1) {
                                          final index = controller
                                              .editingTerraceIndex.value;
                                          final terrace =
                                          controller.savedTerraces[index];

                                          controller.solarPanelsPolygons
                                              .clear();

                                          controller.updateAvailableRows();

                                          if (controller
                                              .availableRows.isNotEmpty) {
                                            controller.selectedRows.value =
                                                controller
                                                    .availableRows.first;
                                          }

                                          final newCenters = controller
                                              .calculatePanelCenters(
                                            terrace.areaPoints,
                                            isHorizontal,
                                            terrace.padding,
                                            terrace.rowSpacing,
                                            isAlternate: isAlternate,
                                          );

                                          // Update terrace with new orientation
                                          controller.savedTerraces[index] =
                                              terrace.copyWith(
                                                isHorizontal: isHorizontal,
                                                isAlternate: isAlternate,
                                                panels: newCenters,
                                              );

                                          // Update displayed panels
                                          controller
                                              .solarPanelsPolygons.value =
                                              controller
                                                  .convertCentersToPolygons(
                                                newCenters,
                                                isHorizontal,
                                                isAlternate: isAlternate,
                                              );
                                        }
                                        controller.detectAndHighlightLayout();
                                        controller.totalPanelWidth.value =
                                            controller
                                                .getPanelStructureWidth();
                                        controller.totalPanelHeight.value =
                                            controller
                                                .getPanelStructureHeight();
                                      },
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    //
                                    // LayoutSelectorWidget(),  // Add this line  for drpdown

                                    /// number of rows
                                    // Obx(() {
                                    //   if (controller
                                    //               .selectedPanelCount.value <=
                                    //           0 ||
                                    //       controller.editingTerraceIndex
                                    //               .value ==
                                    //           -1) {
                                    //     return SizedBox(
                                    //       width: 120,
                                    //       child: DropdownButtonFormField<int>(
                                    //         hint: Text(
                                    //           "Select panels first",
                                    //           style: TextStyle(fontSize: 10),
                                    //         ),
                                    //         items: [],
                                    //         onChanged: null,
                                    //       ),
                                    //     );
                                    //   }
                                    //
                                    //   final terrace =
                                    //       controller.savedTerraces[controller
                                    //           .editingTerraceIndex.value];
                                    //
                                    //   // Get only feasible row options
                                    //   final feasibleRows = <int>[];
                                    //   for (int rows = 1;
                                    //       rows <=
                                    //           controller
                                    //               .selectedPanelCount.value;
                                    //       rows++) {
                                    //     if (controller
                                    //         .isRowConfigurationFeasible(
                                    //       terrace.areaPoints,
                                    //       controller.selectedPanelCount.value,
                                    //       rows,
                                    //       terrace.isHorizontal,
                                    //     )) {
                                    //       feasibleRows.add(rows);
                                    //     }
                                    //   }
                                    //
                                    //   // If no feasible rows, show empty dropdown
                                    //   if (feasibleRows.isEmpty) {
                                    //     return SizedBox(
                                    //       width: 120,
                                    //       child: DropdownButtonFormField<int>(
                                    //         hint: Text(
                                    //           "No space available",
                                    //           style: TextStyle(
                                    //               fontSize: 10,
                                    //               color: Colors.red),
                                    //         ),
                                    //         items: [],
                                    //         onChanged: null,
                                    //       ),
                                    //     );
                                    //   }
                                    //
                                    //   return SizedBox(
                                    //     width: 135,
                                    //     child: DropdownButtonFormField<int>(
                                    //       hint: Text(
                                    //         "Number of Rows",
                                    //         style: TextStyle(
                                    //             fontSize: 10,
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //       initialValue:
                                    //       (controller.selectedRows.value == null) ?  feasibleRows.first : controller.selectedRows.value,
                                    //       items: feasibleRows.map((rows) {
                                    //         return DropdownMenuItem<int>(
                                    //           value: rows,
                                    //           child: Text(
                                    //               "$rows Row${rows > 1 ? 's' : ''}"),
                                    //         );
                                    //       }).toList(),
                                    //       onChanged: (value) {
                                    //         if (value != null) {
                                    //           controller.selectedRows.value =
                                    //               value;
                                    //           controller
                                    //               .updatePanelPositionsWithRows();
                                    //         }
                                    //       },
                                    //     ),
                                    //   );
                                    // }),

                                    // SizedBox(height: 0),
                                    // // Padding Slider - Add Obx wrapper
                                    // Text("Padding", style: TextStyle(
                                    //     fontWeight: FontWeight.bold, fontSize: 12)),
                                    // SizedBox(
                                    //   height: 20,
                                    //   width: 100,
                                    //   child: Obx(() =>
                                    //       Slider( // Wrap with Obx
                                    //         label: "${controller.paddingSliderValue
                                    //             .value.toInt()}m",
                                    //         max: 2,
                                    //         min: 0,
                                    //         thumbColor: AppColors.secondaryOrange,
                                    //         divisions: 4,
                                    //         value: controller.paddingSliderValue
                                    //             .value,
                                    //         onChangeEnd: (value) {
                                    //           controller.solarPanelsPolygons
                                    //               .clear();
                                    //           controller.paddingSliderValue.value =
                                    //               value;
                                    //           // Update both preview and terrace config
                                    //           controller.savedTerraces[controller
                                    //               .editingTerraceIndex.value] =
                                    //               controller
                                    //                   .savedTerraces[controller
                                    //                   .editingTerraceIndex.value]
                                    //                   .copyWith(
                                    //                   padding: value
                                    //               );
                                    //           controller.updatePanelPositions();
                                    //           controller.saveEditedTerrace();
                                    //           controller.startEditingTerrace(
                                    //               selecting);
                                    //         },
                                    //         onChanged: (value) {
                                    //           controller.paddingSliderValue.value =
                                    //               value;
                                    //         },
                                    //       )),
                                    // ),
                                    //
                                    // // Row Spacing Slider - Keep Obx but fix value handling
                                    // if(controller.terraceType.value != "Slant Roof")
                                    //   Column(
                                    //     mainAxisSize: MainAxisSize.min,
                                    //     children: [
                                    //       Text("Row Spacing", style: TextStyle(
                                    //           fontWeight: FontWeight.bold,
                                    //           fontSize: 12)),
                                    //       SizedBox(
                                    //         height: 20,
                                    //         width: 100,
                                    //         child: Obx(() =>
                                    //             Slider(
                                    //               label: "${controller
                                    //                   .rowSpacingSlidervalue.value
                                    //                   .toStringAsFixed(1)}m",
                                    //               max: controller.sliderLimit.value,
                                    //               min: 0,
                                    //               thumbColor: AppColors.secondaryOrange,
                                    //               divisions: 10,
                                    //               //
                                    //               value: controller
                                    //                   .rowSpacingSlidervalue.value,
                                    //               onChangeEnd: (value) {
                                    //                 controller.solarPanelsPolygons
                                    //                     .clear();
                                    //                 controller.rowSpacingSlidervalue
                                    //                     .value = value;
                                    //                 // Update both preview and terrace config
                                    //                 controller
                                    //                     .savedTerraces[controller
                                    //                     .editingTerraceIndex
                                    //                     .value] =
                                    //                     controller
                                    //                         .savedTerraces[controller
                                    //                         .editingTerraceIndex
                                    //                         .value].copyWith(
                                    //                         rowSpacing: value
                                    //                     );
                                    //                 controller.saveEditedTerrace();
                                    //                 controller.startEditingTerrace(
                                    //                     selecting);
                                    //                 controller
                                    //                     .updatePanelPositions();
                                    //
                                    //
                                    //               },
                                    //               onChanged: (value) {
                                    //                 controller.rowSpacingSlidervalue
                                    //                     .value = value;
                                    //               },
                                    //             )),
                                    //       ),
                                    //     ],
                                    //   ),

                                    Obx(() {
                                      if (controller
                                          .selectedPanelCount.value <=
                                          0 ||
                                          controller.editingTerraceIndex
                                              .value ==
                                              -1) {
                                        return SizedBox(
                                          width: 130,
                                          child: DropdownButtonFormField<int>(
                                            hint: Text(
                                              "Select panels first",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            items: [],
                                            onChanged: null,
                                          ),
                                        );
                                      }

                                      final terrace =
                                      controller.savedTerraces[controller
                                          .editingTerraceIndex.value];

                                      // Get only feasible row options
                                      final feasibleRows = <int>[];
                                      for (int rows = 1;
                                      rows <=
                                          controller
                                              .selectedPanelCount.value;
                                      rows++) {
                                        if (controller
                                            .isRowConfigurationFeasible(
                                          terrace.areaPoints,
                                          controller.selectedPanelCount.value,
                                          rows,
                                          terrace.isHorizontal,
                                        )) {
                                          feasibleRows.add(rows);
                                        }
                                      }

                                      // If no feasible rows, show empty dropdown
                                      if (feasibleRows.isEmpty) {
                                        return SizedBox(
                                          width: 150,
                                          child: DropdownButtonFormField<int>(
                                            hint: Text(
                                              "No space available",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.red),
                                            ),
                                            items: [],
                                            onChanged: null,
                                          ),
                                        );
                                      }

                                      // Check if current selected value is available, if not use first available
                                      final currentValue =
                                          controller.selectedRows.value;
                                      final isValidValue =
                                      feasibleRows.contains(currentValue);
                                      final dropdownValue = isValidValue
                                          ? currentValue
                                          : feasibleRows.first;

                                      return SizedBox(
                                        width: 145,
                                        child: DropdownButtonFormField<int>(
                                          decoration: InputDecoration(
                                              labelText: "Number of Rows"),
                                          hint: Text(
                                            "Number of Rows",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          initialValue: dropdownValue,
                                          items: feasibleRows.map((rows) {
                                            return DropdownMenuItem<int>(
                                              value: rows,
                                              child: Text(
                                                  "$rows Row${rows > 1 ? 's' : ''}"),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.selectedRows.value =
                                                  value;
                                              controller
                                                  .updatePanelPositionsWithRows();
                                              controller
                                                  .detectAndHighlightLayout();
                                              controller.isRowSelected.value =
                                              true;
                                              controller
                                                  .totalPanelWidth.value =
                                                  controller
                                                      .getPanelStructureWidth();
                                              controller.totalPanelHeight
                                                  .value =
                                                  controller
                                                      .getPanelStructureHeight();
                                              print(
                                                  "totalWidth == ${controller.totalPanelWidth.value}");
                                              print(
                                                  "totalHeight == ${controller.totalPanelHeight.value}");
                                            }
                                          },
                                        ),
                                      );
                                    }),

                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Solar Panels: ",
                                            style: TextStyle(
                                                height: 0.3,
                                                // Adjust the height as needed  Adjust the height as needed
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                        Obx(() => Text(
                                          "${controller.savedTerraces[controller.editingTerraceIndex.value].panels.length}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Kw: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                        Obx(() => Text(
                                          "${controller.savedTerraces[controller.editingTerraceIndex.value].panels.length * int.parse(controller.dropdown_panel_wats_name.value) / 1000}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87),
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                          : SizedBox();
                    },
                  ),
                ),
              ),
              // Positioned(
              //     top: MediaQuery.of(context).size.height * 0.13,
              //     right: 0,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Obx(() {
              //         return  controller.editingTerraceIndex.value != -1 ? SizedBox(
              //           width: 60,
              //           height: MediaQuery.of(context).size.height * 0.2,
              //           child: Card(
              //                           child: Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: GridView.builder(
              //                               itemCount: 5,
              //                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              //                                 itemBuilder: (context, index) {
              //                                   return InkWell(
              //                                       onTap: () {
              //
              //                                       },
              //                                       child: Center(child: Text("${index +1}")));
              //                                 },),
              //                           ),
              //                         ),
              //         ) : SizedBox();
              //       },
              //       ),)),

              /// Mounting style
              Positioned(
                  top: 0,
                  left: 0,
                  child: Obx(
                        () {
                      return controller.editingTerraceIndex.value != -1
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                                  () {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Mounting Style",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.35,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadiusGeometry
                                                .circular(6)),
                                        elevation: 2,
                                        color: controller
                                            .highlightedLayout
                                            .value ==
                                            "Legs On Wall"
                                            ? Colors.grey
                                            : Colors.white,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Legs On Wall",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: controller
                                                    .highlightedLayout
                                                    .value ==
                                                    "Legs On Wall"
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.35,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadiusGeometry
                                                .circular(6)),
                                        elevation: 2,
                                        color: controller
                                            .highlightedLayout
                                            .value ==
                                            "Legs On Terrace"
                                            ? Colors.grey
                                            : Colors.white,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Legs On Terrace",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: controller
                                                    .highlightedLayout
                                                    .value ==
                                                    "Legs On Terrace"
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.35,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadiusGeometry
                                                .circular(6)),
                                        elevation: 2,
                                        color: controller
                                            .highlightedLayout
                                            .value ==
                                            "Hybrid"
                                            ? Colors.grey
                                            : Colors.white,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(6.0),
                                          child: Text(
                                            "Hybrid",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: controller
                                                    .highlightedLayout
                                                    .value ==
                                                    "Hybrid"
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                          : SizedBox();
                    },
                  )),

              // RotatingCompass(),
              // azimuth angle
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: Obx(() {
              //     return controller.editingTerraceIndex.value != -1
              //         ? Container(
              //         width: MediaQuery.of(context).size.width * 0.35,
              //         padding: EdgeInsets.all(8.0),
              //         child: Card(
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               Text("Azimuth angle"),
              //               Slider(
              //                 divisions: 20,
              //                 value: controller.azimuthAngle.value,
              //                 min: -90,
              //                 max: 90,
              //                 onChanged: controller.updateAzimuthAngle,
              //               ),
              //             ],
              //           ),
              //         )
              //     )
              //         : SizedBox();
              //   }),
              // ),

              ///  walkway control
              // Positioned(
              //     top: 10,
              //     left: 10,
              //     child: Obx(() =>
              //     controller.editingTerraceIndex.value != -1
              //         ? Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         _buildWalkwayControls(),
              //         addGril(),
              //       ],
              //     )
              //         : SizedBox(),
              //     ) // ADD WALKWAY CONTROLS
              //
              // ),

              // Positioned(
              //   top: MediaQuery
              //       .of(context)
              //       .size
              //       .height * 0.07,
              //   left: 10,
              //   child: Obx(() =>
              //   controller.editingWalkwayIndex.value != -1
              //       ? _buildWalkwayEditControls()
              //       : SizedBox(),
              //   ),
              // ),

              Positioned(
                right: 0,
                left: 0,
                top: 0,
                child: Obx(
                      () {
                    return !controller.isSelectingArea.value
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 55,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Card(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                color: Colors.grey,
                                width: 1.5), // Thicker border
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              cursorColor: AppColors.primaryBlue,
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: 'Search location...',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  controller.searchLocation(value, context);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                        : SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget panels_layot() {
    return Card(color: Colors.white, elevation: 10, child: Column());
  }

  void _createNewBuilding(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController customernameController =
    TextEditingController();
    final TextEditingController mobileNoController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text("Create New Building"),
        content: Form(
          key: controller.buildingStructureKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: customernameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Enter customer name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter customer Name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: mobileNoController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Enter Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.deny(RegExp('[\\-|\\,\\.\\ ]'))
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Mobile Number";
                    }
                    if (value.length != 10) {
                      return 'Enter Valid Mobile No.';
                    }

                    if (value.split('').every((digit) => digit == value[0])) {
                      return 'Enter Valid Mobile No.';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction, //
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter building name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Building Name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hint: Text("Building Type"),
                  items: ["Ternament", "flate"].map(
                        (e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    },
                  ).toList(),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Select Building Type";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hint: Text("Building Floor"),
                  items: ["1 ", "2 ", "3 ", "4"].map(
                        (e) {
                      return DropdownMenuItem(
                        child: Text("${e}"),
                        value: e,
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    int floor = int.tryParse(value ?? "1") ?? 1;
                    controller.total_floor.clear();
                    for (int i = 0; i < floor; i++) {
                      controller.total_floor.value.add(i);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Select Floor";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
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
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              bool isvalidate =
                  controller.buildingStructureKey.currentState?.validate() ??
                      false;
              if (isvalidate) {
                controller.currentCustomerName.value =
                    customernameController.text;
                controller.currentCustomerMobile.value =
                    mobileNoController.text;
                controller.currentBuilding.value = nameController.text;
                controller.buildingNamecontrol.text = nameController.text;
                controller.isSelectingArea.value = true;
                Navigator.pop(context);
              }
            },
            child: Text("Create"),
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

              // Group terraces by building
              controller.savedTerraces.forEach((terrace) {
                final building =
                    controller.terraceBuildings[terrace.id] ?? 'Unassigned';
                buildingGroups[building] ??= [];
                buildingGroups[building]!.add(terrace);
              });

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...buildingGroups.entries.map((entry) => Column(
                    children: [
                      ...entry.value.map((terrace) {
                        return _buildExistingTerraceCard(terrace, index);
                      }),
                    ],
                  )),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildExistingTerraceCard(Terrace terrace, int indexx) {
    final controller = Get.find<SurveyMapController>();
    final index =
    controller.savedTerraces.indexWhere((t) => t.id == terrace.id);

    if (index == -1) return SizedBox();

    return index == indexx
        ? Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Colors.white,
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Terrace ${index + 1}", // Now using proper index
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete,
                              size: 20, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:
                                Text("Are you sure Want to Delete ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.solarPanelsPolygons.value
                                          .clear();
                                      controller.savedTerraces
                                          .removeAt(index);
                                      controller.terraceBuildings
                                          .remove(terrace.id);
                                      controller.calculateAllPanels();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Yes"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Area:"),
                    Obx(() => Text(
                      controller.showInMeters.value
                          ? '${controller.calculatePolygonArea(terrace.areaPoints).toStringAsFixed(2)} m²' // Direct access
                          : '${(controller.calculatePolygonArea(terrace.areaPoints) * 10.764).toStringAsFixed(2)} ft²',
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Solar Panels:"),
                    Text("${terrace.panels.length}"), // Direct access
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Kw:"),
                    Text("${(terrace.panels.length * 545) / 1000}"),
                    // Direct access
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Kg "),
                    Text("${(terrace.panels.length * 545) / 1000}"),
                    // Direct access
                  ],
                ),
                // In _buildExistingTerraceCard widget
                // if (terrace.hasGril)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       // hand rail in meter
                //       Text("Hand Rail:"),
                //       Text(
                //           "${controller.calculateHandRailLength(terrace.handRailPoints).toStringAsFixed(2)}m"),
                //     ],
                //   ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.editingTerraceIndex.value = index;
                  structureTableDilog(isEditing: true);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text("Edit Structure Table"),
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
                  child: Text("Edit Solar Panel Placement"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryBlue)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    bomDialog(index);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryBlue),
                  child: Text("BOM")),
            ),
          ],
        )
      ],
    )
        : SizedBox();
  }

  bomDialog(int index) async {
    Terrace terrace = controller.savedTerraces[index];
    SharedPreferences sp = await SharedPreferences.getInstance();
    // pu = per unit
    String f6040Price_perKg = sp.getString("f6040controller") ?? "82.01";
    String totalKgPerpipe_6040 = sp.getString("f6040KGcontroller") ?? "17";
    String f4040Price_perKg = sp.getString("f4040controller") ?? "79.65";
    String totalKgPerpipe_4040 = sp.getString("f4040Kgcontroller") ?? "18";

    // accessories
    String langle_price_pu = sp.getString("lAnglecontroller") ?? "29.5";
    String americanbolt_price_pu =
        sp.getString("amiricalBoltcontroller") ?? "11.8";
    String zink_price_pu = sp.getString("zinkcontroller") ?? "76.7";
    String jBolt_price_pu = sp.getString("jBoltcontroller") ?? "15.34";
    String foundation_price_pu = sp.getString("foundationcontroller") ?? "295";

    // wires
    String dcwire_price_perM = sp.getString("dcWirecontroller") ?? "47.2";
    String acwire_price_perpm = sp.getString("acWirecontroller") ?? "45.43";

    String costomerName = terrace.customerName;
    String costomermobile = terrace.customerMobile;

    int qty6040 = terrace.f6040;
    int qty4040 = terrace.f4040;
    double totalKg = terrace.totalKg;
    int lAngle_qty = terrace.lAngle_qty;
    int americanBolt_qty = terrace.americanBolt_qty;
    int zink_qty = terrace.zink_qty;
    int jBolt_qty = terrace.jBolt_qty;
    int foundation_qty = terrace.foundation_qty;
    int dcWire_qty = terrace.dcWire_meter;
    int acWire_qty = terrace.acWire_meter;
    String mountingStyle = terrace.mountingStyle;
    int extraPipes_qty = terrace.extraPipes;

    print("qty6040 $qty6040");
    print("qty4040 $qty4040");
    print("totalKg $totalKg");

    showDialog(
      context: context,
      builder: (context) {
        // Get screen size for responsiveness
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final isSmallScreen = screenWidth < 600;

        // Define primary color and its shades
        final Color primaryColor = Color(0xFF0073B6);
        final Color primaryLight = Color(0xFF4DA0D3);
        final Color primaryDark = Color(0xFF005085);
        final Color primaryExtraLight = Color(0xFFE6F3FB);
        final Color primaryLightShade = Color(0xFFB3D9ED);

        double iconsize() {
          return isSmallScreen ? 18 : 20;
        }

        return StatefulBuilder(builder: (context, setState) {
          // pipes sub total
          double qty6040_total = qty6040 *
              double.parse(f6040Price_perKg) *
              double.parse(totalKgPerpipe_6040);
          double qty4040_total = qty4040 *
              double.parse(f4040Price_perKg) *
              double.parse(totalKgPerpipe_4040);
          double extrapipes_total = extraPipes_qty *
              double.parse(f4040Price_perKg) *
              double.parse(totalKgPerpipe_4040);

          // pipes total

          // accessoris sub total
          double lAngle_total = lAngle_qty * double.parse(langle_price_pu);
          double americanBolt_total =
              americanBolt_qty * double.parse(americanbolt_price_pu);
          double zink_total = zink_qty * double.parse(zink_price_pu);
          double jBolt_total = jBolt_qty * double.parse(jBolt_price_pu);
          // double nutVicer_total = nutVicer_qty * double.parse(nutVicer_price_pu);
          // double stude_total = stude_qty * double.parse(stude_price_pu);
          double foundation_total =
              foundation_qty * double.parse(foundation_price_pu);
          // double basePlate_total = basePlate_qty * double.parse(basePlate_price_pu);

          // wires total
          double dcWire_total = dcWire_qty * double.parse(dcwire_price_perM);
          double acWire_total = acWire_qty * double.parse(acwire_price_perpm);

          // sub totals  total prices
          double accessories_total = lAngle_total +
              americanBolt_total +
              zink_total +
              jBolt_total +
              foundation_total;
          double wire_total = dcWire_total + acWire_total;
          double pipes_total = qty6040_total + qty4040_total + extrapipes_total;

          // grand total
          double grand_total = pipes_total + accessories_total + wire_total;

          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(isSmallScreen ? 8 : 16),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isSmallScreen ? screenWidth * 0.98 : 550,
                maxHeight: screenHeight * 0.85,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 14 : 18,
                        vertical: isSmallScreen ? 10 : 14),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 14 : 18,
                                    vertical: isSmallScreen ? 10 : 14),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // Main Title - Different Style
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: isSmallScreen ? 6 : 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "Survey BOM List Of Terrace ${index + 1}",
                                                  style: TextStyle(
                                                    fontSize:
                                                    isSmallScreen ? 18 : 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.2),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(4),
                                                    child: Icon(Icons.close,
                                                        color: Colors.white,
                                                        size: isSmallScreen
                                                            ? 18
                                                            : 22),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Details Section - Different Style
                                          Container(
                                            padding: EdgeInsets.all(
                                                isSmallScreen ? 8 : 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.15),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.table_chart,
                                                        size: isSmallScreen
                                                            ? 14
                                                            : 16,
                                                        color: Colors.white),
                                                    SizedBox(width: 6),
                                                    Text(
                                                      "Structure Type:",
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen
                                                            ? 13
                                                            : 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        " Hot dig Gi(Galvanised iron)",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize:
                                                          isSmallScreen
                                                              ? 13
                                                              : 15,
                                                          color: Colors
                                                              .yellow[100],
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  children: [
                                                    Icon(Icons.style,
                                                        size: isSmallScreen
                                                            ? 14
                                                            : 16,
                                                        color: Colors.white),
                                                    SizedBox(width: 6),
                                                    Text(
                                                      "Mounting Style: ",
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen
                                                            ? 13
                                                            : 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      mountingStyle,
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen
                                                            ? 13
                                                            : 15,
                                                        color:
                                                        Colors.yellow[100],
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  children: [
                                                    Icon(Icons.person,
                                                        size: isSmallScreen
                                                            ? 14
                                                            : 16,
                                                        color: Colors.white),
                                                    SizedBox(width: 6),
                                                    Text(
                                                      "Name: ",
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen
                                                            ? 13
                                                            : 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      "$costomerName",
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen
                                                            ? 13
                                                            : 15,
                                                        color:
                                                        Colors.yellow[100],
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  children: [
                                                    Icon(Icons.bolt,
                                                        size: isSmallScreen
                                                            ? 14
                                                            : 16,
                                                        color: Colors.white),
                                                    SizedBox(width: 6),
                                                    Text(
                                                      "KW: ",
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen
                                                            ? 13
                                                            : 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller
                                                          .selectedKW.value,
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen
                                                            ? 13
                                                            : 15,
                                                        color:
                                                        Colors.yellow[100],
                                                        fontWeight:
                                                        FontWeight.w600,
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
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.pop(context);
                                    //   },
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.white.withOpacity(0.2),
                                    //       shape: BoxShape.circle,
                                    //     ),
                                    //     padding: EdgeInsets.all(4),
                                    //     child: Icon(Icons.close, color: Colors.white, size: isSmallScreen ? 18 : 22),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                            // children: [
                            //   Text(
                            //     "Survey BOM List Of Terrace ${index+1}",
                            //     style: TextStyle(
                            //       fontSize: isSmallScreen ? 17 : 19,
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            //   Text(
                            //     "mounting Style: $mountingStyle",
                            //     style: TextStyle(
                            //       fontSize: isSmallScreen ? 14 : 16,
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            //   Text(
                            //     "Name: ${widget.name}",
                            //     style: TextStyle(
                            //       fontSize: isSmallScreen ? 14 : 16,
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            //   Text(
                            //     "KW: ${controller.selectedKW.value}",
                            //     style: TextStyle(
                            //       fontSize: isSmallScreen ? 14 : 16,
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.all(isSmallScreen ? 10 : 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Standard Pipes Section
                            Row(
                              children: [
                                Icon(Icons.gite,
                                    size: isSmallScreen ? 18 : 20,
                                    color: primaryColor),
                                SizedBox(width: 8),
                                Text("Standard Pipes",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: isSmallScreen ? 15 : 17,
                                        color: primaryColor)),
                              ],
                            ),
                            SizedBox(height: isSmallScreen ? 8 : 12),

                            // Table for pipes
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Table(
                                border: TableBorder.symmetric(
                                  inside:
                                  BorderSide(color: Colors.grey.shade200),
                                ),
                                columnWidths: {
                                  0: FlexColumnWidth(isSmallScreen ? 1.8 : 2.2),
                                  1: FlexColumnWidth(1.5),
                                  2: FlexColumnWidth(1),
                                },
                                defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                                children: [
                                  // Table headers
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: primaryExtraLight,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Item",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Qty (Unit)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Price",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                    ],
                                  ),

                                  // 6040 pipes
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("60 x 40",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (qty6040 > 0) {
                                                    qty6040--;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("${qty6040}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  qty6040++;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${qty6040_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),

                                  // 4040 pipes
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("40 x 40",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (qty4040 > 0) {
                                                    qty4040--;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("$qty4040",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  qty4040++;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// qty4040_total total
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${qty4040_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),

                                  if (extraPipes_qty != 0)
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: primaryExtraLight,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                      ),
                                      children: [
                                        // extra pipes title
                                        Padding(
                                          padding: EdgeInsets.all(
                                              isSmallScreen ? 8 : 10),
                                          child: Text("Extra Pipes",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                  isSmallScreen ? 12 : 14,
                                                  color: primaryDark)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              isSmallScreen ? 8 : 10),
                                          child: Text("Qty (Unit)",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                  isSmallScreen ? 12 : 14,
                                                  color: primaryDark)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              isSmallScreen ? 8 : 10),
                                          child: Text("Price",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                  isSmallScreen ? 12 : 14,
                                                  color: primaryDark)),
                                        ),
                                      ],
                                    ),

                                  // extra pipes quantity
                                  if (extraPipes_qty != 0)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              isSmallScreen ? 8 : 10),
                                          child: Text("40 x 40",
                                              style: TextStyle(
                                                  fontSize:
                                                  isSmallScreen ? 12 : 14)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              isSmallScreen ? 8 : 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (extraPipes_qty > 0) {
                                                      extraPipes_qty--;
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: primaryLightShade,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(Icons.remove,
                                                      color: primaryColor,
                                                      size: iconsize()),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    isSmallScreen ? 4 : 6),
                                                child: Text("$extraPipes_qty",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: isSmallScreen
                                                            ? 12
                                                            : 14)),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    extraPipes_qty++;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: primaryLightShade,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(Icons.add,
                                                      color: primaryColor,
                                                      size: iconsize()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /// extrapipes_total total
                                        Padding(
                                          padding: EdgeInsets.all(
                                              isSmallScreen ? 8 : 10),
                                          child: Text(
                                              "₹ ${extrapipes_total.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                  isSmallScreen ? 12 : 14)),
                                        ),
                                      ],
                                    ),

                                  // Total pipes
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: primaryExtraLight,
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Total GI Pipes:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "${qty4040 + qty6040 + extraPipes_qty}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      SizedBox(), // Empty cell
                                    ],
                                  ),

                                  // total kg
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: primaryExtraLight,
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Total KG:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "${totalKg.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: isSmallScreen ? 12 : 14,
                                            )),
                                      ),
                                      SizedBox(), // Empty cell
                                    ],
                                  ),

                                  // total of pipes
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: primaryLightShade,
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Total Rs:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                isSmallScreen ? 13 : 15,
                                                color: primaryDark)),
                                      ),
                                      SizedBox(), // Empty cell
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${pipes_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                isSmallScreen ? 13 : 15,
                                                color: primaryDark)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: isSmallScreen ? 16 : 20),

                            // Accessories Section
                            Row(
                              children: [
                                Icon(Icons.build,
                                    size: isSmallScreen ? 18 : 20,
                                    color: primaryColor),
                                SizedBox(width: 8),
                                Text("Accessories",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: isSmallScreen ? 15 : 17,
                                        color: primaryColor)),
                              ],
                            ),
                            SizedBox(height: isSmallScreen ? 8 : 12),

                            // Table for accessories
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Table(
                                border: TableBorder.symmetric(
                                  inside:
                                  BorderSide(color: Colors.grey.shade200),
                                ),
                                columnWidths: {
                                  0: FlexColumnWidth(isSmallScreen ? 1.8 : 2.2),
                                  1: FlexColumnWidth(1.5),
                                  2: FlexColumnWidth(1),
                                },
                                defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                                children: [
                                  // Table headers
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: primaryExtraLight,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Item",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Qty (Unit)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Price",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                    ],
                                  ),

                                  // l angle
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("L - Angle",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (lAngle_qty > 0) {
                                                    lAngle_qty--;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("$lAngle_qty",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {});
                                                lAngle_qty++;
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // langle total
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${lAngle_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),

                                  // american bolt
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("American Bolt",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (americanBolt_qty > 0) {
                                                    americanBolt_qty--;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("$americanBolt_qty",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  americanBolt_qty++;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // americanbolt total
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${americanBolt_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),

                                  // zink spray
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Zink Spray",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (zink_qty > 0) {
                                                    zink_qty--;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("$zink_qty",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  zink_qty++;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // zink total
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${zink_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),

                                  // jbolt
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("J Bolt",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {});
                                                if (jBolt_qty > 0) {
                                                  jBolt_qty--;
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("$jBolt_qty",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  jBolt_qty++;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // jbolt total
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${jBolt_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),

                                  // nut vicer
                                  // TableRow(
                                  //   children: [
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Text("Nut & Vicer", style: TextStyle(fontSize: isSmallScreen ? 12 : 14)),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           InkWell(
                                  //             onTap : (){
                                  //               setState((){
                                  //                 if(nutVicer_qty > 0){
                                  //                   nutVicer_qty--;
                                  //                 }
                                  //               });
                                  //             },
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                 color: primaryLightShade,
                                  //                 shape: BoxShape.circle,
                                  //               ),
                                  //               child: Icon(Icons.remove, color: primaryColor, size: iconsize()),
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 4 : 6),
                                  //             child: Text("$nutVicer_qty",
                                  //                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmallScreen ? 12 : 14)),
                                  //           ),
                                  //           InkWell(
                                  //             onTap: () {
                                  //               setState((){
                                  //                 nutVicer_qty++;
                                  //               });
                                  //             },
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                 color: primaryLightShade,
                                  //                 shape: BoxShape.circle,
                                  //               ),
                                  //               child: Icon(Icons.add, color: primaryColor, size: iconsize()),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     // nut vicer total
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Text("₹ ${nutVicer_total.toStringAsFixed(2)}",
                                  //           style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmallScreen ? 12 : 14)),
                                  //     ),
                                  //   ],
                                  // ),

                                  // stud
                                  // TableRow(
                                  //   children: [
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Text("Stud", style: TextStyle(fontSize: isSmallScreen ? 12 : 14)),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           InkWell(
                                  //             onTap : (){
                                  //               setState((){
                                  //                 if(stude_qty > 0){
                                  //                   stude_qty--;
                                  //                 }
                                  //               });
                                  //             },
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                 color: primaryLightShade,
                                  //                 shape: BoxShape.circle,
                                  //               ),
                                  //               child: Icon(Icons.remove, color: primaryColor, size: iconsize()),
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 4 : 6),
                                  //             child: Text("$stude_qty",
                                  //                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmallScreen ? 12 : 14)),
                                  //           ),
                                  //           InkWell(
                                  //             onTap: () {
                                  //               setState((){
                                  //                 stude_qty++;
                                  //               });
                                  //             },
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                 color: primaryLightShade,
                                  //                 shape: BoxShape.circle,
                                  //               ),
                                  //               child: Icon(Icons.add, color: primaryColor, size: iconsize()),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     // stud total
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Text("₹ ${stude_total.toStringAsFixed(2)}",
                                  //           style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmallScreen ? 12 : 14)),
                                  //     ),
                                  //   ],
                                  // ),

                                  // foundation
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Foundation",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (foundation_qty > 0) {
                                                    foundation_qty--;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("$foundation_qty",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  foundation_qty++;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // foundation total
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${foundation_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),

                                  // base plate
                                  // TableRow(
                                  //   children: [
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Text("Base Plate", style: TextStyle(fontSize: isSmallScreen ? 12 : 14)),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           InkWell(
                                  //             onTap : (){
                                  //               setState((){
                                  //                 if(basePlate_qty > 0){
                                  //                   basePlate_qty--;
                                  //
                                  //                 }
                                  //               });
                                  //             },
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                 color: primaryLightShade,
                                  //                 shape: BoxShape.circle,
                                  //               ),
                                  //               child: Icon(Icons.remove, color: primaryColor, size: iconsize()),
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 4 : 6),
                                  //             child: Text("$basePlate_qty",
                                  //                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmallScreen ? 12 : 14)),
                                  //           ),
                                  //           InkWell(
                                  //             onTap: () {
                                  //               setState((){
                                  //                 basePlate_qty++;
                                  //               });
                                  //             },
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                 color: primaryLightShade,
                                  //                 shape: BoxShape.circle,
                                  //               ),
                                  //               child: Icon(Icons.add, color: primaryColor, size: iconsize()),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     // base plate total
                                  //     Padding(
                                  //       padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                                  //       child: Text("₹ ${basePlate_total.toStringAsFixed(2)}",
                                  //           style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmallScreen ? 12 : 14)),
                                  //     ),
                                  //   ],
                                  // ),

                                  // Total of accessoris
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: primaryLightShade,
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Total :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                isSmallScreen ? 13 : 15,
                                                color: primaryDark)),
                                      ),
                                      SizedBox(), // Empty cell
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${accessories_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                isSmallScreen ? 13 : 15,
                                                color: primaryDark)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: isSmallScreen ? 16 : 20),

                            // Wires Section
                            Row(
                              children: [
                                Icon(Icons.electric_bolt,
                                    size: isSmallScreen ? 18 : 20,
                                    color: primaryColor),
                                SizedBox(width: 8),
                                Text("Wires",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: isSmallScreen ? 15 : 17,
                                        color: primaryColor)),
                              ],
                            ),
                            SizedBox(height: isSmallScreen ? 8 : 12),

                            // Table for wires
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Table(
                                border: TableBorder.symmetric(
                                  inside:
                                  BorderSide(color: Colors.grey.shade200),
                                ),
                                columnWidths: {
                                  0: FlexColumnWidth(isSmallScreen ? 1.8 : 2.2),
                                  1: FlexColumnWidth(1.5),
                                  2: FlexColumnWidth(1),
                                },
                                defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                                children: [
                                  // Table headers
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: primaryExtraLight,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Item",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Qty (Meter)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Price",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                isSmallScreen ? 12 : 14,
                                                color: primaryDark)),
                                      ),
                                    ],
                                  ),

                                  // Items
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Dc",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (dcWire_qty > 0) {
                                                    dcWire_qty -= 5;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("$dcWire_qty M",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  dcWire_qty += 5;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // dc wire total
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${dcWire_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),
                                  // ac wire
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Ac",
                                            style: TextStyle(
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (acWire_qty > 0) {
                                                    acWire_qty -= 5;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                  isSmallScreen ? 4 : 6),
                                              child: Text("$acWire_qty M",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: isSmallScreen
                                                          ? 12
                                                          : 14)),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  acWire_qty += 5;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primaryLightShade,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add,
                                                    color: primaryColor,
                                                    size: iconsize()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // ac wire total
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${acWire_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                isSmallScreen ? 12 : 14)),
                                      ),
                                    ],
                                  ),

                                  // Total of wires
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: primaryLightShade,
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text("Total :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                isSmallScreen ? 13 : 15,
                                                color: primaryDark)),
                                      ),
                                      SizedBox(), // Empty cell
                                      Padding(
                                        padding: EdgeInsets.all(
                                            isSmallScreen ? 8 : 10),
                                        child: Text(
                                            "₹ ${wire_total.toStringAsFixed(2)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                isSmallScreen ? 13 : 15,
                                                color: primaryDark)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),

                  // Grand Total Row
                  Container(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Grand Total (Including GST):",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹ ${grand_total.toStringAsFixed(2)}", // This should be the sum of all totals
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    ).then(
          (value) {
        // save the value of bom
        controller.savedTerraces[index] = terrace.copyWith(
          f6040: qty6040,
          f4040: qty4040,
          lAngle_qty: lAngle_qty,
          americanBolt_qty: americanBolt_qty,
          zink_qty: zink_qty,
          jBolt_qty: jBolt_qty,
          foundation_qty: foundation_qty,
          dcWire_meter: dcWire_qty,
          acWire_meter: acWire_qty,
        );
      },
    );
  }

  Set<Polygon> _buildPolygons2() {
    final Set<Polygon> allPolygons = {};
    final controller = Get.find<SurveyMapController>();

    // 1. Current working terrace (yellow outline)
    if (controller.polygonPoints.length >= 3 &&
        controller.selectedBuilding.value.isEmpty) {
      allPolygons.add(Polygon(
        polygonId: const PolygonId('current_area'),
        points: List<LatLng>.from(controller.polygonPoints),
        strokeWidth: 4,
        strokeColor: Colors.yellow,
        fillColor: Colors.yellow.withOpacity(0.15),
        consumeTapEvents: true,
      ));
    }

    // 2. Highlighted borders (ONLY shown during active hand rail editing)
    if (controller.isDrawingHandRail.value &&
        controller.polygonPoints.length >= 3) {
      final borderPoints = <LatLng>[];
      List<int> selectedIndices = [];

      if (controller.editingTerraceIndex.value != -1) {
        selectedIndices = controller
            .savedTerraces[controller.editingTerraceIndex.value]
            .selectedBorderIndices;
      }

      // crateing the polygon

      for (int i = 0; i < controller.polygonPoints.length; i++) {
        final nextIndex = (i + 1) % controller.polygonPoints.length;
        if (selectedIndices.contains(i)) {
          borderPoints.add(controller.polygonPoints[i]);
          borderPoints.add(controller.polygonPoints[nextIndex]);
        }
      }
    }

    // 3. Saved terraces and their components (EXCLUDING hand rails)
    controller.savedTerraces.asMap().forEach((index, terrace) {
      final buildingName =
          controller.terraceBuildings[terrace.id] ?? 'Unassigned';

      if (controller.selectedBuilding.value.isNotEmpty &&
          controller.selectedBuilding.value != buildingName) {
        return;
      }

      final isSelected = controller.selectedBuilding.value == buildingName;

      // Terrace boundary (blue/green)
      allPolygons.add(Polygon(
        consumeTapEvents: true,
        polygonId: PolygonId('terrace_$index'),
        points: List<LatLng>.from(terrace.areaPoints),
        strokeWidth: isSelected ? 4 : 3,
        strokeColor: isSelected ? Colors.green : Colors.blue,
        fillColor: isSelected
            ? Colors.green.withOpacity(0.25)
            : Colors.blue.withOpacity(0.15),
        onTap: () {
          if (controller.editingTerraceIndex.value == -1) {
            _handleTerraceTap(index);

            controller.isHorizontal.value = terrace.isHorizontal;
            controller.paddingSliderValue.value = terrace.padding;
            controller.rowSpacingSlidervalue.value = terrace.rowSpacing;
          }
        },
      ));

      // Walkways (orange)
      allPolygons.addAll(terrace.walkways.map((walkway) => Polygon(
        polygonId: PolygonId(walkway.id),
        points: walkway.points,
        strokeWidth: 1,
        strokeColor: Colors.deepOrange,
        fillColor: Colors.deepOrange.withOpacity(0.5),
        consumeTapEvents: true,
      )));

      // Solar panels
      allPolygons.addAll(controller.convertCentersToPolygons(
        terrace.panels,
        terrace.isHorizontal,
      ));
    });

    // 4. Current working panels if not editing
    if (controller.editingTerraceIndex.value == -1 &&
        controller.polygonPoints.length >= 3 &&
        controller.selectedBuilding.value.isEmpty) {
      allPolygons.addAll(controller.solarPanelsPolygons);
    }

    return allPolygons;
  }

  // on map tap
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                    () => CupertinoSlidingSegmentedControl(
                                  backgroundColor: Colors.white54,
                                  thumbColor: AppColors.primaryBlue,
                                  groupValue:
                                  controller.selectedmaserType.value,
                                  children: {"m": Text("m²"), "f": Text("ft²")},
                                  onValueChanged: (value) {
                                    controller.selectedmaserType.value = value!;
                                    if (value == "m") {
                                      controller.showInMeters.value = true;
                                    } else {
                                      controller.showInMeters.value = false;
                                    }
                                    controller.updatePolygon(forceUpdate: true);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Obx(() => Text(
                                'Area: ${controller.showInMeters.value ? '${controller.polygonArea.toStringAsFixed(2)} m²' : '${(controller.polygonArea.value * 10.764).toStringAsFixed(2)} ft²'}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.isRowSelected.value) {
                                    controller.saveEditedTerrace();
                                    controller.clearPolygon();
                                    controller.isSelectingArea.value = false;
                                  } else if (controller
                                      .savedTerraces[controller
                                      .editingTerraceIndex.value]
                                      .panels
                                      .length !=
                                      controller.selectedPanelCount.value) {
                                    showCustomSnackBar(context,
                                        message:
                                        "No Space Available Please Change Number of Panels",
                                        backgroundColor: Colors.red);
                                  } else {
                                    showCustomSnackBar(context,
                                        message: "Please Select Number of Row",
                                        backgroundColor: Colors.red);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.secondaryOrange,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Icon(Icons.clear),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    if (controller.editingTerraceIndex.value !=
                                        -1)
                                      IconButton(
                                        icon: Icon(Icons.undo_outlined),
                                        onPressed: () {
                                          controller.polygonPoints.value =
                                              List.from(controller
                                                  .originalTerracePoints);
                                          controller.updatePolygon();
                                        },
                                      ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    // ... keep existing controls ...
                                    ElevatedButton(
                                      onPressed: () {
                                        if(controller.polygonPoints.isEmpty){
                                          showCustomSnackBar(context,
                                              message:
                                              "Please Select Area To View Panels",
                                              backgroundColor: Colors.red);

                                        }
                                        if (controller
                                            .currentHandRailPoints.length >=
                                            2) {
                                          controller.finishDrawingHandRail();
                                        }
                                        if (controller.polygonPoints.length >=
                                            3) {
                                          print(
                                              "controller.editingTerraceIndex.value ${controller.editingTerraceIndex.value}");
                                          if (controller
                                              .editingTerraceIndex.value !=
                                              -1) {
                                            if (controller
                                                .isRowSelected.value) {
                                              controller.saveEditedTerrace();
                                            } else if (controller
                                                .savedTerraces[controller
                                                .editingTerraceIndex
                                                .value]
                                                .panels
                                                .length !=
                                                controller
                                                    .selectedPanelCount.value) {
                                              showCustomSnackBar(context,
                                                  message:
                                                  "No Space Available Please Change Number of Panels",
                                                  backgroundColor: Colors.red);
                                            } else {
                                              showCustomSnackBar(context,
                                                  message:
                                                  "Please Select Number of Row",
                                                  backgroundColor: Colors.red);
                                            }
                                          } else {
                                            structureTableDilog(
                                                isEditing: false);
                                            print("save changes ==2");
                                          }
                                          if (controller
                                              .polygonPoints.isNotEmpty) {
                                            print("save changes ==3");
                                            final bounds =
                                            controller.getPolygonBounds(
                                                controller.polygonPoints);
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.secondaryOrange,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                      ),
                                      child: Text(
                                        controller.editingTerraceIndex.value !=
                                            -1
                                            ? "Save Changes"
                                            : "Show Panels",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 8,),

                                    ElevatedButton(onPressed: () {
                                      Get.to(()=>SurveyScreen());

                                    }, child: Text("Save"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.secondaryOrange,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                      ),),
                                    // if (controller.editingTerraceIndex.value !=
                                    //     -1)
                                    //   TextButton(
                                    //     onPressed: controller.cancelEditing,
                                    //     child: Text(
                                    //       "Cancel",
                                    //       style: TextStyle(
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.w700),
                                    //     ),
                                    //   ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
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

  Widget editHandrail() {
    return controller.editingTerraceIndex.value != -1
        ? Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(4),
      semanticContainer: true,
      surfaceTintColor: Colors.blue,
      color: Colors.white10,
      shadowColor: Colors.black,
      elevation: 10,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Select Border of Terrace For Hand Rail"),
            SizedBox(
              height: 5,
            ),
            Row(children: [
              ElevatedButton(
                  onPressed: () {
                    // save the selected border
                  },
                  child: Text("Save")),
              ElevatedButton(
                  onPressed: () {
                    // calcle editing
                  },
                  child: Text("Cancle"))
            ]),
          ],
        ),
      ),
    )
        : ElevatedButton(onPressed: () {}, child: Text("Add/Edit Hand rail"));
  }

  structureTableDilog({bool isEditing = false}) {
    final controller = Get.find<SurveyMapController>();
    print("=== DIALOG CALLED ===");
    print("isEditing: $isEditing");
    print("editingTerraceIndex: ${controller.editingTerraceIndex.value}");
    print("savedTerraces length: ${controller.savedTerraces.length}");

    // Get current terrace data if editing
    Terrace? currentTerrace;
    if (isEditing && controller.editingTerraceIndex.value != -1) {
      currentTerrace =
      controller.savedTerraces[controller.editingTerraceIndex.value];
      print("currentTerrace.numberOfRows ${currentTerrace.numberOfRows}");
      print("currentTerrace.mountingStyle ${currentTerrace.mountingStyle}");
      print("currentTerrace.paneltotalWidth ${currentTerrace.paneltotalWidth}");
      print(
          "currentTerrace.inverterPositopn ${currentTerrace.inverterPositopn}");
      print("currentTerrace.frontLegHeight ${currentTerrace.frontLegHeight}");
      print("currentTerrace.backLegHeight ${currentTerrace.backLegHeight}");
      print("currentTerrace.isMeterOrFeet ${currentTerrace.isMeterOrFeet}");
    } else {
      print(
          "Condition not met: isEditing=$isEditing, editingIndex=${controller.editingTerraceIndex.value}");
    }

    showDialog(
      context: context,
      builder: (context) {
        // Get initial values from current terrace or use defaults
        final initialTerraceType = currentTerrace?.terraceType ?? "Rcc Roof";
        final initialIsMeterOrFeet = currentTerrace?.isMeterOrFeet ?? true;
        final initialFrontLeg =
            currentTerrace?.frontLegHeight.toString() ?? "0";
        final initialBackLeg = currentTerrace?.backLegHeight.toString() ?? "0";
        final initialInverterPosition =
            currentTerrace?.inverterPositopn ?? "Ground Floor";

        // Create controllers with correct initial values
        final frontLegController = TextEditingController(text: initialFrontLeg);
        final backLegController = TextEditingController(text: initialBackLeg);

        String currentTerraceType = initialTerraceType;
        bool currentIsMeterOrFeet = initialIsMeterOrFeet;
        String currentInverterPosition = initialInverterPosition;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title:
              Text(isEditing ? "Edit Structure Table" : "Structure Table"),
              content: Form(
                key: controller.StructureTableKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: currentTerraceType,
                      items: ["Rcc Roof"].map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            currentTerraceType = value;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Terrace Type"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Select Terrace Type";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: "Type of Structure",
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                        isExpanded: true,
                        items: ["Hot dig Gi(Galvanised iron)"].map((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Select Structure Type";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),

                    // INVERTER POSITION DROPDOWN - ADD THIS
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Inverter Position",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Select Floor";
                        }
                        return null;
                      },
                      initialValue: isEditing ? currentInverterPosition : null,
                      hint: Text("Select Inverter Position"),
                      items: ["Sidi Room", "Ground Floor"].map(
                            (e) {
                          return DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            currentInverterPosition = value;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10),

                    currentTerraceType == "Rcc Roof"
                        ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text("Meter"),
                            SizedBox(width: 5),
                            Switch(
                              activeThumbColor: Colors.white,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: AppColors.secondaryOrange,
                              activeTrackColor: AppColors.primaryBlue,
                              value: currentIsMeterOrFeet,
                              onChanged: (value) {
                                setState(() {
                                  currentIsMeterOrFeet = value;
                                });
                              },
                            ),
                            SizedBox(width: 5),
                            Text("Feet"),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          controller: frontLegController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    int val = int.tryParse(
                                        frontLegController.text) ??
                                        0;
                                    val += 1;
                                    frontLegController.text =
                                        val.toString();
                                    setState(() {});
                                  },
                                  child:
                                  Icon(Icons.arrow_drop_up_outlined),
                                ),
                                InkWell(
                                  onTap: () {
                                    int val = int.tryParse(
                                        frontLegController.text) ??
                                        0;
                                    val -= 1;
                                    if (val <= 0) val = 0;
                                    frontLegController.text =
                                        val.toString();
                                    setState(() {});
                                  },
                                  child: Icon(
                                      Icons.arrow_drop_down_outlined),
                                ),
                              ],
                            ),
                            labelText: !currentIsMeterOrFeet
                                ? "FrontLeg Height -(Meter)"
                                : "FrontLeg Height -(Feet)",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == 0 ||
                                value == "0") {
                              return "Please Enter FrontLeg Height";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        // TextFormField(
                        //   autovalidateMode: AutovalidateMode.onUserInteraction,
                        //   controller: backLegController,
                        //   readOnly: true,
                        //   decoration: InputDecoration(
                        //     suffixIcon: Column(
                        //       children: [
                        //         InkWell(
                        //           onTap: () {
                        //             int val = int.tryParse(backLegController.text) ?? 0;
                        //             val += 1;
                        //             backLegController.text = val.toString();
                        //             setState(() {});
                        //           },
                        //           child: Icon(Icons.arrow_drop_up_outlined),
                        //         ),
                        //         InkWell(
                        //           onTap: () {
                        //             int val = int.tryParse(backLegController.text) ?? 0;
                        //             val -= 1;
                        //             if (val <= 0) val = 0;
                        //             backLegController.text = val.toString();
                        //             setState(() {});
                        //           },
                        //           child: Icon(Icons.arrow_drop_down_outlined),
                        //         ),
                        //       ],
                        //     ),
                        //     labelText: !currentIsMeterOrFeet
                        //         ? "BackLeg Height -(Meter)"
                        //         : "BackLeg Height -(Feet)",
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   validator: (value) {
                        //     if(value == null || value.isEmpty || value == 0 || value == "0"){
                        //       return "Please Enter BackLeg Height";
                        //     }
                        //   },
                        // ),
                      ],
                    )
                        : SizedBox(),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller.editingTerraceIndex.value = -1;
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    bool isValidate =
                        controller.StructureTableKey.currentState?.validate() ??
                            false;
                    if (isValidate) {
                      if (isEditing &&
                          controller.editingTerraceIndex.value != -1) {
                        final index = controller.editingTerraceIndex.value;
                        final terrace = controller.savedTerraces[index];

                        controller.savedTerraces[index] = terrace.copyWith(
                          terraceType: currentTerraceType,
                          isMeterOrFeet: currentIsMeterOrFeet,
                          frontLegHeight:
                          int.tryParse(frontLegController.text) ?? 0,
                          backLegHeight:
                          int.tryParse(backLegController.text) ?? 0,
                          inverterPositopn:
                          currentInverterPosition, // SAVE INVERTER POSITION
                        );

                        controller.calculateBom(index);
                        controller.editingTerraceIndex.value = -1;
                      } else {
                        controller.calculateSolarPanels1();
                        controller.saveCurrentTerrace();

                        final newIndex = controller.savedTerraces.length - 1;
                        controller.savedTerraces[newIndex] =
                            controller.savedTerraces[newIndex].copyWith(
                              terraceType: currentTerraceType,
                              isMeterOrFeet: currentIsMeterOrFeet,
                              frontLegHeight:
                              int.tryParse(frontLegController.text) ?? 0,
                              backLegHeight:
                              int.tryParse(backLegController.text) ?? 0,
                              inverterPositopn: currentInverterPosition,
                              // SAVE INVERTER POSITION
                            );
                        controller.totalPanelWidth.value =
                            controller.getPanelStructureWidth();
                        controller.totalPanelHeight.value =
                            controller.getPanelStructureHeight();
                        controller.startEditingTerrace(newIndex);
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditing ? "Save Changes" : "Show Panels"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // structureTableDilog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
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
  //                   } else {
  //                     return null;
  //                   }
  //                 },
  //                 decoration: InputDecoration(labelText: "Terrace Type"),
  //                 hint: Text("Select Terrace type"),
  //                 items: ["Rcc Roof", "Slant Roof", "Ground Mountain"].map((e) {
  //                   return DropdownMenuItem<String>(
  //                     value: e,
  //                     child: Text(e),
  //                   );
  //                 }).toList(),
  //                 onChanged: (value) {
  //                   if (value != null) controller.terraceType.value = value;
  //                 },
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Obx(
  //                 () {
  //                   return controller.terraceType.value == "Rcc Roof"
  //                       ? Column(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Text("Meter"),
  //                                 SizedBox(
  //                                   width: 5,
  //                                 ),
  //                                 Obx(
  //                                   () => Switch(
  //                                     inactiveThumbColor: white,
  //                                     inactiveTrackColor: AppColors.secondaryOrange,
  //                                     activeTrackColor: AppColors.primaryBlue,
  //                                     value: controller
  //                                         .isMeaterorFeet_strucrt.value,
  //                                     onChanged: (value) {
  //                                       controller.isMeaterorFeet_strucrt
  //                                           .value = value;
  //                                       print(
  //                                           "${controller.isMeaterorFeet_strucrt.value}");
  //                                     },
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 5,
  //                                 ),
  //                                 Text("Feet"),
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: 10,
  //                             ),
  //                             Obx(
  //                               () => TextFormField(
  //                                 autovalidateMode:
  //                                     AutovalidateMode.onUserInteraction,
  //                                 validator: (value) {
  //                                   if (value == "0" ||
  //                                       value == null ||
  //                                       value.isEmpty) {
  //                                     return "Please Enter Front Leg Height";
  //                                   } else {
  //                                     return null;
  //                                   }
  //                                 },
  //                                 readOnly: true,
  //                                 controller: controller.frontLegController,
  //                                 decoration: InputDecoration(
  //                                     suffixIcon: Column(
  //                                       children: [
  //                                         InkWell(
  //                                             onTap: () {
  //                                               int val = int.tryParse(
  //                                                       controller
  //                                                           .frontLegController
  //                                                           .text) ??
  //                                                   0;
  //                                               val += 1;
  //                                               controller.frontLegController
  //                                                   .text = val.toString();
  //                                             },
  //                                             child: Icon(Icons
  //                                                 .arrow_drop_up_outlined)),
  //                                         InkWell(
  //                                             onTap: () {
  //                                               int val = int.tryParse(
  //                                                       controller
  //                                                           .frontLegController
  //                                                           .text) ??
  //                                                   0;
  //                                               val -= 1;
  //                                               if (val <= 0) {
  //                                                 val = 0;
  //                                               }
  //                                               controller.frontLegController
  //                                                   .text = val.toString();
  //                                             },
  //                                             child: Icon(Icons
  //                                                 .arrow_drop_down_outlined)),
  //                                       ],
  //                                     ),
  //                                     labelText: !controller
  //                                             .isMeaterorFeet_strucrt.value
  //                                         ? "FrontLeg Height -(Meter)"
  //                                         : "FrontLeg Height -(Feet)",
  //                                     border: OutlineInputBorder()),
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height: 10,
  //                             ), //
  //                             Obx(
  //                               () => TextFormField(
  //                                 autovalidateMode:
  //                                     AutovalidateMode.onUserInteraction,
  //                                 validator: (value) {
  //                                   if (value == "0" ||
  //                                       value == null ||
  //                                       value.isEmpty) {
  //                                     return "Please Enter Back Leg Height";
  //                                   } else {
  //                                     return null;
  //                                   }
  //                                 },
  //                                 readOnly: true,
  //                                 controller: controller.backLegController,
  //                                 decoration: InputDecoration(
  //                                     suffixIcon: Column(
  //                                       children: [
  //                                         InkWell(
  //                                             onTap: () {
  //                                               int val = int.tryParse(
  //                                                       controller
  //                                                           .backLegController
  //                                                           .text) ??
  //                                                   0;
  //                                               val += 1;
  //                                               controller.backLegController
  //                                                   .text = val.toString();
  //                                               controller.sliderLimit.value =
  //                                                   val * 1.5;
  //                                             },
  //                                             child: Icon(Icons
  //                                                 .arrow_drop_up_outlined)),
  //                                         InkWell(
  //                                             onTap: () {
  //                                               int val = int.tryParse(
  //                                                       controller
  //                                                           .backLegController
  //                                                           .text) ??
  //                                                   0;
  //                                               val -= 1;
  //                                               if (val <= 0) {
  //                                                 val = 0;
  //                                               }
  //                                               controller.backLegController
  //                                                   .text = val.toString();
  //                                               controller.sliderLimit.value =
  //                                                   val * 1.5;
  //                                             },
  //                                             child: Icon(Icons
  //                                                 .arrow_drop_down_outlined)),
  //                                       ],
  //                                     ),
  //                                     labelText: !controller
  //                                             .isMeaterorFeet_strucrt.value
  //                                         ? "BackLeg Height -(Meter)"
  //                                         : "BackLeg Height -(Feet)",
  //                                     border: OutlineInputBorder()),
  //                               ),
  //                             ),
  //                           ],
  //                         )
  //                       : controller.terraceType.value == "Slant Roof"
  //                           ? Column(
  //                               children: [
  //                                 DropdownButtonFormField<String>(
  //                                   autovalidateMode:
  //                                       AutovalidateMode.onUserInteraction,
  //
  //                                   decoration: InputDecoration(
  //                                       labelText: "Walkway Width"),
  //                                   // hint: Text("1"),
  //                                   items: [
  //                                     "270",
  //                                     "273",
  //                                     "305",
  //                                     "310",
  //                                     "350",
  //                                     "400",
  //                                     "500",
  //                                   ].map((e) {
  //                                     return DropdownMenuItem<String>(
  //                                       value: e,
  //                                       child: Text("$e MM"),
  //                                     );
  //                                   }).toList(),
  //                                   onChanged: (value) {
  //                                     if (value != null) {
  //                                       controller.selectedWalkwayWidth.value =
  //                                           value;
  //                                     }
  //                                   },
  //                                 ),
  //                                 SizedBox(
  //                                   height: 10,
  //                                 ),
  //                                 DropdownButtonFormField<String>(
  //                                   autovalidateMode:
  //                                       AutovalidateMode.onUserInteraction,
  //                                   decoration: InputDecoration(
  //                                       labelText: "Walkway Thickness"),
  //                                   // hint: Text("1"),
  //                                   items: ["25", "30", "38", "40"].map((e) {
  //                                     return DropdownMenuItem<String>(
  //                                       value: e,
  //                                       child: Text("$e MM"),
  //                                     );
  //                                   }).toList(),
  //                                   onChanged: (value) {},
  //                                 ),
  //                               ],
  //                             )
  //                           : Column(
  //                               children: [Text("Ground mountain")],
  //                             );
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 controller.saveEditedTerrace();
  //               },
  //               child: Text("Cancle")),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           TextButton(
  //               onPressed: () {
  //                 bool isValidate =
  //                     controller.tableStructureKey.currentState?.validate() ??
  //                         false;
  //                 if (isValidate) {
  //                   controller.calculateSolarPanels1();
  //                   controller.saveCurrentTerrace();
  //
  //                   final currentIndex = controller.savedTerraces.length -
  //                       1; // Get the newly created terrace index
  //                   controller.startEditingTerrace(currentIndex);
  //                   Navigator.pop(context);
  //
  //                   // navigator.push
  //                   // navigator.pop(context);
  //                 }
  //               },
  //               child: Text("Show Panels"))
  //         ],
  //       );
  //     },
  //   );
  // }

  _handleWhatsapp() {
    TextEditingController moNumbercontroller = TextEditingController();
    // Implement whatsapp functionality
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Location"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Get Current Location of Coustmer From Whatsapp"),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: moNumbercontroller,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Whatsapp Number';
                  } else if (value.length < 10) {
                    return 'Please Enter Whatsapp Number';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Enter Whatsapp Number',
                  contentPadding:
                  EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                //  Get from Whatsapp
                onPressed: () {
                  controller.requestLocation(moNumbercontroller.text);
                },
                child: Text("Get From Whatsapp"),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              )
            ],
          ),
        );
      },
    );
  }

  Widget drawer() {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      width: screenWidth * 0.6,
      elevation: 8,
      shadowColor: Colors.grey,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.drawerKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Obx(
                          () => DropdownSearch<Common_Model>(
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        popupProps: PopupProps.dialog(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              hintText: "Search by District",
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                            ),
                          ),
                          title: Container(
                            color: Colors.white,
                            // Set the background color of the title to white
                            padding: EdgeInsets.all(20),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'Select District',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -15,
                                  right: -15,
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the popup
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          containerBuilder: (ctx, popupWidget) {
                            return Container(
                              color: Colors.white,
                              // Set the background color of the whole dialog to white
                              child: popupWidget,
                            );
                          },
                        ),
                        items: controller.district_list,
                        itemAsString: (Common_Model u) => u.name,
                        selectedItem: controller.district_list.firstWhere(
                              (element) =>
                          element.id == controller.dropdown_district_id,
                          orElse: () =>
                              Common_Model(id: '', name: 'Select District'),
                        ),
                        onChanged: (Common_Model? newValue) {
                          if (newValue != null) {
                            print('newValue $newValue');
                            controller.dropdown_district_id.value = newValue.id;
                            controller.get_Type(
                                controller.dropdown_district_id.value);
                            controller.dropdown_panel_wats_name.value = "";
                            controller.selectedKW.value = "";
                            controller.numberOfPanels.value = "";
                            controller.dropdown_solar_technology_id.value == '';
                            controller.projectTypeId.value = "";
                            controller.dropdown_solar_technology_id.value = "";
                          }else{
                            print("new value is null");
                          }
                        },

                        validator: (value) {
                          if (controller.dropdown_district_id == "") {
                            return "Please Select district";
                          } else {
                            return null;
                          }
                        },
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "District*",
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Select technology
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Obx(
                          () => DropdownButtonFormField<Project_type_model>(
                        isExpanded: true, // This allows the dropdown to expand
                        selectedItemBuilder: (context) {
                          return controller.projectTypeList.map((element) {
                            String displayText = element.name.length > 25
                                ? '${element.name.substring(0, 22)}...'
                                : element.name;
                            return Container(
                              constraints: BoxConstraints(
                                maxWidth: screenWidth * 0.45,
                              ),
                              child: Text(
                                displayText,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13),
                                maxLines: 1,
                              ),
                            );
                          }).toList();
                        },
                        initialValue: controller.projectTypeList.isEmpty
                            ? null
                            : controller.projectTypeId.value == ""
                            ? null
                            : controller.projectTypeList.firstWhere(
                              (element) => element.id == controller.projectTypeId.value,
                          orElse: () => Project_type_model(
                              id: '0',
                              name: 'Project Type',
                              minRange: '',
                              maxRange: '',
                              slotRange: '',
                              tax: '',
                              slot: '',
                              customizedKitMargin: '',
                              comboKitMargin: ''),
                        ),
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: "Project Type",
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: controller.projectTypeList.map(
                              (element) {
                            // Truncate long text in dropdown items
                            String displayText = element.name.length > 35
                                ? '${element.name.substring(0, 32)}...'
                                : element.name;
                            return DropdownMenuItem<Project_type_model>(
                              value: element,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.45,
                                ),
                                child: Text(
                                  displayText,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13),
                                  maxLines: 1,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          controller.projectTypeId.value = value!.id;
                          controller.dropdown_panel_wats_name.value = "";
                          controller.selectedKW.value = "";
                          controller.numberOfPanels.value = "";
                          controller.dropdown_solar_technology_id.value == '';
                          controller.minRange.value = int.tryParse(value.minRange) ?? 5000;
                          controller.getPanelTechnology();
                        },
                        validator: (value) {
                          if (value == null ||
                              controller.projectTypeId.value == "" ||
                              controller.projectTypeId.value == "0") {
                            return "Please Select Project Type";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Obx(
                          () => DropdownButtonFormField<Common_Model>(
                        initialValue: controller.panel_technology_list.isEmpty
                            ? null
                            : (controller.dropdown_solar_technology_id.value ==
                            ''
                            ? controller.panel_technology_list
                            .first // Automatically selects the first item
                            : controller.panel_technology_list.firstWhere(
                              (e) =>
                          e.id ==
                              controller
                                  .dropdown_solar_technology_id.value,
                          orElse: () => controller
                              .panel_technology_list
                              .first, // Providing the first item as a fallback value
                        )),
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: "Technology",
                        ),
                        validator: (value) {
                          if (controller.dropdown_solar_technology_id.value ==
                              "" ||
                              value?.name == "Technology") {
                            return "Please select technology";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: controller.panel_technology_list.map(
                              (e) {
                            return DropdownMenuItem<Common_Model>(
                              child: Text(e.name),
                              value: e,
                            );
                          },
                        ).toList(),
                        onChanged: (value) async {
                          print(value!.id);
                          controller.dropdown_panel_wats_name.value = "";
                          controller.selectedKW.value = "";
                          controller.numberOfPanels.value = "";
                          controller.dropdown_solar_technology_id.value =
                              value.id;

                          await controller
                              .getPanelWats(controller.projectTypeId.value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  // panel watt
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Obx(
                          () => DropdownButtonFormField<Common_Model>(
                        dropdownColor: Colors.white,

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: controller.panel_wats_list.isEmpty
                            ? null
                            : (controller.dropdown_panel_wats_name.value == ''
                            ? controller.panel_wats_list
                            .first // Automatically selects the first item
                            : controller.panel_wats_list.firstWhere(
                              (e) =>
                          e.watt ==
                              controller
                                  .dropdown_panel_wats_name.value,
                          orElse: () => controller.panel_wats_list
                              .first, // Providing the first item as a fallback value
                        )),
                        items: controller.panel_wats_list.map(
                              (e) {
                            return DropdownMenuItem<Common_Model>(
                              child: Text(e.watt),
                              value: e,
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          controller.selectedKW.value = "";
                          controller.numberOfPanels.value = "";
                          controller.dropdown_panel_wats_name.value =
                              value!.watt;
                          controller.get_KW(
                              controller.projectTypeId.value,
                              controller.Application_login_id.value,
                              controller.minRange.value);
                        },
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                          hintText: "panel watt",
                          labelText: "panel watt",
                        ),
                        borderRadius: BorderRadius.circular(0),
                        validator: (value) {
                          if (controller.dropdown_panel_wats_name.value == "" ||
                              value == null ||
                              value.watt == "panel watt" ||
                              value.name == "panel watt") {
                            return "Please select solar panel watt";
                          }
                          return null;
                        },

                        //
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  // number of pannels
                  Obx(() => SizedBox(
                    width: screenWidth * 0.5,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: controller.numberOfPanels.value == ""
                          ? null
                          : controller.numberOfPanels.value,
                      hint: Text(
                        "Number of Panels",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      items: controller.nofpanelList.map((count) {
                        return DropdownMenuItem(
                          value: count,
                          child: Text("${count}"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedKW.value = "";
                          controller.numberOfPanels.value =
                              value.toString();
                          controller.selectedPanelCount.value =
                              int.parse(value.toString());
                          print(
                              "controller.selectedPanelCount.value ${controller.selectedPanelCount.value}");
                          controller.hasSelectedPanelCount.value = true;
                          controller.updateAvailableRows();
                          controller.get_KW(
                              controller.projectTypeId.value,
                              controller.Application_login_id.value,
                              controller.minRange.value);
                          // get kw call api
                        }
                      },
                      validator: (value) {
                        if (value == null ||
                            value.toString().isEmpty ||
                            controller.numberOfPanels.value == "") {
                          return "Please Select Number of Panels";
                        }
                        return null;
                      },
                    ),
                  )),

                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Obx(
                          () => DropdownButtonFormField<Common_Model>(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        initialValue: controller.KW_list.isEmpty
                            ? null
                            : (controller.selectedKW.value == ""
                            ? null
                            : controller.KW_list.firstWhere(
                              (e) =>
                          e.kilowat ==
                              controller.selectedKW.value,
                          orElse: () => Common_Model(
                              id: "0", kilowat: "kilowatt", kw: "0"),
                        )),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hint: Text(
                          "Kilowatt",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        items: controller.KW_list.map(
                              (e) {
                            return DropdownMenuItem<Common_Model>(
                              value: e,
                              child: Text(
                                "${e.kilowat} KW",
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          if (value != null ||
                              value?.kilowat == "kilowatt" ||
                              controller.selectedKW.value == "") {
                            controller.selectedKW.value = value!.kilowat;
                            print(
                                "controller.selectedKW.value ${controller.selectedKW.value}");
                          }
                        },
                        validator: (value) {
                          if (value == null || value.id.isEmpty) {
                            return "PLease Select Kilowatt";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(() => ElevatedButton(
                    onPressed: () {
                      bool validate =
                          controller.drawerKey.currentState?.validate() ??
                              false;
                      if (validate) {
                        _createNewBuilding(context);
                      } else {
                        showCustomSnackBar(context,
                            message: "Please select Number of panels",
                            backgroundColor: Colors.red);
                      }
                    },
                    child: Text("New Building"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor:
                      controller.hasSelectedPanelCount.value
                          ? AppColors.secondaryOrange
                          : Colors.grey,
                    ),
                  )),
                  Expanded(
                    child: Obx(() {
                      final buildingData = <String, double>{};
                      //
                      // controller.savedTerraces.forEach((terrace) {
                      //   final buildingName =
                      //       controller.terraceBuildings[terrace.id] ??
                      //           'Unassigned';
                      //   final kw = (terrace.panels.length * 545) / 1000;
                      //   buildingData[buildingName] =
                      //       (buildingData[buildingName] ?? 0) + kw;
                      // });

                      if (controller.currentBuilding.value.isNotEmpty) {
                        buildingData[controller.currentBuilding.value] = 0.0;
                      }

                      // Then add buildings that have terraces
                      controller.savedTerraces.forEach((terrace) {
                        final buildingName =
                            controller.terraceBuildings[terrace.id] ??
                                'Unassigned';
                        final kw = (terrace.panels.length *
                            num.parse(controller
                                .dropdown_panel_wats_name.value)) /
                            1000;
                        buildingData[buildingName] =
                            (buildingData[buildingName] ?? 0) + kw;
                      });

                      return ListView(
                        children: [
                          ...buildingData.entries.map((entry) => Card(
                            elevation: 8,
                            color: controller.selectedBuilding.value ==
                                entry.key
                                ? Colors.blue[100]
                                : Colors.white,
                            child: InkWell(
                              onTap: () {
                                print("Entery.key ${entry.key}");
                                controller.toggleBuildingSelection(entry
                                    .key); // show only selected building terraces
                              },
                              child: ListTile(
                                title: Text(entry.key),
                                subtitle: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text:
                                              "${entry.value.toStringAsFixed(2)}KW"),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              _deleteBuilding(entry.key);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                        InkWell(
                                            onTap: () {
                                              // show dilog here
                                              _showBuildingTerracesDialog(
                                                  entry.key);
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.blueAccent,
                                            )),
                                        InkWell(
                                          onTap: () {},
                                          child: Card(
                                              color: AppColors.secondaryOrange,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    5.0),
                                                child: Text(
                                                  "BOM",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
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
              // Filter terraces belonging to this building
              final buildingTerraces = controller.savedTerraces
                  .where((terrace) =>
              controller.terraceBuildings[terrace.id] == buildingName)
                  .toList();

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (buildingTerraces.isEmpty) const Text("No terraces found"),
                  ...buildingTerraces.map((terrace) {
                    final index = controller.savedTerraces.indexOf(terrace);
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
                                Text(
                                  "Terrace ${index + 1}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue[700],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 20, color: Colors.red),
                                  onPressed: () {
                                    controller.savedTerraces.removeAt(index);
                                    controller.terraceBuildings
                                        .remove(terrace.id);
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
                                Obx(() => Text(
                                  controller.showInMeters.value
                                      ? '${controller.calculatePolygonArea(terrace.areaPoints).toStringAsFixed(2)} m²'
                                      : '${(controller.calculatePolygonArea(terrace.areaPoints) * 10.764).toStringAsFixed(2)} ft²',
                                )),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Solar Panels: "),
                                Text("${terrace.panels.length}"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Kw:"),
                                Text("${(terrace.panels.length * 545) / 1000}"),
                              ],
                            ),
                            if (terrace.hasGril)
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Hand Rail"),
                                  Text(
                                      "${controller.calculateHandRailLength(terrace.handRailPoints).toStringAsFixed(2)}m")
                                ],
                              )
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _deleteBuilding(String buildingName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Building?"),
        content: Text(
            "Are you sure you want to delete '$buildingName' and all its terraces?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Remove all terraces belonging to this building
              controller.savedTerraces.removeWhere((terrace) {
                final terraceBuilding =
                    controller.terraceBuildings[terrace.id] ?? '';
                if (terraceBuilding == buildingName) {
                  // Also remove the building association
                  controller.terraceBuildings.remove(terrace.id);
                  return true;
                }
                return false;
              });

              // Clear selection if it was this building
              if (controller.selectedBuilding.value == buildingName) {
                controller.selectedBuilding.value = '';
              }

              // Recalculate panels
              controller.calculateAllPanels();

              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget addGril() {
    final controller = Get.find<SurveyMapController>();

    return Obx(() {
      if (controller.terraceType.value != "Slant Roof") return SizedBox();

      return Column(
        children: [
          if (controller.isDrawingHandRail.value)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Tap borders in order to create hand rail",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: controller.finishDrawingHandRail,
                          child: Text("Save"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            controller.isDrawingHandRail.value = false;
                            controller.currentHandRailPoints.clear();
                          },
                          child: Text("Cancel"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (!controller.isDrawingHandRail.value)
            ElevatedButton(
              onPressed: controller.startDrawingHandRail,
              child: Text("Add/Edit Hand Rail"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.secondaryOrange,
              ),
            ),
        ],
      );
    });
  }

  // code for walk way
  Widget _buildWalkwayControls() {
    final controller = Get.find<SurveyMapController>();

    return Obx(() {
      if (controller.terraceType.value != "Slant Roof") return SizedBox();

      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              controller.addWalkway();
              controller.updatePanelPositions();
            },
            child: Text("Add Walkway"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.secondaryOrange,
            ),
          ),

          // if (controller.editingWalkwayIndex.value != -1)
          //   _buildWalkwayEditControls(),
        ],
      );
    });
  }

  Widget _buildWalkwayEditControls() {
    final controller = Get.find<SurveyMapController>();

    return Obx(() {
      if (controller.editingWalkwayIndex.value < 0 ||
          controller.editingWalkwayIndex.value >=
              controller.currentWalkways.length) {
        return SizedBox();
      }

      final index = controller.editingWalkwayIndex.value;
      final walkway = controller.currentWalkways[index];
      final isHorizontal = walkway.isHorizontal;

      // Calculate max length based on terrace dimensions
      double maxLength;
      if (walkway.isHorizontal) {
        // For horizontal walkways, max length is terrace width
        final terrace =
        controller.savedTerraces[controller.editingTerraceIndex.value];
        final bounds = controller.getPolygonBounds(terrace.areaPoints);
        maxLength = (bounds.northeast.longitude - bounds.southwest.longitude) *
            111111 *
            cos(bounds.southwest.latitude * pi / 180);
      } else {
        // For vertical walkways, max length is terrace height
        final terrace =
        controller.savedTerraces[controller.editingTerraceIndex.value];
        final bounds = controller.getPolygonBounds(terrace.areaPoints);
        maxLength =
            (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
      }

      // Ensure reasonable bounds
      final minLength = 1.0;
      maxLength = max(minLength * 1.1, maxLength); // Ensure max > min
      final currentLength = walkway.length.clamp(minLength, maxLength);

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Walkway ${index + 1}",
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              SizedBox(height: 8),

              //
              // Padding(
              //   padding: const EdgeInsets.only(top: 0,right: 8,left: 8),
              //   child: Text("Length: ${walkway.length.toStringAsFixed(2)}m"),
              // ),
              // SizedBox(
              //   height: 50,
              //   width: 120,
              //   child: Slider(
              //     thumbColor: AppColors.secondaryOrange,
              //     min: minLength,
              //     max: maxLength,
              //     value: currentLength,
              //     onChanged: (value) {
              //       controller.updateWalkwayLength(index, value);
              //     },
              //   ),
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(width: 15,),
              //     CupertinoSlidingSegmentedControl(
              //       thumbColor: AppColors.primaryBlue,
              //       groupValue: isHorizontal ? "H" : "V",
              //       children: {"H": Text("H"), "V": Text("V")},
              //       onValueChanged: (value) {
              //         controller.toggleWalkwayOrientation(index);
              //         controller.updatePanelPositions();
              //       },
              //     ),
              //   ],
              // ),
              //
              // SizedBox(height: 8),
              // Padding(
              //   padding: const EdgeInsets.only(top: 0,right: 8,left: 8),
              //   child: Center(
              //     child: ElevatedButton(
              //       onPressed: () {
              //         controller.removeWalkway(index);
              //         controller.editingWalkwayIndex.value = -1;
              //         controller.updatePanelPositions();
              //       },
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.red,
              //           foregroundColor: Colors.white
              //       ),
              //       child: Text("Delete"),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }

  Set<Polyline> _buildTerraceBorderPolylines() {
    final controller = Get.find<SurveyMapController>();
    final polylines = <Polyline>{};

    if (controller.polygonPoints.length >= 2) {
      final points = List<LatLng>.from(controller.polygonPoints);
      if (points.length >= 3 && points.first == points.last) {
        points.removeLast();
      }

      // Only show special border styling during ACTIVE hand rail editing
      if (controller.isDrawingHandRail.value) {
        List<int> selectedIndices = [];
        if (controller.editingTerraceIndex.value != -1) {
          selectedIndices = controller
              .savedTerraces[controller.editingTerraceIndex.value]
              .selectedBorderIndices;
        }

        for (int i = 0; i < points.length; i++) {
          final isSelected = selectedIndices.contains(i);
          polylines.add(Polyline(
            polylineId: PolylineId('terrace_border_$i'),
            points: [points[i], points[(i + 1) % points.length]],
            color: isSelected ? Colors.black : Colors.transparent,
            // Only show selected borders in black
            width: isSelected ? 6 : 0,
            consumeTapEvents: true,
            onTap: () => controller.toggleBorderSelection(i),
          ));
        }
      } else {
        // Normal border styling (no hand rail editing)
        for (int i = 0; i < points.length; i++) {
          polylines.add(Polyline(
            polylineId: PolylineId('terrace_border_$i'),
            points: [points[i], points[(i + 1) % points.length]],
            color: Colors.white.withOpacity(0.7),
            // Default white border
            width: 2,
            consumeTapEvents: false,
          ));
        }
      }
    }
    return polylines;
  }

  Set<Polyline> _buildHandRailPolylines() {
    final controller = Get.find<SurveyMapController>();
    final polylines = <Polyline>{};

    // Draw each selected border as a separate segment
    for (int i = 0; i < controller.currentHandRailPoints.length; i += 2) {
      if (i + 1 < controller.currentHandRailPoints.length) {
        polylines.add(Polyline(
          polylineId: PolylineId('handrail_${i ~/ 2}'),
          points: [
            controller.currentHandRailPoints[i],
            controller.currentHandRailPoints[i + 1]
          ],
          color: Colors.black,
          width: 5,
        ));
      }
    }

    return polylines;
  }

  Set<Polygon> _buildWalkwayPolygons() {
    final controller = Get.find<SurveyMapController>();
    final polygons = <Polygon>{};

    for (final walkway in controller.currentWalkways) {
      polygons.add(walkway.toPolygon());
    }

    return polygons;
  }

  LatLng _getWalkwayEndPoint(Walkway walkway) {
    if (walkway.points.isEmpty) return LatLng(0, 0);

    // For horizontal walkways, find midpoint of right edge
    if (walkway.isHorizontal) {
      // Points 1 and 2 are the right edge (assuming standard polygon creation order)
      final p1 = walkway.points[1];
      final p2 = walkway.points[2];
      return LatLng(
        (p1.latitude + p2.latitude) / 2,
        (p1.longitude + p2.longitude) / 2,
      );
    }
    // For vertical walkways, find midpoint of top edge
    else {
      // Points 0 and 1 are the top edge
      final p1 = walkway.points[0];
      final p2 = walkway.points[1];
      return LatLng(
        (p1.latitude + p2.latitude) / 2,
        (p1.longitude + p2.longitude) / 2,
      );
    }
  }

  // testing
  Set<Marker> _buildWalkwayMarkers() {
    final controller = Get.find<SurveyMapController>();
    final markers = <Marker>{};

    for (int i = 0; i < controller.currentWalkways.length; i++) {
      final walkway = controller.currentWalkways[i];

      // Find the midpoint of the "end edge" of the walkway
      final endPoint = _getWalkwayEndPoint(walkway);

      markers.add(Marker(
        markerId: MarkerId('walkway_${walkway.id}'),
        position: endPoint,
        icon: controller.walkWayIcon.value,
        draggable: true,
        infoWindow: InfoWindow(
          title: 'Walkway ${i + 1}',
          snippet: 'Tap to edit',
          onTap: () {
            controller.editingWalkwayIndex.value = i;
            controller.update();
          },
        ),
        onDragStart: (value) {
          HapticFeedback.vibrate();
          controller.editingWalkwayIndex.value = i;
        },
        onDrag: (newPosition) {
          // Calculate translation needed
          final translation = LatLng(
            newPosition.latitude - endPoint.latitude,
            newPosition.longitude - endPoint.longitude,
          );

          // Apply same translation to all points
          final newPoints = walkway.points
              .map((point) => LatLng(
            point.latitude + translation.latitude,
            point.longitude + translation.longitude,
          ))
              .toList();

          controller.updateWalkwayPoints(i, newPoints);
          controller.updatePanelPositions();
        },
        onDragEnd: (value) {
          controller.updatePanelPositions();
        },
      ));
    }

    return markers;
  }

  // buildmarks
  Set<Marker> _buildMarkers() {
    final controller = Get.find<SurveyMapController>();
    final markers = <Marker>{};

    // Always show location marker
    if (!controller.isSelectingArea.value) {
      markers.add(
        Marker(
          markerId: MarkerId("PickLocation"),
          position: controller.pickedLocation.value,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    // Always show distance markers
    markers.addAll(controller.distanceMarkers);

    if (controller.editingTerraceIndex.value != -1) {
      final terrace =
      controller.savedTerraces[controller.editingTerraceIndex.value];
      if (terrace.panels.isNotEmpty) {
        // Update drag handle position to panel center when not manually dragging
        if (!controller.isManuallyDraggingHandle.value) {
          final panelsCenter = controller.getPanelsCenter(terrace.panels);
          controller.dragHandlePosition.value = panelsCenter;
        }

        markers.add(Marker(
          markerId: MarkerId('panels_drag_handle'),
          position: controller.dragHandlePosition.value,
          icon: controller.panelDrageIcos.value,
          draggable: true,
          onDragStart: (position) {
            HapticFeedback.vibrate();
            controller.isManuallyDraggingHandle.value = true;
            controller.dragHandlePosition.value = position;
            controller.originalPanelCenters.value = List.from(terrace.panels);
            controller.isDraggingPanel.value = true;
          },
          onDrag: (position) {
            if (controller.editingTerraceIndex.value != -1) {
              // Calculate movement delta
              final latDelta = position.latitude -
                  controller.dragHandlePosition.value.latitude;
              final lngDelta = position.longitude -
                  controller.dragHandlePosition.value.longitude;

              // Update drag handle position
              controller.dragHandlePosition.value = position;

              // CALL moveAllPanels HERE - this moves all panels together
              controller.moveAllPanels(latDelta, lngDelta);
              controller.detectAndHighlightLayout();
            }
          },
          onDragEnd: (position) {
            controller.isManuallyDraggingHandle.value = false;
            controller.isDraggingPanel.value = false;
            controller.originalPanelCenters.clear();

            // After dragging, ensure drag handle is at the new center
            final terrace =
            controller.savedTerraces[controller.editingTerraceIndex.value];
            final newCenter = controller.getPanelsCenter(terrace.panels);
            controller.dragHandlePosition.value = newCenter;
          },
        ));
      }
    }

    // Always show draggable boundary markers (only when editing terrace)

    markers.addAll(controller.polygonPoints.asMap().entries.map((entry) {
      final index = entry.key;
      final point = entry.value;
      return Marker(
        draggable: true,
        onDragStart: (_) => HapticFeedback.vibrate(),
        onDrag: (newPosition) {
          controller.detectAndHighlightLayout();
          controller.polygonPoints[index] = newPosition;
          controller.updatePolygon(forceUpdate: true);
        },
        onDragEnd: (newPosition) => _handleMarkerDrag(index, newPosition),
        markerId: MarkerId('polygon_point_$index'),
        position: point,
        icon: controller.boundaryIcon.value,
        infoWindow: InfoWindow(
          title: 'Point ${index + 1} ✖',
          onTap: () {
            controller.polygonPoints.removeAt(index);
            controller.updatePolygon();
          },
        ),
      );
    }));

    return markers;
  }
}

class LayoutSelectorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SurveyMapController controller = Get.find();

    return Container(
      width: 120,
      padding: EdgeInsets.all(8),
      child: Obx(() {
        if (controller.availableLayouts.isEmpty) {
          return Center(
            child: Text(
              "No space available",
              style: TextStyle(fontSize: 12, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

        final List<int> layoutsToShow = controller.panelOrientation.value == "V"
            ? [0, 1] // Vertical layouts
            : [2, 3]; // Horizontal

        // ADD THIS: Automatically select first available layout if current selection is invalid
        if (!layoutsToShow.contains(controller.selectedLayout.value) ||
            !controller.availableLayouts
                .contains(controller.selectedLayout.value)) {
          final availableLayout = layoutsToShow.firstWhere(
                (layout) => controller.availableLayouts.contains(layout),
            orElse: () => layoutsToShow.first,
          );
          controller.selectedLayout.value = availableLayout;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text("Panels layout",
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            // SizedBox(height: 8),
            ...layoutsToShow.map((index) {
              final isAvailable = controller.availableLayouts.contains(index);
              final isSelected = controller.selectedLayout.value == index;
              return GestureDetector(
                onTap: isAvailable
                    ? () {
                  controller.selectedLayout.value = index;
                  controller.updatePanelPositions1(controller);
                }
                    : null,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  margin: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue
                        : isAvailable
                        ? Colors.grey[200]
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        width: 2),
                  ),
                  child: Text(
                    controller.layoutOptions[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? Colors.white
                          : isAvailable
                          ? Colors.black
                          : Colors.grey,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ],
        );
      }),
    );
  }
}

// panel layout selection
