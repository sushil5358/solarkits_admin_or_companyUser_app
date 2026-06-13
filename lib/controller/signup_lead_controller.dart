// import 'dart:convert';
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../models/dropdown_model.dart';
// import '../models/user_model.dart';
// import '../sevices/api_services.dart';
//
// class SignupLeadController extends GetxController{
//   ApiService apiService = ApiService();
//   RxList experienceList = <DropdownModel>[].obs;
//   RxList businessList = <DropdownModel>[].obs;
//   RxList professionList = <DropdownModel>[].obs;
//   RxList newUsers = <UserModel>[].obs;
//   RxString selectedLoginType = "".obs;
//   RxString selectedDistrict = "".obs;
//   RxString selectedStatusType = "3".obs;
//   // 3 for new lead
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     print("signup on init controller");
//     getexperince();
//     getbusinesstype();
//     getProfessionType();
//   }
//
//
//
//
//
//
//
//
//   Future<List<UserModel>> getSignupLeads() async{
//     http.Response response= await apiService.getCustomerUsers(selectedLoginType.value, selectedDistrict.value,selectedStatusType.value);
//     if(response.statusCode == 200){
//       var extractdata = jsonDecode(response.body);
//       print("extractdata $extractdata");
//       if(extractdata['ack'] == 1 || extractdata['ack'] == "1")
//       {
//         List allusers = extractdata['result'];
//         List<UserModel> allnewusers = List<UserModel>.from(allusers.map((e) => UserModel.fromJson(e),));
//         print("all uers $newUsers");
//         return allnewusers;
//
//
//
//
//       }else{
//         ScaffoldMessenger.of(Get.context!).showSnackBar(
//             snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
//             SnackBar(
//                 backgroundColor: Colors.red,
//                 content: Text(extractdata['ack_msg']))
//         );
//         return [];
//
//
//       }
//
//     }else{
//       print("error in statuscode ${response.statusCode}");
//
//     return [];
//     }
//
//   }
//
//
//   Future<void> getexperince()async{
//     http.Response response = await apiService.getsolarExperince();
//     if(response.statusCode == 200){
//       var data = jsonDecode(response.body);
//       if(data['ack'] == 1 || data['ack'] == '1'){
//        List alldata =  data['result'] as List;
//        print("data $alldata");
//       List<DropdownModel> exeperince =  List<DropdownModel>.from(alldata.map((e) => DropdownModel.fromJson(e),));
//
//        experienceList.value = exeperince.where((e) {
//         return  e.isActive == "1";
//       },).toList();
//
//       }else{
//         ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(data['ack_msg'])));
//
//       }
//     }else{
//       print("Error in statuscode ${response.statusCode}");
//     }
//
//   }
//
//
//   Future<void> getbusinesstype()async{
//     http.Response response = await apiService.getbusinessType();
//     if(response.statusCode == 200){
//       var data = jsonDecode(response.body);
//       if(data['ack'] == 1 || data['ack'] == '1'){
//         List alldata =  data['result'] as List;
//         print("data $alldata");
//         List<DropdownModel> profesionlist =  List<DropdownModel>.from(alldata.map((e) => DropdownModel.fromJson(e),));
//
//         businessList.value = profesionlist.where((e) {
//           return  e.isActive == "1";
//         },).toList();
//
//       }else{
//         ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(data['ack_msg'])));
//
//       }
//     }else{
//       print("Error in statuscode ${response.statusCode}");
//     }
//   }
//
//
//
//   Future<void> getProfessionType()async{
//     http.Response response = await apiService.getProfesionType();
//     if(response.statusCode == 200){
//       var data = jsonDecode(response.body);
//       if(data['ack'] == 1 || data['ack'] == '1'){
//         List alldata =  data['result'] as List;
//         print("data $alldata");
//         List<DropdownModel> profesionlist =  List<DropdownModel>.from(alldata.map((e) => DropdownModel.fromJson(e),));
//
//         professionList.value = profesionlist.where((e) {
//           return  e.isActive == "1";
//         },).toList();
//
//       }else{
//
//         ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(data['ack_msg'])));
//
//       }
//     }else{
//       print("Error in statuscode ${response.statusCode}");
//     }
//   }
//
//
// }