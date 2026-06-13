import 'dart:convert';

QuotationModel QuotationModelFromJson(String str) =>
    QuotationModel.fromJson(json.decode(str));

String QuotationModelToJson(QuotationModel data) => json.encode(data.toJson());

class QuotationModel {
  String id;
  String quotation_no;
  String lead_id;
  String cp_id;
  String application_login_id;
  String killowat;
  String combo_id;
  String solar_panel_id;
  String inverter_id;
  String bos_kit_id;
  String structure_installation_charge;
  String margin_commission_charge;
  String discount_amount;
  String gst;
  String gst_amount;
  String lead_commission;
  String grand_total;
  String cp_name;
  String cp_mobile_no;
  String cp_email;
  String lead_no;
  String no_of_panel;
  String kw;
  String panle_of_tech;
  String solar_panel_image_path;
  String solar_icon_image_path;
  String invertor_image_path;
  String quotation_date;
  String project_type;
  String project_type_image_path;
  String company_margin;
  String lead_customer_name;
  String lead_customer_mobile_no;
  String quote_status_name;
  String quote_status_color;
  String custmized_combo_price;
  String state_subsidy;
  String mnre_subsidy;
  String single_combo_price;
  String followup_btn_show_or_not;
  String structure_charge;
  String installation_charge;
  String quote_editable_or_not;
  String selected_technology_ids;
  String selcted_panel_watt_ids;
  String file_type;

  QuotationModel({
    required this.id,
    required this.quotation_no,
    required this.lead_id,
    required this.cp_id,
    required this.application_login_id,
    required this.killowat,
    required this.combo_id,
    required this.solar_panel_id,
    required this.inverter_id,
    required this.bos_kit_id,
    required this.structure_installation_charge,
    required this.margin_commission_charge,
    required this.discount_amount,
    required this.gst,
    required this.gst_amount,
    required this.lead_commission,
    required this.grand_total,
    required this.cp_name,
    required this.cp_mobile_no,
    required this.cp_email,
    required this.lead_no,
    required this.no_of_panel,
    required this.kw,
    required this.panle_of_tech,
    required this.solar_panel_image_path,
    required this.solar_icon_image_path,
    required this.invertor_image_path,
    required this.quotation_date,
    required this.project_type,
    required this.project_type_image_path,
    required this.company_margin,
    required this.lead_customer_name,
    required this.lead_customer_mobile_no,
    required this.quote_status_name,
    required this.quote_status_color,
    required this.custmized_combo_price,
    required this.state_subsidy,
    required this.mnre_subsidy,
    required this.single_combo_price,
    required this.followup_btn_show_or_not,
    required this.structure_charge,
    required this.installation_charge,
    required this.quote_editable_or_not,
    required this.selcted_panel_watt_ids,
    required this.selected_technology_ids,
    required this.file_type,
  });

  factory QuotationModel.fromJson(Map<String, dynamic> json) => QuotationModel(
    id: json["id"].toString(),
    quotation_no: json["quotation_no"].toString(),
    lead_id: json["name"].toString(),
    cp_id: json["phone"].toString(),
    application_login_id: json["mobile3"].toString(),
    killowat: json["address"].toString(),
    combo_id: json["email"].toString(),
    solar_panel_id: json["channel_parnter"].toString(),
    inverter_id: json["electricity_bill_payment"].toString(),
    bos_kit_id: json["kilowart"].toString(),
    structure_installation_charge: json["date"].toString(),
    margin_commission_charge: json["district_id"].toString(),
    discount_amount: json["city"].toString(),
    gst: json["lead_type"].toString(),
    gst_amount: json["sub_lead_type"].toString(),
    lead_commission: json["district_name"].toString(),
    grand_total: json["grand_total"].toString(),
    cp_name: json["cp_name"].toString(),
    cp_mobile_no: json["cp_mobile_no"].toString(),
    cp_email: json["cp_email"].toString(),
    lead_no: json["lead_no"].toString(),
    no_of_panel: json["no_of_panel"].toString(),
    kw: json["kw"].toString(),
    panle_of_tech: json["panle_of_tech"].toString(),
    solar_panel_image_path: json["solar_panel_image_path"].toString(),
    solar_icon_image_path: json["solar_icon_image_path"].toString(),
    invertor_image_path: json["invertor_image_path"].toString(),
    quotation_date: json["quotation_date"].toString(),
    project_type: json["project_type"].toString(),
    project_type_image_path: json["project_type_image_path"].toString(),
    company_margin: json["company_margin"].toString(),
    lead_customer_name: json["lead_customer_name"].toString(),
    lead_customer_mobile_no: json["lead_customer_mobile_no"].toString(),
    quote_status_name: json["status_name"].toString(),
    quote_status_color: json["status_color"].toString(),
    custmized_combo_price: json["custmized_combo_price"].toString(),
    state_subsidy: json["state_subsidy"].toString(),
    mnre_subsidy: json["mnre_subsidy"].toString(),
    single_combo_price: json["single_combo_price"].toString(),
    followup_btn_show_or_not: json["followup_btn_show_or_not"].toString(),
    structure_charge: json["structure_charge"].toString(),
    installation_charge: json["installation_charge"].toString(),
    quote_editable_or_not: json["quote_editable_or_not"].toString(),
    selected_technology_ids: json["technology_id"].toString(),
    selcted_panel_watt_ids: json["panelwatt_id"].toString(),
    file_type: json["panelwatt_id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quotation_no": quotation_no,
    "lead_id": lead_id,
    "cp_id": cp_id,
    "quotation_by": application_login_id,
    "killowat_id": killowat,
    "combo_id": combo_id,
    "solar_panel_id": solar_panel_id,
    "inverter_id": inverter_id,
    "bos_kit_id": bos_kit_id,
    "structure_installation_charge": structure_installation_charge,
    "margin_commission_charge": margin_commission_charge,
    "discount_amount": discount_amount,
    "gst": gst,
    "gst_amount": gst_amount,
    "lead_commission": lead_commission,
    "grand_total": grand_total,
    "cp_name": cp_name,
    "cp_mobile_no": cp_mobile_no,
    "cp_email": cp_email,
    "lead_no": lead_no,
    "no_of_panel": no_of_panel,
    "kw": kw,
    "panle_of_tech": panle_of_tech,
    "solar_panel_image_path": solar_panel_image_path,
    "solar_icon_image_path": solar_icon_image_path,
    "invertor_image_path": invertor_image_path,
    "quotation_date": quotation_date,
    "project_type": project_type,
    "project_type_image_path": project_type_image_path,
    "company_margin": company_margin,
    "lead_customer_mobile_no": lead_customer_mobile_no,
    "lead_customer_name": lead_customer_name,
    "custmized_combo_price": custmized_combo_price,
    "state_subsidy": state_subsidy,
    "mnre_subsidy": mnre_subsidy,
    "followup_btn_show_or_not": followup_btn_show_or_not,
    "technology_id": selected_technology_ids,
    "panelwatt_id": selcted_panel_watt_ids,
    "file_type" : file_type,

  };
}
