// bos_kit_model.dart

class BosKitModel {
  final String id;
  final String skuCode;
  final int version;                     // __v
  final String capacity;
  final String cluster;
  final DateTime createdAt;
  final String? createdBy;
  final String description;
  final String? image;
  final String phase;
  final String state;
  final bool status;
  final String technology;
  final DateTime updatedAt;
  final String? updatedBy;
  final int wattage;
  final String productId;
  final String productName;
  final String? companyName;
  final String? brandName;
  final String? brandLogo;
  final String? brandLogoUrl;
  final String name;
  final String skuName;
  final String? imageUrl;
  final String? projectType;            // optional, present in some items

  BosKitModel({
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
    this.companyName,
    this.brandName,
    this.brandLogo,
    this.brandLogoUrl,
    required this.name,
    required this.skuName,
    this.imageUrl,
    this.projectType,
  });

  factory BosKitModel.fromJson(Map<String, dynamic> json) {
    return BosKitModel(
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
      companyName: json['companyName'],
      brandName: json['brandName'],
      brandLogo: json['brandLogo'],
      brandLogoUrl: json['brandLogoUrl'],
      name: json['name'] ?? '',
      skuName: json['skuName'] ?? '',
      imageUrl: json['imageUrl'],
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
    'name': name,
    'skuName': skuName,
    'imageUrl': imageUrl,
    'projectType': projectType,
  };
}

/// Wrapper for the API response (only the `data` list)
class BosKitResponse {
  final List<BosKitModel> data;

  BosKitResponse({required this.data});

  factory BosKitResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['data'] ?? [];
    return BosKitResponse(
      data: list.map((item) => BosKitModel.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
  };
}