// sku_model.dart

class InverterModel {
  final String id;
  final String skuCode;
  final int version;                     // __v
  final String capacity;
  final String cluster;
  final DateTime createdAt;
  final String? createdBy;
  final String description;
  final dynamic image;                  // can be null or string
  final String phase;
  final String state;
  final bool status;
  final String technology;
  final DateTime updatedAt;
  final String? updatedBy;
  final int wattage;
  final String productId;
  final String productName;
  final String companyName;
  final String brandName;
  final String? brandLogo;
  final String? brandLogoUrl;

  // Optional nested brand object (only present in some items)
  final BrandInfo? brand;

  // Other optional fields that may appear
  final String? category;
  final String? projectType;

  InverterModel({
    required this.id,
    required this.skuCode,
    required this.version,
    required this.capacity,
    required this.cluster,
    required this.createdAt,
    this.createdBy,
    required this.description,
    this.image,
    required this.phase,
    required this.state,
    required this.status,
    required this.technology,
    required this.updatedAt,
    this.updatedBy,
    required this.wattage,
    required this.productId,
    required this.productName,
    required this.companyName,
    required this.brandName,
    this.brandLogo,
    this.brandLogoUrl,
    this.brand,
    this.category,
    this.projectType,
  });

  factory InverterModel.fromJson(Map<String, dynamic> json) {
    return InverterModel(
      id: json['_id'] ?? '',
      skuCode: json['skuCode'] ?? '',
      version: json['__v'] ?? 0,
      capacity: json['capacity'] ?? '',
      cluster: json['cluster'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      createdBy: json['createdBy'],
      description: json['description'] ?? '',
      image: json['image'],
      phase: json['phase'] ?? '',
      state: json['state'] ?? '',
      status: json['status'] ?? false,
      technology: json['technology'] ?? '',
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      updatedBy: json['updatedBy'],
      wattage: json['wattage'] ?? 0,
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      companyName: json['companyName'] ?? '',
      brandName: json['brandName'] ?? '',
      brandLogo: json['brandLogo'],
      brandLogoUrl: json['brandLogoUrl'],
      brand: json['brand'] != null ? BrandInfo.fromJson(json['brand']) : null,
      category: json['category'],
      projectType: json['projectType'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'skuCode': skuCode,
    '__v': version,
    'capacity': capacity,
    'cluster': cluster,
    'createdAt': createdAt.toIso8601String(),
    'createdBy': createdBy,
    'description': description,
    'image': image,
    'phase': phase,
    'state': state,
    'status': status,
    'technology': technology,
    'updatedAt': updatedAt.toIso8601String(),
    'updatedBy': updatedBy,
    'wattage': wattage,
    'productId': productId,
    'productName': productName,
    'companyName': companyName,
    'brandName': brandName,
    'brandLogo': brandLogo,
    'brandLogoUrl': brandLogoUrl,
    'brand': brand?.toJson(),
    'category': category,
    'projectType': projectType,
  };
}

class BrandInfo {
  final String id;
  final String companyName;
  final String brand;
  final String brandLogo;
  final String name;

  BrandInfo({
    required this.id,
    required this.companyName,
    required this.brand,
    required this.brandLogo,
    required this.name,
  });

  factory BrandInfo.fromJson(Map<String, dynamic> json) {
    return BrandInfo(
      id: json['_id'] ?? '',
      companyName: json['companyName'] ?? '',
      brand: json['brand'] ?? '',
      brandLogo: json['brandLogo'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'companyName': companyName,
    'brand': brand,
    'brandLogo': brandLogo,
    'name': name,
  };
}

/// Wrapper for the API response (only the `data` list)
class SkuResponse {
  final List<InverterModel> data;

  SkuResponse({required this.data});

  factory SkuResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['data'] ?? [];
    return SkuResponse(
      data: list.map((item) => InverterModel.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
  };
}