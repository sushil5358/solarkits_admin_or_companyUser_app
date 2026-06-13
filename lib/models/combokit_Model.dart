// combo_kit_model.dart

class ComboKitModel {
  final String kitId;
  final String name;
  final String status;
  final String? image;
  final String panelBrand;
  final String? panelBrandImage;
  final String inverterBrand;
  final String? inverterBrandImage;
  final int panelSkuCount;
  final int inverterSkuCount;
  final int benchmarkPrice;
  final int marketPrice;
  final int gst;
  final String benchmarkPriceFormatted;
  final String marketPriceFormatted;
  final String finalPriceFormatted;
  final String gstFormatted;
  final String finalPrice;

  ComboKitModel({
    required this.kitId,
    required this.name,
    required this.status,
    this.image,
    required this.panelBrand,
    this.panelBrandImage,
    required this.inverterBrand,
    this.inverterBrandImage,
    required this.panelSkuCount,
    required this.inverterSkuCount,
    required this.benchmarkPrice,
    required this.marketPrice,
    required this.gst,
    required this.benchmarkPriceFormatted,
    required this.marketPriceFormatted,
    required this.finalPriceFormatted,
    required this.gstFormatted,
    required this.finalPrice,
  });

  factory ComboKitModel.fromJson(Map<String, dynamic> json) {
    return ComboKitModel(
      kitId: json['kitId'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      image: json['image'],
      panelBrand: json['panelBrand'] ?? '',
      panelBrandImage: json['panelBrandImage'],
      inverterBrand: json['inverterBrand'] ?? '',
      inverterBrandImage: json['inverterBrandImage'],
      panelSkuCount: json['panelSkuCount'] ?? 0,
      inverterSkuCount: json['inverterSkuCount'] ?? 0,
      benchmarkPrice: json['benchmarkPrice'] ?? 0,
      marketPrice: json['marketPrice'] ?? 0,
      gst: json['gst'] ?? 0,
      finalPrice: json['finalPrice'].toString() ,
      benchmarkPriceFormatted: json['benchmarkPriceFormatted'] ?? '',
      marketPriceFormatted: json['marketPriceFormatted'] ?? '',
      finalPriceFormatted: json['finalPriceFormatted'] ?? '',
      gstFormatted: json['gstFormatted'] ?? '',
    );
  }
}

/// Wrapper for the API response (only `data` list)
class ComboKitResponse {
  final List<ComboKitModel> kits;

  ComboKitResponse({required this.kits});

  factory ComboKitResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    return ComboKitResponse(
      kits: data.map((item) => ComboKitModel.fromJson(item)).toList(),
    );
  }
}