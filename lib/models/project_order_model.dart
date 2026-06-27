// models/project_order_model.dart
import 'dart:convert';

List<ProjectOrderModel> projectOrderModelFromJson(String str) =>
    List<ProjectOrderModel>.from(json.decode(str)['orders'].map((x) => ProjectOrderModel.fromJson(x)));

class ProjectOrderModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String date;
  final String time;
  final String remark;
  final District? district;
  final Category? category;
  final SubCategory? subCategory;
  final ProjectType? projectType;
  final SubProjectType? subProjectType;
  final Brand? brand;
  final Technology? technology;
  final SolarPanelWatt? solarPanelWatt;
  final int numberOfSolarPanel;
  final double kilowatt;
  final String kitType;
  final ComboKit? comboKit;
  final AmcPlan? amcPlan;
  final List<AmcService> amcServices;
  final String solarPanel;
  final String solarInverter;
  final String bosKit;
  final String paymentType;
  final String loanType;
  final dynamic channelPartnerCharge;
  final TerraceType? terraceType;
  final double structureCharge;
  final double installationCharge;
  final double agentMarginCommission;
  final dynamic companyMargin;
  final double discount;
  final double subTotal;
  final double gst;
  final int roundOff;
  final int grandTotal;
  final String userId;
  final bool userAgress;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String quoteNumber;
  final int v;
  final String image;
  final String panelBrand;
  final String inverterBrand;
  final String panelBrandImage;
  final String inverterBrandImage;
  final String webViewUrl;
  final String pdfDownloadUrl;
  final String agreementUrl;
  final String projectOrderId;
  final String? orderId;
  final DateTime? orderDate;
  final int expectedDate;
  final bool paymentPending;
  final bool orderCreated;
  final bool atWarehouse;
  final bool willDeliver;
  final bool inTransit;
  final bool delivered;
  final DateTime? orderCreatedAt;
  final DateTime? orderUpdatedAt;
  final int totalPanels;
  final int totalPanelWatt;

  ProjectOrderModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.date,
    required this.time,
    required this.remark,
    this.district,
    this.category,
    this.subCategory,
    this.projectType,
    this.subProjectType,
    this.brand,
    this.technology,
    this.solarPanelWatt,
    required this.numberOfSolarPanel,
    required this.kilowatt,
    required this.kitType,
    this.comboKit,
    this.amcPlan,
    required this.amcServices,
    required this.solarPanel,
    required this.solarInverter,
    required this.bosKit,
    required this.paymentType,
    required this.loanType,
    this.channelPartnerCharge,
    this.terraceType,
    required this.structureCharge,
    required this.installationCharge,
    required this.agentMarginCommission,
    this.companyMargin,
    required this.discount,
    required this.subTotal,
    required this.gst,
    required this.roundOff,
    required this.grandTotal,
    required this.userId,
    required this.userAgress,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.quoteNumber,
    required this.v,
    required this.image,
    required this.panelBrand,
    required this.inverterBrand,
    required this.panelBrandImage,
    required this.inverterBrandImage,
    required this.webViewUrl,
    required this.pdfDownloadUrl,
    required this.agreementUrl,
    required this.projectOrderId,
    this.orderId,
    this.orderDate,
    required this.expectedDate,
    required this.paymentPending,
    required this.orderCreated,
    required this.atWarehouse,
    required this.willDeliver,
    required this.inTransit,
    required this.delivered,
    this.orderCreatedAt,
    this.orderUpdatedAt,
    required this.totalPanels,
    required this.totalPanelWatt,
  });

  factory ProjectOrderModel.fromJson(Map<String, dynamic> json) {
    // Helper to parse DateTime safely
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      try {
        return DateTime.parse(value.toString());
      } catch (_) {
        return null;
      }
    }

    // Helper to get nested object safely
    T? safeGet<T>(dynamic value, T Function(Map<String, dynamic>) fromJson) {
      if (value == null || value is! Map<String, dynamic>) return null;
      return fromJson(value);
    }

    return ProjectOrderModel(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      date: json["date"] ?? '',
      time: json["time"] ?? '',
      remark: json["remark"] ?? '',
      district: safeGet<District>(json["district"], District.fromJson),
      category: safeGet<Category>(json["category"], Category.fromJson),
      subCategory: safeGet<SubCategory>(json["subCategory"], SubCategory.fromJson),
      projectType: safeGet<ProjectType>(json["projectType"], ProjectType.fromJson),
      subProjectType: safeGet<SubProjectType>(json["subProjectType"], SubProjectType.fromJson),
      brand: safeGet<Brand>(json["brand"], Brand.fromJson),
      technology: safeGet<Technology>(json["technology"], Technology.fromJson),
      solarPanelWatt: safeGet<SolarPanelWatt>(json["solarPanelWatt"], SolarPanelWatt.fromJson),
      numberOfSolarPanel: json["numberOfSolarPanel"] ?? 0,
      kilowatt: (json["kilowatt"] ?? 0).toDouble(),
      kitType: json["kitType"] ?? '',
      comboKit: safeGet<ComboKit>(json["comboKit"], ComboKit.fromJson),
      amcPlan: safeGet<AmcPlan>(json["amcPlan"], AmcPlan.fromJson),
      amcServices: (json["amcServices"] as List?)?.map((x) => AmcService.fromJson(x)).toList() ?? [],
      solarPanel: json["solarPanel"] ?? '',
      solarInverter: json["solarInverter"] ?? '',
      bosKit: json["bosKit"] ?? '',
      paymentType: json["paymentType"] ?? '',
      loanType: json["loanType"] ?? '',
      channelPartnerCharge: json["channelPartnerCharge"],
      terraceType: safeGet<TerraceType>(json["terraceType"], TerraceType.fromJson),
      structureCharge: (json["structureCharge"] ?? 0).toDouble(),
      installationCharge: (json["installationCharge"] ?? 0).toDouble(),
      agentMarginCommission: (json["agentMarginCommission"] ?? 0).toDouble(),
      companyMargin: json["companyMargin"],
      discount: (json["discount"] ?? 0).toDouble(),
      subTotal: (json["subTotal"] ?? 0).toDouble(),
      gst: (json["gst"] ?? 0).toDouble(),
      roundOff: json["roundOff"] ?? 0,
      grandTotal: json["grandTotal"] ?? 0,
      userId: json["userId"] ?? '',
      userAgress: json["userAgress"] ?? false,
      status: json["status"] ?? '',
      createdAt: parseDate(json["createdAt"]),
      updatedAt: parseDate(json["updatedAt"]),
      quoteNumber: json["quoteNumber"] ?? '',
      v: json["__v"] ?? 0,
      image: json["image"] ?? '',
      panelBrand: json["panelBrand"] ?? '',
      inverterBrand: json["inverterBrand"] ?? '',
      panelBrandImage: json["panelBrandImage"] ?? '',
      inverterBrandImage: json["inverterBrandImage"] ?? '',
      webViewUrl: json["webViewUrl"] ?? '',
      pdfDownloadUrl: json["pdfDownloadUrl"] ?? '',
      agreementUrl: json["agreementUrl"] ?? '',
      projectOrderId: json["projectOrderId"] ?? '',
      orderId: json["orderId"],
      orderDate: parseDate(json["orderDate"]),
      expectedDate: json["expectedDate"] ?? 0,
      paymentPending: json["paymentPending"] ?? false,
      orderCreated: json["orderCreated"] ?? false,
      atWarehouse: json["atWarehouse"] ?? false,
      willDeliver: json["willDeliver"] ?? false,
      inTransit: json["inTransit"] ?? false,
      delivered: json["delivered"] ?? false,
      orderCreatedAt: parseDate(json["orderCreatedAt"]),
      orderUpdatedAt: parseDate(json["orderUpdatedAt"]),
      totalPanels: json["totalPanels"] ?? 0,
      totalPanelWatt: json["totalPanelWatt"] ?? 0,
    );
  }
}

