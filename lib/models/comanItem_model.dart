
class CommonItemModel {
  final String id;               // _id
  final String name;             // name
  final String? description;     // description (nullable)
  final bool? status;            // status (nullable if not always present)
  final String? createdBy;       // createdBy
  final String? updatedBy;       // updatedBy
  final DateTime? createdAt;     // createdAt
  final DateTime? updatedAt;     // updatedAt
  final String? uniqueId;        // unique_id
  final int? version;            // __v
  final String? projectTypeId;   // projectTypeId (only for some items)

  CommonItemModel({
    required this.id,
    required this.name,
    this.description,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.uniqueId,
    this.version,
    this.projectTypeId,
  });

  factory CommonItemModel.fromJson(Map<String, dynamic> json) {
    return CommonItemModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      status: json['status'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      uniqueId: json['unique_id'],
      version: json['__v'],
      projectTypeId: json['projectTypeId'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'status': status,
    'createdBy': createdBy,
    'updatedBy': updatedBy,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'unique_id': uniqueId,
    '__v': version,
    'projectTypeId': projectTypeId,
  };
}