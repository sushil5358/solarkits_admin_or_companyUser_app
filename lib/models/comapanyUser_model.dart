// company_user_model.dart

class CompanyUserResponse {
  final List<CompanyUser> data;

  CompanyUserResponse({required this.data});

  factory CompanyUserResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    return CompanyUserResponse(
      data: list.map((e) => CompanyUser.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class CompanyUser {
  final String id;
  final String fullName;
  final String mobileNumber;
  final String emailAddress;
  final String district;
  final String role;
  final String status;
  final bool partnerGoalsEnabled;
  final int partnerMonthlyTargetKw;
  final int partnerPerKwCommission;
  final PartnerQuotePermissions partnerQuotePermissions;
  final List<PartnerType> partnerTypes;
  final bool projectGoalEnabled;
  final int projectMonthlyTargetKw;
  final int projectPerKwCommission;
  final List<ProjectType> projectTypes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final int partnersCreatedCount;

  CompanyUser({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.emailAddress,
    required this.district,
    required this.role,
    required this.status,
    required this.partnerGoalsEnabled,
    required this.partnerMonthlyTargetKw,
    required this.partnerPerKwCommission,
    required this.partnerQuotePermissions,
    required this.partnerTypes,
    required this.projectGoalEnabled,
    required this.projectMonthlyTargetKw,
    required this.projectPerKwCommission,
    required this.projectTypes,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.partnersCreatedCount,
  });

  factory CompanyUser.fromJson(Map<String, dynamic> json) {
    return CompanyUser(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      district: json['district'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      partnerGoalsEnabled: json['partnerGoalsEnabled'] ?? false,
      partnerMonthlyTargetKw: json['partnerMonthlyTargetKw'] ?? 0,
      partnerPerKwCommission: json['partnerPerKwCommission'] ?? 0,
      partnerQuotePermissions:
      PartnerQuotePermissions.fromJson(json['partnerQuotePermissions'] ?? {}),
      partnerTypes: (json['partnerTypes'] as List?)
          ?.map((e) => PartnerType.fromJson(e))
          .toList() ??
          [],
      projectGoalEnabled: json['projectGoalEnabled'] ?? false,
      projectMonthlyTargetKw: json['projectMonthlyTargetKw'] ?? 0,
      projectPerKwCommission: json['projectPerKwCommission'] ?? 0,
      projectTypes: (json['projectTypes'] as List?)
          ?.map((e) => ProjectType.fromJson(e))
          .toList() ??
          [],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
      partnersCreatedCount: json['partnersCreatedCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'fullName': fullName,
    'mobileNumber': mobileNumber,
    'emailAddress': emailAddress,
    'district': district,
    'role': role,
    'status': status,
    'partnerGoalsEnabled': partnerGoalsEnabled,
    'partnerMonthlyTargetKw': partnerMonthlyTargetKw,
    'partnerPerKwCommission': partnerPerKwCommission,
    'partnerQuotePermissions': partnerQuotePermissions.toJson(),
    'partnerTypes': partnerTypes.map((e) => e.toJson()).toList(),
    'projectGoalEnabled': projectGoalEnabled,
    'projectMonthlyTargetKw': projectMonthlyTargetKw,
    'projectPerKwCommission': projectPerKwCommission,
    'projectTypes': projectTypes.map((e) => e.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': version,
    'partnersCreatedCount': partnersCreatedCount,
  };
}

class PartnerQuotePermissions {
  final bool create;
  final bool edit;
  final bool delete;

  PartnerQuotePermissions({
    required this.create,
    required this.edit,
    required this.delete,
  });

  factory PartnerQuotePermissions.fromJson(Map<String, dynamic> json) {
    return PartnerQuotePermissions(
      create: json['create'] ?? false,
      edit: json['edit'] ?? false,
      delete: json['delete'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'create': create,
    'edit': edit,
    'delete': delete,
  };
}

class PartnerType {
  final String type;        // can be ID or name
  final int count;
  final DateTime deadline;
  final String id;

  PartnerType({
    required this.type,
    required this.count,
    required this.deadline,
    required this.id,
  });

  factory PartnerType.fromJson(Map<String, dynamic> json) {
    return PartnerType(
      type: json['type'] ?? '',
      count: json['count'] ?? 0,
      deadline: DateTime.tryParse(json['deadline'] ?? '') ?? DateTime.now(),
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'count': count,
    'deadline': deadline.toIso8601String(),
    '_id': id,
  };
}

class ProjectType {
  final String type;
  final int count;
  final DateTime deadline;
  final String id;

  ProjectType({
    required this.type,
    required this.count,
    required this.deadline,
    required this.id,
  });

  factory ProjectType.fromJson(Map<String, dynamic> json) {
    return ProjectType(
      type: json['type'] ?? '',
      count: json['count'] ?? 0,
      deadline: DateTime.tryParse(json['deadline'] ?? '') ?? DateTime.now(),
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'count': count,
    'deadline': deadline.toIso8601String(),
    '_id': id,
  };
}