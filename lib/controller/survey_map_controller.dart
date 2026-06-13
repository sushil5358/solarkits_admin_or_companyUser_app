import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';

import '../custome_snackbar.dart';
import '../models/comman_model.dart';
import '../models/project_type_model.dart';
import '../retrofit.dart';







class Walkway {
  String id;
  String name;
  List<LatLng> points;
  bool isHorizontal;
  double width; // Width in meters (500mm = 0.5m)
  double length; // Length in meters
  double maxLength;
  double rotationAngle; // Maximum possible length

  Walkway(
      {required this.id,
        required this.points,
        this.isHorizontal = true,
        this.width = 0.5, // Default 500mm
        this.length = 3.0,
        required this.maxLength,
        this.rotationAngle = 0,
        required this.name});

  Polygon toPolygon() {
    return Polygon(
      polygonId: PolygonId(id),
      points: points,
      strokeWidth: 1,
      strokeColor: Colors.deepOrange,
      fillColor: Colors.deepOrange.withOpacity(0.5),
    );
  }

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

class PanelBounds {
  final double north, south, east, west;
  PanelBounds(
      {required this.north,
        required this.south,
        required this.east,
        required this.west});
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
  List<bool> rowOrientations = [];
  double paneltotalWidth;
  double paneltotalHeight;
  String terraceType;
  bool isMeterOrFeet; // true for meter, false for feet
  int frontLegHeight;
  int backLegHeight;
  String inverterPositopn;
  String mountingStyle;
  int numberOfRows;
  int nofPanels;
  double totalKg;
  int f6040;
  int f4040;
  int lAngle_qty;
  int americanBolt_qty;
  int zink_qty;
  int jBolt_qty;
  int foundation_qty;
  int dcWire_meter;
  int acWire_meter;
  double azimuthAngle;
  int extraPipes;

  String customerName;
  String customerMobile;
  String buildingName;

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
    this.paneltotalWidth = 0.0,
    this.paneltotalHeight = 0.0,
    this.terraceType = "Rcc Roof",
    this.isMeterOrFeet = true,
    this.frontLegHeight = 0,
    this.backLegHeight = 0,
    this.inverterPositopn = "Ground Floor",
    this.mountingStyle = "Legs On Terrace",
    this.numberOfRows = 1,
    this.nofPanels = 0,
    this.totalKg = 0.0,
    this.f6040 = 1,
    this.f4040 = 1,
    this.lAngle_qty = 1,
    this.americanBolt_qty = 1,
    this.zink_qty = 1,
    this.jBolt_qty = 1,
    this.foundation_qty = 1,
    this.dcWire_meter = 1,
    this.acWire_meter = 1,
    this.azimuthAngle = 0.0,
    this.extraPipes = 0,
    this.buildingName = "",
    this.customerMobile = "",
    this.customerName = "",
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
    double? paneltotalWidth,
    double? paneltotalHeight,
    String? terraceType,
    bool? isMeterOrFeet,
    int? frontLegHeight,
    int? backLegHeight,
    String? inverterPositopn,
    String? mountingStyle,
    int? numberOfRows,
    int? nofPanels,
    double? totalKg,
    int? f6040,
    int? f4040,
    int? lAngle_qty,
    int? americanBolt_qty,
    int? zink_qty,
    int? jBolt_qty,
    int? foundation_qty,
    int? dcWire_meter,
    int? acWire_meter,
    double? azimuthAngle,
    int? extraPipes,
    String? customerName,
    String? customerMobile,
    String? buildingName,
  }) {
    return Terrace(
      id: this.id,
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
      selectedBorderIndices:
      selectedBorderIndices ?? this.selectedBorderIndices,
      rowOrientations: rowOrientations ?? this.rowOrientations,
      paneltotalWidth: paneltotalWidth ?? this.paneltotalWidth,
      paneltotalHeight: paneltotalHeight ?? this.paneltotalHeight,
      terraceType: terraceType ?? this.terraceType,
      isMeterOrFeet: isMeterOrFeet ?? this.isMeterOrFeet,
      frontLegHeight: frontLegHeight ?? this.frontLegHeight,
      backLegHeight: backLegHeight ?? this.backLegHeight,
      inverterPositopn: inverterPositopn ?? this.inverterPositopn,
      mountingStyle: mountingStyle ?? this.mountingStyle,
      numberOfRows: numberOfRows ?? this.numberOfRows,
      nofPanels: nofPanels ?? this.nofPanels,
      totalKg: totalKg ?? this.totalKg,
      f6040: f6040 ?? this.f6040,
      f4040: f4040 ?? this.f4040,
      lAngle_qty: lAngle_qty ?? this.lAngle_qty,
      americanBolt_qty: americanBolt_qty ?? this.americanBolt_qty,
      zink_qty: zink_qty ?? this.zink_qty,
      jBolt_qty: jBolt_qty ?? this.jBolt_qty,
      foundation_qty: foundation_qty ?? this.foundation_qty,
      dcWire_meter: dcWire_meter ?? this.dcWire_meter,
      acWire_meter: acWire_meter ?? this.acWire_meter,
      azimuthAngle: azimuthAngle ?? this.azimuthAngle,
      extraPipes: extraPipes ?? this.extraPipes,
      buildingName: buildingName ?? this.buildingName,
      customerMobile: customerMobile ?? this.customerMobile,
      customerName: customerName ?? this.customerName,
    );
  }
}

class StructureBounds {
  final double north, south, east, west;
  StructureBounds(
      {required this.north,
        required this.south,
        required this.east,
        required this.west});
}

class SurveyMapController extends GetxController {
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
  var panelDrageIcos = BitmapDescriptor.defaultMarker.obs;

  StreamSubscription? _uriSub;
  var selectedvalue = "H".obs;
  var paddingSliderValue = 0.0.obs;
  var selectedmaserType = "m".obs;
  var selectedwalkwayOrinteation = "H".obs;
  var rowSpacingSlidervalue = 0.0.obs;
  var terraceType = "".obs;

  // NEW: Walkway management
  RxList<Walkway> currentWalkways = <Walkway>[].obs;
  RxInt editingWalkwayIndex = (-1).obs;
  // In SurveyMapController
  var currentHasGril = false.obs;

  RxDouble padding = 0.0.obs;
  final RxInt rowSpacingInterval = 1.obs;

  GoogleMapController? mapController;
  // StreetViewController? streetViewController;

  final double earthRadius = 6371000;

  var savedTerraces = <Terrace>[].obs;
  var allPanels = <Polygon>{}.obs;
  var isNewTerrace = false.obs;

  var editingTerraceIndex = (-1).obs;
  var originalTerracePoints = <LatLng>[].obs;

  TextEditingController frontLegController = TextEditingController(text: "0");
  TextEditingController backLegController = TextEditingController(text: "0");
  TextEditingController buildingNamecontrol = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxDouble sliderLimit = 5.0.obs;

  GlobalKey<FormState> buildingStructureKey = GlobalKey<FormState>();
  GlobalKey<FormState> StructureTableKey = GlobalKey<FormState>();
  GlobalKey<FormState> drawerKey = GlobalKey<FormState>();

  final RxMap<String, String> terraceBuildings = <String, String>{}.obs;
  final RxString currentBuilding = 'Building 1'.obs;
  RxString currentCustomerName = ''.obs;
  RxString currentCustomerMobile = ''.obs;

  final selectedBuilding = RxString('');

  RxString selectedWalkwayWidth = "270".obs; // Default to 270mm

  RxList<LatLng> currentHandRailPoints = <LatLng>[].obs;
  RxBool isDrawingHandRail = false.obs;
  RxBool isHandRailComplete = false.obs;

  var selectedPanelCount = 0.obs;
  var hasSelectedPanelCount = false.obs;
  var availablePanelCounts = [4, 5, 6, 7, 8, 9, 10].obs;

  RxBool isMeaterorFeet_strucrt = false.obs;

  RxList total_floor = [].obs;

  // Add these variables for layout selection
  var selectedLayout = 0
      .obs; // 0: 2xN vertical, 1: 1xN vertical, 2: Nx2 horizontal, 3: 2xN horizontal
  var availableLayouts = <int>[].obs;
  var panelOrientation = "H".obs;
  var layoutOptions = [
    "2 Row", // "2×N Vertical",
    "1 Row", // "1×N Vertical",
    "2 Column", // "N×2 Horizontal",
    "2 Row" // "2×N Horizontal"
  ];

  //

  var originalPanelCenters = <LatLng>[].obs;
  var solarPanelsPolygons = <Polygon>{}.obs;
  LatLng? dragStartPosition;

  var isDraggingPanel = false.obs;
  var draggedPanelIndex = (-1).obs;
  LatLng? dragStartPoint;
  List<LatLng> originalPanelPositions = [];
  var isDragHandleMoving = false.obs;
  LatLng? dragHandleStartPosition;

  // Add these to track drag handle position independently
  var dragHandlePosition = LatLng(0, 0).obs;
  var isManuallyDraggingHandle = false.obs;

  // Add this to track the current highlighted option
  var highlightedLayout = "Legs On Terrace".obs;

  var currentHeading = 0.0.obs;

  // for number of rows
  var selectedRows = 1.obs;
  var availableRows = <int>[].obs;
  var totalPanelWidth = 0.1.obs;
  var totalPanelHeight = 0.0.obs;

  var panel_technology_list = <Common_Model>[].obs;
  RxString dropdown_solar_technology_id = ''.obs;

  var panel_wats_list = <Common_Model>[].obs;
  RxString dropdown_panel_wats_id = ''.obs;
  RxString dropdown_panel_wats_name = ''.obs;
  // RxString  dropdown_panels_watts_name = "".obs;
  // RxString

  var KW_list = <Common_Model>[].obs;
  RxString dropdown_KW_id = '0'.obs;
  RxString dropdown_KW_name = ''.obs;
  RxString kilowat = ''.obs;

  var projectTypeList = <Project_type_model>[].obs;

  var nofpanelList = [].obs;
  RxString numberOfPanels = "".obs;
  RxString selectedKW = "".obs;

  var azimuthAngle =
      0.0.obs; // Angle in degrees (0 = South, -90 = East, +90 = West)
  var showAzimuthSlider = false.obs;

  final originalPanelOffsets = <Offset>[];
  var originalPanelPositionsForAzimuth = <LatLng>[].obs;
  var originalStructureGrid = <Offset>[].obs;
  RxBool isRowSelected = false.obs;

  RxList<Common_Model> district_list = <Common_Model>[].obs;
  RxString dropdown_district_id = "".obs;

  RxString cp_id = ''.obs;
  RxString Application_login_id = ''.obs;
  RxString projectTypeId = ''.obs;
  RxInt minRange = 0.obs;

  // var paneltotalWidth = 0.0;
  final appLinks = AppLinks();








  @override
  void onInit() {
    print("on init called");
    super.onInit();
    loadIcons();
    availableLayouts.value = [0, 1, 2, 3];
    isDraggingPanel.value = false;
    draggedPanelIndex.value = -1;
    initDeepLinks();
    // GetCpId();
  }

  void initDeepLinks() {
    // Handle case when app is already running and receives a deep link
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) _processLocationUri(uri);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    terraceBuildings.clear();
    originalPanelPositions.clear();
    savedTerraces.clear();
    polygonPoints.clear();
  }

  /// code for azimuth angle

  // double toRadians(double degrees) => degrees * pi / 180.0;

  void initializeStructureGrid() {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    final structureBounds = getStructureBounds(terrace.panels);
    final structureCenter = LatLng(
      (structureBounds.north + structureBounds.south) / 2,
      (structureBounds.east + structureBounds.west) / 2,
    );

    originalStructureGrid.value = terrace.panels.map((panel) {
      return Offset(
        panel.longitude - structureCenter.longitude,
        panel.latitude - structureCenter.latitude,
      );
    }).toList();
  }

  /// Convert radians to degrees
  double toDegrees(double radians) => radians * 180.0 / pi;

  /// Rotate a point around a center point by given angle (in degrees)
  LatLng rotatePoint(LatLng point, LatLng center, double angleDegrees) {
    final angleRad = toRadians(angleDegrees);

    // Convert to Cartesian coordinates (approximate for small distances)
    final dx = point.longitude - center.longitude;
    final dy = point.latitude - center.latitude;

    // Apply rotation
    final cosAngle = cos(angleRad);
    final sinAngle = sin(angleRad);

    final newDx = dx * cosAngle - dy * sinAngle;
    final newDy = dx * sinAngle + dy * cosAngle;

    // Convert back to geographic coordinates
    return LatLng(
      center.latitude + newDy,
      center.longitude + newDx,
    );
  }

  /// Initialize original offsets when terrace is created/edited
  void initializePanelOffsets() {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    if (terrace.panels.isEmpty) return;

    final center = getPanelsCenter(terrace.panels);
    originalPanelOffsets.clear();

    // Store each panel's offset from the center
    for (final panel in terrace.panels) {
      final dx = panel.longitude - center.longitude;
      final dy = panel.latitude - center.latitude;
      originalPanelOffsets.add(Offset(dx, dy));
    }
  }

  /// Rotate all panels by azimuth angle (fixed version)
  void rotatePanelsByAzimuth(double angle) {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    if (terrace.panels.isEmpty || originalPanelOffsets.isEmpty) return;

    // Get the center of all panels
    final center = getPanelsCenter(terrace.panels);

    // Rotate each panel around the center
    final rotatedPanels = <LatLng>[];
    final angleRad = toRadians(angle);

    for (int i = 0; i < terrace.panels.length; i++) {
      final offset = originalPanelOffsets[i];

      // Apply rotation to the offset
      final cosAngle = cos(angleRad);
      final sinAngle = sin(angleRad);

      final newDx = offset.dx * cosAngle - offset.dy * sinAngle;
      final newDy = offset.dx * sinAngle + offset.dy * cosAngle;

      // Calculate new position
      final newLng = center.longitude + newDx;
      final newLat = center.latitude + newDy;

      rotatedPanels.add(LatLng(newLat, newLng));
    }

    // Update terrace with rotated panels
    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
      panels: rotatedPanels,
      azimuthAngle: angle,
    );

    // Update displayed panels
    solarPanelsPolygons.value =
        convertCentersToPolygons(rotatedPanels, terrace.isHorizontal);

    update();
  }

  /// Update azimuth angle from slider

  void updateAzimuthAngle(double angle) {
    if (editingTerraceIndex.value == -1) return;

    azimuthAngle.value = angle;
    print(angle);

    final terrace = savedTerraces[editingTerraceIndex.value];
    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
      azimuthAngle: angle,
    );

    // Use the new rotated panels function
    solarPanelsPolygons.value = getRotatedSolarPanels();
    update();

    print("Azimuth updated to: $angle");
  }

  StructureBounds getStructureBounds(List<LatLng> panels) {
    double north = panels[0].latitude;
    double south = panels[0].latitude;
    double east = panels[0].longitude;
    double west = panels[0].longitude;

    for (final panel in panels) {
      north = max(north, panel.latitude);
      south = min(south, panel.latitude);
      east = max(east, panel.longitude);
      west = min(west, panel.longitude);
    }

    return StructureBounds(north: north, south: south, east: east, west: west);
  }

