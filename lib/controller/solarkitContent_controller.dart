import 'dart:convert';

import 'package:admin_app_new/sevices/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/comanItem_model.dart';

class SolarkitcontentController  extends GetxController{
  ApiService _apiService = ApiService();


  var categoryList = <CommonItemModel>[].obs;
  RxString selectedCategoryIds = ''.obs;

  var subCategoryList = [].obs;
  RxString selectedSubCategoryIds = ''.obs;

  var projectTypeList = [].obs;
  RxString selectedProjectTypesIds = ''.obs;

  var subProjectTypeList = [].obs;
  RxString subProjectTypeIds = ''.obs;

  String userId = '';



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getId();
  }

  getId()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    userId = await sp.getString('uniqueId') ?? '';
    getCategory();


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

    http.Response response = await _apiService.getProjectTypes(selectedCategoryIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      projectTypeList.value = data
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






}