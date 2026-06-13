import 'dart:convert';

class DropdownModel {
  late String id;
  late String solar_experience;
  late String isActive;
  late String business_type;
  late String professional_type;
  late String project_type;


  DropdownModel({
    this.id = "",
    this.solar_experience = "",
    this.isActive = "",
    this.business_type = "",
    this.professional_type = "",
    this.project_type = "",
});


   factory DropdownModel.fromJson(Map<String, dynamic> json){
          return DropdownModel(
            id: json['id'].toString(),
            solar_experience: json['solar_experience'].toString(),
            isActive: json['isActive'].toString(),
            business_type: json['business_type'].toString(),
            professional_type: json['professional_type'].toString(),
            project_type: json['project_type'].toString(),
          );
    }

}