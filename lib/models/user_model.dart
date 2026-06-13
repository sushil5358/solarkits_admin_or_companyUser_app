class UserModel{
 late String id;
 late String name;
 late String email;
 late String mobile_number;
 late String type;
 late String type_name;
 late String reference_id;
 late String reference_table;
 late String parent_user_id;
 late String isActive;
 late String created_date;
 late String lead_generated;
 late String quote_generated;
 late String project_signup;
 late String state_id;
 late String state;
 late String city_id;
 late String city;
 late String district_id;
 late String district;
 late String cp_status_id;
 late String cp_status;
 late String total_grand_total;


 UserModel({
  this.id = "",
  this.name = "",
  this.email = "",
  this.mobile_number = "",
  this.type = "",
  this.type_name = "",
  this.reference_id = "",
  this.reference_table = "",
  this.parent_user_id = "",
  this.isActive = "",
  this.created_date = "",
  this.lead_generated = "",
  this.quote_generated = "",
  this.project_signup = "",
  this.state_id = "",
  this.state = "",
  this.city_id = "",
  this.city = "",
  this.district_id = "",
  this.district = "",
  this.cp_status_id = "",
  this.cp_status = "",
  this.total_grand_total = "",
 });


 factory UserModel.fromJson(Map<String, dynamic> json){
       return UserModel(
        id: json['id'].toString(),
        name: json['name'].toString(),
        email: json['email'].toString(),
        mobile_number: json['mobile_number'].toString(),
        type: json['type'].toString(),
        reference_id: json['reference_id'].toString(),
        reference_table: json['reference_table'].toString(),
        parent_user_id: json['parent_user_id'].toString(),
        isActive: json['isActive'].toString(),
        created_date: json['created_date'].toString(),
        lead_generated: json['lead_generated'].toString(),
        quote_generated: json['quote_generated'].toString(),
        project_signup: json['project_signup'].toString(),
        state_id: json['state_id'].toString(),
        state: json['state'].toString(),
        city_id: json['city_id'].toString(),
        city: json['city'].toString(),
        district_id: json['district_id'].toString(),
        district: json['district'].toString(),
        cp_status_id: json['cp_status_id'].toString(),
        cp_status: json['cp_status'].toString(),
        total_grand_total: json['total_grand_total'].toString(),
       );
 }







}




