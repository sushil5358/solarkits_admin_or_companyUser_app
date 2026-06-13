// brand_model.dart

class Brand {
  final String id;
  final String companyName;
  final String companyOriginCountry;
  final String brand;
  final String? brandLogo;          // nullable, because it can be null
  final String product;
  final bool comboKit;
  final StateInfo state;
  final dynamic city;               // can be null or string – adjust as needed
  final DistrictInfo district;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;                // __v

  Brand({
    required this.id,
    required this.companyName,
    required this.companyOriginCountry,
    required this.brand,
    this.brandLogo,
    required this.product,
    required this.comboKit,
    required this.state,
    this.city,
    required this.district,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'] ?? '',
      companyName: json['companyName'] ?? '',
      companyOriginCountry: json['companyOriginCountry'] ?? '',
      brand: json['brand'] ?? '',
      brandLogo: json['brandLogo'],
      product: json['product'] ?? '',
      comboKit: json['comboKit'] ?? false,
      state: StateInfo.fromJson(json['state'] ?? {}),
      city: json['city'],
      district: DistrictInfo.fromJson(json['district'] ?? {}),
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'companyName': companyName,
    'companyOriginCountry': companyOriginCountry,
    'brand': brand,
    'brandLogo': brandLogo,
    'product': product,
    'comboKit': comboKit,
    'state': state.toJson(),
    'city': city,
    'district': district.toJson(),
    'isActive': isActive,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': version,
  };
}

class StateInfo {
  final String id;
  final String name;

  StateInfo({required this.id, required this.name});

  factory StateInfo.fromJson(Map<String, dynamic> json) {
    return StateInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}

class DistrictInfo {
  final String id;
  final String name;

  DistrictInfo({required this.id, required this.name});

  factory DistrictInfo.fromJson(Map<String, dynamic> json) {
    return DistrictInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}

/// Wrapper that holds only the list of brands (ignores success, message, count)
class BrandList {
  final List<Brand> brands;

  BrandList({required this.brands});

  factory BrandList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    return BrandList(
      brands: data.map((item) => Brand.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': brands.map((b) => b.toJson()).toList(),
  };
}