// Calculate each panel's offset from structure center to maintain grid
  List<Offset> calculateGridOffsets(List<LatLng> panels, LatLng center) {
    return panels.map((panel) {
      return Offset(
        panel.longitude - center.longitude,
        panel.latitude - center.latitude,
      );
    }).toList();
  }

  // Store original panel layout (without rotation)
  List<LatLng> getOriginalPanelCenters(Terrace terrace) {
    // This should return the panel centers as if azimuth was 0
    // You might need to store this separately or recalculate
    return calculatePanelCentersWithRows(
      terrace.areaPoints,
      selectedPanelCount.value,
      selectedRows.value,
      terrace.isHorizontal,
    );
  }

// Calculate bounds of all panels
  PanelBounds getPanelsBounds(List<LatLng> panels) {
    double north = panels[0].latitude;
    double south = panels[0].latitude;
    double east = panels[0].longitude;
    double west = panels[0].longitude;

    for (final panel in panels) {
      north = max(north, panel.latitude);
      south = min(south, panel.latitude);
      east = max(east, panel.longitude);
      west = min(west, panel.longitude);
    }

    return PanelBounds(north: north, south: south, east: east, west: west);
  }

// Rotate point around center
  LatLng rotatePointAroundCenter(
      LatLng point, LatLng center, double angleDegrees) {
    final angleRad = angleDegrees * pi / 180;

    // Convert to relative coordinates
    final dx = point.longitude - center.longitude;
    final dy = point.latitude - center.latitude;

    // Apply rotation
    final newDx = dx * cos(angleRad) - dy * sin(angleRad);
    final newDy = dx * sin(angleRad) + dy * cos(angleRad);

    // Convert back to absolute coordinates
    return LatLng(
      center.latitude + newDy,
      center.longitude + newDx,
    );
  }

  Set<Polygon> getRotatedSolarPanels() {
    if (editingTerraceIndex.value == -1) return {};

    final terrace = savedTerraces[editingTerraceIndex.value];
    final panels = terrace.panels;

    Set<Polygon> rotatedPolygons = {};

    for (int i = 0; i < panels.length; i++) {
      final panel = panels[i];
      print(panel);
      final polygon = createRotatedPanelPolygon(
          panel, terrace.isHorizontal, terrace.azimuthAngle);
      rotatedPolygons.add(polygon);
    }

    return rotatedPolygons;
  }

  Polygon createRotatedPanelPolygon(
      LatLng center, bool isHorizontal, double azimuthAngle) {
    final panelHeight = isHorizontal ? 1.13 : 2.27;
    final panelWidth = isHorizontal ? 2.27 : 1.13;

    final latDelta = panelHeight / 111111.0 / 2;
    final lngDelta =
        panelWidth / (111111.0 * cos(center.latitude * pi / 180)) / 2;

    // Apply rotation based on azimuth angle
    final angleRad = azimuthAngle * pi / 180;

    List<LatLng> points = [
      LatLng(center.latitude - latDelta, center.longitude - lngDelta),
      LatLng(center.latitude - latDelta, center.longitude + lngDelta),
      LatLng(center.latitude + latDelta, center.longitude + lngDelta),
      LatLng(center.latitude + latDelta, center.longitude - lngDelta),
    ];

    // Rotate each point around the center
    if (azimuthAngle != 0) {
      points = points.map((point) {
        final dx = point.longitude - center.longitude;
        final dy = point.latitude - center.latitude;

        final newDx = dx * cos(angleRad) - dy * sin(angleRad);
        final newDy = dx * sin(angleRad) + dy * cos(angleRad);
        print("newDx $newDx");
        print("newDy $newDy");

        return LatLng(
          center.latitude + newDy,
          center.longitude + newDx,
        );
      }).toList();
    }

    return Polygon(
      polygonId:
      PolygonId('rotated_panel_${center.latitude}_${center.longitude}'),
      points: points,
      strokeWidth: 1,
      strokeColor: Colors.white,
      fillColor: Colors.blue.withOpacity(0.8),
    );
  }

  // code for drawer apis

  void GetCpId() async {
    print("getcpId called == ");
    SharedPreferences sp = await SharedPreferences.getInstance();
    // cp_id.value = sp.getString("cp_id") ?? '153';
    cp_id.value = '122';
    // Application_login_id.value = sp.getString("application_login_id")!;
    Application_login_id.value = '123';
    get_district();
  }

  get_district() async {
    print('get_district fun called');
    var response = await GetKycDistrict(cp_id.value);
    if (response.statusCode == 200) {
      var extractdata = json.decode(response.body);
      print(extractdata);

      //isdataupdate = false;
      if (extractdata['ack'] == 1) {
        district_list.value = List<Common_Model>.from(
            extractdata["result"].map((x) => Common_Model.fromJson(x)));

        print('district_list.value $district_list.value');
      } else {
        showCustomSnackBar(
          Get.context!,
          message: extractdata['ack_msg'],
          backgroundColor: Colors.red,
        );
      }
    } else {
      throw Exception("failed  to data load");
    }
  }

  get_Type(String district) async {
    var response = await GetleadTypesandSubType(
        "get_lead_type", district, cp_id.value, "");
    if (response.statusCode == 200) {
      var extractdata = json.decode(response.body);
      if (extractdata['ack'] == 1) {
        projectTypeList.value = List<Project_type_model>.from(
          extractdata["result"].map((x) => Project_type_model.fromJson(x)),
        );

        // var specificItem = extractdata['result']
        //     .firstWhere((item) => item['id'] == specificId, orElse: () => null);
      } else {
        showCustomSnackBar(
            Get.context!,
            message: extractdata['ack_msg'],
            backgroundColor: Colors.red
        );
      }
    } else {
      throw Exception("failed to load data");
    }
  }

  get_KW(String type_id, String application_id, int maxrange) async {
    var response = await GetKWforMargin(application_id, type_id, maxrange,
        dropdown_solar_technology_id.value, dropdown_panel_wats_name.value);
    if (response.statusCode == 200) {
      var extractdata = json.decode(response.body);

      if (extractdata['ack'] == 1) {
        KW_list.value = [
          ...List<Common_Model>.from(
              extractdata["result"].map((x) => Common_Model.fromJson(x))),
        ];

        KW_list.map(
              (e) {
            if (!nofpanelList.contains(e.no_of_panel)) {
              nofpanelList.add(e.no_of_panel);
            }
          },
        ).toList();

        if (numberOfPanels.value != "") {
          KW_list.value = [
            ...KW_list.where(
                  (element) {
                return element.no_of_panel == numberOfPanels.value;
              },
            ).toList(),
          ];
        }
      } else {
        print("get kw data not found");
        showCustomSnackBar(Get.context!,
            message: extractdata['ack_msg'], backgroundColor: Colors.red);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     duration: const Duration(seconds: 2),
        //     content: Text(extractdata['ack_msg']),
        //     backgroundColor: color.snackbar_fail,
        //     margin: EdgeInsets.all(40),
        //     behavior: SnackBarBehavior.floating,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(20)))));
      }
    } else {
      throw Exception("failed to data load");
    }
  }

  getPanelTechnology() async {
    var response = await GetPanelTechnology();
    if (response.statusCode == 200) {
      var extractdata = json.decode(response.body);
      print("extractdata $panel_technology_list");

      if (extractdata['ack'] == 1) {
        panel_technology_list.value = [
          Common_Model(id: '0', name: 'Technology', watt: 'Technology'),
          ...List<Common_Model>.from(
              extractdata["result"].map((x) => Common_Model.fromJson(x))),
        ];

        print("panel_technology_list $panel_technology_list");
      } else {
        showCustomSnackBar(
          Get.context!,
          message: extractdata['ack_msg'],
          backgroundColor: Colors.red,
        );
      }
    } else {
      throw Exception("failed  to data load");
    }
  }

  getPanelWats(String projectType) async {
    try {
      var response = await GetSolarPanelWatts(
          dropdown_solar_technology_id.value,
          "",
          Application_login_id.value,
          projectType);
      if (response.statusCode == 200) {
        var extractdata = json.decode(response.body);
        print(extractdata);
        panel_wats_list.clear();
        if (extractdata['ack'] == 1) {
          // Convert response to list of Common_Model instances
          panel_wats_list.value = [
            Common_Model(id: '0', name: 'panel watt', watt: 'Panel watt'),
            ...List<Common_Model>.from(
                extractdata["result"].map((x) => Common_Model.fromJson(x))),
          ];
          print(panel_wats_list);
        } else {
          showCustomSnackBar(Get.context!,
              message: extractdata['ack_msg'], backgroundColor: Colors.red);
        }
      } else {
        throw Exception("Failed to load data");
      }
    } catch (error) {
      showCustomSnackBar(Get.context!,
          message: "An error occurred: $error", backgroundColor: Colors.red);
    }
  }

  void onCameraMove(CameraPosition position) {
    currentHeading.value = position.bearing;
  }

  // bom
  void calculateBom(int index) {
    print("=======Bom calculation=======");
    final terrace = savedTerraces[index];

    int frontLeg_Height = terrace.frontLegHeight;
    int backLeg_Height = terrace.backLegHeight;
    double backLeg_Height_double = terrace.frontLegHeight.toDouble();
    double paneltotal_width = terrace.paneltotalWidth;
    double paneltotal_Height = terrace.paneltotalHeight;
    int extraPipes = terrace.extraPipes;

    int nof_Rows = terrace.numberOfRows;
    bool isMeterOrFeet = terrace.isMeterOrFeet; // true = feet , false = meter
    int nofPanels = terrace.nofPanels;
    String inverterPosition = terrace.inverterPositopn;

    print("paneltotal_width${terrace.paneltotalWidth}");
    print("paneltotal_width_round $paneltotal_width");

    int nof_FrontLeg = (paneltotal_width / 1.5).round();
    print("nof_FrontLeg ${paneltotal_width / 1.5}");
    print("nof_FrontLeg_round $nof_FrontLeg");

    int nof_BackLeg = (paneltotal_Height / 3.048).round();

    print("nof_BackLeg ${paneltotal_Height / 3.048}");
    print("nof_BackLeg $nof_BackLeg");

    paneltotal_Height > 3.048 ? nof_BackLeg += 1 : nof_BackLeg += 0;
    print("nof_BackLeg after condition  $nof_BackLeg");

    print("======= result =======");
    print("paneltotal_Height $paneltotal_Height");
    print("nof_BackLeg ${paneltotal_Height / 3.048}");
    print("nof_BackLeg_round $nof_BackLeg");

    // print("nof_FrontLeg ${paneltotal_width / 1.5}");
    // print("nof_FrontLeg_round $nof_FrontLeg");

    List backLegsList = [];

    for (int i = 1; i <= nof_BackLeg; i++) {
      var addedHeight = (isMeterOrFeet) ? 3.42 : 1.04;
      double x = backLeg_Height_double + addedHeight;
      backLegsList.add(x);
      print("back leg $i height = $x");
      backLeg_Height_double = x;
    }

    print("inverter Postion $inverterPosition");

    // accessories
    int langle_qty = terrace.lAngle_qty;
    int americanBolt_qty = terrace.americanBolt_qty;
    int zink_qty = terrace.zink_qty;
    int jBolt_qty = terrace.jBolt_qty;
    int foundation_qty = terrace.foundation_qty;

    // wires
    int dcWire_qty = terrace.dcWire_meter;
    int acWire_qty = terrace.acWire_meter;

    print("frontLeg_Height $frontLeg_Height");
    print("backLeg_Height $backLeg_Height");
    print("paneltotal_width $paneltotal_width");
    print("nof_FrontLeg $nof_FrontLeg");
    print("nof_Rows $nof_Rows");
    print("isMeterOrFeet $isMeterOrFeet");

    int legs;

    if (isMeterOrFeet) {
      double frontLegHeight = frontLeg_Height / 3.281;
      double backLegHeight = backLeg_Height_double / 3.281;

      legs = nof_FrontLeg * (frontLegHeight + backLegHeight).floor();
    } else {
      legs = nof_FrontLeg * (frontLeg_Height + backLeg_Height_double).toInt();
    }
    print("legs $legs");

    var rafter = nof_FrontLeg * nof_Rows;

    print("rafter $rafter");

    var perlin = nof_Rows * paneltotal_width * 2;

    print("perlin $perlin");

    double f6040 = (legs + rafter) * 0.8;

    int f6040_2 = f6040.floor();
    print("f6040_2 $f6040_2");

    int f4040 = (perlin * 0.8).floor();

    print("f4040 $f4040");

    var totalKg = (f6040_2 + f4040) * 3.28;
    print("totalKg $totalKg");

    double qty6040 = ((legs + rafter) * 3.28) / 20;
    int qty6040_1 = qty6040.floor();

    var qty4040 = (perlin * 3.28) / 20;
    int qty4040_1 = qty4040.floor();

    // total in meter
    double borderTotalLength = 2 * (paneltotal_width + paneltotal_Height);
    print("borderTotalLength $borderTotalLength");

    // ismeter 2.43 meter : 8 feet

    // true = feet , false = meter
    if (isMeterOrFeet) {
      int epipes = (borderTotalLength / 6.096).round();
      extraPipes = backLeg_Height_double >= 8 ? epipes : 0;
    } else {
      int epipes = (borderTotalLength / 6.096).round();
      extraPipes = backLeg_Height_double >= 2.43 ? epipes : 0;
    }

    print("extraPipes $extraPipes");

    print("qty6040 $qty6040");
    print("qty4040 $qty4040");

    print("qty6040_1 $qty6040_1");
    print("qty4040 $qty4040");

    langle_qty = legs * 2;
    foundation_qty = legs * 2;
    americanBolt_qty = langle_qty * 2;
    double kw = double.tryParse(selectedKW.value) ?? 1.1;
    zink_qty = kw <= 3
        ? 1
        : kw <= 6
        ? 2
        : kw <= 9
        ? 3
        : kw <= 12
        ? 4
        : kw <= 15
        ? 5
        : kw <= 18
        ? 6
        : kw <= 21
        ? 7
        : kw <= 24
        ? 8
        : 9;
    jBolt_qty = nofPanels * 4;

    dcWire_qty = 25;

    acWire_qty = 25;

    savedTerraces[index] = savedTerraces[index].copyWith(
      f6040: qty6040_1,
      f4040: qty4040_1,
      totalKg: totalKg,
      lAngle_qty: langle_qty,
      americanBolt_qty: americanBolt_qty,
      zink_qty: zink_qty,
      jBolt_qty: jBolt_qty,
      foundation_qty: foundation_qty,
      dcWire_meter: dcWire_qty,
      acWire_meter: acWire_qty,
      extraPipes: extraPipes,
    );

    print("=======Bom calculation over =======");
  }

  double getPanelStructureWidth() {
    if (editingTerraceIndex.value == -1 ||
        savedTerraces[editingTerraceIndex.value].panels.isEmpty) {
      return 0.0;
    }

    final terrace = savedTerraces[editingTerraceIndex.value];
    final panels = terrace.panels;

    if (panels.isEmpty) return 0.0;

    if (terrace.isHorizontal) {
      // For horizontal: width = number of panels in a row * panel height (2.27m)
      // Group panels by rows (similar latitude)
      final rows = <double, List<LatLng>>{};
      for (final panel in panels) {
        final rowKey = double.parse(panel.latitude.toStringAsFixed(6));
        rows.putIfAbsent(rowKey, () => []).add(panel);
      }

      // Find the row with most panels
      int maxPanelsInRow = 0;
      for (final row in rows.values) {
        if (row.length > maxPanelsInRow) {
          maxPanelsInRow = row.length;
        }
      }

      final double width =
          maxPanelsInRow * 2.27; // 2.27m per panel in horizontal
      print(
          "Horizontal structure width: $width (${maxPanelsInRow} panels × 2.27m)");
      return width;
    } else {
      // For vertical: width = number of panels in a row * panel width (1.13m)
      // Group panels by rows (similar latitude) - SAME as horizontal!
      final rows = <double, List<LatLng>>{};
      for (final panel in panels) {
        final rowKey = double.parse(panel.latitude.toStringAsFixed(6));
        rows.putIfAbsent(rowKey, () => []).add(panel);
      }

      // Find the row with most panels
      int maxPanelsInRow = 0;
      for (final row in rows.values) {
        if (row.length > maxPanelsInRow) {
          maxPanelsInRow = row.length;
        }
      }

      final double width = maxPanelsInRow * 1.13; // 1.13m per panel in vertical
      print(
          "Vertical structure width: $width (${maxPanelsInRow} panels × 1.13m)");
      return width;
    }
  }

  /// panels table height and width
