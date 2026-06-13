//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'dart:ui' as ui;
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//
// class Walkway {
//   String id;
//   String name;
//   List<LatLng> points;
//   bool isHorizontal;
//   double width;   // Width in meters (500mm = 0.5m)
//   double length;  // Length in meters
//   double maxLength;
//   double rotationAngle; // Maximum possible length
//
//   Walkway({
//     required this.id,
//     required this.points,
//     this.isHorizontal = true,
//     this.width = 0.5,   // Default 500mm
//     this.length = 3.0,
//     required this.maxLength,
//     this.rotationAngle = 0,
//     required this.name
//   });
//
//   Polygon toPolygon() {
//     return Polygon(
//       polygonId: PolygonId(id),
//       points: points,
//       strokeWidth: 1,
//       strokeColor: Colors.deepOrange,
//       fillColor: Colors.deepOrange.withOpacity(0.5),
//     );
//   }
//
//   Walkway copyWith({
//     List<LatLng>? points,
//     bool? isHorizontal,
//     double? width,
//     double? length,
//     double? maxLength,
//     String? name,
//   }) {
//     return Walkway(
//       id: id,
//       points: points ?? this.points,
//       isHorizontal: isHorizontal ?? this.isHorizontal,
//       width: width ?? this.width,
//       length: length ?? this.length,
//       maxLength: maxLength ?? this.maxLength,
//       name: name ?? this.name,
//     );
//   }
// }
//
// class Terrace {
//   String id;
//   List<LatLng> areaPoints;
//   List<LatLng> panels;
//   List<Walkway> walkways;
//   bool isHorizontal;
//   bool isAlternate;
//   double padding;
//   double rowSpacing;
//   bool isActive;
//   bool hasGril;
//   List<LatLng> handRailPoints;
//   List<int> selectedBorderIndices;
//   List<bool> rowOrientations = [];
//
//   Terrace({
//     required this.id,
//     required this.areaPoints,
//     required this.panels,
//     this.walkways = const [],
//     this.isHorizontal = true,
//     this.isAlternate = false,
//     this.padding = 0,
//     this.rowSpacing = 0,
//     this.isActive = true,
//     this.hasGril = false,
//     this.handRailPoints = const [],
//     this.selectedBorderIndices = const [],
//     this.rowOrientations = const [],
//   });
//
//   Terrace copyWith({
//     List<LatLng>? areaPoints,
//     List<LatLng>? panels,
//     List<Walkway>? walkways,
//     bool? isHorizontal,
//     bool? isAlternate,
//     double? padding,
//     double? rowSpacing,
//     bool? isActive,
//     bool? hasGril,
//     List<LatLng>? handRailPoints,
//     List<int>? selectedBorderIndices,
//     List<bool>? rowOrientations,
//   }) {
//     return Terrace(
//       id: this.id,
//       areaPoints: areaPoints ?? this.areaPoints,
//       panels: panels ?? this.panels,
//       walkways: walkways ?? this.walkways,
//       isHorizontal: isHorizontal ?? this.isHorizontal,
//       isAlternate: isAlternate ?? this.isAlternate,
//       padding: padding ?? this.padding,
//       rowSpacing: rowSpacing ?? this.rowSpacing,
//       isActive: isActive ?? this.isActive,
//       hasGril: hasGril ?? this.hasGril,
//       handRailPoints: handRailPoints ?? this.handRailPoints,
//       selectedBorderIndices: selectedBorderIndices ?? this.selectedBorderIndices,
//       rowOrientations: rowOrientations ?? this.rowOrientations,
//     );
//   }
// }
//
// class SurveyMapController2 extends GetxController {
//   // Reactive variables
//   var polygonPoints = <LatLng>[].obs;
//   var polygonArea = 0.0.obs;
//   var polylines = <Polyline>{}.obs;
//   var distanceMarkers = <Marker>{}.obs;
//   var segmentDistances = <double>[].obs;
//   var isSelectingArea = false.obs;
//   var showStreetView = false.obs;
//   var pickedLocation = LatLng(22.260076, 70.787970).obs;
//   var address = "Location".obs;
//   var showInMeters = true.obs;
//   var boundaryIcon = BitmapDescriptor.defaultMarker.obs;
//   var walkWayIcon = BitmapDescriptor.defaultMarker.obs;
//
//   StreamSubscription? _uriSub;
//   var selectedvalue = "H".obs;
//   var paddingSliderValue = 0.0.obs;
//   var selectedmaserType = "m".obs;
//   var selectedwalkwayOrinteation = "H".obs;
//   var rowSpacingSlidervalue = 0.0.obs;
//   var terraceType = "".obs;
//
//   // NEW: Walkway management
//   RxList<Walkway> currentWalkways = <Walkway>[].obs;
//   RxInt editingWalkwayIndex = (-1).obs;
//   // In SurveyMapController
//   var currentHasGril = false.obs;
//
//   RxDouble padding = 0.0.obs;
//   final RxInt rowSpacingInterval = 1.obs;
//
//   GoogleMapController? mapController;
//   // StreetViewController? streetViewController;
//
//   final double earthRadius = 6371000;
//
//
//
//   var savedTerraces = <Terrace>[].obs;
//   var allPanels = <Polygon>{}.obs;
//   var isNewTerrace = false.obs;
//
//
//   var editingTerraceIndex = (-1).obs;
//   var originalTerracePoints = <LatLng>[].obs;
//
//   TextEditingController frontLegController = TextEditingController(text: "0");
//   TextEditingController backLegController = TextEditingController(text: "0");
//   TextEditingController buildingNamecontrol = TextEditingController();
//   RxDouble sliderLimit=5.0.obs;
//
//   GlobalKey<FormState> tableStructureKey = GlobalKey<FormState>();
//
//
//   final RxMap<String, String> terraceBuildings = <String, String>{}.obs;
//   final RxString currentBuilding = 'Building 1'.obs;
//
//   final selectedBuilding = RxString('');
//
//   RxString selectedWalkwayWidth = "270".obs; // Default to 270mm
//
//   RxList<LatLng> currentHandRailPoints = <LatLng>[].obs;
//   RxBool isDrawingHandRail = false.obs;
//   RxBool isHandRailComplete = false.obs;
//
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadIcons();
//   }
//
//
//   List<int> getSelectedBorderIndices() {
//     if (editingTerraceIndex.value == -1) return [];
//     return savedTerraces[editingTerraceIndex.value].selectedBorderIndices;
//   }
//
//   void setSelectedBorderIndices(List<int> indices) {
//     if (editingTerraceIndex.value == -1) return;
//     final terrace = savedTerraces[editingTerraceIndex.value];
//     savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
//       selectedBorderIndices: indices,
//     );
//   }
//
//
//
//
//
//   void startDrawingHandRail() {
//     isDrawingHandRail.value = true;
//     isHandRailComplete.value = false;
//     update();
//   }
//
//
//
//   void toggleBorderSelection(int index) {
//     if (!isDrawingHandRail.value || editingTerraceIndex.value == -1) return;
//
//     final terrace = savedTerraces[editingTerraceIndex.value];
//     final selectedIndices = List<int>.from(terrace.selectedBorderIndices);
//
//     if (selectedIndices.contains(index)) {
//       selectedIndices.remove(index);
//     } else {
//       selectedIndices.add(index);
//     }
//
//     // Sort to maintain order but don't connect automatically
//     selectedIndices.sort();
//
//     savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
//       selectedBorderIndices: selectedIndices,
//     );
//
//     updateHandRailFromSelectedBorders();
//   }
//
//
//   void updateHandRailFromSelectedBorders() {
//     if (editingTerraceIndex.value == -1) return;
//
//     final terrace = savedTerraces[editingTerraceIndex.value];
//     currentHandRailPoints.clear();
//
//     // Create hand rail segments for exactly what was selected
//     for (final index in terrace.selectedBorderIndices) {
//       final nextIndex = (index + 1) % polygonPoints.length;
//       currentHandRailPoints.add(polygonPoints[index]);
//       currentHandRailPoints.add(polygonPoints[nextIndex]);
//     }
//
//     update();
//   }
//
//
//   void addHandRailPoint(LatLng point) {
//     currentHandRailPoints.add(point);
//     update();
//   }
//
//   void removeHandrail_test(LatLng points){
//     if(currentHandRailPoints.contains(points)){
//
//     }else{
//       currentHandRailPoints.remove(points);
//     }
//     update();
//   }
//
//   void updateHandRailPoint(int index, LatLng newPosition) {
//     if (index >= 0 && index < currentHandRailPoints.length) {
//       currentHandRailPoints[index] = newPosition;
//       update();
//     }
//   }
//
//
//   void finishDrawingHandRail() {
//
//     if (editingTerraceIndex.value == -1) return;
//
//     final terrace = savedTerraces[editingTerraceIndex.value];
//
//     // Get unique selected borders (in case user toggled same border multiple times)
//     final uniqueSelectedIndices = terrace.selectedBorderIndices.toSet().toList();
//
//     // Sort the selected indices to maintain proper order around the polygon
//     uniqueSelectedIndices.sort();
//
//     final handRailPoints = <LatLng>[];
//
//     // Create continuous hand rail by connecting selected borders in order
//     for (final index in uniqueSelectedIndices) {
//       final nextIndex = (index + 1) % polygonPoints.length;
//       handRailPoints.add(polygonPoints[index]);
//       handRailPoints.add(polygonPoints[nextIndex]);
//     }
//
//     savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
//       handRailPoints: handRailPoints,
//       hasGril: handRailPoints.isNotEmpty,
//     );
//
//     // Reset drawing state
//     isDrawingHandRail.value = false;
//     isHandRailComplete.value = handRailPoints.isNotEmpty;
//     update();
//   }
//
//
//   bool isPointNearBorder(LatLng tapPoint, LatLng lineStart, LatLng lineEnd) {
//     const double threshold = 0.00005; // Adjust for tap sensitivity (about 5 meters)
//
//     // If line is just a point
//     if (lineStart == lineEnd) return false;
//
//     // Calculate distance from point to line segment
//     final double lineLength = calculateDistance(lineStart, lineEnd);
//     final double distance = ((lineEnd.latitude - lineStart.latitude) * (tapPoint.longitude - lineStart.longitude) -
//         (lineEnd.longitude - lineStart.longitude) * (tapPoint.latitude - lineStart.latitude)).abs() / lineLength;
//
//     return distance < threshold;
//   }
//
//   double calculateHandRailLength(List<LatLng> handRailPoints) {
//     if (handRailPoints.isEmpty || handRailPoints.length % 2 != 0) {
//       return 0.0; // Return 0 if empty or has odd number of points (invalid)
//     }
//
//     double totalLength = 0.0;
//
//     // Calculate each segment (points are stored in pairs)
//     for (int i = 0; i < handRailPoints.length; i += 2) {
//       if (i + 1 < handRailPoints.length) {
//         totalLength += calculateDistance(handRailPoints[i], handRailPoints[i + 1]);
//       }
//     }
//
//     return totalLength;
//   }
//
//   double calculateHandrailLength_2(List<LatLng> polygonPoints){
//     if(currentHandRailPoints.isEmpty) return 0.0;
//
//
//     if(currentHandRailPoints.isNotEmpty || isDrawingHandRail.value == false){
//       for(int i = 0; i <= polygonPoints.length; i++){
//         calculateDistance(polygonPoints[i], polygonPoints[i + 2]);
//
//       }
//     }
//     var handrail = 0.0;
//     return handrail;
//   }
//
//
//
//   void startEditingHandRail() {
//     if (editingTerraceIndex.value != -1) {
//       final terrace = savedTerraces[editingTerraceIndex.value];
//       if (terrace.hasGril && terrace.handRailPoints.isNotEmpty) {
//         isDrawingHandRail.value = true;
//         currentHandRailPoints.value = List.from(terrace.handRailPoints);
//       }
//     }
//   }
//
//
//
//   void cancelDrawingHandRail() {
//     if (editingTerraceIndex.value != -1) {
//       final terrace = savedTerraces[editingTerraceIndex.value];
//       if (terrace.hasGril && terrace.handRailPoints.isNotEmpty) {
//         currentHandRailPoints.value = List.from(terrace.handRailPoints);
//       }
//     }
//     isDrawingHandRail.value = false;
//   }
//
//
//
//
//   Polyline createHandRailPolyline(List<LatLng> points) {
//     return Polyline(
//       polylineId: PolylineId('handrail_${DateTime.now().millisecondsSinceEpoch}'),
//       points: points,
//       color: Colors.black,
//       width: 5,
//       consumeTapEvents: false,
//     );
//   }
//
//
//   void addWalkway() {
//     if (polygonPoints.isEmpty) return;
//
//     final bounds = getPolygonBounds(polygonPoints);
//     final center = LatLng(
//       (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
//       (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
//     );
//
//     final double widthMeters = double.parse(selectedWalkwayWidth.value) / 1000;
//     final double lengthMeters = min(
//         (bounds.northeast.longitude - bounds.southwest.longitude) * 111111 * cos(center.latitude * pi / 180),
//         (bounds.northeast.latitude - bounds.southwest.latitude) * 111111
//     );
//
//     currentWalkways.add(Walkway(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       name: 'Walkway ${currentWalkways.length + 1}',
//       points: createWalkwayPoints(center, isHorizontal.value, widthMeters, lengthMeters),
//       isHorizontal: isHorizontal.value,
//       width: widthMeters,
//       length: lengthMeters,
//       maxLength: lengthMeters,
//     ));
//
//     editingWalkwayIndex.value = currentWalkways.length - 1;
//     updatePanelPositions();
//   }
//
//
//   List<LatLng> createWalkwayPoints(LatLng center, bool isHorizontal, double width, double length) {
//     // Convert meters to degrees
//     final latDelta = (isHorizontal ? width : length) / 111111.0 / 2;
//     final lngDelta = (isHorizontal ? length : width) / (111111.0 * cos(center.latitude * pi / 180)) / 2;
//
//     return [
//       LatLng(center.latitude - latDelta, center.longitude - lngDelta),
//       LatLng(center.latitude - latDelta, center.longitude + lngDelta),
//       LatLng(center.latitude + latDelta, center.longitude + lngDelta),
//       LatLng(center.latitude + latDelta, center.longitude - lngDelta),
//     ];
//   }
//
//
//
//   // testing
//   void updateWalkwayPoints(int index, List<LatLng> newPoints) {
//     if (index >= 0 && index < currentWalkways.length) {
//       final walkway = currentWalkways[index];
//
//       // Calculate new length based on the moved points
//       final bounds = getPolygonBounds(newPoints);
//       double newLength;
//       if (walkway.isHorizontal) {
//         newLength = (bounds.northeast.longitude - bounds.southwest.longitude) *
//             111111 * cos(bounds.southwest.latitude * pi / 180);
//       } else {
//         newLength = (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
//       }
//
//       currentWalkways[index] = walkway.copyWith(
//         points: newPoints,
//         length: newLength,
//       );
//     }
//   }
//
//
//   // testing
//   void updateWalkwayLength(int index, double newLength) {
//     if (index < 0 || index >= currentWalkways.length) return;
//     if (editingTerraceIndex.value < 0 || editingTerraceIndex.value >= savedTerraces.length) return;
//
//     final walkway = currentWalkways[index];
//     final terrace = savedTerraces[editingTerraceIndex.value];
//
//     // Calculate max possible length based on terrace
//     final bounds = getPolygonBounds(terrace.areaPoints);
//     double maxLength;
//     if (walkway.isHorizontal) {
//       maxLength = (bounds.northeast.longitude - bounds.southwest.longitude) *
//           111111 * cos(bounds.southwest.latitude * pi / 180);
//     } else {
//       maxLength = (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
//     }
//
//     // Apply constraints
//     final minLength = 1.0;
//     final clampedLength = newLength.clamp(minLength, maxLength);
//
//     final center = getCenter(walkway.points);
//     final newPoints = createWalkwayPoints(
//       center,
//       walkway.isHorizontal,
//       walkway.width,
//       clampedLength,
//     );
//
//     currentWalkways[index] = walkway.copyWith(
//       length: clampedLength,
//       points: newPoints,
//       maxLength: maxLength,
//     );
//
//     updatePanelPositions();
//   }
//
//
//
//
//   void updateWalkwayWidth(int index, double newWidth) {
//     if (index < 0 || index >= currentWalkways.length) return;
//
//     final walkway = currentWalkways[index];
//     final center = getCenter(walkway.points);
//
//     currentWalkways[index] = walkway.copyWith(
//         width: newWidth,
//         points: createWalkwayPoints(
//             center,
//             walkway.isHorizontal,
//             newWidth,
//             walkway.length
//         )
//     );
//
//     updatePanelPositions();
//   }
//
//
//   void removeWalkway(int index) {
//
//     if (index >= 0 && index < currentWalkways.length) {
//       currentWalkways.removeAt(index);
//     }
//
//     editingWalkwayIndex.value = -1;
//   }
//
//
//   void toggleWalkwayOrientation(int index) {
//     if (index < 0 || index >= currentWalkways.length) return;
//
//     final walkway = currentWalkways[index];
//     final newOrientation = !walkway.isHorizontal;
//
//     currentWalkways[index] = walkway.copyWith(
//         isHorizontal: newOrientation,
//         points: createWalkwayPoints(
//             getCenter(walkway.points),
//             newOrientation,
//             walkway.width,
//             walkway.length
//         )
//     );
//
//     selectedwalkwayOrinteation.value = newOrientation ? "H" : "V";
//     updatePanelPositions();
//   }
//
//   LatLng getCenter(List<LatLng> points) {
//     double lat = 0, lng = 0;
//     for (final point in points) {
//       lat += point.latitude;
//       lng += point.longitude;
//     }
//     return LatLng(lat / points.length, lng / points.length);
//   }
//
//   void toggleBuildingSelection(String buildingName) {
//     if (selectedBuilding.value == buildingName) {
//       selectedBuilding.value = '';
//     } else {
//       selectedBuilding.value = buildingName;
//     }
//   }
//
//   void toggleWalkwaySelection(){
//     if(editingWalkwayIndex.value == -1) return;
//     selectedvalue.value = editingWalkwayIndex.value.toString();
//
//   }
//
//
//
//   Set<Polygon> convertCentersToPolygons(
//       List<LatLng> centers,
//       bool isHorizontal, {
//         bool isAlternate = false,
//       }) {
//     Set<Polygon> polygons = {};
//
//     if (isAlternate && editingTerraceIndex.value != -1) {
//       final terrace = savedTerraces[editingTerraceIndex.value];
//       if (terrace.rowOrientations.isNotEmpty) {
//         // Calculate approximate row index based on latitude
//         final bounds = getPolygonBounds(terrace.areaPoints);
//         final latRange = bounds.northeast.latitude - bounds.southwest.latitude;
//
//         for (int i = 0; i < centers.length; i++) {
//           final normalizedLat = (centers[i].latitude - bounds.southwest.latitude) / latRange;
//           final rowIndex = (normalizedLat * terrace.rowOrientations.length).toInt().clamp(0, terrace.rowOrientations.length - 1);
//
//           polygons.add(_createPanelPolygon(
//             centers[i],
//             isHorizontal,
//             isAlternate: isAlternate,
//             rowIndex: rowIndex,
//           ));
//         }
//         return polygons;
//       }
//     }
//
//     // Fallback for non-alternate mode
//     return centers.map((center) => _createPanelPolygon(
//       center,
//       isHorizontal,
//       isAlternate: isAlternate,
//     )).toSet();
//   }
//
//   // old before alternative
//   // Set<Polygon> convertCentersToPolygons(List<LatLng> centers, bool isHorizontal) {
//   //   return centers.map((center) => _createPanelPolygon(
//   //       center,
//   //       isHorizontal,
//   //       uniqueId: center.hashCode.toString()
//   //   )).toSet();
//   // }
//
//
//
//   void updatePanelPositions() {
//     if (editingTerraceIndex.value != -1) {
//       solarPanelsPolygons.clear();
//       final terrace = savedTerraces[editingTerraceIndex.value];
//
//       final newCenters = calculatePanelCenters(
//         terrace.areaPoints,
//         terrace.isHorizontal,
//         terrace.padding,
//         terrace.rowSpacing,
//         isAlternate: terrace.isAlternate,
//       );
//
//       savedTerraces[editingTerraceIndex.value] = terrace.copyWith(panels: newCenters);
//
//       // Call with named parameter
//       solarPanelsPolygons.value = convertCentersToPolygons(
//         newCenters,
//         terrace.isHorizontal,
//         isAlternate: terrace.isAlternate,
//       );
//     }
//   }
//
//
//   // old before alternative
//   // void updatePanelPositions() {
//   //   if (editingTerraceIndex.value != -1) {
//   //     solarPanelsPolygons.clear();
//   //     final terrace = savedTerraces[editingTerraceIndex.value];
//   //
//   //     final newCenters = calculatePanelCenters(
//   //         terrace.areaPoints,
//   //         terrace.isHorizontal,
//   //         terrace.padding,
//   //         terrace.rowSpacing
//   //     );
//   //
//   //     savedTerraces[editingTerraceIndex.value] = terrace.copyWith(panels: newCenters);
//   //     solarPanelsPolygons.value = terrace.panelPolygons;
//   //   }
//   // }
//
//
//
//   List<LatLng> calculatePanelCenters(
//       List<LatLng> polygonPoints,
//       bool isHorizontal,
//       double padding,
//       double rowSpacing, {
//         bool isAlternate = false,
//       }) {
//     List<LatLng> centers = [];
//     if (polygonPoints.length < 3) return centers;
//
//     final bounds = getPolygonBounds(polygonPoints);
//     final center = LatLng(
//       (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
//       (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
//     );
//
//     // Panel dimensions in meters
//     const double panelWidth = 1.0;   // 1m for vertical
//     const double panelHeight = 2.0;  // 2m for horizontal
//
//     // Convert padding to degrees
//     final double paddingLat = padding / 111111.0;
//     final double paddingLng = padding / (111111.0 * cos(center.latitude * pi / 180));
//
//     // Calculate grid boundaries
//     final double startLat = bounds.southwest.latitude + paddingLat;
//     final double endLat = bounds.northeast.latitude - paddingLat;
//     final double startLng = bounds.southwest.longitude + paddingLng;
//     final double endLng = bounds.northeast.longitude - paddingLng;
//
//     // Calculate grid dimensions in meters
//     final double widthMeters = (endLng - startLng) * 111111 * cos(center.latitude * pi / 180);
//     final double heightMeters = (endLat - startLat) * 111111;
//
//     // Calculate number of columns and rows
//     int cols, rows;
//     if (isAlternate) {
//       cols = (widthMeters / panelWidth).floor();
//       rows = (heightMeters / 1.5).floor(); // Adjusted for alternating heights
//     } else if (isHorizontal) {
//       cols = (widthMeters / panelHeight).floor();
//       rows = (heightMeters / panelWidth).floor();
//     } else {
//       cols = (widthMeters / panelWidth).floor();
//       rows = (heightMeters / panelHeight).floor();
//     }
//
//     // Calculate step sizes
//     final double lngStep = (endLng - startLng) / cols;
//     final double latStep = (endLat - startLat) / rows;
//
//     for (int y = 0; y < rows; y++) {
//       bool rowIsHorizontal = isAlternate ? y.isEven : isHorizontal;
//       double rowHeight = rowIsHorizontal ? 1.0 : 2.0;
//
//       for (int x = 0; x < cols; x++) {
//         final double centerLng = startLng + (x * lngStep) + (lngStep / 2);
//         final double centerLat = startLat + (y * latStep) + (latStep / 2);
//         final LatLng panelCenter = LatLng(centerLat, centerLng);
//
//         if (_isPointInPolygon(panelCenter, polygonPoints)) {
//           centers.add(panelCenter);
//         }
//       }
//     }
//
//     return centers;
//   }
//
//
//   // old code before alternative
//   // List<LatLng> calculatePanelCenters(
//   //     List<LatLng> polygonPoints,
//   //     bool isHorizontal,
//   //     double padding,
//   //     double rowSpacing,
//   //     ) {
//   //   List<LatLng> centers = [];
//   //   if (polygonPoints.length < 3) return centers;
//   //
//   //   // Get terrace bounds
//   //   final terraceBounds = getPolygonBounds(polygonPoints);
//   //
//   //   // Panel dimensions
//   //   final double panelWidthMeters = isHorizontal ? 2.0 : 1.0;
//   //   final double panelHeightMeters = isHorizontal ? 1.0 : 2.0;
//   //
//   //   // Calculate effective padding that accounts for walkways
//   //   double effectivePadding = padding;
//   //
//   //   // If we have walkways, reduce padding to ensure they're respected
//   //   if (currentWalkways.isNotEmpty) {
//   //     // Get the smallest dimension of the terrace
//   //     final terraceWidth = (terraceBounds.northeast.longitude - terraceBounds.southwest.longitude) *
//   //         111111 * cos(terraceBounds.southwest.latitude * pi / 180);
//   //     final terraceHeight = (terraceBounds.northeast.latitude - terraceBounds.southwest.latitude) * 111111;
//   //     final minDimension = min(terraceWidth, terraceHeight);
//   //
//   //     // Limit padding to 1/4 of smallest dimension to preserve walkways
//   //     effectivePadding = min(padding, minDimension / 4);
//   //   }
//   //
//   //   // Convert padding to degrees
//   //   final double paddingLat = effectivePadding / 111111;
//   //   final double paddingLng = effectivePadding / (111111 * cos(terraceBounds.southwest.latitude * pi / 180));
//   //
//   //   // Calculate grid boundaries with padding
//   //   final double startLat = terraceBounds.southwest.latitude + paddingLat;
//   //   final double endLat = terraceBounds.northeast.latitude - paddingLat;
//   //   final double startLng = terraceBounds.southwest.longitude + paddingLng;
//   //   final double endLng = terraceBounds.northeast.longitude - paddingLng;
//   //
//   //   // Calculate grid dimensions in meters
//   //   final double widthMeters = (endLng - startLng) * 111111 * cos(terraceBounds.southwest.latitude * pi / 180);
//   //   final double heightMeters = (endLat - startLat) * 111111;
//   //
//   //   // Calculate number of columns and rows
//   //   final int cols = (widthMeters / panelWidthMeters).floor();
//   //   final int rows = (heightMeters / panelHeightMeters).floor();
//   //
//   //   // Calculate step sizes in degrees
//   //   final double lngStep = (endLng - startLng) / cols;
//   //   final double latStep = (endLat - startLat) / rows;
//   //
//   //   // Spacing configuration
//   //   final double rowSpacingMeters = rowSpacing;
//   //   final int interval = rowSpacingInterval.value;
//   //   final double walkwayBufferMeters = 0.5; // 0.5m buffer around walkways
//   //
//   //   // Create walkway exclusion zones with buffer
//   //   final walkwayExclusionZones = <LatLngBounds>[];
//   //   for (final walkway in currentWalkways) {
//   //     final bounds = getPolygonBounds(walkway.points);
//   //     final latBuffer = walkwayBufferMeters / 111111;
//   //     final lngBuffer = walkwayBufferMeters / (111111 * cos(bounds.southwest.latitude * pi / 180));
//   //
//   //     walkwayExclusionZones.add(LatLngBounds(
//   //       southwest: LatLng(
//   //         bounds.southwest.latitude - latBuffer,
//   //         bounds.southwest.longitude - lngBuffer,
//   //       ),
//   //       northeast: LatLng(
//   //         bounds.northeast.latitude + latBuffer,
//   //         bounds.northeast.longitude + lngBuffer,
//   //       ),
//   //     ));
//   //   }
//   //
//   //   double verticalOffsetMeters = 0.0;
//   //   int rowsSinceLastSpace = 0;
//   //
//   //   for (int y = 0; y < rows; y++) {
//   //     // Add spacing row when needed
//   //     if (rowsSinceLastSpace >= interval) {
//   //       verticalOffsetMeters += rowSpacingMeters;
//   //       rowsSinceLastSpace = 0;
//   //     }
//   //
//   //     final double currentLat = startLat + (verticalOffsetMeters / 111111);
//   //     if (currentLat > endLat) break;
//   //
//   //     for (int x = 0; x < cols; x++) {
//   //       final double centerLng = startLng + (x * lngStep) + (lngStep / 2);
//   //       final LatLng center = LatLng(currentLat, centerLng);
//   //
//   //       // Skip if outside terrace polygon
//   //       if (!_isPointInPolygon(center, polygonPoints)) {
//   //         continue;
//   //       }
//   //
//   //       // Check if center is in any walkway exclusion zone
//   //       bool inWalkwayZone = false;
//   //       for (final zone in walkwayExclusionZones) {
//   //         if (center.latitude >= zone.southwest.latitude &&
//   //             center.latitude <= zone.northeast.latitude &&
//   //             center.longitude >= zone.southwest.longitude &&
//   //             center.longitude <= zone.northeast.longitude) {
//   //           inWalkwayZone = true;
//   //           break;
//   //         }
//   //       }
//   //
//   //       if (!inWalkwayZone) {
//   //         centers.add(center);
//   //       }
//   //     }
//   //
//   //     verticalOffsetMeters += panelHeightMeters;
//   //     rowsSinceLastSpace++;
//   //   }
//   //
//   //   return centers;
//   // }
//
//
//
//
//
//
//
//
//   void startEditingTerrace(int index) {
//     editingTerraceIndex.value = index;
//     originalTerracePoints.value = List.from(savedTerraces[index].areaPoints);
//     polygonPoints.value = List.from(savedTerraces[index].areaPoints);
//     currentWalkways.value = List.from(savedTerraces[index].walkways);
//
//     // Load hand rail data from the terrace
//     if (savedTerraces[index].hasGril) {
//       currentHandRailPoints.value = List.from(savedTerraces[index].handRailPoints);
//       isHandRailComplete.value = true;
//     } else {
//       currentHandRailPoints.clear();
//       isHandRailComplete.value = false;
//     }
//     isDrawingHandRail.value = false;
//
//     // Load other terrace properties
//     isHorizontal.value = savedTerraces[index].isHorizontal;
//     paddingSliderValue.value = savedTerraces[index].padding;
//     rowSpacingSlidervalue.value = savedTerraces[index].rowSpacing;
//     currentHasGril.value = savedTerraces[index].hasGril;
//
//     updatePolygon(forceUpdate: true);
//   }
//
//
//
//
//
//
//
//
//
//
//
//   void saveEditedTerrace() {
//     if (editingTerraceIndex.value == -1 || polygonPoints.length < 3) return;
//
//     final terrace = savedTerraces[editingTerraceIndex.value];
//
//     // Preserve the existing hand rail if we're not currently drawing
//     List<LatLng> newHandRailPoints = isDrawingHandRail.value
//         ? List.from(currentHandRailPoints)
//         : terrace.handRailPoints;
//
//     savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
//       areaPoints: List.from(polygonPoints),
//       panels: calculatePanelCenters(polygonPoints, terrace.isHorizontal, terrace.padding, terrace.rowSpacing),
//       walkways: List.from(currentWalkways),
//       handRailPoints: newHandRailPoints,
//       hasGril: newHandRailPoints.isNotEmpty,
//     );
//
//     // Reset editing state including hand rail drawing
//     editingTerraceIndex.value = -1;
//     currentWalkways.clear();
//     polygonPoints.clear();
//     isDrawingHandRail.value = false;
//     currentHandRailPoints.clear();
//     isHandRailComplete.value = false;
//
//     updatePanelPositions();
//     update();
//   }
//
//
//
//
//
//   void cancelEditing() {
//     editingTerraceIndex.value = -1;
//     originalTerracePoints.clear();
//     polygonPoints.clear();
//     currentWalkways.clear();
//     isDrawingHandRail.value = false;
//     currentHandRailPoints.clear();
//     isHandRailComplete.value = false;
//   }
//
//   void calculateSolarPanels1() {
//     solarPanelsPolygons.value = calculateSolarPanelsForTerrace(
//       polygonPoints,
//       isHorizontal.value,
//       paddingSliderValue.value,
//       rowSpacingSlidervalue.value,
//     );
//   }
//
//   void calculateAllTerracesPanels() {
//     allPanels.clear();
//
//     if (polygonPoints.length >= 3) {
//       allPanels.addAll(calculateSolarPanelsForTerrace(
//         polygonPoints,
//         isHorizontal.value,
//         paddingSliderValue.value,
//         rowSpacingSlidervalue.value,
//       ),);
//     }
//
//     for (final terrace in savedTerraces) {
//       allPanels.addAll(calculateSolarPanelsForTerrace(
//         polygonPoints,
//         isHorizontal.value,
//         paddingSliderValue.value,
//         rowSpacingSlidervalue.value,
//       ),);
//     }
//   }
//
//
//
//   void saveCurrentTerrace() {
//     if (polygonPoints.length >= 3) {
//       final newTerrace = Terrace(
//         id: DateTime.now().toString(),
//         areaPoints: List<LatLng>.from(polygonPoints),
//         panels: calculatePanelCenters(
//           polygonPoints,
//           isHorizontal.value,
//           paddingSliderValue.value,
//           rowSpacingSlidervalue.value,
//         ),
//         walkways: List.from(currentWalkways), // NEW: Save walkways
//         isHorizontal: isHorizontal.value,
//         padding: paddingSliderValue.value,
//         rowSpacing: rowSpacingSlidervalue.value,
//         isActive: true,
//       );
//
//       terraceBuildings[newTerrace.id] = currentBuilding.value;
//       savedTerraces.add(newTerrace);
//       calculateAllPanels();
//       startNewTerrace();
//       currentWalkways.clear();
//     }
//   }
//
//   void calculateAllPanels() {
//     allPanels.clear();
//     savedTerraces.forEach((terrace) {
//       allPanels.addAll(calculateSolarPanelsForTerrace(
//         terrace.areaPoints,
//         terrace.isHorizontal,
//         terrace.padding,
//         terrace.rowSpacing,
//       ));
//     });
//
//     if (polygonPoints.length >= 3) {
//       allPanels.addAll(calculateSolarPanelsForTerrace(
//         polygonPoints,
//         isHorizontal.value,
//         paddingSliderValue.value,
//         rowSpacingSlidervalue.value,
//       ));
//     }
//   }
//
//   Set<Polygon> calculateSolarPanelsForTerrace(
//       List<LatLng> polygonPoints,
//       bool isHorizontal,
//       double padding,
//       double rowSpacing,
//       ) {
//     return calculatePanelCenters(
//       polygonPoints,
//       isHorizontal,
//       padding,
//       rowSpacing,
//     ).map((center) => _createPanelPolygon(center,isHorizontal)).toSet();
//   }
//
//   void startNewTerrace() {
//     polygonPoints.clear();
//     isSelectingArea.value = true;
//     isNewTerrace.value = true;
//     currentHasGril.value = false;
//     currentHandRailPoints.clear();
//     isDrawingHandRail.value = false;
//     isHandRailComplete.value = false;
//   }
//
//
//   final RxSet<Polygon> solarPanelsPolygons = <Polygon>{}.obs;
//   final RxBool isHorizontal = true.obs;
//
//   double get panelWidth => isHorizontal.value ? 2.0 : 1.0;
//   double get panelHeight => isHorizontal.value ? 1.0 : 2.0;
//
//   double distanceToSegment(LatLng start, LatLng end) {
//     final lat1 = start.latitude * pi / 180;
//     final lon1 = start.longitude * pi / 180;
//     final lat2 = end.latitude * pi / 180;
//     final lon2 = end.longitude * pi / 180;
//
//     final dLat = lat2 - lat1;
//     final dLon = lon2 - lon1;
//
//     final a = sin(dLat/2) * sin(dLat/2) +
//         cos(lat1) * cos(lat2) *
//             sin(dLon/2) * sin(dLon/2);
//     final c = 2 * atan2(sqrt(a), sqrt(1-a));
//
//     return earthRadius * c;
//   }
//
//   Future<void> updatePolygon({bool forceUpdate = false}) async {
//     if (!forceUpdate && polygonPoints.length < 2) return;
//
//     final bool currentShowInMeters = showInMeters.value;
//     polylines.clear();
//     distanceMarkers.clear();
//     segmentDistances.clear();
//
//     final List<LatLng> cleanPoints = List<LatLng>.from(polygonPoints);
//     if (cleanPoints.length >= 3 && cleanPoints.first == cleanPoints.last) {
//       cleanPoints.removeLast();
//     }
//
//     for (int i = 0; i < cleanPoints.length; i++) {
//       final nextIndex = (i + 1) % cleanPoints.length;
//       final start = cleanPoints[i];
//       final end = cleanPoints[nextIndex];
//
//       final distance = calculateDistance(start, end);
//       final convertedValue = currentShowInMeters ? distance : distance * 3.28084;
//       final unit = currentShowInMeters ? 'm' : 'ft';
//       final text = '${convertedValue.toStringAsFixed(1)}$unit';
//
//       final textMarker = await createTextMarker(text);
//       final midpoint = LatLng(
//         (start.latitude + end.latitude) / 2,
//         (start.longitude + end.longitude) / 2,
//       );
//
//       distanceMarkers.add(Marker(
//         markerId: MarkerId('distance_$i'),
//         position: midpoint,
//         icon: textMarker,
//         anchor: const Offset(0.5, 0.5),
//       ));
//     }
//
//     if (cleanPoints.length >= 3) {
//       final closedPoints = List<LatLng>.from(cleanPoints)..add(cleanPoints[0]);
//       polygonArea.value = calculatePolygonArea(closedPoints);
//     } else {
//       polygonArea.value = 0.0;
//     }
//   }
//
//
//   Polygon _createPanelPolygon(LatLng center, bool isHorizontal, {
//     bool isAlternate = false,
//     int rowIndex = 0,
//   }) {
//     bool panelIsHorizontal = isAlternate ? rowIndex.isEven : isHorizontal;
//
//     // Panel dimensions (2m × 1m)
//     final double panelWidth = panelIsHorizontal ? 2.0 : 1.0;
//     final double panelHeight = panelIsHorizontal ? 1.0 : 2.0;
//
//     // Convert to degrees
//     final double latDelta = panelHeight / 111111.0 / 2;
//     final double lngDelta = panelWidth / (111111.0 * cos(center.latitude * pi / 180)) / 2;
//
//     return Polygon(
//       polygonId: PolygonId('panel_${center.latitude}_${center.longitude}_$rowIndex'),
//       points: [
//         LatLng(center.latitude - latDelta, center.longitude - lngDelta),
//         LatLng(center.latitude - latDelta, center.longitude + lngDelta),
//         LatLng(center.latitude + latDelta, center.longitude + lngDelta),
//         LatLng(center.latitude + latDelta, center.longitude - lngDelta),
//       ],
//       strokeWidth: 1,
//       strokeColor: Colors.white,
//       fillColor: Colors.blue.withOpacity(0.8),
//     );
//   }
//
//
//
//
//   // old before alternative
//   // Polygon _createPanelPolygon(LatLng center, bool isHorizontal, {String? uniqueId}) {
//   //
//   //   // final panelHeight = isHorizontal ? 2.0 ; 1.0;
//   //   // final panelWidth = isHorizontal ? 1.0 : 2.0;
//   //
//   //   final panelHeight = isHorizontal ? 1.0 : 2.0;
//   //   final panelWidth = isHorizontal ? 2.0 : 1.0;
//   //
//   //   final latDelta = panelHeight / 111111.0 / 2;
//   //   final lngDelta = panelWidth / (111111.0 * cos(center.latitude * pi / 180)) / 2;
//   //
//   //   return Polygon(
//   //     polygonId: PolygonId(uniqueId ?? 'panel_${center.latitude}_${center.longitude}'),
//   //     points: [
//   //       LatLng(center.latitude - latDelta, center.longitude - lngDelta),
//   //       LatLng(center.latitude - latDelta, center.longitude + lngDelta),
//   //       LatLng(center.latitude + latDelta, center.longitude + lngDelta),
//   //       LatLng(center.latitude + latDelta, center.longitude - lngDelta),
//   //     ],
//   //     strokeWidth: 1,
//   //     strokeColor: Colors.white,
//   //     fillColor: Colors.blue.withOpacity(0.8),
//   //   );
//   // }
//
//   LatLngBounds getPolygonBounds(List<LatLng> points) {
//     if (points.isEmpty) {
//       return LatLngBounds(
//         southwest: const LatLng(0, 0),
//         northeast: const LatLng(0, 0),
//       );
//     }
//
//     double minLat = points[0].latitude;
//     double maxLat = points[0].latitude;
//     double minLng = points[0].longitude;
//     double maxLng = points[0].longitude;
//
//     for (final point in points) {
//       minLat = point.latitude < minLat ? point.latitude : minLat;
//       maxLat = point.latitude > maxLat ? point.latitude : maxLat;
//       minLng = point.longitude < minLng ? point.longitude : minLng;
//       maxLng = point.longitude > maxLng ? point.longitude : maxLng;
//     }
//
//     return LatLngBounds(
//       southwest: LatLng(minLat, minLng),
//       northeast: LatLng(maxLat, maxLng),
//     );
//   }
//
//   Future<void> loadIcons() async {
//     boundaryIcon.value = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(10, 10)),
//       "assets/bcircle2.png",
//     );
//     walkWayIcon.value = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(10, 10)),
//       "assets/wcircle.png",
//     );
//
//
//
//   }
//
//   // Add this to your SurveyMapController
//   Future<void> updateBoundaryIcons() async {
//     if (isDrawingHandRail.value) {
//       //     Show only hand rail icons when in hand rail mode
//
//     } else {
//       // Show normal boundary icons when not in hand rail mode
//       boundaryIcon.value = await BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(size: Size(10, 10)),
//         "assets/bcircle2.png",
//       );
//     }
//     update(); // Notify UI to rebuild
//   }
//
//
//   Future<BitmapDescriptor> createTextMarker(String text) async {
//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);
//
//     var textStyle = TextStyle(
//       color: Colors.white,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//       backgroundColor: Colors.black54,
//     );
//
//
//     final textSpan = TextSpan(text: text, style: textStyle);
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );
//
//     textPainter.layout();
//     textPainter.paint(canvas, Offset.zero);
//
//     final image = await recorder.endRecording().toImage(
//       textPainter.width.ceil(),
//       textPainter.height.ceil(),
//     );
//
//     final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
//   }
//
//   double calculateDistance(LatLng start, LatLng end) {
//     final lat1 = start.latitude * pi / 180;
//     final lon1 = start.longitude * pi / 180;
//     final lat2 = end.latitude * pi / 180;
//     final lon2 = end.longitude * pi / 180;
//
//     final dLat = lat2 - lat1;
//     final dLon = lon2 - lon1;
//
//     final a = sin(dLat/2) * sin(dLat/2) +
//         cos(lat1) * cos(lat2) *
//             sin(dLon/2) * sin(dLon/2);
//     final c = 2 * atan2(sqrt(a), sqrt(1-a));
//
//     return earthRadius * c;
//   }
//
//   double calculatePolygonArea(List<LatLng> points) {
//     if (points.length < 3) return 0.0;
//     double area = 0.0;
//     final len = points.length;
//
//     for (int i = 0; i < len; i++) {
//       final p1 = points[i];
//       final p2 = points[(i + 1) % len];
//       area += toRadians(p2.longitude - p1.longitude) *
//           (2 + sin(toRadians(p1.latitude)) + sin(toRadians(p2.latitude)));
//     }
//
//     return (area * 6378137 * 6378137 / 2).abs();
//   }
//
//
//   double toRadians(double degree) => degree * pi / 180;
//
//
//   void clearPolygon() {
//     polygonPoints.clear();
//     polygonArea.value = 0.0;
//     distanceMarkers.clear();
//     solarPanelsPolygons.clear();
//     currentWalkways.clear(); // NEW: Clear walkways
//   }
//
//
//   bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
//     bool inside = false;
//     for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
//       final xi = polygon[i].latitude;
//       final yi = polygon[i].longitude;
//       final xj = polygon[j].latitude;
//       final yj = polygon[j].longitude;
//
//       final intersect = ((yi > point.longitude) != (yj > point.longitude)) &&
//           (point.latitude < (xj - xi) * (point.longitude - yi) / (yj - yi) + xi);
//
//       if (intersect) inside = !inside;
//     }
//     return inside;
//   }
//
//   Future<void> requestLocation() async {
//     // _uriSub = uriLinkStream.listen((Uri? uri) {
//     //   if (uri != null) _processLocationUri(uri);
//     // });
//     //
//     // String phone = "+91 9574510891";
//     // const message = "Please share Current Location via 📎 button";
//     // final url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";
//     //
//     // if (await canLaunchUrl(Uri.parse(url))) {
//     //   await launchUrl(Uri.parse(url));
//     // } else {
//     //   _uriSub?.cancel();
//     // }
//   }
//
//   void _processLocationUri(Uri uri) {
//     if (uri.scheme == 'geo') {
//       final coords = uri.path.split(',');
//       if (coords.length >= 2) {
//         final lat = double.tryParse(coords[0]);
//         final lng = double.tryParse(coords[1]);
//
//         if (lat != null && lng != null) {
//           final newLocation = LatLng(lat, lng);
//           pickedLocation = newLocation as Rx<LatLng>;
//           mapController?.animateCamera(
//             CameraUpdate.newLatLngZoom(newLocation, 16),
//           );
//           _uriSub?.cancel();
//         }
//       }
//     }
//   }
// }
//
//
//
//
//
//
//


