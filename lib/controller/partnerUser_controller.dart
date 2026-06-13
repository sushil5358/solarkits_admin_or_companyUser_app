import 'dart:convert';

import 'package:admin_app_new/models/comanItem_model.dart';
import 'package:admin_app_new/sevices/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/partner_model.dart';

class PartnerUserController extends GetxController{
  final ApiService _apiService = ApiService();

  var partnerList = <PartnerUserModel>[].obs;
  String _userId = '';
  RxBool isLoading = false.obs;

  var partnerTypeList = <CommonItemModel>[].obs;
  RxString selectedPartnerTypeId = ''.obs;

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

    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getId();
  }

  void getId()async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      _userId = sp.getString('uniqueId') ?? '';
      getPartners();
      getPartnerType();

  }



  Future<void> getPartners() async {
    isLoading.value = true;
    http.Response response = await _apiService.getPartners(_userId, selectedDistrictId.value, selectedCategoryId.value, selectedSubCategoryId.value, selectedProjectTypeId.value, selectedSubProjectTypeId.value, selectedPartnerTypeId.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      partnerList.value = data
          .map((item) => PartnerUserModel.fromJson(item))
          .toList();

    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }

  Future<void> getPartnerType() async {
    isLoading.value = true;
    http.Response response = await _apiService.getPartnerType('');

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');

      partnerTypeList.value = [
        CommonItemModel(id: '', name: 'All'),
          ...data.map((item) => CommonItemModel.fromJson(item)).toList(),
      ];

    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }






}