// In SurveyMapController class
//   double getPanelStructureWidth() {
//     if (editingTerraceIndex.value == -1 || savedTerraces[editingTerraceIndex.value].panels.isEmpty) {
//       return 0.0;
//     }
//
//     final terrace = savedTerraces[editingTerraceIndex.value];
//     final panels = terrace.panels;
//
//     if (panels.isEmpty) return 0.0;
//
//     // Get the actual panel polygon for the first panel to determine its dimensions
//     final panelPolygon = createPanelPolygon(panels[0], terrace.isHorizontal);
//     if (panelPolygon.points.length < 4) return 0.0;
//
//     // Calculate panel width in degrees
//     final double panelWidthDeg = (panelPolygon.points[1].longitude - panelPolygon.points[0].longitude).abs();
//
//     // Calculate total structure width in degrees
//     double westMost = panels[0].longitude;
//     double eastMost = panels[0].longitude;
//
//     for (final panel in panels) {
//       if (panel.longitude < westMost) westMost = panel.longitude;
//       if (panel.longitude > eastMost) eastMost = panel.longitude;
//     }
//
//     final double structureWidthDeg = eastMost - westMost + panelWidthDeg;
//
//     // Convert to meters
//     final centerLat = terrace.areaPoints.isNotEmpty
//         ? terrace.areaPoints[0].latitude
//         : panels[0].latitude;
//
//     final double widthMeters = structureWidthDeg * (111111.0 * cos(centerLat * pi / 180));
//     print("in function totalwidth = $widthMeters");
//
//     return widthMeters.abs();
//   }

  double getPanelStructureHeight() {
    if (editingTerraceIndex.value == -1 ||
        savedTerraces[editingTerraceIndex.value].panels.isEmpty) {
      return 0.0;
    }

    final terrace = savedTerraces[editingTerraceIndex.value];
    final panels = terrace.panels;

    if (panels.isEmpty) return 0.0;

    if (terrace.isHorizontal) {
      // For horizontal: height = number of rows * panel width (1.13m)
      // Group panels by rows (similar latitude)
      final rows = <double, List<LatLng>>{};
      for (final panel in panels) {
        final rowKey = double.parse(panel.latitude.toStringAsFixed(6));
        rows.putIfAbsent(rowKey, () => []).add(panel);
      }

      final double height = rows.length * 1.13; // 1.13m per row in horizontal
      print(
          "Horizontal structure height: $height (${rows.length} rows × 1.13m)");
      return height;
    } else {
      // For vertical: height = number of rows * panel height (2.27m)
      // Group panels by rows (similar latitude)
      final rows = <double, List<LatLng>>{};
      for (final panel in panels) {
        final rowKey = double.parse(panel.latitude.toStringAsFixed(6));
        rows.putIfAbsent(rowKey, () => []).add(panel);
      }

      final double height = rows.length * 2.27; // 2.27m per row in vertical
      print("Vertical structure height: $height (${rows.length} rows × 2.27m)");
      return height;
    }
  }

  /// fOR number of rows
  void updatePanelPositionsWithRows() {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    final newCenters = calculatePanelCentersWithRows(
      terrace.areaPoints,
      selectedPanelCount.value,
      selectedRows.value,
      terrace.isHorizontal,
    );

    savedTerraces[editingTerraceIndex.value] =
        terrace.copyWith(panels: newCenters);
    solarPanelsPolygons.value =
        convertCentersToPolygons(newCenters, terrace.isHorizontal);
  }

  List<LatLng> calculatePanelCentersWithRows(
      List<LatLng> polygonPoints,
      int panelCount,
      int rows,
      bool isHorizontal,
      ) {
    if (polygonPoints.length < 3 || panelCount <= 0 || rows <= 0) return [];

    final bounds = getPolygonBounds(polygonPoints);
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    // Calculate columns based on rows
    final columns = (panelCount / rows).ceil();

    // Panel dimensions in degrees
    final double panelWidthDeg =
        1.13 / (111111.0 * cos(center.latitude * pi / 180));
    final double panelHeightDeg = 2.27 / 111111.0;

    // Calculate step sizes based on orientation
    double lngStep, latStep;

    if (isHorizontal) {
      lngStep = panelHeightDeg; // 2m in longitude direction
      latStep = panelWidthDeg; // 1m in latitude direction
    } else {
      lngStep = panelWidthDeg; // 1m in longitude direction
      latStep = panelHeightDeg; // 2m in latitude direction
    }

    // Calculate grid boundaries with padding
    final double paddingLat = 0.5 / 111111.0;
    final double paddingLng =
        0.5 / (111111.0 * cos(center.latitude * pi / 180));

    final double startLat = bounds.southwest.latitude + paddingLat;
    final double endLat = bounds.northeast.latitude - paddingLat;
    final double startLng = bounds.southwest.longitude + paddingLng;
    final double endLng = bounds.northeast.longitude - paddingLng;

    // Calculate total space needed
    final double totalWidth = (columns - 1) * lngStep;
    final double totalHeight = (rows - 1) * latStep;

    // Calculate starting position to center the panels
    final double startLngCentered =
        startLng + (endLng - startLng - totalWidth) / 2;
    final double startLatCentered =
        startLat + (endLat - startLat - totalHeight) / 2;

    List<LatLng> centers = [];
    int panelsPlaced = 0;

    for (int row = 0; row < rows && panelsPlaced < panelCount; row++) {
      for (int col = 0; col < columns && panelsPlaced < panelCount; col++) {
        final double centerLng = startLngCentered + (col * lngStep);
        final double centerLat = startLatCentered + (row * latStep);
        final LatLng panelCenter = LatLng(centerLat, centerLng);

        if (isPointInPolygon(panelCenter, polygonPoints)) {
          centers.add(panelCenter);
          panelsPlaced++;
        }
      }
    }

    return centers;
  }

  // In SurveyMapController class
  void updateAvailableRows() {
    if (selectedPanelCount.value <= 0 || editingTerraceIndex.value == -1) {
      availableRows.value = [1];
      selectedRows.value = 1; // Reset selection
      return;
    }

    final terrace = savedTerraces[editingTerraceIndex.value];
    final feasibleRows = <int>[];

    // Check only feasible row configurations
    for (int rows = 1; rows <= selectedPanelCount.value; rows++) {
      if (isRowConfigurationFeasible(
        terrace.areaPoints,
        selectedPanelCount.value,
        rows,
        terrace.isHorizontal,
      )) {
        feasibleRows.add(rows);
      }
    }

    availableRows.value = feasibleRows.isNotEmpty ? feasibleRows : [1];

    // Reset selected rows to first available option
    if (availableRows.isNotEmpty &&
        !availableRows.contains(selectedRows.value)) {
      selectedRows.value = availableRows.first;
    } else if (availableRows.isEmpty) {
      selectedRows.value = 1;
    }
  }

  bool isRowConfigurationFeasible(
      List<LatLng> polygonPoints,
      int panelCount,
      int rows,
      bool isHorizontal,
      ) {
    if (polygonPoints.length < 3 || panelCount <= 0 || rows <= 0) return false;
    if (rows > panelCount) return false;

    final bounds = getPolygonBounds(polygonPoints);
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    // Calculate columns needed
    final columns = (panelCount / rows).ceil();

    // Panel dimensions in meters
    const double panelWidth = 1.13;
    const double panelHeight = 2.27;

    // Convert to degrees
    final double panelWidthDeg =
        panelWidth / (111111.0 * cos(center.latitude * pi / 180));
    final double panelHeightDeg = panelHeight / 111111.0;

    // Calculate required space
    double requiredWidth, requiredHeight;

    if (isHorizontal) {
      requiredWidth = columns * panelHeightDeg; // 2m per column
      requiredHeight = rows * panelWidthDeg; // 1m per row
    } else {
      requiredWidth = columns * panelWidthDeg; // 1m per column
      requiredHeight = rows * panelHeightDeg; // 2m per row
    }

    // Calculate available space (NO PADDING)
    final double availableWidth =
    (bounds.northeast.longitude - bounds.southwest.longitude).abs();
    final double availableHeight =
    (bounds.northeast.latitude - bounds.southwest.latitude).abs();

    // Debug output
    print('=== Feasibility Check (No Padding) ===');
    print('Panels: $panelCount, Rows: $rows, Columns: $columns');
    print('Orientation: ${isHorizontal ? "Horizontal" : "Vertical"}');

    // Convert to meters for easier understanding
    final double requiredWidthMeters =
        requiredWidth * (111111.0 * cos(center.latitude * pi / 180));
    final double requiredHeightMeters = requiredHeight * 111111.0;
    final double availableWidthMeters =
        availableWidth * (111111.0 * cos(center.latitude * pi / 180));
    final double availableHeightMeters = availableHeight * 111111.0;

    print(
        'Required space: ${requiredWidthMeters.toStringAsFixed(2)}m x ${requiredHeightMeters.toStringAsFixed(2)}m');
    print(
        'Available space: ${availableWidthMeters.toStringAsFixed(2)}m x ${availableHeightMeters.toStringAsFixed(2)}m');

    final bool isFeasible =
        requiredWidth <= availableWidth && requiredHeight <= availableHeight;
    print('Is feasible: $isFeasible');
    print('======================================');

    return isFeasible;
  }

  /// for panels drag functionality
  List<bool> getPanelBorderContact(
      LatLng panelCenter, bool isHorizontal, List<LatLng> terracePoints) {
    // Calculate terrace boundaries without creating a new class
    double northBoundary = terracePoints[0].latitude;
    double southBoundary = terracePoints[0].latitude;

    for (final point in terracePoints) {
      northBoundary =
      northBoundary > point.latitude ? northBoundary : point.latitude;
      southBoundary =
      southBoundary < point.latitude ? southBoundary : point.latitude;
    }

    // Use a tolerance of about 0.5 meters (approx 0.0000045 degrees)
    // const double tolerance = 0.3048 / 111111.0;
    const double tolerance = 0.000010;

    // Check if panel is near North edge
    final isNearNorth =
        (panelCenter.latitude - northBoundary).abs() < tolerance;
    // Check if panel is near South edge
    final isNearSouth =
        (panelCenter.latitude - southBoundary).abs() < tolerance;

    print("Panel: $panelCenter");
    print("Terrace North: $northBoundary, South: $southBoundary");
    print("Near North: $isNearNorth, Near South: $isNearSouth");

    return [isNearNorth, isNearSouth, false, false];
  }

  void detectAndHighlightLayout() {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    if (terrace.panels.isEmpty) return;

    bool hasNorthContact = false;
    bool hasSouthContact = false; // false

    print("=== LAYOUT DETECTION STARTED ===");
    print(
        "Terrace orientation: ${terrace.isHorizontal ? 'Horizontal' : 'Vertical'}");

    for (final panel in terrace.panels) {
      final contacts = getPanelBorderContact(
          panel, terrace.isHorizontal, terrace.areaPoints);
      final borderContect = getPanelBorderContact(
          panel, terrace.isHorizontal, terrace.areaPoints);

      // IGNORE left and right contacts completely
      final north = contacts[0];
      final south = contacts[1];
      // final south = contacts[2];

      print(
          "Panel at ${panel.latitude.toStringAsFixed(6)}, ${panel.longitude.toStringAsFixed(6)}");
      print("  North: $north, South: $south");

      if (north) {
        hasNorthContact = true;
        print("  ✅ North contact detected");
      }

      if (south) {
        hasSouthContact = true;
        print("  ✅ South contact detected");
      }
    }

    print("=== RESULT ===");
    print("Has North: $hasNorthContact, Has South: $hasSouthContact");

    if (hasNorthContact && hasSouthContact) {
      highlightedLayout.value = "Legs On Wall";
      print("Setting layout: Legs On Wall");
    } else if (hasNorthContact || hasSouthContact) {
      highlightedLayout.value = "Hybrid";
      print("Setting layout: Hybrid");
    } else {
      highlightedLayout.value = "Legs On Terrace";
      print("Setting layout: Legs On Terrace");
    }
  }

  Future<void> searchLocation(String address, BuildContext context) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      print("locations $locations");
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng newLocation = LatLng(location.latitude, location.longitude);

        //  pickedlocation.value = newLocation
        pickedLocation.value = newLocation;

        // _getAddress(newLocation);
        if (mapController != null) {
          mapController!
              .animateCamera(CameraUpdate.newLatLngZoom(newLocation, 18.0));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location not found')),
        );
      }
    } catch (e) {
      print('Error searching location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching location')),
      );
    }
  }

  /// panel dragging methods
  // Add this method to your controller
  LatLng getDragHandlePosition() {
    if (isDragHandleMoving.value && dragHandleStartPosition != null) {
      return dragHandleStartPosition!;
    }

    if (editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];
      if (terrace.panels.isNotEmpty) {
        return getPanelsCenter(terrace.panels);
      }
    }

    return LatLng(0, 0);
  }

  // Add this method to calculate movement
  void moveAllPanels(double latDelta, double lngDelta) {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    final newCenters = <LatLng>[];

    // First check if ALL new positions are within bounds
    for (final panel in terrace.panels) {
      final newPanelPos = LatLng(
        panel.latitude + latDelta,
        panel.longitude + lngDelta,
      );

      // If any panel would go outside, cancel the movement
      if (!isPointInPolygon(newPanelPos, terrace.areaPoints)) {
        return; // Don't move any panels
      }

      newCenters.add(newPanelPos);
    }

    // If all panels stay within bounds, update them
    savedTerraces[editingTerraceIndex.value] =
        terrace.copyWith(panels: newCenters);
    solarPanelsPolygons.value =
        convertCentersToPolygons(newCenters, terrace.isHorizontal);
    update();
  }

  // REPLACE your updatePanelsWithDrag method with this:
  void updatePanelsWithDrag(
      double latDelta, double lngDelta, List<LatLng> terracePoints) {
    if (!isDraggingPanel.value || originalPanelCenters.isEmpty) return;

    List<LatLng> newCenters = [];

    for (final originalCenter in originalPanelCenters) {
      final newLat = originalCenter.latitude + latDelta;
      final newLng = originalCenter.longitude + lngDelta;
      final newPosition = LatLng(newLat, newLng);

      if (isPointInPolygon(newPosition, terracePoints)) {
        newCenters.add(newPosition);
      } else {
        // If any panel would go outside, cancel the drag
        return;
      }
    }

    if (editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];
      savedTerraces[editingTerraceIndex.value] =
          terrace.copyWith(panels: newCenters);

      // Force UI update
      solarPanelsPolygons.value =
          convertCentersToPolygons(newCenters, terrace.isHorizontal);
      update();
    }
  }

  // Method to check if a layout is feasible - MORE ACCURATE
  bool isLayoutFeasible(
      int layoutType, int panelCount, List<LatLng> polygonPoints) {
    if (polygonPoints.length < 3) return false;

    final bounds = getPolygonBounds(polygonPoints);
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    // Calculate grid dimensions in meters
    final double widthMeters =
        (bounds.northeast.longitude - bounds.southwest.longitude) *
            111111 *
            cos(center.latitude * pi / 180);
    final double heightMeters =
        (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;

    switch (layoutType) {
      case 0: // 2×N Vertical (2 rows, N columns)
        final requiredWidth =
            ((panelCount / 2).ceil()) * 1.0; // N columns * 1m panel width
        final requiredHeight = 2 * 2.0; // 2 rows * 2m panel height
        return widthMeters >= requiredWidth && heightMeters >= requiredHeight;

      case 1: // 1×N Vertical (1 row, N columns)
        final requiredWidth = panelCount * 1.0; // N columns * 1m panel width
        final requiredHeight = 1 * 2.0; // 1 row * 2m panel height
        return widthMeters >= requiredWidth && heightMeters >= requiredHeight;

      case 2: // N×2 Horizontal (N rows, 2 columns)
        final requiredWidth = 2 * 2.0; // 2 columns * 2m panel width
        final requiredHeight =
            ((panelCount / 2).ceil()) * 1.0; // N rows * 1m panel height
        return widthMeters >= requiredWidth && heightMeters >= requiredHeight;

      case 3: // 2×N Horizontal (2 rows, N columns)
        final requiredWidth =
            ((panelCount / 2).ceil()) * 2.0; // N columns * 2m panel width
        final requiredHeight = 2 * 1.0; // 2 rows * 1m panel height
        return widthMeters >= requiredWidth && heightMeters >= requiredHeight;

      default:
        return false;
    }
  }

  // Method to update available layouts based on terrace size
  void updateAvailableLayouts(int panelCount, List<LatLng> polygonPoints) {
    availableLayouts.clear();

    for (int i = 0; i < 4; i++) {
      if (isLayoutFeasible(i, panelCount, polygonPoints)) {
        availableLayouts.add(i);
      }
    }

    // Select first available layout or default to 0 if none available
    if (availableLayouts.isNotEmpty &&
        !availableLayouts.contains(selectedLayout.value)) {
      selectedLayout.value = availableLayouts.first;
    } else if (availableLayouts.isEmpty) {
      selectedLayout.value = -1; // No layout available
    }
  }

  // Method to calculate panel centers based on selected layout
  // Method to calculate panel centers based on selected layout - NO SPACING
  List<LatLng> calculatePanelCentersWithLayout(
      List<LatLng> polygonPoints, int panelCount, int layoutType) {
    final bounds = getPolygonBounds(polygonPoints);
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    // Convert panel dimensions to degrees
    final double panelWidthDeg =
        1.13 / (111111.0 * cos(center.latitude * pi / 180));
    final double panelHeightDeg = 2.27 / 111111.0;

    // Calculate grid boundaries
    final double startLat = bounds.southwest.latitude;
    final double endLat = bounds.northeast.latitude;
    final double startLng = bounds.southwest.longitude;
    final double endLng = bounds.northeast.longitude;

    int rows, cols;

    switch (layoutType) {
      case 0: // 2×N Vertical (2 rows, N columns) - FIXED
        rows = 2;
        cols = (panelCount / rows).ceil();
        break;
      case 1: // 1×N Vertical (1 row, N columns)
        rows = 1;
        cols = panelCount;
        break;
      case 2: // N×2 Horizontal (N rows, 2 columns)
        rows = (panelCount / 2).ceil();
        cols = 2;
        break;
      case 3: // 2×N Horizontal (2 rows, N columns)
        rows = 2;
        cols = (panelCount / rows).ceil();
        break;
      default:
        rows = 1;
        cols = panelCount;
    }

    // Calculate total space needed
    final double totalWidth =
        cols * (layoutType >= 2 ? panelHeightDeg : panelWidthDeg);
    final double totalHeight =
        rows * (layoutType >= 2 ? panelWidthDeg : panelHeightDeg);

    // Calculate starting position to center the panels
    final double startLngCentered =
        startLng + (endLng - startLng - totalWidth) / 2;
    final double startLatCentered =
        startLat + (endLat - startLat - totalHeight) / 2;

    List<LatLng> centers = [];
    int panelsPlaced = 0;

    // For vertical layouts, panels are placed in columns (south to north)
    if (layoutType <= 1) {
      // Vertical layouts (0,1)
      for (int col = 0; col < cols && panelsPlaced < panelCount; col++) {
        for (int row = 0; row < rows && panelsPlaced < panelCount; row++) {
          final double centerLng =
              startLngCentered + (col * panelWidthDeg) + (panelWidthDeg / 2);
          final double centerLat =
              startLatCentered + (row * panelHeightDeg) + (panelHeightDeg / 2);
          final LatLng panelCenter = LatLng(centerLat, centerLng);

          if (isPointInPolygon(panelCenter, polygonPoints)) {
            centers.add(panelCenter);
            panelsPlaced++;
          }
        }
      }
    }
    // For horizontal layouts, panels are placed in rows (west to east)
    else {
      // Horizontal layouts (2,3)
      for (int row = 0; row < rows && panelsPlaced < panelCount; row++) {
        for (int col = 0; col < cols && panelsPlaced < panelCount; col++) {
          final double centerLng =
              startLngCentered + (col * panelHeightDeg) + (panelHeightDeg / 2);
          final double centerLat =
              startLatCentered + (row * panelWidthDeg) + (panelWidthDeg / 2);
          final LatLng panelCenter = LatLng(centerLat, centerLng);

          if (isPointInPolygon(panelCenter, polygonPoints)) {
            centers.add(panelCenter);
            panelsPlaced++;
          }
        }
      }
    }

    return centers;
  }

  void handlePanelDrag(LatLng currentPosition, List<LatLng> terracePoints) {
    if (!isDraggingPanel.value || dragStartPoint == null) return;

    // Calculate the delta movement
    final latDelta = currentPosition.latitude - dragStartPoint!.latitude;
    final lngDelta = currentPosition.longitude - dragStartPoint!.longitude;

    // Update all panel positions
    List<LatLng> newCenters = [];
    for (final originalCenter in originalPanelPositions) {
      final newLat = originalCenter.latitude + latDelta;
      final newLng = originalCenter.longitude + lngDelta;
      final newPosition = LatLng(newLat, newLng);

      // Only add if within terrace boundaries
      if (isPointInPolygon(newPosition, terracePoints)) {
        newCenters.add(newPosition);
      } else {
        // If any panel would go outside, cancel the drag
        return;
      }
    }

    // Update the drag start point for continuous dragging
    dragStartPoint = currentPosition;

    // Update panels
    final terrace = savedTerraces[editingTerraceIndex.value];
    savedTerraces[editingTerraceIndex.value] =
        terrace.copyWith(panels: newCenters);
    solarPanelsPolygons.value =
        convertCentersToPolygons(newCenters, terrace.isHorizontal);
  }

  void endPanelDragging() {
    isDraggingPanel.value = false;
    dragStartPoint = null;
    originalPanelPositions.clear();
  }

  // Method to start dragging panels
  void startDraggingPanel(LatLng tapPosition, List<LatLng> terracePoints) {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];

    // Check if tap is near the panels center (drag handle)
    final panelsCenter = getPanelsCenter(terrace.panels);
    final distance = calculateDistance(tapPosition, panelsCenter);

    if (distance < 10.0) {
      // 10 meter threshold
      isDraggingPanel.value = true;
      dragStartPoint = tapPosition;
      originalPanelPositions = List.from(terrace.panels);
    }
  }

  // Add this method to your SurveyMapController
  bool isPointNearDragHandle(
      LatLng point, LatLng dragHandlePosition, double thresholdMeters) {
    final distance = calculateDistance(point, dragHandlePosition);
    return distance < thresholdMeters;
  }

  // Method to update panel postion during drag