import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Walkway {
  String id;
  String name;
  List<LatLng> points;
  bool isHorizontal;
  double width;
  double length;
  double maxLength;
  double rotationAngle;

  Walkway({
    required this.id,
    required this.points,
    this.isHorizontal = true,
    this.width = 0.5,
    this.length = 3.0,
    required this.maxLength,
    this.rotationAngle = 0,
    required this.name,
  });

  Polygon toPolygon() => Polygon(
    polygonId: PolygonId(id),
    points: points,
    strokeWidth: 1,
    strokeColor: Colors.deepOrange,
    fillColor: Colors.deepOrange.withOpacity(0.5),
  );

  Walkway copyWith({
    List<LatLng>? points,
    bool? isHorizontal,
    double? width,
    double? length,
    double? maxLength,
    String? name,
  }) {
    return Walkway(
      id: id,
      points: points ?? this.points,
      isHorizontal: isHorizontal ?? this.isHorizontal,
      width: width ?? this.width,
      length: length ?? this.length,
      maxLength: maxLength ?? this.maxLength,
      name: name ?? this.name,
    );
  }
}

class Terrace {
  String id;
  List<LatLng> areaPoints;
  List<LatLng> panels;
  List<Walkway> walkways;
  bool isHorizontal;
  bool isAlternate;
  double padding;
  double rowSpacing;
  bool isActive;
  bool hasGril;
  List<LatLng> handRailPoints;
  List<int> selectedBorderIndices;
  List<bool> rowOrientations;

