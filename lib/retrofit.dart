import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'custome_snackbar.dart';



//notification send from firebase - app.craftbox@gmail.com
///LOCAL LINK
///LOCAL LINK
// String url = "http://192.168.1.18:81/sunnovative/service/";
// String url = "http://192.168.1.18:81/2025/solarbox/service/";
// String url = "http://192.168.1.32:81//solarbox/service/";

String key = '1226';

///LIVE LINK 06-3-2024

//new server link 23-08-2024
// String url = "https://crm.solakits.in/service/";

// 15-10-2024 live clone
// String url = "https://test.solakits.in/service/";


// working links

// String url ="https://crm.sunnovativecrm.com/service/";



String url = "https://test.sunnovativecrm.com/service/";
// String url = "http://192.168.1.31:81/test.solakits.in/service/";
// String url = "http://192.168.1.19:81/test.solakits.in/service/";
// String url = "http://192.168.1.17:81/test.solakits.in/service/";

// http://192.168.1.25:81/test.solakits.in/

//http://192.168.1.232/solarbox/service/channel_partner_agreement.php?channel_partner_id=3






Uri agreementLink(String channelPartnerId, String date, String cp_name,
    String cp_adress, String type) {
  var uri = Uri.parse(url +
      "channel_partner_agreement.php?channel_partner_id=$channelPartnerId&date=$date&name=$cp_name&address=$cp_adress&type=$type");
  print("agreeement uri : $uri");
  return uri;
}


Future<http.Response> comboOrders(String baseurl) async{
  var uri = Uri.parse( url + baseurl);
  print("orderd combos  " + uri.toString());
  http.Response response = await http.get(uri);
  return response;
}

