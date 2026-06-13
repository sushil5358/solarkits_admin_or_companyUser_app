import 'dart:convert';

import 'package:admin_app_new/screens/home_page.dart';
import 'package:admin_app_new/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../custome_snackbar.dart';
import '../screens/dashbord_screen.dart';
import '../sevices/api_services.dart';
class LoginController extends GetxController{
  ApiService apiServices = ApiService();
  TextEditingController mobileController = TextEditingController();

  String userId = '';


  Future<void> loginWithNumber()async{
    http.Response response;
     response = await  apiServices.loginWithNUmber(mobileController.text);
     

       var extractData = jsonDecode(response.body);
       if(extractData['success'] == true || extractData['success'] == 'true'){
         print('extractData $extractData');
         showCustomSnackBar(Get.context!, message: extractData['message'], backgroundColor: Colors.green);
         userId = extractData['user']['_id'];
         print('userId $userId');
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('uniqueId', userId);
        sp.setBool('isLoggedIn', true);
         Get.to(()=>DashboardScreen());

       }else{
         showCustomSnackBar(Get.context!, message: extractData['message'], backgroundColor: Colors.red);
       }
       
       



  }

}