  Terrace({
    required this.id,
    required this.areaPoints,
    required this.panels,
    this.walkways = const [],
    this.isHorizontal = true,
    this.isAlternate = false,
    this.padding = 0,
    this.rowSpacing = 0,
    this.isActive = true,
    this.hasGril = false,
    this.handRailPoints = const [],
    this.selectedBorderIndices = const [],
    this.rowOrientations = const [],
  });

  Terrace copyWith({
    List<LatLng>? areaPoints,
    List<LatLng>? panels,
    List<Walkway>? walkways,
    bool? isHorizontal,
    bool? isAlternate,
    double? padding,
    double? rowSpacing,
    bool? isActive,
    bool? hasGril,
    List<LatLng>? handRailPoints,
    List<int>? selectedBorderIndices,
    List<bool>? rowOrientations,
  }) {
    return Terrace(
      id: id,
      areaPoints: areaPoints ?? this.areaPoints,
      panels: panels ?? this.panels,
      walkways: walkways ?? this.walkways,
      isHorizontal: isHorizontal ?? this.isHorizontal,
      isAlternate: isAlternate ?? this.isAlternate,
      padding: padding ?? this.padding,
      rowSpacing: rowSpacing ?? this.rowSpacing,
      isActive: isActive ?? this.isActive,
      hasGril: hasGril ?? this.hasGril,
      handRailPoints: handRailPoints ?? this.handRailPoints,
      selectedBorderIndices: selectedBorderIndices ?? this.selectedBorderIndices,
      rowOrientations: rowOrientations ?? this.rowOrientations,
    );
  }
}

