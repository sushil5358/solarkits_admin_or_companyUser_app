import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/lead_model.dart';
import '../models/project_model.dart';
import '../models/quote_model.dart';
import '../sevices/api_services.dart';

class UserDetailController extends GetxController{

 ApiService apiService = ApiService();
 var leads = <LeadModel>[].obs;
 var quoteList = <QuotationModel>[].obs;
 var projectList = <ProjectModel>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  Future<void> getLeads(String userId) async{
    http.Response response = await apiService.getuserLeads(userId);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      print("data $data");
      if(data["ack"] == 1 || data["ack"] == '1'){

        List allleads = data['customers'] as List;
       leads.value =  List<LeadModel>.from(
           allleads.map((e) => LeadModel.fromJson(e),)
        );

      }else{
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(data['message'])));

      }

    }else{
      print("Error statuscode = ${response.statusCode}");

    }
  }



  Future<void> getquote(String userId) async{
    http.Response response = await apiService.getUserQuotataions(userId);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      if(data["ack"] == 1 || data["ack"] == '1'){
       List quote = data['result'] as List;

       quoteList.value =  List<QuotationModel>.from(quote.map((e) => QuotationModel.fromJson(e),));

      }else{
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(data['message'])));

      }

    }else{
      print("error statuscode ${response.statusCode}");
    }
  }


  Future<void> getprojects(String userId) async {
    http.Response response = await apiService.getUsersProjects(userId);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      if(data["ack"] == 1 || data["ack"] == '1'){
        List project = data['result'] as List;
        projectList.value = List<ProjectModel>.from(project.map((e) => ProjectModel.fromJson(e),) );



      }else{
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(data['message'])));

      }

    }else{
      print("Error in statuscode ${response.statusCode}");
    }
  }





}