// partner_user_model.dart

class PartnerUserResponse {
  final List<PartnerUserModel> data;

  PartnerUserResponse({required this.data});

  factory PartnerUserResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List? ?? [];
    return PartnerUserResponse(
      data: list.map((item) => PartnerUserModel.fromJson(item)).toList(),
    );
  }
}

class PartnerUserModel {
  final String id;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String stateName;
  final String districtName;
  final String aadhaarNumber;
  final String industryTypeName;
  final String professionTypeName;
  final String hasShopOffice;
  final bool hasGST;
  final String businessTypeName;
  final String gstPartnerTypeId;
  final String gstPartnerTypeName;
  final String gstNumber;
  final String status;
  final CompanyUserInfo? companyUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final int totalQuotes;
  final int totalProjects;
  final int totalRevenue;

  PartnerUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.stateName,
    required this.districtName,
    required this.aadhaarNumber,
    required this.industryTypeName,
    required this.professionTypeName,
    required this.hasShopOffice,
    required this.hasGST,
    required this.businessTypeName,
    required this.gstPartnerTypeId,
    required this.gstPartnerTypeName,
    required this.gstNumber,
    required this.status,
    this.companyUser,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.totalQuotes,
    required this.totalProjects,
    required this.totalRevenue,
  });

  factory PartnerUserModel.fromJson(Map<String, dynamic> json) {
    return PartnerUserModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      stateName: json['state']?['name'] ?? '',
      districtName: json['district']?['name'] ?? '',
      aadhaarNumber: json['aadhaarNumber'] ?? '',
      industryTypeName: json['industryType']?['name'] ?? '',
      professionTypeName: json['professionType']?['name'] ?? '',
      hasShopOffice: json['hasShopOffice'] ?? '',
      hasGST: json['hasGST'] ?? false,
      businessTypeName: json['businessType']?['name'] ?? '',
      gstPartnerTypeId: json['gstPartnerType']?['_id'] ?? '',
      gstPartnerTypeName: json['gstPartnerType']?['name'] ?? '',
      gstNumber: json['gstNumber'] ?? '',
      status: json['status'] ?? '',
      companyUser: json['companyUser'] != null
          ? CompanyUserInfo.fromJson(json['companyUser'])
          : null,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
      totalQuotes: json['totalQuotes'] ?? 0,
      totalProjects: json['totalProjects'] ?? 0,
      totalRevenue: json['totalRevenue'] ?? 0,
    );
  }
}

class CompanyUserInfo {
  final String id;
  final String fullName;
  final String mobileNumber;
  final String emailAddress;
  final String role;

  CompanyUserInfo({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.emailAddress,
    required this.role,
  });

  factory CompanyUserInfo.fromJson(Map<String, dynamic> json) {
    return CompanyUserInfo(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      role: json['role'] ?? '',
    );
  }
}