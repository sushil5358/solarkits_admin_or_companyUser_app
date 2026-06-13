// To parse this JSON data, do
//
//     final leadModel = leadModelFromJson(jsonString);

import 'dart:convert';

LeadModel leadModelFromJson(String str) => LeadModel.fromJson(json.decode(str));

String leadModelToJson(LeadModel data) => json.encode(data.toJson());

class LeadModel {
  String id;
  // String lead_no;
  String name;
  String phone;
  String mobile3;
  String address;
  String email;
  String channelParnter;
  String electricityBillPayment;
  String kilowart;
  String createdDate;
  String districtId;
  String city;
  String leadType;
  String subLeadType;
  String districtName;
  String cityName;
  String leadTypeName;
  String leadSubTypeName;
  String leadStatusName;
  String leadStatusColor;
  String leadSourceType;
  // String leadAttechment;
  // bool is_project_signup;
  String reg_no;
  String created_date;

  LeadModel({
    required this.id,
    // required this.lead_no,
    required this.name,
    required this.phone,
    required this.mobile3,
    required this.address,
    required this.email,
    required this.channelParnter,
    required this.electricityBillPayment,
    required this.kilowart,
    required this.createdDate,
    required this.districtId,
    required this.city,
    required this.leadType,
    required this.subLeadType,
    required this.districtName,
    required this.cityName,
    required this.leadTypeName,
    required this.leadSubTypeName,
    required this.leadStatusName,
    required this.leadStatusColor,
    required this.leadSourceType,
    // required this.leadAttechment,
    // required this.is_project_signup,
    required this.reg_no,
    required this.created_date,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) => LeadModel(
    id: json["id"].toString(),
    // lead_no: json["lead_no"].toString(),
    name: json["name"].toString(),
    phone: json["phone"].toString(),
    mobile3: json["mobile3"].toString(),
    address: json["address"].toString(),
    email: json["email"].toString(),
    channelParnter: json["channel_parnter"].toString(),
    electricityBillPayment: json["electricity_bill_payment"].toString(),
    kilowart: json["kilowart"].toString(),
    createdDate: json["date"].toString(),
    districtId: json["district_id"].toString(),
    city: json["city"].toString(),
    leadType: json["lead_type"].toString(),
    subLeadType: json["sub_lead_type"].toString(),
    districtName: json["district_name"].toString(),
    cityName: json["city_name"].toString(),
    leadTypeName: json["lead_type_name"].toString(),
    leadSubTypeName: json["lead_sub_type_name"].toString(),
    leadStatusName: json["lead_status_name"].toString(),
    leadStatusColor: json["lead_status_color_code"].toString(),
    leadSourceType:
    (json["lead_source_type"] == null) ? "" : json["lead_source_type"],
    // leadAttechment: json["lead_attachment"],
    // is_project_signup: json["is_project_signup"],
    reg_no: json['reg_no'].toString(),
    created_date: json['created_date'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    // "lead_no": lead_no,
    "name": name,
    "phone": phone,
    "mobile3": mobile3,
    "address": address,
    "email": email,
    "channel_parnter": channelParnter,
    "electricity_bill_payment": electricityBillPayment,
    "kilowart": kilowart,
    "date": createdDate,
    "district_id": districtId,
    "city": city,
    "lead_type": leadType,
    "sub_lead_type": subLeadType,
    "district_name": districtName,
    "city_name": cityName,
    "lead_type_name": leadTypeName,
    "lead_sub_type_name": leadSubTypeName,
    "lead_status_name": leadStatusName,
    "lead_status_color_code": leadStatusColor,
    "lead_source_type": leadSourceType,
    // "lead_attachment": leadAttechment,
    // "is_project_signup": is_project_signup,
    "reg_no" : reg_no,
    "created_date" : created_date,

  };
}