// ---- Nested Models (all nullable) ----
class District {
  final String id;
  final String name;
  District({required this.id, required this.name});
  factory District.fromJson(Map<String, dynamic> json) =>
      District(id: json["_id"] ?? '', name: json["name"] ?? '');
}

class Category {
  final String id;
  final String name;
  Category({required this.id, required this.name});
  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json["_id"] ?? '', name: json["name"] ?? '');
}

class SubCategory {
  final String id;
  final String name;
  SubCategory({required this.id, required this.name});
  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      SubCategory(id: json["_id"] ?? '', name: json["name"] ?? '');
}

class ProjectType {
  final String id;
  final int projectTypeFrom;
  final int projectTypeTo;
  ProjectType({required this.id, required this.projectTypeFrom, required this.projectTypeTo});
  factory ProjectType.fromJson(Map<String, dynamic> json) =>
      ProjectType(
        id: json["_id"] ?? '',
        projectTypeFrom: json["projectTypeFrom"] ?? 0,
        projectTypeTo: json["projectTypeTo"] ?? 0,
      );
}

class SubProjectType {
  final String id;
  final String name;
  SubProjectType({required this.id, required this.name});
  factory SubProjectType.fromJson(Map<String, dynamic> json) =>
      SubProjectType(id: json["_id"] ?? '', name: json["name"] ?? '');
}

