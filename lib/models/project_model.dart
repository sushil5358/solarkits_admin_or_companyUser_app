class ProjectModel {
  late String id;
  late String project_status;
  late String project_status_color;
  late String project_no;
  late String project_signup_type;
  late String quote_id;
  late String quote_type;
  late String lead_id;
  late String lead_no;
  late String quote_no;
  late String customer_name;
  late String customer_phone;
  late String city;
  late String project_type_name;
  late String no_of_panel;
  late String kw;
  late String project_type_image;
  late String panel_brand_image;
  late String invertor_brand_image;
  late String project_type_id;
  late String project_pi_image;
  late String part_a_total;
  late String structure_charge;
  late String installation_charge;
  late String margin_commission_suggestive_amount;
  late String margin_commission_charge;
  late String company_margin;
  late String state_subsidy;
  late String mnre_subsidy;
  late String grnad_total;
  late String discount_amt;
  late String single_combo_price;
  late String custmized_price;
  late String created_date;
  late String user_name;
  late String GSTAmount;
  late String gst;
  late String file_type;
  late String required_kw;
  late String current_project_status;
  late String current_project_status_color;

  ProjectModel({
    this.id = "",
    this.project_status = "",
    this.project_status_color = "",
    this.project_no = "",
    this.project_signup_type = "",
    this.quote_id = "",
    this.quote_type = "",
    this.lead_id = "",
    this.lead_no = "",
    this.quote_no = "",
    this.customer_name = "",
    this.customer_phone = "",
    this.city = "",
    this.project_type_name = "",
    this.no_of_panel = "",
    this.kw = "",
    this.project_type_image = "",
    this.panel_brand_image = "",
    this.invertor_brand_image = "",
    this.project_type_id = "",
    this.project_pi_image = "",
    this.part_a_total = "",
    this.structure_charge = "",
    this.installation_charge = "",
    this.margin_commission_suggestive_amount = "",
    this.margin_commission_charge = "",
    this.company_margin = "",
    this.state_subsidy = "",
    this.mnre_subsidy = "",
    this.grnad_total = "",
    this.discount_amt = "",
    this.single_combo_price = "",
    this.custmized_price = "",
    this.created_date = "",
    this.user_name = "",
    this.GSTAmount = "",
    this.gst = "",
    this.file_type = "",
    this.required_kw = "",
    this.current_project_status = "",
    this.current_project_status_color = "",
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'].toString(),
      project_status: json['project_status'].toString(),
      project_status_color: json['project_status_color'].toString(),
      project_no: json['project_no'].toString(),
      project_signup_type: json['project_signup_type'].toString(),
      quote_id: json['quote_id'].toString(),
      quote_type: json['quote_type'].toString(),
      lead_id: json['lead_id'].toString(),
      lead_no: json['lead_no'].toString(),
      quote_no: json['quote_no'].toString(),
      customer_name: json['customer_name'].toString(),
      customer_phone: json['customer_phone'].toString(),
      city: json['city'].toString(),
      project_type_name: json['project_type_name'].toString(),
      no_of_panel: json['no_of_panel'].toString(),
      kw: json['kw'].toString(),
      project_type_image: json['project_type_image'].toString(),
      panel_brand_image: json['panel_brand_image'].toString(),
      invertor_brand_image: json['invertor_brand_image'].toString(),
      project_type_id: json['project_type_id'].toString(),
      project_pi_image: json['project_pi_image'].toString(),
      part_a_total: json['part_a_total'].toString(),
      structure_charge: json['structure_charge'].toString(),
      installation_charge: json['installation_charge'].toString(),
      margin_commission_suggestive_amount: json['margin_commission_suggestive_amount'].toString(),
      margin_commission_charge : json['margin_commission_charge'].toString(),
      company_margin: json['company_margin'].toString(),
      state_subsidy: json['state_subsidy'].toString(),
      mnre_subsidy: json['mnre_subsidy'].toString(),
      grnad_total: json['grand_total'].toString(),
      discount_amt: json['discount_amt'].toString(),
      single_combo_price: json['single_combo_price'].toString(),
      custmized_price: json['custmized_price'].toString(),
      created_date: json['created_date'].toString(),
      user_name: json['user_name'].toString(),
      GSTAmount: json["gst_amount"].toString(),
      gst: json["gst"].toString(),
      file_type: json["file_type"].toString(),
      required_kw: json['required_kw'].toString(),
        current_project_status: json['current_project_status'].toString(),
      current_project_status_color: json['current_project_status_color'].toString(),
    );
  }
}
