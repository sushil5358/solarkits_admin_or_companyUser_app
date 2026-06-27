import 'dart:convert';

import 'package:admin_app_new/models/project_order_model.dart';
import 'package:admin_app_new/sevices/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../custome_snackbar.dart';
import '../models/comanItem_model.dart';

class ProjectOrderCuController  extends GetxController{

  final ApiService _apiService = ApiService();

  var districtList = <CommonItemModel>[].obs;
  RxString selectedDistrictId = ''.obs;

  var categoryList = <CommonItemModel>[].obs;
  RxString selectedCategoryId = ''.obs;

  var subCategoryList = <CommonItemModel>[].obs;
  RxString selectedSubCategoryId = ''.obs;

  var projectTypeList = <CommonItemModel>[].obs;
  RxString selectedProjectTypeId = ''.obs;

  var subProjectTypeList = <CommonItemModel>[].obs;
  RxString selectedSubProjectTypeId = ''.obs;

  var myOrderList = <ProjectOrderModel>[].obs;
  RxBool isLoading = false.obs;
  String userId = '';

  @override
  void onInit() {
    super.onInit();
    getId();
  }


  Future<void> getId()async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    userId = sp.getString('uniqueId') ?? '';
    print('userId = $userId');
    getMyOrders();

  }


  Future<void> getDistrict() async {
    isLoading.value = true;
    http.Response response = await _apiService.getDistrict_ForAddQuote(userId);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      districtList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('districtsList.value $districtList');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }

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

    http.Response response = await _apiService.getSubCategory(selectedCategoryId.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      subCategoryList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('categoryList.value $categoryList');
    } else {
      print('API error: ${jsonResponse['message']}');
    }


  }

  Future<void> getProjectTypes() async {

    http.Response response = await _apiService.getProjectTypes(selectedSubCategoryId.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      projectTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('projectTypeList.value $projectTypeList');
    } else {
      print('API error: ${jsonResponse['message']}');
    }


  }

  Future<void> getSubProjectTypes() async {

    http.Response response = await _apiService.getSubProjectTypes(selectedProjectTypeId.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      subProjectTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('subProjectTypeList.value $subProjectTypeList');
    } else {
      print('API error: ${jsonResponse['message']}');
    }


  }




  Future<void> getMyOrders() async{
    isLoading.value = true;
    http.Response response = await _apiService.getMyProjectOrdersCompanyUser(userId, selectedDistrictId.value, selectedCategoryId.value, selectedSubCategoryId.value, selectedProjectTypeId.value, selectedSubProjectTypeId.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['orders'];
      print('data $data');
      myOrderList.value = data.map((item) => ProjectOrderModel.fromJson(item)).toList();
      isLoading.value = false;

      print('myOrderList.value $myOrderList');
    } else {
      showCustomSnackBar(Get.context!, message: jsonResponse['message'], backgroundColor: Colors.red);

      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;
  }



}