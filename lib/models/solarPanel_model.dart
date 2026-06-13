// solar_brand_detail_model.dart

class SolarPanelModel {
  final String id;
  final String name;
  final String serialNo;
  final String subtype;
  final String technology;
  final String tolerance;
  final String dcr;
  final String datasheet;
  final String description;
  final bool status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;          // __v
  final String companyName;
  final String companyOriginCountry;
  final String brand;
  final String brandLogo;
  final String product;
  final bool comboKit;
  final String state;
  final dynamic city;        // can be null or string
  final String district;
  final bool isActive;
  final String brandLogoUrl;

  SolarPanelModel({
    required this.id,
    required this.name,
    required this.serialNo,
    required this.subtype,
    required this.technology,
    required this.tolerance,
    required this.dcr,
    required this.datasheet,
    required this.description,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.companyName,
    required this.companyOriginCountry,
    required this.brand,
    required this.brandLogo,
    required this.product,
    required this.comboKit,
    required this.state,
    this.city,
    required this.district,
    required this.isActive,
    required this.brandLogoUrl,
  });

  factory SolarPanelModel.fromJson(Map<String, dynamic> json) {
    return SolarPanelModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      serialNo: json['serialNo'] ?? '',
      subtype: json['subtype'] ?? '',
      technology: json['technology'] ?? '',
      tolerance: json['tolerance'] ?? '',
      dcr: json['dcr'] ?? '',
      datasheet: json['datasheet'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? false,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
      companyName: json['companyName'] ?? '',
      companyOriginCountry: json['companyOriginCountry'] ?? '',
      brand: json['brand'] ?? '',
      brandLogo: json['brandLogo'] ?? '',
      product: json['product'] ?? '',
      comboKit: json['comboKit'] ?? false,
      state: json['state'] ?? '',
      city: json['city'],
      district: json['district'] ?? '',
      isActive: json['isActive'] ?? false,
      brandLogoUrl: json['brandLogoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'serialNo': serialNo,
    'subtype': subtype,
    'technology': technology,
    'tolerance': tolerance,
    'dcr': dcr,
    'datasheet': datasheet,
    'description': description,
    'status': status,
    'createdBy': createdBy,
    'updatedBy': updatedBy,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': version,
    'companyName': companyName,
    'companyOriginCountry': companyOriginCountry,
    'brand': brand,
    'brandLogo': brandLogo,
    'product': product,
    'comboKit': comboKit,
    'state': state,
    'city': city,
    'district': district,
    'isActive': isActive,
    'brandLogoUrl': brandLogoUrl,
  };
}

/// Wrapper that holds only the list of brands (ignores success, count)
class SolarBrandDetailResponse {
  final List<SolarPanelModel> data;

  SolarBrandDetailResponse({required this.data});

  factory SolarBrandDetailResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['data'] ?? [];
    return SolarBrandDetailResponse(
      data: list.map((item) => SolarPanelModel.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
  };
}