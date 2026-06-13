import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/comman_model.dart';
import '../models/user_model.dart';
import '../screens/error_401.dart';
import '../sevices/api_services.dart';

class CustomerUsersController extends GetxController{


  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLoginTypes();
    getusers();
    print("on init user screen");
  }




  ApiService apiService = ApiService();
  var loginType = <Common_Model>[].obs;
  // var users = <UserModel>[].obs;
  RxString selectedlogintype = "".obs;
  RxString  selectedDistrict= "".obs;
  var refreshKey = 0.obs;

  void refreshUsers() {
    refreshKey.value++; // Increment key to trigger FutureBuilder rebuild
  }









  Future<void> getLoginTypes () async{
    http.Response response = await  apiService.getLoginType();
    if(response.statusCode == 200){
      var extractdata = jsonDecode(response.body);
      print("extractdata $extractdata");
      if(extractdata['ack'] == 1 || extractdata['ack'] == "1"){

        loginType.value = [
          Common_Model(id: "0",name: "All"),
          ...List<Common_Model>.from(
            extractdata['result'].map((e)=> Common_Model.fromJson(e))
        ),];

        selectedlogintype.value = loginType.value.first.name;

      }else{
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(extractdata['ack_msg']))
        );
      }

    }else{
      if(response.statusCode == 401 || response.statusCode == 403){
        Get.to(()=>UnauthorizedScreen());
      }

    }
  }



  Future<List<UserModel>> getusers() async{
    http.Response response= await apiService.getCustomerUsers(selectedlogintype.value == "All" ? "" :selectedlogintype.value, selectedDistrict.value,"");
    if(response.statusCode == 200){
      var extractdata = jsonDecode(response.body);
      print("extractdata $extractdata");
      if(extractdata['ack'] == 1 || extractdata['ack'] == "1")
      {
        List allusers = extractdata['result'];
       List<UserModel> users = List<UserModel>.from(allusers.map((e) => UserModel.fromJson(e),));
       print("all uers $users");
       print("users  $users");
        return users;


      }else{
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
            SnackBar(
                backgroundColor: Colors.red,
                content: Text(extractdata['ack_msg']))
        );
        return [];

      }

    }else{
      print("error in statuscode");
      return [];

    }


  }



}