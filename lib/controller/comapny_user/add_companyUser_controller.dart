import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/comanItem_model.dart';
import '../../models/comapanyUser_model.dart';
import '../../sevices/api_services.dart';


class AddCompanyuserController extends GetxController {
  ApiService _apiService = ApiService();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  var partnerList = <CommonItemModel>[].obs;
  var projectTypeList = <CommonItemModel>[].obs;
  var companyUsers = <CompanyUser>[].obs;


  var categoryList = <CommonItemModel>[].obs;
  RxString selectedCategoryIds = ''.obs;

  var subCategoryList = <CommonItemModel>[].obs;
  RxString selectedSubCategoryIds = ''.obs;

  var projectTypeList_forFilter = <CommonItemModel>[].obs;
  RxString selectedProjectTypesIds = ''.obs;

  var subProjectTypeList = <CommonItemModel>[].obs;
  RxString selectedSubProjectTypeIds = ''.obs;

  var stateList = <CommonItemModel>[].obs;
  RxString selectedStateIds = ''.obs;

  var distrcitList = <CommonItemModel>[].obs;
  RxString selectedDistrictIds = ''.obs;

  var countryList_form =  <CommonItemModel>[].obs;
  RxString selectedcountryIds_form = ''.obs;

  var stateList_form =  <CommonItemModel>[].obs;
  RxString selectedStateIds_form = ''.obs;

  var clusterList_form =  <CommonItemModel>[].obs;
  RxString selectedClusterIds_form = ''.obs;

  var districtList_form =  <CommonItemModel>[].obs;
  RxString slectedDistrictIds_form = ''.obs;




  RxString selectedPartnerIds = ''.obs;




  String selectedProjectTypeIds = '';

