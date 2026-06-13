// final_price_data_model.dart

class CustomizeKitModel {
  final double solarPanelPrice;
  final double solarInverterPrice;
  final double bosKitsPrice;
  final int companyMargin;
  final double gst;
  final int finalPrice;
  final String numberOfPanels;
  final String kilowatt;
  final Breakdown breakdown;

  CustomizeKitModel({
    required this.solarPanelPrice,
    required this.solarInverterPrice,
    required this.bosKitsPrice,
    required this.companyMargin,
    required this.gst,
    required this.finalPrice,
    required this.breakdown,
    required this.numberOfPanels,
    required this.kilowatt,
  });

  factory CustomizeKitModel.fromJson(Map<String, dynamic> json) {
    return CustomizeKitModel(
      solarPanelPrice: (json['solarPanelPrice'] ?? 0).toDouble(),
      numberOfPanels: (json['numberOfPanels'] ?? 0).toString(),
      kilowatt: (json['kilowatt'] ?? 0).toString(),
      solarInverterPrice: (json['solarInverterPrice'] ?? 0).toDouble(),
      bosKitsPrice: (json['bosKitsPrice'] ?? 0).toDouble(),
      companyMargin: json['companyMargin'] ?? 0,
      gst: (json['gst'] ?? 0).toDouble(),
      finalPrice: json['finalPrice'] ?? 0,
      breakdown: Breakdown.fromJson(json['breakdown'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {

    'solarPanelPrice': solarPanelPrice,
    'solarInverterPrice': solarInverterPrice,
    'bosKitsPrice': bosKitsPrice,
    'companyMargin': companyMargin,
    'gst': gst,
    'finalPrice': finalPrice,
    'numberOfPanels': numberOfPanels,
    'kilowatt': kilowatt,
    'breakdown': breakdown.toJson(),
  };
}

class Breakdown {
  final BreakdownItem solarPanel;
  final BreakdownItem solarInverter;
  final BreakdownItem bosKits;
  final CompanyMarginBreakdown companyMargin;

  Breakdown({
    required this.solarPanel,
    required this.solarInverter,
    required this.bosKits,
    required this.companyMargin,
  });

  factory Breakdown.fromJson(Map<String, dynamic> json) {
    return Breakdown(
      solarPanel: BreakdownItem.fromJson(json['solarPanel'] ?? {}),
      solarInverter: BreakdownItem.fromJson(json['solarInverter'] ?? {}),
      bosKits: BreakdownItem.fromJson(json['bosKits'] ?? {}),
      companyMargin: CompanyMarginBreakdown.fromJson(json['companyMargin'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'solarPanel': solarPanel.toJson(),
    'solarInverter': solarInverter.toJson(),
    'bosKits': bosKits.toJson(),
    'companyMargin': companyMargin.toJson(),
  };
}

class BreakdownItem {
  final String id;
  final String sku;
  final String name;
  final String? photo;   // can be null

  BreakdownItem({
    required this.id,
    required this.sku,
    required this.name,
    this.photo,
  });

  factory BreakdownItem.fromJson(Map<String, dynamic> json) {
    return BreakdownItem(
      id: json['id'] ?? '',
      sku: json['sku'] ?? '',
      name: json['name'] ?? '',
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'sku': sku,
    'name': name,
    'photo': photo,
  };
}

class CompanyMarginBreakdown {
  final String type;
  final int baseAmount;
  final int gstRate;
  final int gstAmount;

  CompanyMarginBreakdown({
    required this.type,
    required this.baseAmount,
    required this.gstRate,
    required this.gstAmount,
  });

  factory CompanyMarginBreakdown.fromJson(Map<String, dynamic> json) {
    return CompanyMarginBreakdown(
      type: json['type'] ?? '',
      baseAmount: json['baseAmount'] ?? 0,
      gstRate: json['gstRate'] ?? 0,
      gstAmount: json['gstAmount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'baseAmount': baseAmount,
    'gstRate': gstRate,
    'gstAmount': gstAmount,
  };
}