//register
//192.168.1.232/solarbox/service/service_sr_user.php?key=1226&s=59&name=Dinesh&phone=8488032287
Future<http.Response> register(String name, String Mobile_no) async {
  var uri = Uri.parse( url + "service_sr_user.php?key=$key&s=59&name=$name&phone=$Mobile_no");
  print("register  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_user_rights.php?key=1226&s=119&application_login_id=78
Future<http.Response> GetRights(
    String application_login_id, String cp_id) async {
  var uri = Uri.parse(//
      url +
          "service_sr_user_rights.php?key=$key&s=119&application_login_id=$application_login_id&cp_id=$cp_id");
  print("GetRights :  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

//otp verification
//http://192.168.1.232/solarbox/service/service_sr_user.php?key=1226&s=60&otp=606112&phone=8488032287
Future<http.Response> VerifyOTP(
    String otp, String phone, String api_call_from) async {
  var uri = Uri.parse(url +
      "service_sr_user.php?key=$key&s=60&otp=$otp&phone=$phone&api_call_from=$api_call_from");
  print("VerifyOTP  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//resend otp
//http://192.168.1.232/solarbox/service/service_sr_user.php?key=1226&s=61&phone=9408589442
Future<http.Response> ResendOTP(String phone, String deviceUniqueId) async {
  var uri = Uri.parse(url +
      "service_sr_user.php?key=$key&s=61&phone=$phone&device_unique_id=$deviceUniqueId");
  print("ResendOTP  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//add apply for cp
//http://192.168.1.232/solarbox/service/service_sr_user.php?key=1226&s=63&sign_agreement_id&id=1&state_id=1&district_id=1&city_id=1&whatsapp_number=8488032287&type_of_company_id=1&profession_id=1&active_customer_id=1&residential_customer_id=1&type_of_solar_customer=1&installation_team_id=1&channel_partner_security_deposit_id=1&sign_agreement_id=1
Future<http.Response> ApplyForCp(
    String cp_id,
    String pincode,
    String state_id,
    String district_id,
    String city_id,
    String whatsapp_number,
    String village_name,
    String email,
    String adharcard_no,
    String pancard_no,
    String type_of_company_id,
    String profession_id,
    String customerActivate_id,
    String residentialCustomer_id,
    String solarCustomer_type_id,
    String installation_team_id,
    String chennal_partner_id,
    String sign_agreement_id,
    String nameAsperAadhar,
    String gstNo,
    String companyName,
    ) async {
  var uri = Uri.parse(url +
      "service_sr_user.php?key=$key&s=63&id=$cp_id&pincode=$pincode&state_id=$state_id&district_id=$district_id&city_id=$city_id&whatsapp_number=$whatsapp_number&village_name=$village_name&email=$email&adharcard_number=$adharcard_no&pan_card_number=$pancard_no&type_of_company_id=$type_of_company_id&profession_id=$profession_id&active_customer_id=$customerActivate_id&residential_customer_id=$residentialCustomer_id&type_of_solar_customer=$solarCustomer_type_id&installation_team_id=$installation_team_id&channel_partner_security_deposit_id=$chennal_partner_id&channel_partner_security_deposit_id=$chennal_partner_id&sign_agreement_id=$sign_agreement_id&name=$nameAsperAadhar&gst=$gstNo&company_name=$companyName");
  print("ApplyForCp  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

///GET STATE
//http://192.168.1.232/club_honest/service/service_general.php?key=1226&s=44
Future<http.Response> GetState(String cp_id) async {
  var uri =
  Uri.parse(url + "service_sr_general.php?key=$key&s=44&cp_id=$cp_id");
  print("GetState  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=58&pincode=302555
Future<http.Response> GetPincodeWiseData(String pincode) async {
  var uri =
  Uri.parse(url + "service_sr_general.php?key=$key&s=58&pincode=$pincode");
  print("GetPincodeWiseData  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

///GET CITY
//http:/192.168.1.232/club_honest/service/service_general.php?key=1226&s=45
Future<http.Response> GetCity(String district_id, String cp_id) async {

  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=45&district_id=$district_id&cp_id=$cp_id");
  print("GetCity  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

///GET District
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=57&state_id=45
Future<http.Response> GetDistrict(String state_id, String cp_id) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=57&state_id=$state_id&cp_id=$cp_id");
  print("GetDistrict  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

///GET District
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=57&state_id=45
Future<http.Response> GetKycDistrict(String cp_id) async {
  var uri =
  Uri.parse(url + "service_sr_general.php?key=$key&s=57&cp_id=$cp_id");
  print("GetKycDistrict " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//get CompanyType
Future<http.Response> GetCompanyType() async {
  var uri = Uri.parse(url + "service_sr_general.php?key=$key&s=53");
  print("GetCompanyType  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//get profession
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=55
Future<http.Response> GetProfessionType() async {
  var uri = Uri.parse(url + "service_sr_general.php?key=$key&s=55");
  print("GetProfessionType  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=24&channel_partner_id=1&document_type_id=2
Future<bool> AddKyc(String channel_partner_id, String document_type_id,
    File image_file, String inserted_id) async {
  try {
    var uri = Uri.parse(url +
        "service_sr_general.php?key=$key&s=24&channel_partner_id=$channel_partner_id&document_type_id=$document_type_id&inserted_id=$inserted_id");
    print("AddKyc  " + uri.toString());
    var stream = http.ByteStream(Stream.castFrom(image_file.openRead()));
    var length = await image_file.length();
    var request = http.MultipartRequest('POST', uri);
    var multipartFile = http.MultipartFile("attachment", stream, length,
        filename: image_file.path.split("/").last);

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("KYC Inserted Successfully");
      return true;
    } else {
      print("Failed to insert KYC. Status code: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Error during KYC insertion: $e");
    return false;
  }
}

//kyc submit
Future<http.Response> kycSubmit(
    String channel_partner_id, String document_type_id, String flag) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=24&channel_partner_id=$channel_partner_id&document_type_id=$document_type_id&kyc_submit=$flag");
  print("kycSubmit  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=120&application_login=33
Future<http.Response> GetKyc(String cp_id) async {
  var uri = Uri.parse(url + "service_sr_lead.php?key=$key&s=120&cp_id=$cp_id");

  print("GetKyc " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//get user_type
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=66
Future<http.Response> GetUserType() async {
  var uri = Uri.parse(url + "service_sr_general.php?key=$key&s=66");
  print("GetUserType  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//solar product
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=56
Future<http.Response> GetProduct() async {
  var uri = Uri.parse(url + "service_sr_general.php?key=$key&s=56");
  print("GetProduct  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//solar projects
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=72
Future<http.Response> GetProject() async {
  var uri = Uri.parse(url + "service_sr_general.php?key=$key&s=72");
  print("GetProject  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}
//add user
/*service_sr_general.php?key=1226&s=67&user_profile_photo=&name=&email=&phone=&whatsapp_no=&type=&aadhar_card_no=&pan_no=
&leads_create=&leads_edit=&leads_delete=
&survey_create=&survey_edit=&survey_delete=
&projects_create=&projects_edit=&projects_delete=
&quotation_create=&quotation_edit=&quotation_delete=
&service_create=&service_edit=&service_delete=
&installer_create=&installer_edit=&installer_delete=
&loans_create=&loans_edit=&loans_delete=
&delivery_track=*/

Future<bool> AddUser(
    String user_id,
    File image_file,
    String name,
    String email,
    String phone,
    String whatsapp_no,
    String type,
    String aadhar_card_no,
    String pan_no,
    String leads_create,
    String leads_edit,
    String leads_delete,
    String survey_create,
    String survey_edit,
    String survey_delete,
    String projects_create,
    String projects_edit,
    String projects_delete,
    String quotation_create,
    String quotation_edit,
    String quotation_delete,
    String service_create,
    String service_edit,
    String service_delete,
    String installer_create,
    String installer_edit,
    String installer_delete,
    String loans_create,
    String loans_edit,
    String loans_delete,
    String delivery_track) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=67&application_login_id=$user_id&name=$name&email=$email&phone=$phone&whatsapp_no=$whatsapp_no&type=$type&aadhar_card_no=$aadhar_card_no&pan_no=$pan_no&leads_create=$leads_create&leads_edit=$leads_edit&leads_delete=$leads_delete&survey_create=$survey_create&survey_edit=$survey_edit&survey_delete=$survey_delete&projects_create=$projects_create&projects_edit=$projects_edit&projects_delete=$projects_delete&quotation_create=$quotation_create&quotation_edit=$quotation_edit&quotation_delete=$quotation_delete&service_create=$service_create&service_edit=$service_edit&service_delete=$service_delete&installer_create=$installer_create&installer_edit=$installer_edit&installer_delete=$installer_delete&loans_create=$loans_create&loans_edit=$loans_edit&loans_delete=$loans_delete&delivery_track=$delivery_track");
  print("AddUser  " + uri.toString());

  var stream = http.ByteStream(Stream.castFrom(image_file.openRead()));
  var length = await image_file.length();

  var request = http.MultipartRequest('POST', uri);

  var multipartFile = http.MultipartFile("user_profile_photo", stream, length,
      filename: image_file.path.split("/").last);
  print(multipartFile);
  print("multipartfileeee");
  print("IMG ${multipartFile.filename}");

  request.files.add(multipartFile);

  try {
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print("Response Body: $responseBody");

    if (response.statusCode == 200) {
      // Parse and handle the response body here
      var jsonResponse = jsonDecode(responseBody); // Assuming JSON response
      if (jsonResponse['ack'] == 1) {
        print("User added successfully");
        return true;
      } else {
        print("Failed to add user: ${jsonResponse['ack_msg']}");
        showCustomSnackBar(
          Get.context!,
          message: jsonResponse['ack_msg'],
          backgroundColor: Colors.red,
        );
        return false;
      }
    } else {
      print("Error: ${response.reasonPhrase}");
      return false;
    }
  } catch (e) {
    print("Exception caught: $e");
    return false;
  }
}

Future<http.Response> AddUserWithoutImage(
    String user_id,
    String name,
    String email,
    String phone,
    String whatsapp_no,
    String type,
    String aadhar_card_no,
    String pan_no,
    String leads_create,
    String leads_edit,
    String leads_delete,
    String survey_create,
    String survey_edit,
    String survey_delete,
    String projects_create,
    String projects_edit,
    String projects_delete,
    String quotation_create,
    String quotation_edit,
    String quotation_delete,
    String service_create,
    String service_edit,
    String service_delete,
    String installer_create,
    String installer_edit,
    String installer_delete,
    String loans_create,
    String loans_edit,
    String loans_delete,
    String delivery_track) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=67&application_login_id=$user_id&name=$name&email=$email&phone=$phone&whatsapp_no=$whatsapp_no&type=$type&aadhar_card_no=$aadhar_card_no&pan_no=$pan_no&leads_create=$leads_create&leads_edit=$leads_edit&leads_delete=$leads_delete&survey_create=$survey_create&survey_edit=$survey_edit&survey_delete=$survey_delete&projects_create=$projects_create&projects_edit=$projects_edit&projects_delete=$projects_delete&quotation_create=$quotation_create&quotation_edit=$quotation_edit&quotation_delete=$quotation_delete&service_create=$service_create&service_edit=$service_edit&service_delete=$service_delete&installer_create=$installer_create&installer_edit=$installer_edit&installer_delete=$installer_delete&loans_create=$loans_create&loans_edit=$loans_edit&loans_delete=$loans_delete&delivery_track=$delivery_track");
  print("AddUserWithoutImage  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> EditUserWithoutImage(
    String user_id,
    String id,
    String name,
    String email,
    String phone,
    String whatsapp_no,
    String type,
    String aadhar_card_no,
    String pan_no,
    String leads_create,
    String leads_edit,
    String leads_delete,
    String survey_create,
    String survey_edit,
    String survey_delete,
    String projects_create,
    String projects_edit,
    String projects_delete,
    String quotation_create,
    String quotation_edit,
    String quotation_delete,
    String service_create,
    String service_edit,
    String service_delete,
    String installer_create,
    String installer_edit,
    String installer_delete,
    String loans_create,
    String loans_edit,
    String loans_delete,
    String delivery_track) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=67&application_login_id=$user_id&id=$id&name=$name&email=$email&phone=$phone&whatsapp_no=$whatsapp_no&type=$type&aadhar_card_no=$aadhar_card_no&pan_no=$pan_no&leads_create=$leads_create&leads_edit=$leads_edit&leads_delete=$leads_delete&survey_create=$survey_create&survey_edit=$survey_edit&survey_delete=$survey_delete&projects_create=$projects_create&projects_edit=$projects_edit&projects_delete=$projects_delete&quotation_create=$quotation_create&quotation_edit=$quotation_edit&quotation_delete=$quotation_delete&service_create=$service_create&service_edit=$service_edit&service_delete=$service_delete&installer_create=$installer_create&installer_edit=$installer_edit&installer_delete=$installer_delete&loans_create=$loans_create&loans_edit=$loans_edit&loans_delete=$loans_delete&delivery_track=$delivery_track");
  print("EditUserWithoutImage  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<bool> EditUserwithImage(
    String user_id,
    String id,
    File image_file,
    String name,
    String email,
    String phone,
    String whatsapp_no,
    String type,
    String aadhar_card_no,
    String pan_no,
    String leads_create,
    String leads_edit,
    String leads_delete,
    String survey_create,
    String survey_edit,
    String survey_delete,
    String projects_create,
    String projects_edit,
    String projects_delete,
    String quotation_create,
    String quotation_edit,
    String quotation_delete,
    String service_create,
    String service_edit,
    String service_delete,
    String installer_create,
    String installer_edit,
    String installer_delete,
    String loans_create,
    String loans_edit,
    String loans_delete,
    String delivery_track) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=67&application_login_id=$user_id&id=$id&name=$name&email=$email&phone=$phone&whatsapp_no=$whatsapp_no&type=$type&aadhar_card_no=$aadhar_card_no&pan_no=$pan_no&leads_create=$leads_create&leads_edit=$leads_edit&leads_delete=$leads_delete&survey_create=$survey_create&survey_edit=$survey_edit&survey_delete=$survey_delete&projects_create=$projects_create&projects_edit=$projects_edit&projects_delete=$projects_delete&quotation_create=$quotation_create&quotation_edit=$quotation_edit&quotation_delete=$quotation_delete&service_create=$service_create&service_edit=$service_edit&service_delete=$service_delete&installer_create=$installer_create&installer_edit=$installer_edit&installer_delete=$installer_delete&loans_create=$loans_create&loans_edit=$loans_edit&loans_delete=$loans_delete&delivery_track=$delivery_track");
  print("EditUserwithImage  " + uri.toString());

  var stream = http.ByteStream(Stream.castFrom(image_file.openRead()));
  var length = await image_file.length();

  var request = http.MultipartRequest('POST', uri);

  var multipartFile = http.MultipartFile("user_profile_photo", stream, length,
      filename: image_file.path.split("/").last);
  print(multipartFile);
  print("multipartfileeee");
  print(multipartFile.filename);

  request.files.add(multipartFile);

  var response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

//all user get
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=68&user_id=14&id=&ll=10&ul=0
Future<http.Response> GetAllUsersData(
    String user_id, String id, int ul, int ll) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=68&application_login_id=$user_id&id=$id&ll=$ul&ul=$ll");
  print("GetAllUsersData  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetAllUsersDataLead(String user_id, String id) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=68&application_login_id=$user_id&id=$id");
  print("GetAllUsersDataLead  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//get one user data
////http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=68&user_id=14&id=
Future<http.Response> GetOneUsersData(String user_id, String id) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=68&application_login_id=$user_id&id=$id");
  print("GetOneUsersData  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// rights
//http://192.168.1.232/club_honest/service/service_general.php?key=1226&s=51&type=1
Future<http.Response> GetAllRights(String user_id, String type) async {
  var uri = Uri.parse(
      url + "service_general.php?key=$key&s=51&user_id=$user_id&type=$type");
  print("GetAllRights  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//get profile
//http://192.168.1.232/solarbox/service/service_sr_user.php?key=1226&s=69&application_login_id=8
Future<http.Response> GetProfile(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_user.php?key=$key&s=69&application_login_id=$application_login_id");
  print("GetProfile  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//add enterprice(company kyc)
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=70&person_name=Dinesh&mobile_no=6546546546&email=dj@gmai.com&business_type=1&turn_over=40000&remark=dinesh&channel_partner_id=5
Future<http.Response> AddEnterPrise(
    String channel_partner_id,
    String person_name,
    String mobile_no,
    String email,
    String business_type,
    String turn_over,
    String amountAndBank) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=70&channel_partner_id=$channel_partner_id&person_name=$person_name&mobile_no=$mobile_no&email=$email&business_type=$business_type&turn_over=$turn_over&remark=$amountAndBank");
  print("AddEnterPrise  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//add payment
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=71&reference_no=DIN-001&date=05-01-2024&sn_amount=40000&sd_amount=5000&login_id=21
Future<bool> AddPayment(
    String user_id,
    String reference_no,
    String date,
    String sn_amount,
    File attachment,
    File cheque_photo,
    String sd_bank_name,
    sd_cheque_no,
    String sd_amount) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=71&login_id=$user_id&reference_no=$reference_no&date=$date&sn_amount=$sn_amount&sd_bank_name=$sd_bank_name&sd_cheque_no=$sd_cheque_no&sd_amount=$sd_amount");
  print("AddPayment  " + uri.toString());

  /* var stream = http.ByteStream(Stream.castFrom(attachment.openRead()));
  var length = await attachment.length();

  var request = http.MultipartRequest('POST', uri);

  var multipartFile = http.MultipartFile("attachment", stream, length,
      filename: attachment.path.split("/").last);
  print(multipartFile);
  print("multipartfileeee");
  print(multipartFile.filename);

  request.files.add(multipartFile);*/
  // Add image file
  var request = http.MultipartRequest('POST', uri);
  var imageStream = http.ByteStream(Stream.castFrom(attachment.openRead()));
  var imageLength = await attachment.length();
  var imageMultipartFile = http.MultipartFile(
    "attachment", // Use "attachment" as the key for the image file
    imageStream,
    imageLength,
    filename: attachment.path.split("/").last,
  );
  request.files.add(imageMultipartFile);

  // Add PDF file
  var pdfStream = http.ByteStream(Stream.castFrom(cheque_photo.openRead()));
  var pdfLength = await cheque_photo.length();
  var pdfMultipartFile = http.MultipartFile(
    "cheque_attachment", // Use "pdf_attachment" as the key for the PDF file
    pdfStream,
    pdfLength,
    filename: cheque_photo.path.split("/").last,
  );
  request.files.add(pdfMultipartFile);

  print("multipart files:");
  for (var file in request.files) {
    print(file.filename);
  }

  var response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> AddPaymentWithoutIMG(String user_id, File cheque_photo,
    String sd_bank_name, sd_cheque_no, String sd_amount) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=71&login_id=$user_id&sd_bank_name=$sd_bank_name&sd_cheque_no=$sd_cheque_no&sd_amount=$sd_amount");
  print("AddPayment  " + uri.toString());

  /* var stream = http.ByteStream(Stream.castFrom(attachment.openRead()));
  var length = await attachment.length();

  var request = http.MultipartRequest('POST', uri);

  var multipartFile = http.MultipartFile("attachment", stream, length,
      filename: attachment.path.split("/").last);
  print(multipartFile);
  print("multipartfileeee");
  print(multipartFile.filename);

  request.files.add(multipartFile);*/
  // Add image file
  var request = http.MultipartRequest('POST', uri);
  /*var imageStream = http.ByteStream(Stream.castFrom(attachment.openRead()));
  var imageLength = await attachment.length();
  var imageMultipartFile = http.MultipartFile(
    "attachment", // Use "attachment" as the key for the image file
    imageStream,
    imageLength,
    filename: attachment.path.split("/").last,
  );
  request.files.add(imageMultipartFile);*/

  // Add PDF file
  var pdfStream = http.ByteStream(Stream.castFrom(cheque_photo.openRead()));
  var pdfLength = await cheque_photo.length();
  var pdfMultipartFile = http.MultipartFile(
    "cheque_attachment", // Use "pdf_attachment" as the key for the PDF file
    pdfStream,
    pdfLength,
    filename: cheque_photo.path.split("/").last,
  );
  request.files.add(pdfMultipartFile);

  print("multipart files:");
  for (var file in request.files) {
    print(file.filename);
  }

  var response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

//payment get
//http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=73&application_login_id=23
Future<http.Response> GetPayment(String applicarion_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=73&application_login_id=$applicarion_login_id");
  print("GetPayment  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//set passcode
//http://192.168.1.232/solarbox/service/service_sr_user.php?key=1226&s=74&cp_id=38&passcode=1234&app_flag
Future<http.Response> SetPasscode(
    String cp_id, String passcode, String phone, String app_flag) async {
  var uri = Uri.parse(url +
      "service_sr_user.php?key=$key&s=74&cp_id=$cp_id&passcode=$passcode&phone=$phone&app_flag=$app_flag");
  print("SetPasscode  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=76&flag=get_lead_type&district_id=&cp_id=8&lead_type_id=
//flag = get_lead_type get type and get_sub_lead_type get sub type
Future<http.Response> GetleadTypesandSubType(
    String app_flag,
    String district_id,
    String cp_id,
    String sub_type,
    ) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=76&flag=$app_flag&district_id=$district_id&cp_id=$cp_id&lead_type_id=$sub_type");
  print("get type/sub  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

//lead_source_tye_master
// http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=106
Future<http.Response> Getleadsourcetype() async {
  var uri = Uri.parse(url + "service_sr_lead.php?key=$key&s=106");
  print("get type  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

///add lead
//http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=75&date&gender&name&phone&mobile2&mobile3&email&channel_parnter&state&district_id&city&address&lead_type&sub_lead_type&electricity_bill_payment&kilowart&lead_id=
Future<http.Response> Add_Lead(
    String flag,
    String applicarion_login_id,
    String cp_id,
    String personORcompany_Name,
    String mobile_no,
    String Whatsapp_no,
    String Email,
    String district_id,
    String city_id,
    String type,
    String sub_type,
    int electricity_bill_payment,
    String kilowart,
    String lead_source_type,
    String reference_from,
    String lead_id,
    ) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=75&flag=$flag&application_login_id=$applicarion_login_id&cp_id=$cp_id&name=$personORcompany_Name&phone=$mobile_no&mobile3=$Whatsapp_no&email=$Email&district_id=$district_id&city=$city_id&lead_type=$type&sub_lead_type=$sub_type&electricity_bill_payment=$electricity_bill_payment&kilowart=$kilowart&lead_source_type=$lead_source_type&reference_from=$reference_from&lead_id=$lead_id");
  print("add lead  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=75&application_login_id=78&cp_id=8&name=&phone=&mobile3=&email=&district_id=&city=&lead_type=&sub_lead_type=&electricity_bill_payment=&kilowart=&lead_source_type=&reference_from=&lead_id=45&channel_parnter_user_id=8&flag=channel_parnter_user_id_update
Future<http.Response> Add_Lead_Assign(String applicarion_login_id, String cp_id,
    String lead_id, String assigned_id, String flag) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=75&application_login_id=$applicarion_login_id&cp_id=$cp_id&lead_id=$lead_id&channel_parnter_user_id=$assigned_id&flag=$flag");
  print("add lead  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

//survey

//phase master
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=78
Future<http.Response> GetSurveyPhase(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=78&application_login_id=$application_login_id");
  print("GetSurveyPhase  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//Discom master
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=79
Future<http.Response> GetSurveyDiscom(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=79&application_login_id=$application_login_id");
  print("GetSurveyDiscom  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//sub division master
//http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=80
Future<http.Response> GetSurveySubDivision(
    String application_login_id, String discom_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=80&application_login_id=$application_login_id&discom_id=$discom_id");
  print("GetSurveySubDivision  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//site type
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=81
Future<http.Response> GetSurveySiteType(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=81&application_login_id=$application_login_id");
  print("GetSurveySiteType  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//property type
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=82
Future<http.Response> GetSurveyPropertyType(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=82&application_login_id=$application_login_id");
  print("GetSurveyPropertyType  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//floors Data
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=83
Future<http.Response> GetSurveyFloor(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=83&application_login_id=$application_login_id");
  print("GetSurveyFloor  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//terrace type
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=84
Future<http.Response> GetSurveyTerraceType(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=84&application_login_id=$application_login_id");
  print("GetSurveyTerraceType  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//structure type
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=85
Future<http.Response> GetSurveyStructureType(
    String application_login_id, String terrace_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=85&application_login_id=$application_login_id&terrace_id=$terrace_id");
  print("GetSurveyStructureType  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//inverter floor
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=86
Future<http.Response> GetSurveyInverterFloor(
    String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=86&application_login_id=$application_login_id");
  print("GetSurveyInverterFloor  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//number_of_invertors
//http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=87
Future<http.Response> GetSurveyNumberInverter(
    String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=87&application_login_id=$application_login_id");
  print("GetSurveyNumberInverter  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//number_of_dc_string
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=88
Future<http.Response> GetSurveyNumberofDC(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=88&application_login_id=$application_login_id");
  print("GetSurveyNumberofDC  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//earthing rod type
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=91
Future<http.Response> GetSurveyEarthingRodType(
    String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=91&application_login_id=$application_login_id");
  print("GetSurveyEarthingRodType  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//la type
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=92
Future<http.Response> GetSurveyLAType(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=92&application_login_id=$application_login_id");
  print("GetSurveyLAType  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//installation_charge
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=89
Future<http.Response> GetSurveyInstallationCharges(
    String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=89&application_login_id=$application_login_id");
  print("GetSurveyInstallationCharges  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//installer data
// http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=90
Future<http.Response> GetSurveyInstaller(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=90&application_login_id=$application_login_id");
  print("GetSurveyInstaller  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//add survey_site_info
//http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=93
Future<http.Response> add_survey_site_info(
    String applicarion_login_id,
    String Consumer_no,
    String phase,
    String discom,
    String sub_division,
    String pincode,
    String lat,
    String long,
    String site_type,
    String property_type,
    String floor,
    String terrace_type,
    String structure_type,
    String lead_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=93&application_login_id=$applicarion_login_id&consumer_no=$Consumer_no&phase=$phase&discom=$discom&sub_division=$sub_division&pincode=$pincode&longitude=$long&latitude=$lat&site_type=$site_type&property_type=$property_type&floors=$floor&terrace_type=$terrace_type&structure_type=$structure_type&lead_id=$lead_id");
  print("add_survey_site_info  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//add survey_installation_charges
//http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=96
Future<http.Response> add_survey_installation_charges(
    String applicarion_login_id,
    String installer_type,
    String installation_charges,
    String installer,
    String lead_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=96&application_login_id=$applicarion_login_id&installer_type=$installer_type&installation_charges=$installation_charges&installer=$installer&lead_id=$lead_id");
  print("add_survey_installation_charges  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> add_survey_technical(
    String applicarion_login_id,
    String inverter_floor,
    String no_inverters,
    String ac_capacity,
    String dc_capacity,
    String structure_detail_flag,
    String lead_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=94&application_login_id=$applicarion_login_id&inverter_floor=$inverter_floor&number_of_inverters=$no_inverters&ac_capacity=$ac_capacity&dc_capacity=$dc_capacity&structure_detail_flag=$structure_detail_flag&lead_id=$lead_id");
  print("add_survey_technical  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> add_survey_photos(
    String application_login_id,
    String lead_id,
    List<File> terrace_photo,
    List<File> free_area_photo,
    List<File> property_photo,
    List<File> meter_photo) async {
  // Construct the API URL
  String apiUrl = url +
      "service_sr_lead.php?key=$key&s=95&application_login_id=$application_login_id&lead_id=$lead_id";
  print("apiUrl" + apiUrl);

  // Create the request body
  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  // Add terrace_photo files
  for (var i = 0; i < terrace_photo.length; i++) {
    var photo = terrace_photo[i];

    // Check if it's the last photo
    if (i == terrace_photo.length - 1) {
      var stream = http.ByteStream(photo.openRead());
      var length = await photo.length();
      var multipartFile = http.MultipartFile(
        "terrace_photo[]", // Use "terrace_photo[]" as the key for the last terrace photo
        stream,
        length,
        filename: photo.path.split("/").last,
      );
      request.files.add(multipartFile);
    } else {
      request.files.add(
          await http.MultipartFile.fromPath('terrace_photo[]', photo.path));
    }
  }

  // Add free_area_photo files
  for (var i = 0; i < free_area_photo.length; i++) {
    var photo = free_area_photo[i];

    // Check if it's the last photo
    if (i == free_area_photo.length - 1) {
      var stream = http.ByteStream(photo.openRead());
      var length = await photo.length();
      var multipartFile = http.MultipartFile(
        "free_area_photo[]", // Use "free_area_photo[]" as the key for the last free area photo
        stream,
        length,
        filename: photo.path.split("/").last,
      );
      request.files.add(multipartFile);
    } else {
      request.files.add(
          await http.MultipartFile.fromPath('free_area_photo[]', photo.path));
    }
  }

  // Add property_photo files
  for (var i = 0; i < property_photo.length; i++) {
    var photo = property_photo[i];

    // Check if it's the last photo
    if (i == property_photo.length - 1) {
      var stream = http.ByteStream(photo.openRead());
      var length = await photo.length();
      var multipartFile = http.MultipartFile(
        "property_photo[]", // Use "property_photo[]" as the key for the last property photo
        stream,
        length,
        filename: photo.path.split("/").last,
      );
      request.files.add(multipartFile);
    } else {
      request.files.add(
          await http.MultipartFile.fromPath('property_photo[]', photo.path));
    }
  }

  // Add meter_photo files
  for (var i = 0; i < meter_photo.length; i++) {
    var photo = meter_photo[i];

    // Check if it's the last photo
    if (i == meter_photo.length - 1) {
      var stream = http.ByteStream(photo.openRead());
      var length = await photo.length();
      var multipartFile = http.MultipartFile(
        "meter_area_photo[]", // Use "meter_area_photo[]" as the key for the last meter photo
        stream,
        length,
        filename: photo.path.split("/").last,
      );
      request.files.add(multipartFile);
    } else {
      request.files.add(
          await http.MultipartFile.fromPath('meter_area_photo[]', photo.path));
    }
  }

  // Send the request
  var streamedResponse = await request.send();

  // Convert the streamed response to a Response object
  var response = await http.Response.fromStream(streamedResponse);

  return response;
}

//get lead
//http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=97&application_login_id=72&id=2&ul=3&ll=0
Future<http.Response> GetLead(String user_id, int ul, int ll) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=97&application_login_id=$user_id&ll=$ul&ul=$ll");
  print("GetLead  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetLeadFilter(
    String user_id,
    String districtId,
    String cityIds,
    String typeIds,
    String searchName,
    String lead_source,
    String status,
    String fromDate,
    String toDate) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=97&application_login_id=$user_id&district=$districtId&city=$cityIds&lead_type=$typeIds&searchname=$searchName&lead_source=$lead_source&status=$status&fromdate=$fromDate&todate=$toDate");

  print("GetLeadFilter ${uri.toString()}");
  // print("GetLeadFilter : " + url +"service_sr_lead.php?key=$key&s=97&application_login_id=$user_id&district=$districtId&city=$cityIds&lead_type=$typeIds&fromdate=$fromDate&todate=$toDate");

  http.Response response = await http.post(uri);
  return response;
}

////http://24.24.25.232/solarbox/service/service_sr_lead.php?key=1226&s=97&application_login_id=72&id=2
Future<http.Response> GetOneLeadData(String user_id, String id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=97&application_login_id=$user_id&id=$id");
  print("GetOneLeadData  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//get combo kit
//http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=98
Future<http.Response> GetCombokit(String user_id, String kw,
    String lead_type_id, String kw_id, String combo_flag) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=98&application_login_id=$user_id&kw=$kw&lead_type_id=$lead_type_id&kw_id=$kw_id&combo_flag=$combo_flag");
  print("GETCOMBO ${uri.toString()}");

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetCombokitSearch(
    String user_id,
    String kw,
    String lead_type_id,
    String state_id,
    String district_id,
    String brand_id,
    String technology_id,
    String watts) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=98&application_login_id=$user_id&kw=$kw&lead_type_id=$lead_type_id&state_id=$state_id&district_id=$district_id&brand_id=$brand_id&technology_id=$technology_id&watts=$watts");
  print("GETCOMBO ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetCombokitSelected(String user_id, String kw,
    String lead_type_id, String combo_id, String combo_flag) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=98&application_login_id=$user_id&kw=$kw&lead_type_id=$lead_type_id&combo_id=$combo_id&combo_flag=$combo_flag");
  print("GETCOMBOSELCTED ${uri.toString()}");

  http.Response response = await http.post(uri);
  return response;
}

//get solar penal
//http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=102
Future<http.Response> GetSolarPenal(String user_id, String project_type_id,
    String panel_technology_id, String panel_watt) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=102&application_login_id=$user_id&project_type_id=$project_type_id&panel_technology_id=$panel_technology_id&panel_watt=$panel_watt");
  print("GetSolarPenal  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//get inverer
//http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=99
Future<http.Response> GetInverter(
    String user_id, String kw, String project_type_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=99&application_login_id=$user_id&kw=$kw&project_type_id=$project_type_id");
  print("GetInverter  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//get boskit
//http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=99
Future<http.Response> GetBosKit(
    String user_id, String type_id, String kw) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=100&application_login_id=$user_id&project_type_id=$type_id&kw=$kw");
  print("GetBosKit  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

//get Kw
//http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=101&login_id=1&lead_type_id=7
Future<http.Response> GetKW(
    String user_id, String lead_type_id, int maxrange) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=101&application_login_id=$user_id&lead_type_id=$lead_type_id&maxrange=$maxrange");
  print("get kw ${uri.toString()}");

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetKWforMargin(String user_id, String lead_type_id,
    int maxrange, String panel_technology, String wp) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=101&application_login_id=$user_id&lead_type_id=$lead_type_id&maxrange=$maxrange&panel_technology=$panel_technology&wp=$wp");
  print("get kw ${uri.toString()}");

  http.Response response = await http.post(uri);
  return response;
}

//quick quote customized calculation
//http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=103&solar_panel_id=2&invertor_id=14&bos_kit_id=1&kw=2
Future<http.Response> GetCalculate(
    String user_id,
    String kw,
    String solar_panel_id,
    String invertor_id,
    String bos_kit_id,
    String lead_type_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=103&application_login_id=$user_id&kw=$kw&solar_panel_id=$solar_panel_id&invertor_id=$invertor_id&bos_kit_id=$bos_kit_id&lead_type_id=$lead_type_id");
  print("get calculate ${uri.toString()}");

  http.Response response = await http.post(uri);
  return response;
}

//get quatation calculate
//http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=104&structure_installation_charges=1000&add_margin=1000&customize_calculation=50108&discount=0
Future<http.Response> GetQuoteCalculate(
    String user_id,
    String structure_installation_charges,
    String add_margin,
    String customize_calculation,
    String discount) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=104&application_login_id=$user_id&structure_installation_charges=$structure_installation_charges&add_margin=$add_margin&customize_calculation=$customize_calculation&discount=$discount");
  print("get Quote calculation ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=110&application_login_id=3&module_id=6
Future<http.Response> GetStatusCount(String user_id, String module_id) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=110&application_login_id=$user_id&module_id=$module_id");
  print("GetStatusCount :  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=109&application_login_id=&project_type=2&project_type=30001
/*Future<http.Response> GetKilowalt(String user_id,String project_type,int minrange,int maxrange) async {
  var uri = Uri.parse(
      url +"service_sr_general.php?key=$key&s=109&application_login_id=$user_id&project_type=$project_type&minrange=$minrange&maxrange=$maxrange");
  print("GetKW :  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}*/

// http://192.168.1.232/solarbox/service/service_general.php?key=1226&s=25&id=
Future<http.Response> LeadDelete(String lead_id) async {
  var uri = Uri.parse(url + "service_general.php?key=$key&s=25&id=$lead_id");
  print("LeadDelete :  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_general.php?key=1226&s=42&flag=lead
Future<http.Response> GetLeadStatus(String flag) async {
  var uri = Uri.parse(url + "service_general.php?key=$key&s=42&flag=$flag");
  print("LeadStatus :  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=111&application_login_id=&id=
Future<http.Response> GetRateStructure(String application_login_id) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=111&application_login_id=$application_login_id");
  print("GetRateStructure type:  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=112&id=&cp_id=8&application_login_id=78&project_type_id=1&type_of_structure_id=1&per_kg_rate=20&per_kw_rate=3.5&installation_cost_per_kw=250&cp_margin_per_kw=5&dis_limit_per_kw=1.5
Future<http.Response> AddRateSettings(
    String id,
    String cp_id,
    String application_login_id,
    String project_type,
    String structure_id,
    String structure_name,
    String per_kg_rate,
    String per_kw_rate,
    String installation_cost_per_kw,
    String cp_margin_per_kw,
    String dis_limit_per_kw) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=112&id=$id&cp_id=$cp_id&application_login_id=$application_login_id&project_type_id=$project_type&type_of_structure_id=$structure_id&structure_name=$structure_name&per_kg_rate=$per_kg_rate&per_kw_rate=$per_kw_rate&installation_cost_per_kw=$installation_cost_per_kw&cp_margin_per_kw=$cp_margin_per_kw&dis_limit_per_kw=$dis_limit_per_kw");
  print("AddRateSettings :  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_general.php?key=1226&s=113&cp_id=&application_login_id=78&id=&project_type_id=
Future<http.Response> GetRateData(String cp_id, String application_login_id,
    String id, String project_type) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=113&cp_id=$cp_id&application_login_id=$application_login_id&id=$id&project_type_id=$project_type");
  print("GetRateData :  ${uri.toString()}");
  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetOneRateData(String cp_id, String application_login_id,
    String id, String project_type, String terraceTypeId) async {
  var uri = Uri.parse(url +
      "service_sr_general.php?key=$key&s=113&cp_id=$cp_id&application_login_id=$application_login_id&id=$id&project_type_id=$project_type&type_of_structure_id=$terraceTypeId");
  print("GetOneRateData :  ${uri.toString()}");
  http.Response response = await http.get(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_quotation.php?key=1226&s=114&id=&lead_id=4&cp_id=8&application_login_id=78&killowat_id=369&combo_id=6,7,8&solar_panel_id=1&inverter_id=1&bos_kit_id=1&structure_installation_charge=2350&margin_commission_charge=1500&discount_amount=500&gst=18&gst_amount=1000&lead_commission=500&grand_total=3000
Future<http.Response> Add_Quotation(
    String id,
    String lead_id,
    String cp_id,
    String application_login_id,
    String killowat,
    String combo_id,
    String solar_panel_id,
    String inverter_id,
    String bos_kit_id,
    String structure_installation_charge,
    String margin_commission_charge,
    String discount_amount,
    String gst,
    String gst_amount,
    String lead_commission,
    String sub_total,
    String round_off,
    String grand_total,
    String company_margin,
    String suggestive_amount,
    String structure_charge,
    String installation_charge,
    String single_combo_price,
    String project_type_id,
    String custmized_price,
    String installation_suggestive_amount,
    String margin_commission_suggestive_amount,
    String discount_suggestive_amount,
    String technology_id,
    String panel_watt_id,
    int maxrange,
    String number_of_panel,
    String partAamount,
    String partBamount,
    String partBGST,
    String filetype,
    String loanType,
    String terraceType,

    ) async {
  var uri = Uri.parse(url +
      "service_sr_quotation.php?key=$key&s=114&id=$id&lead_id=$lead_id&cp_id=$cp_id&application_login_id=$application_login_id&killowat_id=$killowat&combo_id=$combo_id&solar_panel_id=$solar_panel_id&inverter_id=$inverter_id&bos_kit_id=$bos_kit_id&structure_installation_charge=$structure_installation_charge&margin_commission_charge=$margin_commission_charge&discount_amount=$discount_amount&gst=$gst&gst_amount=$gst_amount&lead_commission=$lead_commission&sub_total=$sub_total&round_off=$round_off&grand_total=$grand_total&company_margin=$company_margin&suggestive_amount=$suggestive_amount&structure_charge=$structure_charge&installation_charge=$installation_charge&single_combo_price=$single_combo_price&project_type_id=$project_type_id&custmized_price=$custmized_price&installation_suggestive_amount=$installation_suggestive_amount&margin_commission_suggestive_amount=$margin_commission_suggestive_amount&discount_suggestive_amount=$discount_suggestive_amount&technology_id=$technology_id&panelwatt_id=$panel_watt_id&erange=$maxrange&panel_no=$number_of_panel&part_a=$partAamount&part_b=$partBamount&part_b_gst_amount=$partBGST&file_type=$filetype&loan_type=$loanType&terrace_type=$terraceType");
  print("AddQuotation  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_quotation.php?key=1226&s=115&id=&cp_id=8
Future<http.Response> GetQuotation(
    String id, String cp_id, int ul, int ll, String lead_id) async {
  var uri = Uri.parse(url +
      "service_sr_quotation.php?key=$key&s=115&id=$id&cp_id=$cp_id&ll=$ul&ul=$ll&lead_id=$lead_id");
  print("GetQuotation  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetQuotationFilter(String cp_id, String status_id,
    String district_id, String from_date, String to_date) async {
  var uri = Uri.parse(url +
      "service_sr_quotation.php?key=$key&s=115&cp_id=$cp_id&status=$status_id&district_id=$district_id&from_date=$from_date&to_date=$to_date");
  print("GetQuotation  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetOneQuotation(String id, String cp_id) async {
  var uri = Uri.parse(
      url + "service_sr_quotation.php?key=$key&s=115&id=$id&cp_id=$cp_id");
  print("Get one Quotation  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_quotation.php?key=1226&s=116&id=&cp_id=
Future<http.Response> DeleteQuotation(String id, String cp_id) async {
  var uri = Uri.parse(
      url + "service_sr_quotation.php?key=$key&s=116&id=$id&cp_id=$cp_id");
  print("DeleteQuotation  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetQuotePDF(
    String id, String cp_id, String flag, String loginType) async {
  var uri = Uri.parse(url +
      "service_sr_quotation.php?key=$key&s=117&quot_id=$id&cp_id=$cp_id&flag=$flag&login_type=$loginType");
  print("QuotePDF  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

Future<bool> EditCPProfileImage(
    String id, String user_id, File image_file, String flag) async {
  print("EditCPProfileImage " +
      url +
      "service_sr_user.php?key=$key&s=118&application_login_id=$id&reference_id=$user_id&flag=$flag");
  var uri = Uri.parse(url +
      "service_sr_user.php?key=$key&s=118&application_login_id=$id&reference_id=$user_id&flag=$flag");

  var stream = http.ByteStream(Stream.castFrom(image_file.openRead()));
  var length = await image_file.length();

  var request = http.MultipartRequest('POST', uri);

  var multipartFile = http.MultipartFile("profile_photo", stream, length,
      filename: image_file.path.split("/").last);
  print(multipartFile);
  print("multipartfileeee");
  print("IMG ${multipartFile.filename}");

  request.files.add(multipartFile);

  var response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> EditCPProfileDetails(
    String id,
    String user_id,
    File image_file,
    String flag,
    String name,
    String phone,
    String adharcard_number,
    String email,
    String pan_card_number,
    String gst_no,
    String registered_office_address,
    String company_name,
    String color_code,
    String lead_prifix,
    String quotation_prefix,
    ) async {
  var uri = Uri.parse(url +
      "service_sr_user.php?key=$key&s=118&application_login_id=$id&reference_id=$user_id&flag=$flag&name+$name&phone=$phone&adharcard_number=$adharcard_number&email=$email&pan_card_number=$pan_card_number&gst_no=$gst_no&registered_office_address=$registered_office_address&company_name=$company_name&color_code=$color_code&lead_prefix=$lead_prifix&quotation_prefix=$quotation_prefix");

  print("EditCPProfileDetails  " + uri.toString());

  var stream = http.ByteStream(Stream.castFrom(image_file.openRead()));
  var length = await image_file.length();

  var request = http.MultipartRequest('POST', uri);

  var multipartFile = http.MultipartFile("cp_company_logo", stream, length,
      filename: image_file.path.split("/").last);
  print(multipartFile);
  print("multipartfileeee");
  print("IMG ${multipartFile.filename}");

  request.files.add(multipartFile);

  var response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<http.Response> EditCPProfileDetailsWithoutImage(
    String id,
    String user_id,
    String flag,
    String name,
    String phone,
    String adharcard_number,
    String email,
    String pan_card_number,
    String gst_no,
    String registered_office_address,
    String company_name,
    String color_code,
    String lead_prifix,
    String quotation_prefix,
    ) async {
  var uri = Uri.parse(url +
      "service_sr_user.php?key=$key&s=118&application_login_id=$id&reference_id=$user_id&flag=$flag&name+$name&phone=$phone&adharcard_number=$adharcard_number&email=$email&pan_card_number=$pan_card_number&gst_no=$gst_no&registered_office_address=$registered_office_address&company_name=$company_name&color_code=$color_code&lead_prefix=$lead_prifix&quotation_prefix=$quotation_prefix");

  print("EditCPProfileDetails  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=121&cp_id=16&application_login=40
Future<http.Response> DeleteAccount(
    String cp_id, String application_login) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=121&cp_id=$cp_id&application_login=$application_login");
  print("DeleteQuotation  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_quotation.php?key=1226&s=122&application_login=68&flag=genrate_certificate
Future<http.Response> GenerateCertificate(
    String cp_id, String application_login, String flag) async {
  var uri = Uri.parse(url +
      "service_sr_quotation.php?key=$key&s=122&cp_id=$cp_id&application_login=$application_login&flag=$flag");
  print("GenerateCertificate  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=123
Future<http.Response> GetPanelBrand() async {
  var uri = Uri.parse(url + "service_sr_lead.php?key=$key&s=123");
  print("GetPanelBrand  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=124
Future<http.Response> GetPanelTechnology() async {
  var uri = Uri.parse(url + "service_sr_lead.php?key=$key&s=124");
  print("GetPanelTechnology  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> GetPanelTechnologyForMargin(String combo_id) async {
  var uri =
  Uri.parse(url + "service_sr_lead.php?key=$key&s=124&combo_id=$combo_id");
  print("GetPanelTechnology  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=125&panel_technology_id=2,1,3,6&brand_id=12,15,3&application_login_id=
Future<http.Response> GetSolarPanelWatts(String panel_technology_id,
    String brand_id, String application_login_id, String lead_type_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=125&panel_technology_id=$panel_technology_id&brand_id=$brand_id&application_login_id=$application_login_id&lead_type_id=$lead_type_id");
  print("GetSolarPanelWatts  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_lead.php?key=1226&s=126&application_login_id=&document_flag=pan_verify&document_no=KRNPS1329Q&aadhar_request_id=&aadhar_final_otp=
Future<http.Response> VerifyDocuments(
    String cp_id,
    String application_login_id,
    String document_flag,
    String document_no,
    String aadhar_request_id,
    String aadhar_final_otp,
    String document_type_id) async {
  var uri = Uri.parse(url +
      "service_sr_lead.php?key=$key&s=126&cp_id=$cp_id&application_login_id=$application_login_id&document_flag=$document_flag&document_no=$document_no&aadhar_request_id=$aadhar_request_id&aadhar_final_otp=$aadhar_final_otp&document_type_id=$document_type_id");
  print("VerifyDocuments  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_followup.php?key=1226&s=127&application_login_id=5&followup_date=&followup_time=&remark=&followup_type=
Future<http.Response> AddFollowup(
    String application_login_id,
    String followup_date,
    String followup_time,
    String remark,
    String followup_type,
    String refranse_id,
    String reference_type,
    String selcted_technology_ids,
    String selected_panel_watt_ids) async {
  var uri = Uri.parse(url +
      "service_sr_followup.php?key=$key&s=127&application_login_id=$application_login_id&followup_date=$followup_date&followup_time=$followup_time&remark=$remark&followup_type=$followup_type&refranse_id=$refranse_id&reference_type=$reference_type&tecnology_id=$selcted_technology_ids&panelwatt_id=$selected_panel_watt_ids");
  print("AddFollowup  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_followup.php?key=1226&s=128&application_login_id=5&followup_date=&quote_id=&followup_status=
Future<http.Response> GetFollowup(String application_login_id, String quote_id,
    String followup_filter_type, String followup_date) async {
  var uri = Uri.parse(url +
      "service_sr_followup.php?key=$key&s=128&application_login_id=$application_login_id&quote_id=$quote_id&followup_filter_type=$followup_filter_type&followup_date=$followup_date");
  print("GetFollowup  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_followup.php?key=1226&s=129&application_login_id=&followup_id=
Future<http.Response> DeleteFollowup(
    String application_login_id, String followup_id, String quote_id) async {
  var uri = Uri.parse(url +
      "service_sr_followup.php?key=$key&s=129&application_login_id=$application_login_id&followup_id=$followup_id&quote_id=$quote_id");
  print("DeleteFollowup  " + uri.toString());
  print(uri);
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_project_signup.php?key=1226&s=130&application_login_id=&cp_id=&lead_id=&project_signup_type=&refrence_id=&reference_type=
Future<http.Response> SignupProject(
    String application_login_id,
    String cp_id,
    String lead_id,
    String project_signup_type,
    String refrence_id,
    String reference_type,
    String project_type_id) async {
  var uri = Uri.parse(url +
      "service_sr_project_signup.php?key=$key&s=130&application_login_id=$application_login_id&cp_id=$cp_id&lead_id=$lead_id&project_signup_type=$project_signup_type&refrence_id=$refrence_id&reference_type=$reference_type&project_type_id=$project_type_id");
  print("SignupProject  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_project_signup.php?key=1226&s=131&application_login_id=4
Future<http.Response> GetProjects(
    String application_login_id, String status, String lead_id) async {
  var uri = Uri.parse(url +
      "service_sr_project_signup.php?key=$key&s=131&application_login_id=$application_login_id&status=$status&lead_id=$lead_id");
  print("GetProjects  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_project_signup.php?key=1226&s=132&application_login_id=4&project_id=1
Future<http.Response> DeleteProject(
    String application_login_id, String project_id) async {
  var uri = Uri.parse(url +
      "service_sr_project_signup.php?key=$key&s=132&application_login_id=$application_login_id&project_id=$project_id");
  print("DeleteProject  " + uri.toString());

  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_quotation.php?key=1226&s=117&id=8&cp_id=8
Future<http.Response> GetBOMView(String quot_id, String cp_id,
    String project_signup_id, String type_flag, String flag) async {
  var uri = Uri.parse(url +
      "service_sr_quotation.php?key=$key&s=117&quot_id=$quot_id&cp_id=$cp_id&project_signup_id=$project_signup_id&view=$type_flag&flag=$flag");
  print("GetBOMView  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_cashback.php?key=1226&s=133&application_login_id=5
Future<http.Response> GetCashbackType(
    String cp_id, String application_login_id, String id) async {
  var uri = Uri.parse(url +
      "service_sr_cashback.php?key=$key&s=133&cp_id=$cp_id&application_login_id=$application_login_id&id=$id");
  print("GetCashbackType  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

// http://192.168.1.232/solarbox/service/service_sr_cashback.php?key=1226&s=134&application_login_id=33&cp_id=30&cashback_id="
Future<http.Response> GetCashbackList(String application_login_id, String cp_id,
    String cashback_id, String from_date, String to_date) async {
  var uri = Uri.parse(url +
      "service_sr_cashback.php?key=$key&s=134&application_login_id=$application_login_id&cp_id=$cp_id&cashback_id=$cashback_id&from_date=$from_date&to_date=$to_date");
  print("GetCashbackList  " + uri.toString());
  http.Response response = await http.post(uri);
  return response;
}

Future<http.Response> cpAgreementpdf(
    String cp_id, String language, String email) async {
  var uri = Uri.parse(url +
      "channel_partner_agreement_download.php?channel_partner_id=$cp_id&action=$language&mail=$email");
  print("Agreement pdf $uri");
  http.Response response = await http.get(uri);
  return response;
}
