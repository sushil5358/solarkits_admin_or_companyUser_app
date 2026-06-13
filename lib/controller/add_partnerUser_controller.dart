import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin_app_new/models/comanItem_model.dart';
import 'package:admin_app_new/sevices/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custome_snackbar.dart';

class AddPartneruserController extends GetxController{

  final ApiService _apiService = ApiService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController adharNumberController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();

  RxBool isLoading = false.obs;
  String userId = '';

   RxString shopType = 'Office'.obs; // 'Shop' or 'Office'
   RxString hasGst = 'Yes'.obs; // 'Yes' or 'No'

  var districtList = <CommonItemModel>[].obs;
  RxString selectedDistrictIds = ''.obs;

  var industryTypeList = <CommonItemModel>[].obs;
  RxString selectedIndustryType = ''.obs;

  var professionTypeList = <CommonItemModel>[].obs;
  RxString selectedProfessionType = ''.obs;

  var shopOrOfficeList = <CommonItemModel>[].obs;
  RxString selectedShopOrOffice = ''.obs;

  var businessTypeList = <CommonItemModel>[].obs;
  RxString selectedBusinessType = ''.obs;

  var partnerTypeList = <CommonItemModel>[].obs;
  RxString selectedPartnerType = ''.obs;

  GlobalKey<FormState> fKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getId();
  }

  getId()async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    userId = sp.getString('uniqueId') ?? '';
    print('userId $userId');
    getDistrict();
    getIndustryType();
    getProfessionType();
    getBusinessType();
    getPartnerType();
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
      print('distrcitList.value $districtList.value');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }


  Future<void> getIndustryType() async {
    isLoading.value = true;
    http.Response response = await _apiService.getIndustryType();

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      industryTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('industryTypeList.value $industryTypeList');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }



  Future<void> getProfessionType() async {
    isLoading.value = true;
    http.Response response = await _apiService.getProfessionType();

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      professionTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('professionTypeList.value $professionTypeList');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }

  Future<void> getBusinessType() async {
    isLoading.value = true;
    http.Response response = await _apiService.getBusinessType();

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      businessTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('businessTypeList $businessTypeList');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }



  Future<void> getPartnerType() async {
    isLoading.value = true;
    http.Response response = await _apiService.getPartnerType(selectedBusinessType.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      partnerTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('partnerTypeList $partnerTypeList');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }



  Future<void> addPartnerUser() async{
    isLoading.value = true;
    http.Response response = await _apiService.addPartnerUser(
        name: nameController.text,
        email: emailController.text,
        number: mobileNumberController.text,
        userId: userId,
        district: selectedDistrictIds.value,
        aadharNumber: adharNumberController.text,
        industryType: selectedIndustryType.value,
        professionType: selectedProfessionType.value,
        officeOrShop: selectedShopOrOffice.value,
        hasGST: hasGst.value,
        businessType: selectedBusinessType.value,
        partnerType: selectedPartnerType.value,
        gstNumber: gstNumberController.text);

    var extractData = jsonDecode(response.body);
    debugPrint('extractData == $extractData');
    if(extractData['success'] == true){
      isLoading.value = false;
      showCustomSnackBar(Get.context!, message: extractData['message'], backgroundColor: Colors.green);
      Get.back();

    }else{

      showCustomSnackBar(Get.context!, message: extractData['message'], backgroundColor: Colors.red);

    }





    isLoading.value = false;

  }






}