class Brand {
  final String id;
  final String companyName;
  final String brand;
  Brand({required this.id, required this.companyName, required this.brand});
  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(
        id: json["_id"] ?? '',
        companyName: json["companyName"] ?? '',
        brand: json["brand"] ?? '',
      );
}

class Technology {
  final String id;
  final String name;
  Technology({required this.id, required this.name});
  factory Technology.fromJson(Map<String, dynamic> json) =>
      Technology(id: json["_id"] ?? '', name: json["name"] ?? '');
}

class SolarPanelWatt {
  final String id;
  final String name;
  SolarPanelWatt({required this.id, required this.name});
  factory SolarPanelWatt.fromJson(Map<String, dynamic> json) =>
      SolarPanelWatt(id: json["_id"] ?? '', name: json["name"] ?? '');
}

class ComboKit {
  final String id;
  final List<ComboKitItem> comboKits;
  final String solarkitName;
  ComboKit({required this.id, required this.comboKits, required this.solarkitName});
  factory ComboKit.fromJson(Map<String, dynamic> json) =>
      ComboKit(
        id: json["_id"] ?? '',
        comboKits: (json["comboKits"] as List?)?.map((x) => ComboKitItem.fromJson(x)).toList() ?? [],
        solarkitName: json["solarkitName"] ?? '',
      );
}

class ComboKitItem {
  final String name;
  final String image;
  final String panelBrand;
  final List<String> panelSkus;
  final String inverterBrand;
  final List<dynamic> inverterSkus;
  final String id;
  ComboKitItem({
    required this.name,
    required this.image,
    required this.panelBrand,
    required this.panelSkus,
    required this.inverterBrand,
    required this.inverterSkus,
    required this.id,
  });
  factory ComboKitItem.fromJson(Map<String, dynamic> json) =>
      ComboKitItem(
        name: json["name"] ?? '',
        image: json["image"] ?? '',
        panelBrand: json["panelBrand"] ?? '',
        panelSkus: (json["panelSkus"] as List?)?.map((e) => e.toString()).toList() ?? [],
        inverterBrand: json["inverterBrand"] ?? '',
        inverterSkus: (json["inverterSkus"] as List?) ?? [],
        id: json["_id"] ?? '',
      );
}

class AmcPlan {
  final String id;
  final String planName;
  final String category;
  final String subCategory;
  final String projectType;
  final String subProjectType;
  final double basicPricePerKw;
  final int amcServiceCharges;
  AmcPlan({
    required this.id,
    required this.planName,
    required this.category,
    required this.subCategory,
    required this.projectType,
    required this.subProjectType,
    required this.basicPricePerKw,
    required this.amcServiceCharges,
  });
  factory AmcPlan.fromJson(Map<String, dynamic> json) =>
      AmcPlan(
        id: json["_id"] ?? '',
        planName: json["planName"] ?? '',
        category: json["category"] ?? '',
        subCategory: json["subCategory"] ?? '',
        projectType: json["projectType"] ?? '',
        subProjectType: json["subProjectType"] ?? '',
        basicPricePerKw: (json["basicPricePerKw"] ?? 0).toDouble(),
        amcServiceCharges: json["amcServiceCharges"] ?? 0,
      );
}

class AmcService {
  final String id;
  final String serviceName;
  final String description;
  final int basePrice;
  AmcService({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.basePrice,
  });
  factory AmcService.fromJson(Map<String, dynamic> json) =>
      AmcService(
        id: json["_id"] ?? '',
        serviceName: json["serviceName"] ?? '',
        description: json["description"] ?? '',
        basePrice: json["basePrice"] ?? 0,
      );
}

class TerraceType {
  final String id;
  final String name;
  TerraceType({required this.id, required this.name});
  factory TerraceType.fromJson(Map<String, dynamic> json) =>
      TerraceType(id: json["_id"] ?? '', name: json["name"] ?? '');
}