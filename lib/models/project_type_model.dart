class Project_type_model {
  String id;
  String name;
  String minRange;
  String maxRange;
  String slotRange;
  String tax;
  String slot;
  String customizedKitMargin;
  String comboKitMargin;

  Project_type_model({
    required this.id,
    required this.name,
    required this.minRange,
    required this.maxRange,
    required this.slotRange,
    required this.tax,
    required this.slot,
    required this.customizedKitMargin,
    required this.comboKitMargin,
  });

  factory Project_type_model.fromJson(Map<String, dynamic> json) {
    return Project_type_model(
      id: json['id'],
      name: json['name'],
      minRange: json['min_range'],
      maxRange: json['max_range'],
      slotRange: json['slot_range'],
      tax: json['tax'],
      slot: json['slot'],
      customizedKitMargin: json['customized_kit_margin'],
      comboKitMargin: json['combo_kit_margin'],
    );
  }
}