  // Loading state
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategory();
    getPartnerTypes();
    getprojectTypes();
    getCompanyUsers();
    getCountry();
    getState();
  }

  Future<void> getPartnerTypes() async {
    http.Response response = await _apiService.getPartnerTypes();
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      partnerList.value = data.map((item) => CommonItemModel.fromJson(item)).toList();
    } else {
      print('API error: ${jsonResponse['message']}');
    }
  }

  Future<void> getprojectTypes() async {
    http.Response response = await _apiService.getprojectTypes();
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      projectTypeList.value = data.map((item) => CommonItemModel.fromJson(item)).toList();
    } else {
      print('API error: ${jsonResponse['message']}');
    }
  }


  // AddCompanyuserController.dart
  Future<bool> addCompanyUser({
    required String name,
    required String number,
    required String email,
    required String district,
    required bool isPartnerGoalsEnabled,
    required String partnerMonthlyTargetKw,
    required String partnerPerKwCommission,
    required bool partnerQuotePermissionsCreate,
    required bool partnerQuotePermissionsEdit,
    required bool partnerQuotePermissionsDelete,
    required List<Map<String, dynamic>> partnerTypesGoals,
    required bool isProjectGoalEnabled,
    required String projectMonthlyTargetKw,
    required String projectPerKwCommission,
    required List<Map<String, dynamic>> projectTypesGoals,
    required String selectedCountryIds,
    required String selectedStateIds,
    required String selectedClusterIds,
    required String selectedDistrictIds,
    required BuildContext context,
  }) async {
    isLoading.value = true;

    try {
      http.Response response = await _apiService.addCompanyUser(
        name: name,
        number: number,
        email: email,
        district: district,
        isPartnerGoalsEnabled: isPartnerGoalsEnabled,
        partnerMonthlyTargetKw_partnergoal: partnerMonthlyTargetKw,
        partnerPerKwCommission_partnergoal: partnerPerKwCommission,
        partnerQuotePermissions_create: partnerQuotePermissionsCreate,
        partnerQuotePermissions_edit: partnerQuotePermissionsEdit,
        partnerQuotePermissions_delete: partnerQuotePermissionsDelete,
        partnerTypesGoals: partnerTypesGoals,
        isProjectGoalEnabled: isProjectGoalEnabled,
        projectMonthlyTargetKw_projectGoal: projectMonthlyTargetKw,
        projectPerKwCommission_projectGoal: projectPerKwCommission,
        projectTypesGoals: projectTypesGoals,
          selectedCountryIds: selectedCountryIds,
        selectedStateIds: selectedStateIds,
        selectedClusterIds: selectedClusterIds,
        selectedDistrictIds: selectedDistrictIds,
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = jsonResponse['message'] ?? 'Company user created successfully';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green),
        );
        return true;   // ✅ success
      } else {
        String errorMsg = jsonResponse['message'] ?? 'Something went wrong';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
        );
        return false;  // ❌ failure
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  var isLoadingUsers = false.obs;              // Loading state

  Future<void> getCompanyUsers() async {
    isLoadingUsers.value = true;
    try {
      http.Response response = await _apiService.getCompanyUsers(selectedDistrictIds.value,selectedPartnerIds.value,selectedProjectTypesIds.value); // you need to implement this in ApiService
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          CompanyUserResponse usersResponse = CompanyUserResponse.fromJson(jsonResponse);
          companyUsers.value = usersResponse.data;
        } else {
          print('API error: ${jsonResponse['message']}');
        }
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in getCompanyUsers: $e');
    } finally {
      isLoadingUsers.value = false;
    }
  }



  // get filter data from api
  Future<void> getCategory() async {
    try {
      http.Response response = await _apiService.getCategory();

      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        List<dynamic> data = jsonResponse['data'];
        categoryList.value = data
            .map((item) => CommonItemModel.fromJson(item))
            .toList();
        print('categoryList.value $categoryList.value');
      } else {
        print('API error: ${jsonResponse['message']}');
      }

    } catch (e) {
      print('Exception in getCategory: $e');
    }
  }


  Future<void> getSubCategory() async {

    http.Response response = await _apiService.getSubCategory(selectedCategoryIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      subCategoryList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('categoryList.value $categoryList.value');
    } else {
      print('API error: ${jsonResponse['message']}');
    }


  }


  Future<void> getProjectTypes() async {

    http.Response response = await _apiService.getProjectTypes(selectedSubCategoryIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      projectTypeList_forFilter.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('categoryList.value $categoryList.value');
    } else {
      print('API error: ${jsonResponse['message']}');
    }


  }

  Future<void> getSubProjectTypes() async {

    http.Response response = await _apiService.getSubProjectTypes(selectedProjectTypesIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      subProjectTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('categoryList.value $categoryList.value');
    } else {
      print('API error: ${jsonResponse['message']}');
    }


  }



  Future<void> getCountry() async {
    http.Response response = await _apiService.getCountry();
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      countryList_form.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('countryList_form.value ${countryList_form.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

  }


  Future<void> getState_forAddUser() async {
    http.Response response = await _apiService.getState_forAddUser(selectedcountryIds_form.value);
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      stateList_form.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('stateList_form.value ${stateList_form.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
  }




  Future<void> getCluster_forAddUser() async {
    http.Response response = await _apiService.getCluster_forAddUser(selectedStateIds_form.value);
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      clusterList_form.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('clusterList_form.value ${clusterList_form.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
  }


  Future<void> getDistrict_forAddUser() async {
    http.Response response = await _apiService.getDistrict_forAddUser(selectedStateIds_form.value,selectedClusterIds_form.value);
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      districtList_form.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('districtList_form.value ${districtList_form.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
  }


  Future<void> getState() async {
    http.Response response = await _apiService.getState();
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      stateList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('stateList.value ${stateList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

  }



  Future<void> getDistrict() async {
    http.Response response = await _apiService.getDistrict(selectedStateIds.value);
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      distrcitList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('distrcitList.value ${distrcitList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

  }









}