// Method to update panel positions during drag
  // CORRECTED method to update panel positions during drag
  void updatePanelDrag(
      double latDelta, double lngDelta, List<LatLng> terracePoints) {
    if (!isDraggingPanel.value || originalPanelCenters.isEmpty) return;

    // Calculate new positions
    List<LatLng> newCenters = [];
    for (final originalCenter in originalPanelCenters) {
      final newLat = originalCenter.latitude + latDelta;
      final newLng = originalCenter.longitude + lngDelta;
      final newPosition = LatLng(newLat, newLng);

      // Only add if within terrace boundaries
      if (isPointInPolygon(newPosition, terracePoints)) {
        newCenters.add(newPosition);
      } else {
        // If any panel would go outside, cancel the drag
        return;
      }
    }

    // Update panels if all are within boundaries
    if (editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];
      savedTerraces[editingTerraceIndex.value] =
          terrace.copyWith(panels: newCenters);
      solarPanelsPolygons.value =
          convertCentersToPolygons(newCenters, terrace.isHorizontal);
    }
  }

// Method to end dragging
  void endDraggingPanels() {
    isDraggingPanel.value = false;
    originalPanelCenters.clear();
  }

// In getDraggableSolarPanelsPolygons, ensure you're not creating duplicates:
  // In getDraggableSolarPanelsPolygons, ensure real-time updates:
  Set<Polygon> getDraggableSolarPanelsPolygons(List<LatLng> terracePoints) {
    final Set<Polygon> polygons = {};

    if (editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];

      for (int i = 0; i < terrace.panels.length; i++) {
        final panel = terrace.panels[i];
        final polygon = createPanelPolygon(panel, terrace.isHorizontal);

        polygons.add(Polygon(
          polygonId: PolygonId('panel_${terrace.id}_$i'),
          points: polygon.points,
          strokeWidth: isDraggingPanel.value ? 3 : 1,
          strokeColor: isDraggingPanel.value ? Colors.yellow : Colors.white,
          fillColor: isDraggingPanel.value
              ? Colors.blue.withOpacity(0.6)
              : Colors.blue.withOpacity(0.8),
        ));
      }
    }

    return polygons;
  }

  void cleanupDuplicatePanels() {
    if (editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];

      // Remove duplicate panel centers
      final uniqueCenters = <LatLng>[];
      for (final center in terrace.panels) {
        if (!uniqueCenters.any((c) =>
        c.latitude == center.latitude && c.longitude == center.longitude)) {
          uniqueCenters.add(center);
        }
      }

      if (uniqueCenters.length != terrace.panels.length) {
        savedTerraces[editingTerraceIndex.value] =
            terrace.copyWith(panels: uniqueCenters);
        solarPanelsPolygons.value =
            convertCentersToPolygons(uniqueCenters, terrace.isHorizontal);
      }
    }
  }

  void updatePanelDragWithDelta(
      double latDelta, double lngDelta, List<LatLng> terracePoints) {
    if (!isDraggingPanel.value || originalPanelCenters.isEmpty) return;

    // Calculate new positions
    List<LatLng> newCenters = [];
    for (final originalCenter in originalPanelCenters) {
      final newLat = originalCenter.latitude + latDelta;
      final newLng = originalCenter.longitude + lngDelta;
      final newPosition = LatLng(newLat, newLng);

      // Only add if within terrace boundaries
      if (isPointInPolygon(newPosition, terracePoints)) {
        newCenters.add(newPosition);
      } else {
        // If any panel would go outside, cancel the drag
        return;
      }
    }

    // Update panels if all are within boundaries
    if (editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];
      savedTerraces[editingTerraceIndex.value] =
          terrace.copyWith(panels: newCenters);
      solarPanelsPolygons.value =
          convertCentersToPolygons(newCenters, terrace.isHorizontal);
    }
  }

  List<int> getSelectedBorderIndices() {
    if (editingTerraceIndex.value == -1) return [];
    return savedTerraces[editingTerraceIndex.value].selectedBorderIndices;
  }

  void setSelectedBorderIndices(List<int> indices) {
    if (editingTerraceIndex.value == -1) return;
    final terrace = savedTerraces[editingTerraceIndex.value];
    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
      selectedBorderIndices: indices,
    );
  }

  void startDrawingHandRail() {
    isDrawingHandRail.value = true;
    isHandRailComplete.value = false;
    update();
  }

  void toggleBorderSelection(int index) {
    if (!isDrawingHandRail.value || editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    final selectedIndices = List<int>.from(terrace.selectedBorderIndices);

    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }

    // Sort to maintain order but don't connect automatically
    selectedIndices.sort();

    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
      selectedBorderIndices: selectedIndices,
    );

    updateHandRailFromSelectedBorders();
  }

  void updateHandRailFromSelectedBorders() {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    currentHandRailPoints.clear();

    // Create hand rail segments for exactly what was selected
    for (final index in terrace.selectedBorderIndices) {
      final nextIndex = (index + 1) % polygonPoints.length;
      currentHandRailPoints.add(polygonPoints[index]);
      currentHandRailPoints.add(polygonPoints[nextIndex]);
    }

    update();
  }

  void addHandRailPoint(LatLng point) {
    currentHandRailPoints.add(point);
    update();
  }

  void removeHandrail_test(LatLng points) {
    if (currentHandRailPoints.contains(points)) {
    } else {
      currentHandRailPoints.remove(points);
    }
    update();
  }

  void updateHandRailPoint(int index, LatLng newPosition) {
    if (index >= 0 && index < currentHandRailPoints.length) {
      currentHandRailPoints[index] = newPosition;
      update();
    }
  }

  void finishDrawingHandRail() {
    if (editingTerraceIndex.value == -1) return;

    final terrace = savedTerraces[editingTerraceIndex.value];

    // Get unique selected borders (in case user toggled same border multiple times)
    final uniqueSelectedIndices =
    terrace.selectedBorderIndices.toSet().toList();

    // Sort the selected indices to maintain proper order around the polygon
    uniqueSelectedIndices.sort();

    final handRailPoints = <LatLng>[];

    // Create continuous hand rail by connecting selected borders in order
    for (final index in uniqueSelectedIndices) {
      final nextIndex = (index + 1) % polygonPoints.length;
      handRailPoints.add(polygonPoints[index]);
      handRailPoints.add(polygonPoints[nextIndex]);
    }

    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
      handRailPoints: handRailPoints,
      hasGril: handRailPoints.isNotEmpty,
    );

    // Reset drawing state
    isDrawingHandRail.value = false;
    isHandRailComplete.value = handRailPoints.isNotEmpty;
    update();
  }

  bool isPointNearBorder(LatLng tapPoint, LatLng lineStart, LatLng lineEnd) {
    const double threshold =
    0.00005; // Adjust for tap sensitivity (about 5 meters)

    // If line is just a point
    if (lineStart == lineEnd) return false;

    // Calculate distance from point to line segment
    final double lineLength = calculateDistance(lineStart, lineEnd);
    final double distance = ((lineEnd.latitude - lineStart.latitude) *
        (tapPoint.longitude - lineStart.longitude) -
        (lineEnd.longitude - lineStart.longitude) *
            (tapPoint.latitude - lineStart.latitude))
        .abs() /
        lineLength;

    return distance < threshold;
  }

  double calculateHandRailLength(List<LatLng> handRailPoints) {
    if (handRailPoints.isEmpty || handRailPoints.length % 2 != 0) {
      return 0.0; // Return 0 if empty or has odd number of points (invalid)
    }

    double totalLength = 0.0;

    // Calculate each segment (points are stored in pairs)
    for (int i = 0; i < handRailPoints.length; i += 2) {
      if (i + 1 < handRailPoints.length) {
        totalLength +=
            calculateDistance(handRailPoints[i], handRailPoints[i + 1]);
      }
    }

    return totalLength;
  }

  double calculateHandrailLength_2(List<LatLng> polygonPoints) {
    if (currentHandRailPoints.isEmpty) return 0.0;

    if (currentHandRailPoints.isNotEmpty || isDrawingHandRail.value == false) {
      for (int i = 0; i <= polygonPoints.length; i++) {
        calculateDistance(polygonPoints[i], polygonPoints[i + 2]);
      }
    }
    var handrail = 0.0;
    return handrail;
  }

  void startEditingHandRail() {
    if (editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];
      if (terrace.hasGril && terrace.handRailPoints.isNotEmpty) {
        isDrawingHandRail.value = true;
        currentHandRailPoints.value = List.from(terrace.handRailPoints);
      }
    }
  }

  void cancelDrawingHandRail() {
    if (editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];
      if (terrace.hasGril && terrace.handRailPoints.isNotEmpty) {
        currentHandRailPoints.value = List.from(terrace.handRailPoints);
      }
    }
    isDrawingHandRail.value = false;
  }

  Polyline createHandRailPolyline(List<LatLng> points) {
    return Polyline(
      polylineId:
      PolylineId('handrail_${DateTime.now().millisecondsSinceEpoch}'),
      points: points,
      color: Colors.black,
      width: 5,
      consumeTapEvents: false,
    );
  }

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
      points: createWalkwayPoints(
          center, isHorizontal.value, widthMeters, lengthMeters),
      isHorizontal: isHorizontal.value,
      width: widthMeters,
      length: lengthMeters,
      maxLength: lengthMeters,
    ));

    editingWalkwayIndex.value = currentWalkways.length - 1;
    updatePanelPositions();
  }

  List<LatLng> createWalkwayPoints(
      LatLng center, bool isHorizontal, double width, double length) {
    // Convert meters to degrees
    final latDelta = (isHorizontal ? width : length) / 111111.0 / 2;
    final lngDelta = (isHorizontal ? length : width) /
        (111111.0 * cos(center.latitude * pi / 180)) /
        2;

    return [
      LatLng(center.latitude - latDelta, center.longitude - lngDelta),
      LatLng(center.latitude - latDelta, center.longitude + lngDelta),
      LatLng(center.latitude + latDelta, center.longitude + lngDelta),
      LatLng(center.latitude + latDelta, center.longitude - lngDelta),
    ];
  }

  // testing
  void updateWalkwayPoints(int index, List<LatLng> newPoints) {
    if (index >= 0 && index < currentWalkways.length) {
      final walkway = currentWalkways[index];

      // Calculate new length based on the moved points
      final bounds = getPolygonBounds(newPoints);
      double newLength;
      if (walkway.isHorizontal) {
        newLength = (bounds.northeast.longitude - bounds.southwest.longitude) *
            111111 *
            cos(bounds.southwest.latitude * pi / 180);
      } else {
        newLength =
            (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
      }

      currentWalkways[index] = walkway.copyWith(
        points: newPoints,
        length: newLength,
      );
    }
  }

  // testing
  void updateWalkwayLength(int index, double newLength) {
    if (index < 0 || index >= currentWalkways.length) return;
    if (editingTerraceIndex.value < 0 ||
        editingTerraceIndex.value >= savedTerraces.length) return;

    final walkway = currentWalkways[index];
    final terrace = savedTerraces[editingTerraceIndex.value];

    // Calculate max possible length based on terrace
    final bounds = getPolygonBounds(terrace.areaPoints);
    double maxLength;
    if (walkway.isHorizontal) {
      maxLength = (bounds.northeast.longitude - bounds.southwest.longitude) *
          111111 *
          cos(bounds.southwest.latitude * pi / 180);
    } else {
      maxLength =
          (bounds.northeast.latitude - bounds.southwest.latitude) * 111111;
    }

    // Apply constraints
    final minLength = 1.0;
    final clampedLength = newLength.clamp(minLength, maxLength);

    final center = getCenter(walkway.points);
    final newPoints = createWalkwayPoints(
      center,
      walkway.isHorizontal,
      walkway.width,
      clampedLength,
    );

    currentWalkways[index] = walkway.copyWith(
      length: clampedLength,
      points: newPoints,
      maxLength: maxLength,
    );

    updatePanelPositions();
  }

  void updateWalkwayWidth(int index, double newWidth) {
    if (index < 0 || index >= currentWalkways.length) return;

    final walkway = currentWalkways[index];
    final center = getCenter(walkway.points);

    currentWalkways[index] = walkway.copyWith(
        width: newWidth,
        points: createWalkwayPoints(
            center, walkway.isHorizontal, newWidth, walkway.length));

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

    currentWalkways[index] = walkway.copyWith(
        isHorizontal: newOrientation,
        points: createWalkwayPoints(getCenter(walkway.points), newOrientation,
            walkway.width, walkway.length));

    selectedwalkwayOrinteation.value = newOrientation ? "H" : "V";
    updatePanelPositions();
  }

  LatLng getCenter(List<LatLng> points) {
    double lat = 0, lng = 0;
    for (final point in points) {
      lat += point.latitude;
      lng += point.longitude;
    }
    return LatLng(lat / points.length, lng / points.length);
  }

  void toggleBuildingSelection(String buildingName) {
    if (selectedBuilding.value == buildingName) {
      selectedBuilding.value = '';
    } else {
      selectedBuilding.value = buildingName;
    }
  }

  void toggleWalkwaySelection() {
    if (editingWalkwayIndex.value == -1) return;
    selectedvalue.value = editingWalkwayIndex.value.toString();
  }

  // before alternative
  Set<Polygon> convertCentersToPolygons(
      List<LatLng> centers,
      bool isHorizontal, {
        bool isAlternate = false,
      }) {
    Set<Polygon> polygons = {};

    if (isAlternate && editingTerraceIndex.value != -1) {
      final terrace = savedTerraces[editingTerraceIndex.value];
      if (terrace.rowOrientations.isNotEmpty) {
        // Calculate approximate row index based on latitude
        final bounds = getPolygonBounds(terrace.areaPoints);
        final latRange = bounds.northeast.latitude - bounds.southwest.latitude;

        for (int i = 0; i < centers.length; i++) {
          final normalizedLat =
              (centers[i].latitude - bounds.southwest.latitude) / latRange;
          final rowIndex = (normalizedLat * terrace.rowOrientations.length)
              .toInt()
              .clamp(0, terrace.rowOrientations.length - 1);
          final lastindex = (normalizedLat * terrace.rowOrientations.length)
              .toInt()
              .clamp(0, terrace.rowOrientations.length - 1);
          final firstIndex = (normalizedLat +
              terrace.rowOrientations.length
                  .toInt()
                  .clamp(0, terrace.rowOrientations.length - 1));

          polygons.add(createPanelPolygon(
            centers[i],
            isHorizontal,
            rowIndex: rowIndex,
          ));
        }
        return polygons;
      }
    }

    // Fallback for non-alternate mode
    return centers
        .map((center) => createPanelPolygon(
      center,
      isHorizontal,
    ))
        .toSet();
  }

  // convertCenter polygon

  // before panel layout
  // void updatePanelPositions1(SurveyMapController controller) {
  //   if (controller.editingTerraceIndex.value != -1) {
  //     final terrace = controller.savedTerraces[controller.editingTerraceIndex.value];
  //     final newCenters = controller.calculatePanelCentersWithLayout(
  //         terrace.areaPoints,
  //         controller.selectedPanelCount.value,
  //         controller.selectedLayout.value
  //     );
  //
  //     // Determine orientation based on layout WITHOUT changing the segmented control
  //     final bool isHorizontalLayout = controller.selectedLayout.value >= 2; // Layouts 2,3 are horizontal
  //
  //     // Update terrace with new panels and set the correct orientation
  //     controller.savedTerraces[controller.editingTerraceIndex.value] = terrace.copyWith(
  //       panels: newCenters,
  //       isHorizontal: isHorizontalLayout,
  //       isAlternate: false, // Reset alternate when using layout selector
  //     );
  //
  //     // Update displayed panels WITHOUT changing the segmented control value
  //     controller.solarPanelsPolygons.value = controller.convertCentersToPolygons(
  //       newCenters,
  //       isHorizontalLayout,
  //       isAlternate: false,
  //     );
  //
  //     // DON'T change the segmented control value -========\]\cbvcvn
  //     // This will prevent the automatic switching between H and V
  //   }
  // }

  void updatePanelPositions1(SurveyMapController controller) {
    if (controller.editingTerraceIndex.value != -1) {
      final terrace =
      controller.savedTerraces[controller.editingTerraceIndex.value];
      final newCenters = controller.calculatePanelCentersWithLayout(
          terrace.areaPoints,
          controller.selectedPanelCount.value,
          controller.selectedLayout.value);

      // Determine orientation based on layout
      final bool isHorizontalLayout =
          controller.selectedLayout.value >= 2; // Layouts 2,3 are horizontal

      // Update terrace with new panels and set the correct orientation
      controller.savedTerraces[controller.editingTerraceIndex.value] =
          terrace.copyWith(
            panels: newCenters,
            isHorizontal: isHorizontalLayout,
            isAlternate: false,
          );

      // Update displayed panels
      controller.solarPanelsPolygons.value =
          controller.convertCentersToPolygons(
            newCenters,
            isHorizontalLayout,
            isAlternate: false,
          );

      // Sync the segmented control with the layout orientation
      controller.selectedvalue.value = isHorizontalLayout ? "H" : "V";
    }
  }

  // working updatePanelPostion2
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

      savedTerraces[editingTerraceIndex.value] =
          terrace.copyWith(panels: newCenters);

      // Call with named parameter
      solarPanelsPolygons.value = convertCentersToPolygons(
        newCenters,
        terrace.isHorizontal,
        isAlternate: terrace.isAlternate,
      );
    }
  }

  void showLayoutWarning(String message) {
    Get.snackbar(
      'Insufficient Space',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  List<LatLng> calculateAlternatePanelCenters(
      List<LatLng> polygonPoints,
      double padding,
      double rowSpacing,
      ) {
    List<LatLng> centers = [];
    if (polygonPoints.length < 3) return centers;

    final bounds = getPolygonBounds(polygonPoints);
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    // Convert padding to degrees
    final double paddingLat = padding / 111111.0;
    final double paddingLng =
        padding / (111111.0 * cos(center.latitude * pi / 180));
    final double rowSpacingDeg = rowSpacing / 111111.0;

    // Calculate boundaries with padding
    final double startLat = bounds.southwest.latitude + paddingLat;
    final double endLat = bounds.northeast.latitude - paddingLat;
    final double startLng = bounds.southwest.longitude + paddingLng;
    final double endLng = bounds.northeast.longitude - paddingLng;

    // Panel dimensions in degrees
    final double horizontalPanelWidth =
        2.27 / (111111.0 * cos(center.latitude * pi / 180)); // 2m width
    final double horizontalPanelHeight = 1.13 / 111111.0; // 1m height

    final double verticalPanelWidth =
        1.13 / (111111.0 * cos(center.latitude * pi / 180)); // 1m width
    final double verticalPanelHeight = 2.27 / 111111.0; // 2m height

    double currentY = startLat;
    int rowIndex = 0;

    while (currentY < endLat) {
      bool isHorizontalRow = rowIndex % 2 == 0;

      double rowHeight =
      isHorizontalRow ? horizontalPanelHeight : verticalPanelHeight;
      double panelWidth =
      isHorizontalRow ? horizontalPanelWidth : verticalPanelWidth;

      // Check space for this row
      if (currentY + rowHeight > endLat) break;

      // Calculate how many panels fit in this row
      double availableWidth = endLng - startLng;
      int panelsInRow = (availableWidth / panelWidth).floor();

      if (panelsInRow > 0) {
        // Center the row horizontally
        double totalRowWidth = panelsInRow * panelWidth;
        double rowStartLng = startLng + (availableWidth - totalRowWidth) / 2;

        // Place panels in row
        for (int i = 0; i < panelsInRow; i++) {
          double panelCenterLng =
              rowStartLng + (i * panelWidth) + (panelWidth / 2);
          double panelCenterLat = currentY + (rowHeight / 2);

          LatLng panelCenter = LatLng(panelCenterLat, panelCenterLng);

          if (isPointInPolygon(panelCenter, polygonPoints)) {
            centers.add(panelCenter);
          }
        }
      }

      currentY += rowHeight + rowSpacingDeg;
      rowIndex++;
    }

    return centers;
  }

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

    // Panel dimensions in meters
    const double panelWidth = 1.13; // 1m width for vertical panels
    const double panelHeight = 2.27; // 2m height for horizontal panels

    // Convert padding to degrees
    final double paddingLat = padding / 111111.0;
    final double paddingLng =
        padding / (111111.0 * cos(center.latitude * pi / 180));

    // Calculate grid boundaries with padding
    final double startLat = bounds.southwest.latitude + paddingLat;
    final double endLat = bounds.northeast.latitude - paddingLat;
    final double startLng = bounds.southwest.longitude + paddingLng;
    final double endLng = bounds.northeast.longitude - paddingLng;

    // Calculate grid dimensions in meters
    final double widthMeters =
        (endLng - startLng) * 111111 * cos(center.latitude * pi / 180);
    final double heightMeters = (endLat - startLat) * 111111;

    // Calculate maximum number of panels that can fit without any spacing
    int maxCols, maxRows;

    if (isHorizontal) {
      // For horizontal panels: 2m width, 1m height
      maxCols = max(1, (widthMeters / panelHeight).floor());
      maxRows = max(1, (heightMeters / panelWidth).floor());
    } else {
      // For vertical panels: 1m width, 2m height
      maxCols = max(1, (widthMeters / panelWidth).floor());
      maxRows = max(1, (heightMeters / panelHeight).floor());
    }

    // If no panel count is selected, return all possible panels
    if (selectedPanelCount.value <= 0) {
      // Calculate step sizes (no spacing between panels)
      final double lngStep = (endLng - startLng) / maxCols;
      final double latStep = (endLat - startLat) / maxRows;

      for (int y = 0; y < maxRows; y++) {
        for (int x = 0; x < maxCols; x++) {
          final double centerLng = startLng + (x * lngStep) + (lngStep / 2);
          final double centerLat = startLat + (y * latStep) + (latStep / 2);
          final LatLng panelCenter = LatLng(centerLat, centerLng);

          if (isPointInPolygon(panelCenter, polygonPoints)) {
            centers.add(panelCenter);
          }
        }
      }
      return centers;
    }

    // Calculate optimal grid for the selected panel count
    int optimalCols, optimalRows;

    // Find the most balanced distribution (as equal as possible)
    List<List<int>> possibleDistributions = [];

    // Try different numbers of rows
    for (int rows = 1; rows <= min(selectedPanelCount.value, maxRows); rows++) {
      int cols = (selectedPanelCount.value / rows).ceil();

      // Check if this distribution fits within constraints
      if (cols <= maxCols) {
        // Calculate how balanced this distribution is
        int maxPanelsInRow = (selectedPanelCount.value / rows).ceil();
        int minPanelsInRow = (selectedPanelCount.value / rows).floor();
        int imbalance = (maxPanelsInRow - minPanelsInRow).abs();

        possibleDistributions.add([rows, cols, imbalance, maxPanelsInRow]);
      }
    }

    // If no valid distributions found, use fallback
    if (possibleDistributions.isEmpty) {
      optimalRows = 1;
      optimalCols = min(selectedPanelCount.value, maxCols);
    } else {
      // Sort by imbalance (lowest first), then by number of rows
      possibleDistributions.sort((a, b) {
        if (a[2] != b[2]) return a[2].compareTo(b[2]); // Lower imbalance first
        if (isHorizontal)
          return b[0].compareTo(a[0]); // For horizontal, prefer more rows
        return a[0].compareTo(b[0]); // For vertical, prefer fewer rows
      });

      optimalRows = possibleDistributions[0][0];
      optimalCols = possibleDistributions[0][3]; // Use max panels per row
    }

    // Calculate panel dimensions in degrees (no spacing)
    final double panelWidthDeg =
        panelWidth / (111111.0 * cos(center.latitude * pi / 180));
    final double panelHeightDeg = panelHeight / 111111.0;

    // Calculate step sizes based on actual panel dimensions (no spacing)
    double lngStep, latStep;

    if (isHorizontal) {
      lngStep = panelHeightDeg; // 2m in longitude direction
      latStep = panelWidthDeg; // 1m in latitude direction
    } else {
      lngStep = panelWidthDeg; // 1m in longitude direction
      latStep = panelHeightDeg; // 2m in latitude direction
    }

    // Calculate starting position to center the panels
    final double totalWidth = (optimalCols - 1) * lngStep;
    final double totalHeight = (optimalRows - 1) * latStep;

    final double startLngCentered =
        startLng + (endLng - startLng - totalWidth) / 2;
    final double startLatCentered =
        startLat + (endLat - startLat - totalHeight) / 2;

    // Calculate how many panels should be in each row
    int totalPanels = selectedPanelCount.value;
    int panelsPerRow = (totalPanels / optimalRows).ceil();
    int remainingPanels = totalPanels;
    List<int> rowPanelCounts = [];

    for (int i = 0; i < optimalRows; i++) {
      int panelsThisRow = min(panelsPerRow, remainingPanels);
      rowPanelCounts.add(panelsThisRow);
      remainingPanels -= panelsThisRow;

      // Adjust panels per row for remaining rows if needed
      if (optimalRows - i - 1 > 0) {
        panelsPerRow = (remainingPanels / (optimalRows - i - 1)).ceil();
      }
    }

    // Place panels in a grid with no spacing
    int panelsPlaced = 0;

    for (int row = 0; row < optimalRows; row++) {
      int panelsInThisRow = rowPanelCounts[row];

      // Calculate starting position for this row to center the panels
      double rowStartLng =
          startLngCentered + ((optimalCols - panelsInThisRow) * lngStep / 2);

      for (int col = 0; col < panelsInThisRow; col++) {
        final double centerLng = rowStartLng + (col * lngStep);
        final double centerLat = startLatCentered + (row * latStep);
        final LatLng panelCenter = LatLng(centerLat, centerLng);

        if (isPointInPolygon(panelCenter, polygonPoints)) {
          centers.add(panelCenter);
          panelsPlaced++;

          if (panelsPlaced >= selectedPanelCount.value) {
            return centers;
          }
        }
      }
    }

    return centers;
  }

  // testing
  double getTerraceOrientationAngle(List<LatLng> polygonPoints) {
    if (polygonPoints.length < 3) return 0.0;

    // Calculate the principal axis using covariance matrix
    final bounds = getPolygonBounds(polygonPoints);
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    // Convert points to local coordinates (meters from center)
    List<Offset> localPoints = [];
    for (final point in polygonPoints) {
      final double x = (point.longitude - center.longitude) *
          (111111.0 * cos(center.latitude * pi / 180));
      final double y = (point.latitude - center.latitude) * 111111.0;
      localPoints.add(Offset(x, y));
    }

    // Calculate covariance matrix
    double covXX = 0, covYY = 0, covXY = 0;
    for (final point in localPoints) {
      covXX += point.dx * point.dx;
      covYY += point.dy * point.dy;
      covXY += point.dx * point.dy;
    }

    // Calculate orientation angle
    final double angle = 0.5 * atan2(2 * covXY, covXX - covYY);
    return angle;
  }

  // old before alternative
  // void updatePanelPositions() {
  //   if (editingTerraceIndex.value != -1) {
  //     solarPanelsPolygons.clear();
  //     final terrace = savedTerraces[editingTerraceIndex.value];
  //
  //     final newCenters = calculatePanelCenters(
  //         terrace.areaPoints,
  //         terrace.isHorizontal,
  //         terrace.padding,
  //         terrace.rowSpacing
  //     );
  //
  //     savedTerraces[editingTerraceIndex.value] = terrace.copyWith(panels: newCenters);
  //     solarPanelsPolygons.value = terrace.panelPolygons;
  //   }
  // }

  //
  //
  // List<LatLng> calculatePanelCenters(
  //     List<LatLng> polygonPoints,
  //     bool isHorizontal,
  //     double padding,
  //     double rowSpacing, {
  //       bool isAlternate = false,
  //     }) {
  //   List<LatLng> centers = [];
  //   if (polygonPoints.length < 3) return centers;
  //
  //   final bounds = getPolygonBounds(polygonPoints);
  //   final center = LatLng(
  //     (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
  //     (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
  //   );
  //
  //   // Panel dimensions in meters
  //   const double panelWidth = 1.0;   // 1m width for vertical panels
  //   const double panelHeight = 2.0;  // 2m height for horizontal panels
  //
  //   // Convert padding to degrees
  //   final double paddingLat = padding / 111111.0;
  //   final double paddingLng = padding / (111111.0 * cos(center.latitude * pi / 180));
  //
  //   // Calculate grid boundaries with padding
  //   final double startLat = bounds.southwest.latitude + paddingLat;
  //   final double endLat = bounds.northeast.latitude - paddingLat;
  //   final double startLng = bounds.southwest.longitude + paddingLng;
  //   final double endLng = bounds.northeast.longitude - paddingLng;
  //
  //   // Calculate grid dimensions in meters
  //   final double widthMeters = (endLng - startLng) * 111111 * cos(center.latitude * pi / 180);
  //   final double heightMeters = (endLat - startLat) * 111111;
  //
  //   // Calculate maximum number of panels that can fit without any spacing
  //   int maxCols, maxRows;
  //
  //   if (isHorizontal) {
  //     // For horizontal panels: 2m width, 1m height
  //     maxCols = max(1, (widthMeters / panelHeight).floor());
  //     maxRows = max(1, (heightMeters / panelWidth).floor());
  //   } else {
  //     // For vertical panels: 1m width, 2m height
  //     maxCols = max(1, (widthMeters / panelWidth).floor());
  //     maxRows = max(1, (heightMeters / panelHeight).floor());
  //   }
  //
  //   // If no panel count is selected, return all possible panels
  //   if (selectedPanelCount.value <= 0) {
  //     // Calculate step sizes (no spacing between panels)
  //     final double lngStep = (endLng - startLng) / maxCols;
  //     final double latStep = (endLat - startLat) / maxRows;
  //
  //     for (int y = 0; y < maxRows; y++) {
  //       for (int x = 0; x < maxCols; x++) {
  //         final double centerLng = startLng + (x * lngStep) + (lngStep / 2);
  //         final double centerLat = startLat + (y * latStep) + (latStep / 2);
  //         final LatLng panelCenter = LatLng(centerLat, centerLng);
  //
  //         if (isPointInPolygon(panelCenter, polygonPoints)) {
  //           centers.add(panelCenter);
  //         }
  //       }
  //     }
  //     return centers;
  //   }
  //
  //   // Calculate optimal grid for the selected panel count
  //   int optimalCols, optimalRows;
  //
  //   // Find the most balanced distribution (as equal as possible)
  //   List<List<int>> possibleDistributions = [];
  //
  //   for (int rows = 1; rows <= min(selectedPanelCount.value, maxRows); rows++) {
  //     int cols = (selectedPanelCount.value / rows).ceil();
  //     int remainder = selectedPanelCount.value % rows;
  //
  //     if (cols <= maxCols) {
  //       // Calculate how balanced this distribution is
  //       int imbalance = 0;
  //       for (int i = 0; i < rows; i++) {
  //         int panelsInThisRow = (i < remainder) ? cols : cols - 1;
  //         imbalance += (panelsInThisRow - (selectedPanelCount.value / rows)).abs().round();
  //       }
  //
  //       possibleDistributions.add([rows, cols, imbalance]);
  //     }
  //   }
  //
  //   // Sort by imbalance (lowest first) and then by rows (prefer more rows for vertical, more columns for horizontal)
  //   possibleDistributions.sort((a, b) {
  //     if (a[2] != b[2]) return a[2].compareTo(b[2]); // Lower imbalance first
  //     if (isHorizontal) return b[0].compareTo(a[0]); // For horizontal, prefer fewer rows
  //     return a[0].compareTo(b[0]); // For vertical, prefer fewer columns
  //   });
  //
  //   if (possibleDistributions.isNotEmpty) {
  //     optimalRows = possibleDistributions[0][0];
  //     optimalCols = possibleDistributions[0][1];
  //   } else {
  //     // Fallback: use maximum available
  //     optimalRows = min(selectedPanelCount.value, maxRows);
  //     optimalCols = min((selectedPanelCount.value / optimalRows).ceil(), maxCols);
  //   }
  //
  //   // Calculate panel dimensions in degrees (no spacing)
  //   final double panelWidthDeg = panelWidth / (111111.0 * cos(center.latitude * pi / 180));
  //   final double panelHeightDeg = panelHeight / 111111.0;
  //
  //   // Calculate step sizes based on actual panel dimensions (no spacing)
  //   double lngStep, latStep;
  //
  //   if (isHorizontal) {
  //     lngStep = panelHeightDeg; // 2m in longitude direction
  //     latStep = panelWidthDeg;  // 1m in latitude direction
  //   } else {
  //     lngStep = panelWidthDeg;  // 1m in longitude direction
  //     latStep = panelHeightDeg; // 2m in latitude direction
  //   }
  //
  //   // Calculate starting position to center the panels
  //   final double totalWidth = (optimalCols - 1) * lngStep;
  //   final double totalHeight = (optimalRows - 1) * latStep;
  //
  //   final double startLngCentered = startLng + (endLng - startLng - totalWidth) / 2;
  //   final double startLatCentered = startLat + (endLat - startLat - totalHeight) / 2;
  //
  //   // Calculate how many panels should be in each row
  //   int remainder = selectedPanelCount.value % optimalRows;
  //   List<int> panelsPerRow = List.generate(optimalRows, (index) {
  //     return (index < remainder)
  //         ? (selectedPanelCount.value / optimalRows).ceil()
  //         : (selectedPanelCount.value / optimalRows).floor();
  //   });
  //
  //   // Place panels in a grid with no spacing
  //   int panelsPlaced = 0;
  //
  //   for (int row = 0; row < optimalRows; row++) {
  //     int panelsInThisRow = panelsPerRow[row];
  //
  //     // Calculate starting position for this row to center the panels
  //     double rowStartLng = startLngCentered + ((optimalCols - panelsInThisRow) * lngStep / 2);
  //
  //     for (int col = 0; col < panelsInThisRow; col++) {
  //       final double centerLng = rowStartLng + (col * lngStep);
  //       final double centerLat = startLatCentered + (row * latStep);
  //       final LatLng panelCenter = LatLng(centerLat, centerLng);
  //
  //       if (isPointInPolygon(panelCenter, polygonPoints)) {
  //         centers.add(panelCenter);
  //         panelsPlaced++;
  //
  //         if (panelsPlaced >= selectedPanelCount.value) {
  //           return centers;
  //         }
  //       }
  //     }
  //   }
  //
  //   return centers;
  // }

  // List<LatLng> calculatePanelCenters(
  //     List<LatLng> polygonPoints,
  //     bool isHorizontal,
  //     double padding,
  //     double rowSpacing, {
  //       bool isAlternate = false,
  //     }) {
  //   List<LatLng> centers = [];
  //   if (polygonPoints.length < 3) return centers;
  //
  //   final bounds = getPolygonBounds(polygonPoints);
  //   final center = LatLng(
  //     (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
  //     (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
  //   );
  //
  //   // Panel dimensions in meters
  //   const double panelWidth = 1.0;   // 1m width for vertical panels
  //   const double panelHeight = 2.0;  // 2m height for horizontal panels
  //
  //   // Convert padding to degrees
  //   final double paddingLat = padding / 111111.0;
  //   final double paddingLng = padding / (111111.0 * cos(center.latitude * pi / 180));
  //
  //   // Calculate grid boundaries with padding
  //   final double startLat = bounds.southwest.latitude + paddingLat;
  //   final double endLat = bounds.northeast.latitude - paddingLat;
  //   final double startLng = bounds.southwest.longitude + paddingLng;
  //   final double endLng = bounds.northeast.longitude - paddingLng;
  //
  //   // Calculate grid dimensions in meters
  //   final double widthMeters = (endLng - startLng) * 111111 * cos(center.latitude * pi / 180);
  //   final double heightMeters = (endLat - startLat) * 111111;
  //
  //   // Calculate maximum number of panels that can fit without any spacing
  //   int maxCols, maxRows;
  //
  //   if (isHorizontal) {
  //     // For horizontal panels: 2m width, 1m height
  //     maxCols = max(1, (widthMeters / panelHeight).floor());
  //     maxRows = max(1, (heightMeters / panelWidth).floor());
  //   } else {
  //     // For vertical panels: 1m width, 2m height
  //     maxCols = max(1, (widthMeters / panelWidth).floor());
  //     maxRows = max(1, (heightMeters / panelHeight).floor());
  //   }
  //
  //   // If no panel count is selected, return all possible panels
  //   if (selectedPanelCount.value <= 0) {
  //     // Calculate step sizes (no spacing between panels)
  //     final double lngStep = (endLng - startLng) / maxCols;
  //     final double latStep = (endLat - startLat) / maxRows;
  //
  //     for (int y = 0; y < maxRows; y++) {
  //       for (int x = 0; x < maxCols; x++) {
  //         final double centerLng = startLng + (x * lngStep) + (lngStep / 2);
  //         final double centerLat = startLat + (y * latStep) + (latStep / 2);
  //         final LatLng panelCenter = LatLng(centerLat, centerLng);
  //
  //         if (isPointInPolygon(panelCenter, polygonPoints)) {
  //           centers.add(panelCenter);
  //         }
  //       }
  //     }
  //     return centers;
  //   }
  //
  //   // Calculate optimal grid for the selected panel count
  //   int optimalCols, optimalRows;
  //
  //   if (isHorizontal) {
  //     // For horizontal panels, prioritize more columns
  //     optimalCols = min(selectedPanelCount.value, maxCols);
  //     optimalRows = (selectedPanelCount.value / optimalCols).ceil();
  //
  //     // Adjust if rows exceed available space
  //     if (optimalRows > maxRows) {
  //       optimalRows = maxRows;
  //       optimalCols = (selectedPanelCount.value / optimalRows).ceil();
  //     }
  //   } else {
  //     // For vertical panels, prioritize more rows
  //     optimalRows = min(selectedPanelCount.value, maxRows);
  //     optimalCols = (selectedPanelCount.value / optimalRows).ceil();
  //
  //     // Adjust if columns exceed available space
  //     if (optimalCols > maxCols) {
  //       optimalCols = maxCols;
  //       optimalRows = (selectedPanelCount.value / optimalCols).ceil();
  //     }
  //   }
  //
  //   // Calculate panel dimensions in degrees (no spacing)
  //   final double panelWidthDeg = panelWidth / (111111.0 * cos(center.latitude * pi / 180));
  //   final double panelHeightDeg = panelHeight / 111111.0;
  //
  //   // Calculate step sizes based on actual panel dimensions (no spacing)
  //   double lngStep, latStep;
  //
  //   if (isHorizontal) {
  //     lngStep = panelHeightDeg; // 2m in longitude direction
  //     latStep = panelWidthDeg;  // 1m in latitude direction
  //   } else {
  //     lngStep = panelWidthDeg;  // 1m in longitude direction
  //     latStep = panelHeightDeg; // 2m in latitude direction
  //   }
  //
  //   // Calculate starting position to center the panels
  //   final double totalWidth = (optimalCols - 1) * lngStep;
  //   final double totalHeight = (optimalRows - 1) * latStep;
  //
  //   final double startLngCentered = startLng + (endLng - startLng - totalWidth) / 2;
  //   final double startLatCentered = startLat + (endLat - startLat - totalHeight) / 2;
  //
  //   // Place panels in a grid with no spacing
  //   int panelsPlaced = 0;
  //
  //   for (int row = 0; row < optimalRows && panelsPlaced < selectedPanelCount.value; row++) {
  //     for (int col = 0; col < optimalCols && panelsPlaced < selectedPanelCount.value; col++) {
  //       final double centerLng = startLngCentered + (col * lngStep);
  //       final double centerLat = startLatCentered + (row * latStep);
  //       final LatLng panelCenter = LatLng(centerLat, centerLng);
  //
  //       if (isPointInPolygon(panelCenter, polygonPoints)) {
  //         centers.add(panelCenter);
  //         panelsPlaced++;
  //       }
  //     }
  //   }
  //
  //   return centers;
  // }

  void startEditingTerrace1(int index) {
    editingTerraceIndex.value = index;
    isSelectingArea.value = true;
    isSelectingArea.value = true;

    detectAndHighlightLayout();

    // Set the selected layout based on the terrace's actual orientation and layout
    final terrace = savedTerraces[index];
    azimuthAngle.value = savedTerraces[index].azimuthAngle;

    updateAvailableRows();

    // Determine which layout matches the current terrace configuration
    if (terrace.isHorizontal) {
      // For horizontal terraces, select between layout 2 or 3
      selectedLayout.value = terrace.panels.length >= 8 ? 3 : 2; // 2xN or Nx2
    } else {
      // For vertical terraces, select between layout 0 or 1
      selectedLayout.value = terrace.panels.length >= 8 ? 0 : 1; // 2xN or 1xN
    }

    originalTerracePoints.value = List.from(savedTerraces[index].areaPoints);
    polygonPoints.value = List.from(savedTerraces[index].areaPoints);
    currentWalkways.value = List.from(savedTerraces[index].walkways);

    // Load hand rail data from the terrace
    if (savedTerraces[index].hasGril) {
      currentHandRailPoints.value =
          List.from(savedTerraces[index].handRailPoints);
      isHandRailComplete.value = true;
    } else {
      currentHandRailPoints.clear();
      isHandRailComplete.value = false;
    }
    isDrawingHandRail.value = false;

    // Load other terrace properties
    isHorizontal.value = savedTerraces[index].isHorizontal;
    paddingSliderValue.value = savedTerraces[index].padding;
    rowSpacingSlidervalue.value = savedTerraces[index].rowSpacing;
    currentHasGril.value = savedTerraces[index].hasGril;

    updateAvailableLayouts(
        selectedPanelCount.value, savedTerraces[index].areaPoints);

    updatePolygon(forceUpdate: true);
  }

  void startEditingTerrace(int index) {
    editingTerraceIndex.value = index;
    isSelectingArea.value = true;

    // Remove any automatic orientation detection
    final terrace = savedTerraces[index];

    // Keep the terrace's existing orientation instead of forcing south-facing
    isHorizontal.value = terrace.isHorizontal;

    originalTerracePoints.value = List.from(savedTerraces[index].areaPoints);
    polygonPoints.value = List.from(savedTerraces[index].areaPoints);
    currentWalkways.value = List.from(savedTerraces[index].walkways);

    // Load hand rail data
    if (savedTerraces[index].hasGril) {
      currentHandRailPoints.value =
          List.from(savedTerraces[index].handRailPoints);
      isHandRailComplete.value = true;
    } else {
      currentHandRailPoints.clear();
      isHandRailComplete.value = false;
    }
    isDrawingHandRail.value = false;

    // Load other terrace properties
    paddingSliderValue.value = savedTerraces[index].padding;
    rowSpacingSlidervalue.value = savedTerraces[index].rowSpacing;
    currentHasGril.value = savedTerraces[index].hasGril;

    updatePolygon(forceUpdate: true);
  }

  // before panel layout
  // void startEditingTerrace(int index) {
  //   editingTerraceIndex.value = index;
  //
  //   detectAndHighlightLayout();
  //
  //   // Set initial orientation based on selected layout
  //   if (selectedLayout.value >= 0) {
  //     isHorizontal.value = selectedLayout.value >= 2; // Layouts 2,3 are horizontal
  //   }
  //   originalTerracePoints.value = List.from(savedTerraces[index].areaPoints);
  //   polygonPoints.value = List.from(savedTerraces[index].areaPoints);
  //   currentWalkways.value = List.from(savedTerraces[index].walkways);
  //
  //   // Load hand rail data from the terrace
  //   if (savedTerraces[index].hasGril) {
  //     currentHandRailPoints.value = List.from(savedTerraces[index].handRailPoints);
  //     isHandRailComplete.value = true;
  //   } else {
  //     currentHandRailPoints.clear();
  //     isHandRailComplete.value = false;
  //   }
  //   isDrawingHandRail.value = false;
  //
  //   // Load other terrace properties
  //   isHorizontal.value = savedTerraces[index].isHorizontal;
  //   paddingSliderValue.value = savedTerraces[index].padding;
  //   rowSpacingSlidervalue.value = savedTerraces[index].rowSpacing;
  //   currentHasGril.value = savedTerraces[index].hasGril;
  //
  //   updateAvailableLayouts(selectedPanelCount.value, savedTerraces[index].areaPoints);
  //
  //   updatePolygon(forceUpdate: true);
  // }

  // save terrace on save cahnges
  void saveEditedTerrace() {
    print("saveEditedTerrace called ===");
    if (editingTerraceIndex.value == -1 || polygonPoints.length < 3) return;

    final terrace = savedTerraces[editingTerraceIndex.value];
    originalPanelPositionsForAzimuth.clear();

    totalPanelWidth.value = getPanelStructureWidth();
    totalPanelHeight.value = getPanelStructureHeight();

    // Preserve the existing hand rail if we're not currently drawing
    List<LatLng> newHandRailPoints = isDrawingHandRail.value
        ? List.from(currentHandRailPoints)
        : terrace.handRailPoints;

    // CRITICAL: Use the CURRENT panel positions instead of recalculating
    // Don't call calculatePanelCenters - use the existing dragged positions
    savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
      areaPoints: List.from(polygonPoints),
      panels:
      List.from(terrace.panels), // ← Use current panels, don't recalculate
      walkways: List.from(currentWalkways),
      handRailPoints: newHandRailPoints,
      hasGril: newHandRailPoints.isNotEmpty,
      mountingStyle: highlightedLayout.value,
      paneltotalWidth: totalPanelWidth.value,
      paneltotalHeight: totalPanelHeight.value,
      numberOfRows: selectedRows.value,
      nofPanels: selectedPanelCount.value,
      azimuthAngle: azimuthAngle.value,
    );

    calculateBom(editingTerraceIndex.value);
    originalPanelOffsets.clear();
    // Reset editing state including hand rail drawing
    editingTerraceIndex.value = -1;
    currentWalkways.clear();
    polygonPoints.clear();
    isDrawingHandRail.value = false;
    currentHandRailPoints.clear();
    isHandRailComplete.value = false;
    showAzimuthSlider.value = false;

    // Don't call updatePanelPositions() here as it recalculates centers
    update();
  }

  // void saveEditedTerrace() {
  //   if (editingTerraceIndex.value == -1 || polygonPoints.length < 3) return;
  //
  //   final terrace = savedTerraces[editingTerraceIndex.value];
  //
  //   // Preserve the existing hand rail if we're not currently drawing
  //   List<LatLng> newHandRailPoints = isDrawingHandRail.value
  //       ? List.from(currentHandRailPoints)
  //       : terrace.handRailPoints;
  //
  //   savedTerraces[editingTerraceIndex.value] = terrace.copyWith(
  //     areaPoints: List.from(polygonPoints),
  //     panels: calculatePanelCenters(polygonPoints, terrace.isHorizontal, terrace.padding, terrace.rowSpacing),
  //     walkways: List.from(currentWalkways),
  //     handRailPoints: newHandRailPoints,
  //     hasGril: newHandRailPoints.isNotEmpty,
  //   );
  //
  //   // Reset editing state including hand rail drawing
  //   editingTerraceIndex.value = -1;
  //   currentWalkways.clear();
  //   polygonPoints.clear();
  //   isDrawingHandRail.value = false;
  //   currentHandRailPoints.clear();
  //   isHandRailComplete.value = false;
  //
  //   updatePanelPositions();
  //   update();
  // }

  void cancelEditing() {
    editingTerraceIndex.value = -1;
    originalTerracePoints.clear();
    polygonPoints.clear();
    currentWalkways.clear();
    isDrawingHandRail.value = false;
    currentHandRailPoints.clear();
    isHandRailComplete.value = false;
  }

  void calculateSolarPanels1() {
    solarPanelsPolygons.value = calculateSolarPanelsForTerrace(
      polygonPoints,
      isHorizontal.value,
      paddingSliderValue.value,
      rowSpacingSlidervalue.value,
    );
  }

  void calculateAllTerracesPanels() {
    allPanels.clear();

    if (polygonPoints.length >= 3) {
      allPanels.addAll(
        calculateSolarPanelsForTerrace(
          polygonPoints,
          isHorizontal.value,
          paddingSliderValue.value,
          rowSpacingSlidervalue.value,
        ),
      );
    }

    for (final terrace in savedTerraces) {
      allPanels.addAll(
        calculateSolarPanelsForTerrace(
          polygonPoints,
          isHorizontal.value,
          paddingSliderValue.value,
          rowSpacingSlidervalue.value,
        ),
      );
    }
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
          rowSpacingSlidervalue.value,
        ),
        walkways: List.from(currentWalkways), // NEW: Save walkways
        isHorizontal: isHorizontal.value,
        padding: paddingSliderValue.value,
        rowSpacing: rowSpacingSlidervalue.value,
        isActive: true,
        customerName: currentCustomerName.value,
        customerMobile: currentCustomerMobile.value,
        buildingName: currentBuilding.value,
      );

      terraceBuildings[newTerrace.id] = currentBuilding.value;
      savedTerraces.add(newTerrace);
      calculateAllPanels();
      startNewTerrace();
      currentWalkways.clear();

      currentCustomerName.value = '';
      currentCustomerMobile.value = '';
    }
  }

  void calculateAllPanels() {
    allPanels.clear();
    savedTerraces.forEach((terrace) {
      allPanels.addAll(calculateSolarPanelsForTerrace(
        terrace.areaPoints,
        terrace.isHorizontal,
        terrace.padding,
        terrace.rowSpacing,
      ));
    });

    if (polygonPoints.length >= 3) {
      allPanels.addAll(calculateSolarPanelsForTerrace(
        polygonPoints,
        isHorizontal.value,
        paddingSliderValue.value,
        rowSpacingSlidervalue.value,
      ));
    }
  }

  Set<Polygon> calculateSolarPanelsForTerrace(
      List<LatLng> polygonPoints,
      bool isHorizontal,
      double padding,
      double rowSpacing,
      ) {
    return calculatePanelCenters(
      polygonPoints,
      isHorizontal,
      padding,
      rowSpacing,
    ).map((center) => createPanelPolygon(center, isHorizontal)).toSet();
  }
  // The quick brown fox jumps over the lazy dog
  // the quick brown fox jumps over the lazy dog

  void startNewTerrace() {
    polygonPoints.clear();
    isSelectingArea.value = true;
    isNewTerrace.value = true;
    currentHasGril.value = false;
    currentHandRailPoints.clear();
    isDrawingHandRail.value = false;
    isHandRailComplete.value = false;
  }

  final RxBool isHorizontal = true.obs;

  double get panelWidth => isHorizontal.value ? 2.27 : 1.13;
  double get panelHeight => isHorizontal.value ? 1.13 : 2.27;

  double distanceToSegment(LatLng start, LatLng end) {
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

  Future<void> updatePolygon({bool forceUpdate = false}) async {
    if (!forceUpdate && polygonPoints.length < 2) return;

    final bool currentShowInMeters = showInMeters.value;
    polylines.clear();
    distanceMarkers.clear();
    segmentDistances.clear();

    final List<LatLng> cleanPoints = List<LatLng>.from(polygonPoints);
    if (cleanPoints.length >= 3 && cleanPoints.first == cleanPoints.last) {
      cleanPoints.removeLast();
    }

    for (int i = 0; i < cleanPoints.length; i++) {
      final nextIndex = (i + 1) % cleanPoints.length;
      final start = cleanPoints[i];
      final end = cleanPoints[nextIndex];

      final distance = calculateDistance(start, end);
      final convertedValue =
      currentShowInMeters ? distance : distance * 3.28084;
      final unit = currentShowInMeters ? 'm' : 'ft';
      final text = '${convertedValue.toStringAsFixed(1)}$unit';

      final textMarker = await createTextMarker(text);
      final midpoint = LatLng(
        (start.latitude + end.latitude) / 2,
        (start.longitude + end.longitude) / 2,
      );

      distanceMarkers.add(Marker(
        markerId: MarkerId('distance_$i'),
        position: midpoint,
        icon: textMarker,
        anchor: const Offset(0.5, 0.5),
      ));
    }

    if (cleanPoints.length >= 3) {
      final closedPoints = List<LatLng>.from(cleanPoints)..add(cleanPoints[0]);
      polygonArea.value = calculatePolygonArea(closedPoints);
    } else {
      polygonArea.value = 0.0;
    }
  }

// Method to convert centers to polygons

// Method to create panel polygon
  // createPolygon
  Polygon createPanelPolygon(
      LatLng center,
      bool isHorizontal, {
        bool isAlternate = false,
        int rowIndex = 0,
      }) {
    final panelHeight = isHorizontal ? 1.13 : 2.27;
    final panelWidth = isHorizontal ? 2.27 : 1.13;

    // Add logic for alternate orientation if needed
    if (isAlternate) {
      //     hh
      //       // Your alternate panel logic here

      // For example, you might want to adjust dimensions based on rowIndex
    }

    final latDelta = panelHeight / 111111.0 / 2;
    final lngDelta =
        panelWidth / (111111.0 * cos(center.latitude * pi / 180)) / 2;

    return Polygon(
      polygonId: PolygonId('panel_${center.latitude}_${center.longitude}'),
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

  // old before alternative
  // Polygon createPanelPolygon(LatLng center, bool isHorizontal, {String? uniqueId}) {
  //
  //   // final panelHeight = isHorizontal ? 2.0 ; 1.0;
  //   // final panelWidth = isHorizontal ? 1.0 : 2.0;
  //
  //   final panelHeight = isHorizontal ? 1.0 : 2.0;
  //   final panelWidth = isHorizontal ? 2.0 : 1.0;
  //
  //   final latDelta = panelHeight / 111111.0 / 2;
  //   final lngDelta = panelWidth / (111111.0 * cos(center.latitude * pi / 180)) / 2;
  //
  //   return Polygon(
  //     polygonId: PolygonId(uniqueId ?? 'panel_${center.latitude}_${center.longitude}'),
  //     points: [
  //       LatLng(center.latitude - latDelta, center.longitude - lngDelta),
  //       LatLng(center.latitude - latDelta, center.longitude + lngDelta),
  //       LatLng(center.latitude + latDelta, center.longitude + lngDelta),
  //       LatLng(center.latitude + latDelta, center.longitude - lngDelta),
  //     ],
  //     strokeWidth: 1,
  //     strokeColor: Colors.white,
  //     fillColor: Colors.blue.withOpacity(0.8),
  //   );
  // }
  // The quick brown fox jump[s ovber the lazy dog

  LatLngBounds getPolygonBounds(List<LatLng> points) {
    if (points.isEmpty) {
      return LatLngBounds(
        southwest: const LatLng(0, 0),
        northeast: const LatLng(0, 0),
      );
    }

    double minLat = points[0].latitude;
    double maxLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLng = points[0].longitude;

    for (final point in points) {
      minLat = point.latitude < minLat ? point.latitude : minLat;
      maxLat = point.latitude > maxLat ? point.latitude : maxLat;
      minLng = point.longitude < minLng ? point.longitude : minLng;
      maxLng = point.longitude > maxLng ? point.longitude : maxLng;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  Future<BitmapDescriptor> createPreciseBoundaryIcon() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(20, 20); // Canvas size

    // Clear background (transparent)
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.transparent);

    // Draw a small visible dot in the center
    final center = Offset(size.width / 2, size.height / 2);
    final dotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Very small dot (3x3 pixels)
    canvas.drawCircle(center, 1.5, dotPaint);

    // Add a white border for visibility
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, 2.5, borderPaint);

    final image = await recorder.endRecording().toImage(
      size.width.ceil(),
      size.height.ceil(),
    );

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  Future<void> loadIcons() async {
    print("load icon Called");
    boundaryIcon.value = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(22, 22)),
      "assets/images/bcircle3.png",
    );
    walkWayIcon.value = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(10, 10)),
      "assets/images/wcircle.png",
    );

    panelDrageIcos.value = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(22, 22)),
      "assets/images/panelDragHandle.png",
    );
  }

  // The quick brown fox jumps over the lazy dog

  LatLng getPanelsCenter(List<LatLng> panels) {
    // getPanelsCenter
    if (panels.isEmpty) return LatLng(0, 0);

    double totalLat = 0;
    double totalLng = 0;

    for (final panel in panels) {
      totalLat += panel.latitude;
      totalLng += panel.longitude;
    }

    return LatLng(totalLat / panels.length, totalLng / panels.length);
  }

  Future<BitmapDescriptor> createTextMarker(String text) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // font size of distance marker
    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
      backgroundColor: Colors.black54,
    );

    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);

    final image = await recorder.endRecording().toImage(
      textPainter.width.ceil(),
      textPainter.height.ceil(),
    );

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
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
    final len = points.length;

    for (int i = 0; i < len; i++) {
      final p1 = points[i];
      final p2 = points[(i + 1) % len];
      area += toRadians(p2.longitude - p1.longitude) *
          (2 + sin(toRadians(p1.latitude)) + sin(toRadians(p2.latitude)));
    }

    return (area * 6378137 * 6378137 / 2).abs();
  }

  double toRadians(double degree) => degree * pi / 180;

  void clearPolygon() {
    polygonPoints.clear();
    polygonArea.value = 0.0;
    distanceMarkers.clear();
    solarPanelsPolygons.clear();
    currentWalkways.clear(); // NEW: Clear walkways
  }

  bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
    bool inside = false;
    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      final xi = polygon[i].latitude;
      final yi = polygon[i].longitude;
      final xj = polygon[j].latitude;
      final yj = polygon[j].longitude;

      final intersect = ((yi > point.longitude) != (yj > point.longitude)) &&
          (point.latitude <
              (xj - xi) * (point.longitude - yi) / (yj - yi) + xi);

      if (intersect) inside = !inside;
    }
    return inside;
  }

  Future<void> requestLocation(String moNumber) async {
    _uriSub = appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) _processLocationUri(uri);
    });

    // Remove spaces and country code formatting
    String phone = "+91 $moNumber"; // Remove "+91 " and spaces
    const message = "Please share Current Location via 📎 button";
    final url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      _uriSub?.cancel();
      // Fallback: Open WhatsApp directly if the deep link fails
      final fallbackUrl =
          "https://api.whatsapp.com/send?phone=$phone&text=${Uri.encodeComponent(message)}";
      if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
        await launchUrl(Uri.parse(fallbackUrl));
      } else {}
    }
  }

  void _processLocationUri(Uri uri) {
    if (uri.scheme == 'geo') {
      final coords = uri.path.split(',');
      if (coords.length >= 2) {
        final lat = double.tryParse(coords[0]);
        final lng = double.tryParse(coords[1]);

        if (lat != null && lng != null) {
          final newLocation = LatLng(lat, lng);
          pickedLocation.value = newLocation; // FIX THIS LINE
          mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(newLocation, 16),
          );
          _uriSub?.cancel();
        }
      }
    }
  }
}
