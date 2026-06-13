class Common_Model {
  late String id;
  late String name;
  late String kw;
  late String mobile_no;
  late String bank_name;
  late String document_name;
  late String created_date;
  late String attachment;
  late String attachment_name;
  late String icon;
  late String kilowat;
  late String panel_full_name;
  late String price;
  late String min_range;
  late String max_range;
  late String slot;
  late String slote_of_range;
  late String gst;
  late String customized_kit_margin;
  late String combo_kit_margin;
  late String watt;
  late String no_of_panel;
  late String panel_technology_id;
  late String panel_technology_name;
  late String total_subsidy;
  late String wp;
  late String chek_stock;
  bool is_checked;


  Common_Model(
      {this.id = "",
        this.name = "",
        this.kw = "",
        this.mobile_no = "",
        this.bank_name = "",
        this.document_name = "",
        this.created_date = "",
        this.attachment = "",
        this.attachment_name = "",
        this.icon = "",
        this.kilowat = "",
        this.panel_full_name = "",
        this.price = "",
        this.min_range = "",
        this.max_range = "",
        this.slot = "",
        this.slote_of_range = "",
        this.gst = "",
        this.customized_kit_margin = "",
        this.combo_kit_margin = "",
        this.watt = "",
        this.no_of_panel = "",
        this.panel_technology_name = "",
        this.total_subsidy = "",
        this.wp = "",
        this.chek_stock = "",
        this.is_checked = false,
        this.panel_technology_id = ""});

  factory Common_Model.fromJson(Map<String, dynamic> json) {
    return Common_Model(
      id: json['id'].toString(),
      name: json['name'].toString(),
      kw: json['kw'].toString(),
      bank_name: json['bank_name'].toString(),
      document_name: json['document_name'].toString(),
      created_date: json['created_date'].toString(),
      mobile_no: json['mobile_no'].toString(),
      attachment: json['attachment'].toString(),
      attachment_name: json['attachment_name'].toString(),
      kilowat: json['kilowat'].toString(),
      panel_full_name: json['panel_full_name'].toString(),
      icon: json['image_path'].toString(),
      price: json['price'].toString(),
      min_range: json['min_range'].toString(),
      max_range: json['max_range'].toString(),
      slot: json['slot'].toString(),
      slote_of_range: json['slot_range'].toString(),
      gst: json['tax'].toString(),
      customized_kit_margin: json['customized_kit_margin'].toString(),
      combo_kit_margin: json['combo_kit_margin'].toString(),
      watt: json['watt'].toString(),
      no_of_panel: json['no_of_panel'].toString(),
      panel_technology_id: json['panel_technology_id'].toString(),
      panel_technology_name: json['panel_technology_name'].toString(),
      total_subsidy: json['total_subsidy'].toString(),
      wp : json["wp"].toString(),
      chek_stock: json["chek_stock"].toString(),
    );
  }
}