class SurveyMapController2 extends GetxController {
  // Reactive variables
  var polygonPoints = <LatLng>[].obs;
  var polygonArea = 0.0.obs;
  var polylines = <Polyline>{}.obs;
  var distanceMarkers = <Marker>{}.obs;
  var segmentDistances = <double>[].obs;
  var isSelectingArea = false.obs;
  var showStreetView = false.obs;
  var pickedLocation = LatLng(22.260076, 70.787970).obs;
  var address = "Location".obs;
  var showInMeters = true.obs;
  var boundaryIcon = BitmapDescriptor.defaultMarker.obs;
  var walkWayIcon = BitmapDescriptor.defaultMarker.obs;

  var selectedvalue = "H".obs;
  var paddingSliderValue = 0.0.obs;
  var selectedmaserType = "m".obs;
  var selectedwalkwayOrinteation = "H".obs;
  var rowSpacingSlidervalue = 0.0.obs;
  var terraceType = "".obs;

  RxList<Walkway> currentWalkways = <Walkway>[].obs;
  RxInt editingWalkwayIndex = (-1).obs;
  var currentHasGril = false.obs;
  RxDouble padding = 0.0.obs;
  final RxInt rowSpacingInterval = 1.obs;

  GoogleMapController? mapController;

  final double earthRadius = 6371000;

  var savedTerraces = <Terrace>[].obs;
  var allPanels = <Polygon>{}.obs;
  var isNewTerrace = false.obs;

  var editingTerraceIndex = (-1).obs;
  var originalTerracePoints = <LatLng>[].obs;

  TextEditingController frontLegController = TextEditingController(text: "0");
  TextEditingController backLegController = TextEditingController(text: "0");
  TextEditingController buildingNamecontrol = TextEditingController();
  RxDouble sliderLimit = 5.0.obs;

  GlobalKey<FormState> tableStructureKey = GlobalKey<FormState>();

  final RxMap<String, String> terraceBuildings = <String, String>{}.obs;
  final RxString currentBuilding = 'Building 1'.obs;
  final selectedBuilding = RxString('');
  RxString selectedWalkwayWidth = "270".obs;

  RxList<LatLng> currentHandRailPoints = <LatLng>[].obs;
  RxBool isDrawingHandRail = false.obs;
  RxBool isHandRailComplete = false.obs;

  final RxSet<Polygon> solarPanelsPolygons = <Polygon>{}.obs;
  final RxBool isHorizontal = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadIcons();
  }

  // --------------------------------------------------------------------------
  // Walkway management
  // --------------------------------------------------------------------------
  void addWalkway() {
    if (polygonPoints.isEmpty) return;
    final bounds = getPolygonBounds(polygonPoints);
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );
    final double widthMeters = double.parse(selectedWalkwayWidth.value) / 1000;
    final double lengthMeters = min(
        (bounds.northeast.longitude - bounds.southwest.longitude) *
            111111 *
            cos(center.latitude * pi / 180),
        (bounds.northeast.latitude - bounds.southwest.latitude) * 111111);
    currentWalkways.add(Walkway(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Walkway ${currentWalkways.length + 1}',
      points: _createWalkwayPoints(center, isHorizontal.value, widthMeters, lengthMeters),
      isHorizontal: isHorizontal.value,
      width: widthMeters,
      length: lengthMeters,
      maxLength: lengthMeters,
    ));
    editingWalkwayIndex.value = currentWalkways.length - 1;
    updatePanelPositions();
  }

  List<LatLng> _createWalkwayPoints(LatLng center, bool isHoriz, double width, double length) {
    final latDelta = (isHoriz ? width : length) / 111111.0 / 2;
    final lngDelta = (isHoriz ? length : width) / (111111.0 * cos(center.latitude * pi / 180)) / 2;
    return [
      LatLng(center.latitude - latDelta, center.longitude - lngDelta),
      LatLng(center.latitude - latDelta, center.longitude + lngDelta),
      LatLng(center.latitude + latDelta, center.longitude + lngDelta),
      LatLng(center.latitude + latDelta, center.longitude - lngDelta),
    ];
  }

  void updateWalkwayPoints(int index, List<LatLng> newPoints) {
    if (index < 0 || index >= currentWalkways.length) return;
    final walkway = currentWalkways[index];
    final bounds = getPolygonBounds(newPoints);
    double newLength;
    if (walkway.isHorizontal) {
      newLength = (bounds.northeast.longitude - bounds.southwest.longitude) *
          111111 *
          cos(bounds.southwest.latitude * pi / 180);
    } else {
      newLength = (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
    }
    currentWalkways[index] = walkway.copyWith(points: newPoints, length: newLength);
    updatePanelPositions();
  }

  void updateWalkwayLength(int index, double newLength) {
    if (index < 0 || index >= currentWalkways.length) return;
    if (editingTerraceIndex.value < 0 || editingTerraceIndex.value >= savedTerraces.length) return;
    final walkway = currentWalkways[index];
    final terrace = savedTerraces[editingTerraceIndex.value];
    final bounds = getPolygonBounds(terrace.areaPoints);
    double maxLen;
    if (walkway.isHorizontal) {
      maxLen = (bounds.northeast.longitude - bounds.southwest.longitude) *
          111111 *
          cos(bounds.southwest.latitude * pi / 180);
    } else {
      maxLen = (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
    }
    final clamped = newLength.clamp(1.0, maxLen);
    final center = getCenter(walkway.points);
    final newPoints = _createWalkwayPoints(center, walkway.isHorizontal, walkway.width, clamped);
    currentWalkways[index] = walkway.copyWith(length: clamped, points: newPoints, maxLength: maxLen);
    updatePanelPositions();
  }

  void removeWalkway(int index) {
    if (index >= 0 && index < currentWalkways.length) {
      currentWalkways.removeAt(index);
    }
    editingWalkwayIndex.value = -1;
  }

  void toggleWalkwayOrientation(int index) {
    if (index < 0 || index >= currentWalkways.length) return;
    final walkway = currentWalkways[index];
    final newOrientation = !walkway.isHorizontal;
    final center = getCenter(walkway.points);
    currentWalkways[index] = walkway.copyWith(
      isHorizontal: newOrientation,
      points: _createWalkwayPoints(center, newOrientation, walkway.width, walkway.length),
    );
    selectedwalkwayOrinteation.value = newOrientation ? "H" : "V";
    updatePanelPositions();
  }

  LatLng getCenter(List<LatLng> points) {
    double lat = 0, lng = 0;
    for (final p in points) {
      lat += p.latitude;
      lng += p.longitude;
    }
    return LatLng(lat / points.length, lng / points.length);
  }

  // --------------------------------------------------------------------------
  // Panel calculation with full row/column removal for walkways
  // --------------------------------------------------------------------------
  List<LatLng> calculatePanelCenters(
      List<LatLng> polygonPoints,
      bool isHorizontal,
      double padding,
      double rowSpacing, {
        bool isAlternate = false,
      }) {
    List<LatLng> centers = [];
    if (polygonPoints.length < 3) return centers;

    final bounds = getPolygonBounds(polygonPoints);
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    const double panelWidth = 1.0;   // 1m for vertical orientation
    const double panelHeight = 2.0;  // 2m for horizontal orientation

    final double paddingLat = padding / 111111.0;
    final double paddingLng = padding / (111111.0 * cos(center.latitude * pi / 180));

    final double startLat = bounds.southwest.latitude + paddingLat;
    final double endLat = bounds.northeast.latitude - paddingLat;
    final double startLng = bounds.southwest.longitude + paddingLng;
    final double endLng = bounds.northeast.longitude - paddingLng;

    final double widthMeters = (endLng - startLng) * 111111 * cos(center.latitude * pi / 180);
    final double heightMeters = (endLat - startLat) * 111111;

    int cols, rows;
    if (isAlternate) {
      cols = (widthMeters / panelWidth).floor();
      rows = (heightMeters / 1.5).floor();
    } else if (isHorizontal) {
      cols = (widthMeters / panelHeight).floor();
      rows = (heightMeters / panelWidth).floor();
    } else {
      cols = (widthMeters / panelWidth).floor();
      rows = (heightMeters / panelHeight).floor();
    }

    if (cols <= 0 || rows <= 0) return centers;

    final double lngStep = (endLng - startLng) / cols;
    final double latStep = (endLat - startLat) / rows;

    // Determine exactly which rows/columns to remove
    Set<int> rowsToRemove = {};
    Set<int> colsToRemove = {};

    for (final walkway in currentWalkways) {
      // Calculate average position of the walkway
      double avgLat = 0, avgLng = 0;
      for (final p in walkway.points) {
        avgLat += p.latitude;
        avgLng += p.longitude;
      }
      avgLat /= walkway.points.length;
      avgLng /= walkway.points.length;

      if (walkway.isHorizontal) {
        // Horizontal walkway: find the row index that contains avgLat
        int rowIndex = ((avgLat - startLat) / latStep).round().clamp(0, rows - 1);
        rowsToRemove.add(rowIndex);
      } else {
        // Vertical walkway: find the column index that contains avgLng
        int colIndex = ((avgLng - startLng) / lngStep).round().clamp(0, cols - 1);
        colsToRemove.add(colIndex);
      }
    }

    // Generate grid positions, skipping removed rows/columns
    // the quivk brown fox
    for (int y = 0; y < rows; y++) {
      if (rowsToRemove.contains(y)) continue;

      for (int x = 0; x < cols; x++) {
        if (colsToRemove.contains(x)) continue;

        final double centerLng = startLng + (x * lngStep) + (lngStep / 2);
        final double centerLat = startLat + (y * latStep) + (latStep / 2);
        final LatLng panelCenter = LatLng(centerLat, centerLng);

        if (_isPointInPolygon(panelCenter, polygonPoints)) {
          centers.add(panelCenter);
        }
      }
    }

    return centers;
  }

  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    bool inside = false;
    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      final xi = polygon[i].latitude;
      final yi = polygon[i].longitude;
      final xj = polygon[j].latitude;
      final yj = polygon[j].longitude;

      final intersect = ((yi > point.longitude) != (yj > point.longitude)) &&
          (point.latitude < (xj - xi) * (point.longitude - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }
    return inside;
  }

  Set<Polygon> convertCentersToPolygons(
      List<LatLng> centers,
      bool isHorizontal, {
        bool isAlternate = false,
      }) {
    Set<Polygon> polygons = {};
    if (isAlternate && editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];
      if (terrace.rowOrientations.isNotEmpty) {
        final bounds = getPolygonBounds(terrace.areaPoints);
        final latRange = bounds.northeast.latitude - bounds.southwest.latitude;
        for (int i = 0; i < centers.length; i++) {
          final normalizedLat = (centers[i].latitude - bounds.southwest.latitude) / latRange;
          final rowIndex = (normalizedLat * terrace.rowOrientations.length).toInt().clamp(0, terrace.rowOrientations.length - 1);
          polygons.add(_createPanelPolygon(centers[i], isHorizontal, rowIndex: rowIndex));
        }
        return polygons;
      }
    }
    return centers.map((c) => _createPanelPolygon(c, isHorizontal)).toSet();
  }

  Polygon _createPanelPolygon(LatLng center, bool isHorizontal, {int rowIndex = 0}) {
    final panelWidth = isHorizontal ? 2.0 : 1.0;
    final panelHeight = isHorizontal ? 1.0 : 2.0;
    final latDelta = panelHeight / 111111.0 / 2;
    final lngDelta = panelWidth / (111111.0 * cos(center.latitude * pi / 180)) / 2;
    return Polygon(
      polygonId: PolygonId('panel_${center.latitude}_${center.longitude}_$rowIndex'),
      points: [
        LatLng(center.latitude - latDelta, center.longitude - lngDelta),
        LatLng(center.latitude - latDelta, center.longitude + lngDelta),
        LatLng(center.latitude + latDelta, center.longitude + lngDelta),
        LatLng(center.latitude + latDelta, center.longitude - lngDelta),
      ],
      strokeWidth: 1,
      strokeColor: Colors.white,
      fillColor: Colors.blue.withOpacity(0.8),
    );
  }

  void updatePanelPositions() {
    if (editingTerraceIndex.value != -1) {
      solarPanelsPolygons.clear();
      final terrace = savedTerraces[editingTerraceIndex.value];
      final newCenters = calculatePanelCenters(
        terrace.areaPoints,
        terrace.isHorizontal,
        terrace.padding,
        terrace.rowSpacing,
        isAlternate: terrace.isAlternate,
      );
      savedTerraces[editingTerraceIndex.value] = terrace.copyWith(panels: newCenters);
      solarPanelsPolygons.value = convertCentersToPolygons(
          newCenters, terrace.isHorizontal, isAlternate: terrace.isAlternate);
    }
  }

  // --------------------------------------------------------------------------
  // Terrace editing & saving
  // --------------------------------------------------------------------------
  void startEditingTerrace(int index) {
    editingTerraceIndex.value = index;
    originalTerracePoints.value = List<LatLng>.from(savedTerraces[index].areaPoints);
    polygonPoints.value = List<LatLng>.from(savedTerraces[index].areaPoints);
    currentWalkways.value = List<Walkway>.from(savedTerraces[index].walkways);

    if (savedTerraces[index].hasGril) {
      currentHandRailPoints.value = List<LatLng>.from(savedTerraces[index].handRailPoints);
      isHandRailComplete.value = true;
    } else {
      currentHandRailPoints.clear();
      isHandRailComplete.value = false;
    }
    isDrawingHandRail.value = false;

    isHorizontal.value = savedTerraces[index].isHorizontal;
    paddingSliderValue.value = savedTerraces[index].padding;
    rowSpacingSlidervalue.value = savedTerraces[index].rowSpacing;
    currentHasGril.value = savedTerraces[index].hasGril;

    updatePolygon(forceUpdate: true);
    update(); // ensure UI refreshes
  }

  void saveEditedTerrace() {
    if (editingTerraceIndex.value == -1 || polygonPoints.length < 3) return;
    final terrace = savedTerraces[editingTerraceIndex.value];
    final newHandRailPoints = isDrawingHandRail.value
        ? List<LatLng>.from(currentHandRailPoints)
        : terrace.handRailPoints;
    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
      areaPoints: List<LatLng>.from(polygonPoints),
      panels: calculatePanelCenters(
          polygonPoints,
          terrace.isHorizontal,
          terrace.padding,
          terrace.rowSpacing,
          isAlternate: terrace.isAlternate),
      walkways: List<Walkway>.from(currentWalkways),
      handRailPoints: newHandRailPoints,
      hasGril: newHandRailPoints.isNotEmpty,
    );
    editingTerraceIndex.value = -1;
    currentWalkways.clear();
    polygonPoints.clear();
    isDrawingHandRail.value = false;
    currentHandRailPoints.clear();
    isHandRailComplete.value = false;
    updatePanelPositions();
    update();
  }

  void cancelEditing() {
    editingTerraceIndex.value = -1;
    originalTerracePoints.clear();
    polygonPoints.clear();
    currentWalkways.clear();
    isDrawingHandRail.value = false;
    currentHandRailPoints.clear();
    isHandRailComplete.value = false;
  }

  void saveCurrentTerrace() {
    if (polygonPoints.length >= 3) {
      final newTerrace = Terrace(
        id: DateTime.now().toString(),
        areaPoints: List<LatLng>.from(polygonPoints),
        panels: calculatePanelCenters(
            polygonPoints,
            isHorizontal.value,
            paddingSliderValue.value,
            rowSpacingSlidervalue.value),
        walkways: List<Walkway>.from(currentWalkways),
        isHorizontal: isHorizontal.value,
        padding: paddingSliderValue.value,
        rowSpacing: rowSpacingSlidervalue.value,
        isActive: true,
      );
      terraceBuildings[newTerrace.id] = currentBuilding.value;
      savedTerraces.add(newTerrace);
      calculateAllPanels();
      startNewTerrace();
      currentWalkways.clear();
    }
  }

  void startNewTerrace() {
    polygonPoints.clear();
    isSelectingArea.value = true;
    isNewTerrace.value = true;
    currentHasGril.value = false;
    currentHandRailPoints.clear();
    isDrawingHandRail.value = false;
    isHandRailComplete.value = false;
  }

  void calculateAllPanels() {
    allPanels.clear();
    for (final terrace in savedTerraces) {
      allPanels.addAll(convertCentersToPolygons(
          terrace.panels, terrace.isHorizontal, isAlternate: terrace.isAlternate));
    }
    if (polygonPoints.length >= 3) {
      allPanels.addAll(convertCentersToPolygons(
          calculatePanelCenters(polygonPoints, isHorizontal.value,
              paddingSliderValue.value, rowSpacingSlidervalue.value),
          isHorizontal.value));
    }
  }

  void calculateSolarPanels1() {
    solarPanelsPolygons.value = convertCentersToPolygons(
        calculatePanelCenters(polygonPoints, isHorizontal.value,
            paddingSliderValue.value, rowSpacingSlidervalue.value),
        isHorizontal.value);
  }

  // --------------------------------------------------------------------------
  // Hand rail methods (simplified stubs – integrate your existing code)
  // --------------------------------------------------------------------------
  void toggleBorderSelection(int index) {
    if (!isDrawingHandRail.value || editingTerraceIndex.value == -1) return;
    final terrace = savedTerraces[editingTerraceIndex.value];
    final selectedIndices = List<int>.from(terrace.selectedBorderIndices);
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    selectedIndices.sort();
    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(selectedBorderIndices: selectedIndices);
    updateHandRailFromSelectedBorders();
  }

  void updateHandRailFromSelectedBorders() {
    if (editingTerraceIndex.value == -1) return;
    final terrace = savedTerraces[editingTerraceIndex.value];
    currentHandRailPoints.clear();
    for (final index in terrace.selectedBorderIndices) {
      final nextIndex = (index + 1) % polygonPoints.length;
      currentHandRailPoints.add(polygonPoints[index]);
      currentHandRailPoints.add(polygonPoints[nextIndex]);
    }
    update();
  }

  void finishDrawingHandRail() {
    if (editingTerraceIndex.value == -1) return;
    final terrace = savedTerraces[editingTerraceIndex.value];
    final uniqueIndices = terrace.selectedBorderIndices.toSet().toList()..sort();
    final handRailPoints = <LatLng>[];
    for (final index in uniqueIndices) {
      final nextIndex = (index + 1) % polygonPoints.length;
      handRailPoints.add(polygonPoints[index]);
      handRailPoints.add(polygonPoints[nextIndex]);
    }
    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
      handRailPoints: handRailPoints,
      hasGril: handRailPoints.isNotEmpty,
    );
    isDrawingHandRail.value = false;
    isHandRailComplete.value = handRailPoints.isNotEmpty;
    update();
  }

  bool isPointNearBorder(LatLng tapPoint, LatLng lineStart, LatLng lineEnd) {
    const double threshold = 0.00005;
    if (lineStart == lineEnd) return false;
    final lineLength = calculateDistance(lineStart, lineEnd);
    final distance = ((lineEnd.latitude - lineStart.latitude) * (tapPoint.longitude - lineStart.longitude) -
        (lineEnd.longitude - lineStart.longitude) * (tapPoint.latitude - lineStart.latitude))
        .abs() /
        lineLength;
    return distance < threshold;
  }

  double calculateHandRailLength(List<LatLng> handRailPoints) {
    if (handRailPoints.isEmpty || handRailPoints.length % 2 != 0) return 0.0;
    double total = 0.0;
    for (int i = 0; i < handRailPoints.length; i += 2) {
      if (i + 1 < handRailPoints.length) {
        total += calculateDistance(handRailPoints[i], handRailPoints[i + 1]);
      }
    }
    return total;
  }

  // --------------------------------------------------------------------------
  // Map utilities
  // --------------------------------------------------------------------------
  Future<void> updatePolygon({bool forceUpdate = false}) async {
    if (!forceUpdate && polygonPoints.length < 2) return;
    polylines.clear();
    distanceMarkers.clear();
    segmentDistances.clear();

    final List<LatLng> cleanPoints = List<LatLng>.from(polygonPoints);
    if (cleanPoints.length >= 3 && cleanPoints.first == cleanPoints.last) {
      cleanPoints.removeLast();
    }

    for (int i = 0; i < cleanPoints.length; i++) {
      final nextIndex = (i + 1) % cleanPoints.length;
      final distance = calculateDistance(cleanPoints[i], cleanPoints[nextIndex]);
      final converted = showInMeters.value ? distance : distance * 3.28084;
      final textMarker = await createTextMarker(
          '${converted.toStringAsFixed(1)}${showInMeters.value ? 'm' : 'ft'}');
      final midpoint = LatLng(
        (cleanPoints[i].latitude + cleanPoints[nextIndex].latitude) / 2,
        (cleanPoints[i].longitude + cleanPoints[nextIndex].longitude) / 2,
      );
      distanceMarkers.add(Marker(
        markerId: MarkerId('distance_$i'),
        position: midpoint,
        icon: textMarker,
        anchor: const Offset(0.5, 0.5),
      ));
    }

    if (cleanPoints.length >= 3) {
      final closed = List<LatLng>.from(cleanPoints)..add(cleanPoints[0]);
      polygonArea.value = calculatePolygonArea(closed);
    } else {
      polygonArea.value = 0.0;
    }
  }

  double calculateDistance(LatLng start, LatLng end) {
    final lat1 = start.latitude * pi / 180;
    final lon1 = start.longitude * pi / 180;
    final lat2 = end.latitude * pi / 180;
    final lon2 = end.longitude * pi / 180;
    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double calculatePolygonArea(List<LatLng> points) {
    if (points.length < 3) return 0.0;
    double area = 0.0;
    for (int i = 0; i < points.length; i++) {
      final p1 = points[i];
      final p2 = points[(i + 1) % points.length];
      area += toRadians(p2.longitude - p1.longitude) *
          (2 + sin(toRadians(p1.latitude)) + sin(toRadians(p2.latitude)));
    }
    return (area * 6378137 * 6378137 / 2).abs();
  }

  double toRadians(double degree) => degree * pi / 180;

  LatLngBounds getPolygonBounds(List<LatLng> points) {
    if (points.isEmpty) return  LatLngBounds(southwest: LatLng(0, 0), northeast: LatLng(0, 0));
    double minLat = points[0].latitude, maxLat = points[0].latitude;
    double minLng = points[0].longitude, maxLng = points[0].longitude;
    for (final p in points) {
      minLat = min(minLat, p.latitude);
      maxLat = max(maxLat, p.latitude);
      minLng = min(minLng, p.longitude);
      maxLng = max(maxLng, p.longitude);
    }
    return LatLngBounds(southwest: LatLng(minLat, minLng), northeast: LatLng(maxLat, maxLng));
  }

  void clearPolygon() {
    polygonPoints.clear();
    polygonArea.value = 0.0;
    distanceMarkers.clear();
    solarPanelsPolygons.clear();
    currentWalkways.clear();
  }

  Future<void> loadIcons() async {
    boundaryIcon.value = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(10, 10)), "assets/bcircle2.png");
    walkWayIcon.value = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(10, 10)), "assets/wcircle.png");
  }

  Future<BitmapDescriptor> createTextMarker(String text) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final textPainter = TextPainter(
      text: TextSpan(
          text: text,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, backgroundColor: Colors.black54)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);
    final image = await recorder.endRecording().toImage(textPainter.width.ceil(), textPainter.height.ceil());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  void toggleBuildingSelection(String buildingName) {
    if (selectedBuilding.value == buildingName) {
      selectedBuilding.value = '';
    } else {
      selectedBuilding.value = buildingName;
    }
  }
}