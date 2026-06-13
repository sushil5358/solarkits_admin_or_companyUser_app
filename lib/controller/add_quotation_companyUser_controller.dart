import 'dart:convert';

import 'package:admin_app_new/custome_snackbar.dart';
import 'package:admin_app_new/models/brand_model.dart';
import 'package:admin_app_new/models/solarPanel_model.dart';
import 'package:admin_app_new/sevices/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bosKit_model.dart';
import '../models/comanItem_model.dart';
import '../models/combokit_Model.dart';
import '../models/customizeKit_model.dart';
import '../models/inverter_model.dart';
import '../models/quickQuote_model.dart';
import '../screens/all_quotes/admin_quotes.dart';

class AddQuotationCompanyuserController extends GetxController{
  final String quoteId;
  AddQuotationCompanyuserController({required this.quoteId});
  ApiService _apiService = ApiService();


   TextEditingController customerNameController = TextEditingController();
   TextEditingController customerNumberController = TextEditingController();
   TextEditingController dateController = TextEditingController();

  TextEditingController structureChargesController = TextEditingController();
  TextEditingController installationChargesController = TextEditingController();
  TextEditingController myMarginController = TextEditingController();
  TextEditingController discountController = TextEditingController();
   TextEditingController remarkController = TextEditingController();

  RxString strutureChargesPerKW = ''.obs;
  RxString installationChargesPerKW = ''.obs;
  RxString myMarginPerKW = ''.obs;
  RxString discountPerKW = ''.obs;
  RxString selectedTimeSlot = ''.obs;


  var categoryList = <CommonItemModel>[].obs;
  RxString selectedCategoryIds = ''.obs;

  var subCategoryList = <CommonItemModel>[].obs;
  RxString selectedSubCategoryIds = ''.obs;

  var projectTypeList = <CommonItemModel>[].obs;
  RxString selectedProjectTypesIds = ''.obs;

  var subProjectTypeList = <CommonItemModel>[].obs;
  RxString selectedSubProjectTypeIds = ''.obs;

  var stateList = <CommonItemModel>[].obs;
  RxString selectedStateIds = ''.obs;

  var distrcitList = <CommonItemModel>[].obs;
  RxString selectedDistrictIds = ''.obs;

  var cityList = <CommonItemModel>[].obs;
  RxString selectedCityIds = ''.obs;

  var brandList = <CommonItemModel>[].obs;
  RxString selectedBrandIds = ''.obs;

  var technologyList = <CommonItemModel>[].obs;
  RxString selectedTechnologyIds = ''.obs;


  var panelWattList = <CommonItemModel>[].obs;
  RxString selectedPanelWattIds = ''.obs;

  var noOfPanelsList = <CommonItemModel>[].obs;
  RxString selectedNoOfPanels = ''.obs;

  var kilowattList = <CommonItemModel>[].obs;
  RxString selectedKilowattIds = ''.obs;

  var terraceTypesList = <CommonItemModel>[].obs;
  RxString selectedTerraceTypeIds = ''.obs;


  var solarPanelList = <SolarPanelModel>[].obs;
  RxString selectedPanelIds = ''.obs;

  var inverterList = <InverterModel>[].obs;
  RxString selectedInverterIds = ''.obs;

  var bosKitList = <BosKitModel>[].obs;
  RxString selectedBosKitIds = ''.obs;

  var quickQuoteList =  <QuickQuoteModel>[].obs;
  QuickQuoteModel? quoteModel;

  // In add_quotation_companyuser_controller.dart
  var comboKitItems = <ComboKitModel>[].obs;
  var selectedComboKitId = RxString('');
  RxString selectedKitPrice = ''.obs;

  var customizeKit = Rx<CustomizeKitModel?>(null);

  RxBool isLoading = false.obs;
  String userId = '';
  RxString gstValue = ''.obs;

  RxString kitType = 'Combo Kit'.obs;
  RxString fileType = 'Cash File'.obs;
  RxString loanType = 'NBFC Loan'.obs;

  RxString subTotalAmount = ''.obs;
  RxString gstAmount = ''.obs;
  RxString roundOffAmount = ''.obs;
  RxString grandTotalAmount = ''.obs;

  RxBool showComboCompare = false.obs;
  RxBool showCustomize = false.obs;
  RxBool showChannelPartnerCharges = false.obs;

  RxBool isStructureCharges = false.obs;
  RxBool isInstallationCharges = false.obs;
  RxBool isMyMargin = false.obs;
  RxBool isDiscount = false.obs;







  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getId();
  }


  getId()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    userId = sp.getString('uniqueId') ?? '';
    print('userId $userId');
    getDistrict();
    getCategory();
    getTerraceType();
    print('quote id in controller $quoteId');
    if(quoteId.isNotEmpty){
      getQuoteById();
    }
  }



  Future<void> getQuoteById()async{
    isLoading.value = true;
    http.Response response = await _apiService.getQuoteById(quoteId);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      // List<dynamic> data = jsonResponse['data'];
      // print('data $data');
      // quickQuoteList.value = data.map((item) => QuickQuoteModel.fromJson(item)).toList();
      // quoteModel = quickQuoteList.first;
      quoteModel = QuickQuoteModel.fromJson(jsonResponse['data']);


      kitType.value = quoteModel!.kitType;
      fileType.value = quoteModel!.paymentType;
      loanType.value = quoteModel!.loanType;
      customerNameController.text = quoteModel!.name;
      customerNumberController.text = quoteModel!.phoneNumber;
      selectedDistrictIds.value = quoteModel!.district.id;
      selectedCategoryIds.value = quoteModel!.category.id;
      await getSubCategory();
      selectedSubCategoryIds.value = quoteModel!.subCategory.id;
      await getProjectTypes();
      selectedProjectTypesIds.value = quoteModel!.projectType!.id;
      await getSubProjectTypes();
      selectedSubProjectTypeIds.value = quoteModel!.subProjectType.id;
      await getSolarBrands();
      selectedBrandIds.value = quoteModel!.brand.id;
      await getTechnology();
      selectedTechnologyIds.value = quoteModel!.technology.id;
      await getSolarPanelWatt();
      selectedPanelWattIds.value = quoteModel!.solarPanelWatt.id;
      await getNoOfPanels();
      selectedNoOfPanels.value = quoteModel!.numberOfSolarPanel.toString();
      await getKilowatt();
      selectedKilowattIds.value = quoteModel!.kilowatt.toString();
      await getGst();
      await getComboKits();
      await getSolarPanels();
      await getInverter();
      await getBosKit();

      if(quoteModel!.kitType == 'Combo Kit'){

        selectedComboKitId.value = quoteModel!.comboKit.id;
        ComboKitModel combo =  comboKitItems.firstWhere((element) {
          return element.kitId == selectedComboKitId.value;
        },);
        selectedKitPrice.value = combo.finalPrice;
        showComboCompare.value  = true;


      }else{
        selectedPanelIds.value = quoteModel!.solarPanel;
        selectedInverterIds.value = quoteModel!.solarInverter;
        selectedBosKitIds.value = quoteModel!.bosKit;
        getCustomizeKit();
        showCustomize.value = true;
        
        print('selectedPanelIds.value === ${selectedPanelIds.value}');
        print('selectedInverterIds.value === ${selectedInverterIds.value}');
        print('selectedBosKitIds.value === ${selectedBosKitIds.value}');

      }


      await getTerraceType();
      selectedTerraceTypeIds.value = quoteModel!.terraceType.id;
      await getPartnerRates().then((value) {
        structureChargesController.text = quoteModel!.structureCharge.toString();
        installationChargesController.text = quoteModel!.installationCharge.toString();
        myMarginController.text = quoteModel!.agentMarginCommission.toString();
        subTotalAmount.value = quoteModel!.subTotal.toString();
        gstAmount.value = quoteModel!.gst.toString();
        roundOffAmount.value = quoteModel!.roundOff.toString();
        grandTotalAmount.value = quoteModel!.grandTotal.toString();
        showChannelPartnerCharges.value = true;

      },);

      print('quickQuoteList.value ${quickQuoteList.value}');
    } else {
      showCustomSnackBar(Get.context!, message: jsonResponse['message'], backgroundColor: Colors.red);

      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }




  void calculateTotalAmount() {
    // Parse values, default to 0 if empty/invalid
    double kitAmount = double.tryParse(selectedKitPrice.value) ?? 0.0;
    double strutureCharges = double.tryParse(structureChargesController.text) ?? 0;
    double installationCharges = double.tryParse(installationChargesController.text) ?? 0;
    double myMargin = double.tryParse(myMarginController.text) ?? 0;
    double discount = double.tryParse(discountController.text) ?? 0;

    print('kitAmount $kitAmount');
    print('strutureCharges $strutureCharges');
    print('installationCharges $installationCharges');
    print('myMargin $myMargin');
    print('discount $discount');

    // Subtotal
    double subTotal = kitAmount + strutureCharges + installationCharges + myMargin - discount; // discount should be subtracted

    // GST (18%)
    double gst = subTotal * 18 / 100;

    // Total before round off
    double totalBeforeRound = subTotal + gst;

    // Round off to nearest integer (standard practice)
    int grandTotal = totalBeforeRound.round();

    // Round off amount (difference after rounding)
    int roundOff = grandTotal - totalBeforeRound.toInt(); // or grandTotal - totalBeforeRound

    // Update observable variables (assuming you have these in controller)
    subTotalAmount.value = subTotal.toStringAsFixed(2).toString();
    gstAmount.value = gst.toStringAsFixed(2).toString();
    roundOffAmount.value = roundOff.toString();
    grandTotalAmount.value = grandTotal.toString();
  }


  Future<void> getInverter() async {
    isLoading.value = true;
    http.Response response = await _apiService.getInverter();

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      inverterList.value = data
          .map((item) => InverterModel.fromJson(item))
          .toList();
      print('inverterList.value ${inverterList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;
  }

  void clearSelection(){
    selectedKitPrice.value = '';
    selectedComboKitId.value = '';
    selectedPanelIds.value = '';
    selectedInverterIds.value = '';
    selectedBosKitIds.value = '';
    showComboCompare.value = false;
    showCustomize.value = false;
    showChannelPartnerCharges.value = false;
  }



  Future<void> addQuotation()async{
    isLoading.value = true;

    http.Response response;
   response = await  _apiService.addQuotation(
        quoteId: quoteId,
        userId: userId,
       name: customerNameController.text,
       number: customerNumberController.text,
       kitType: kitType.value,
       fileType: fileType.value,
       loanType: loanType.value,
       districtId: selectedDistrictIds.value,
       categoryId: selectedCategoryIds.value,
       subCategoryId: selectedSubCategoryIds.value,
       projectTypeId: selectedProjectTypesIds.value,
       subProjectTypeID: selectedSubProjectTypeIds.value,
       brandId: selectedBrandIds.value,
       technologyId: selectedTechnologyIds.value,
       panelWattId: selectedPanelWattIds.value,
       noOfPanels: selectedNoOfPanels.value,
       kilowattId: selectedKilowattIds.value,
       comboKitId: selectedComboKitId.value,
       panelId: selectedPanelIds.value,
       inverterId: selectedInverterIds.value,
       bosKitId: selectedBosKitIds.value,
       terraceTypeId: selectedTerraceTypeIds.value,
       strutureCharges: structureChargesController.text,
       installationCharges: installationChargesController.text,
       myMargin: myMarginController.text,
       discount: discountController.text,
       subTotal: subTotalAmount.value,
       gst: gstAmount.value,
       roundOff: roundOffAmount.value,
       grandTotal: grandTotalAmount.value,
       scheduleDate: dateController.text,
       timeSlot: selectedTimeSlot.value,
       remark: remarkController.text


   );

   var extractData = jsonDecode(response.body);
   print('extractData $extractData');

   if(extractData['success'] == true){
     showCustomSnackBar(Get.context!, message: extractData['message'], backgroundColor: Colors.green);
     isLoading.value = false;
     Get.off(() => QuotesManagementScreen());

   }else{
     showCustomSnackBar(Get.context!, message: extractData['message'], backgroundColor: Colors.red);
     print('API error: ${extractData['message']}');
   }

   isLoading.value = false;

  }



  Future<void> getCustomizeKit()async{
    isLoading.value = true;
    http.Response response = await _apiService.getCustomizeKit(selectedPanelIds.value, selectedInverterIds.value, selectedBosKitIds.value, selectedNoOfPanels.value, selectedKilowattIds.value);
    var extractData = jsonDecode(response.body);

    if(extractData['success'] == true){
      print('extractData $extractData');

      customizeKit.value  = CustomizeKitModel.fromJson(extractData['data']);
      selectedKitPrice.value = customizeKit.value?.finalPrice.toString() ?? '';
      calculateTotalAmount();
      print('selectedKitPrice.value ${selectedKitPrice.value}');
      print('customizeKit.value?.finalPrice.toString() ${ customizeKit.value?.finalPrice.toString()}');

    }else{
      print('API error: ${extractData['message']}');

    }
    isLoading.value = false;
  }


  Future<void> getBosKit() async {
    isLoading.value = true;
    http.Response response = await _apiService.getBosKit();

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      bosKitList.value = data
          .map((item) => BosKitModel.fromJson(item))
          .toList();
      print('bosKitList.value ${bosKitList}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }


  Future<void> getGst()async{
    isLoading.value = true;

    http.Response response = await _apiService.getGst(selectedCategoryIds.value, selectedProjectTypesIds.value, selectedSubProjectTypeIds.value);
    var extractData = jsonDecode(response.body);

    if(extractData['success'] == true){
      gstValue.value = extractData['data']['gstRate'].toString();

    }else{
      print('API error: ${extractData['message']}');

    }
    isLoading.value = false;
  }



  Future<void> getPartnerRates() async{
    isLoading.value = true;
    http.Response response = await _apiService.getPartnerRates(selectedCategoryIds.value, selectedProjectTypesIds.value, userId);
    var extractData = jsonDecode(response.body);

    if(extractData['success'] == true){
      double kw = double.tryParse(selectedKilowattIds.value)??0.0;

      isStructureCharges.value = extractData['data']['structureCharge']['enabled'];
      isInstallationCharges.value = extractData['data']['installationCharge']['enabled'];
      isMyMargin.value = extractData['data']['agentMargin']['enabled'];
      isDiscount.value = extractData['data']['discount']['enabled'];

      strutureChargesPerKW.value = extractData['data']['structureCharge']['value'].toString();
      installationChargesPerKW.value = extractData['data']['installationCharge']['value'].toString();
      myMarginPerKW.value = extractData['data']['agentMargin']['value'].toString();
      discountPerKW.value = extractData['data']['discount']['value'].toString();

      int strutureCharges = ((int.tryParse(strutureChargesPerKW.value) ?? 0) * kw).toInt();
      int installationCharges = ((int.tryParse(installationChargesPerKW.value) ?? 0) * kw).toInt();
      int myMargin = ((int.tryParse(myMarginPerKW.value) ?? 0) * kw).toInt();
      int discount = ((int.tryParse(discountPerKW.value) ?? 0) * kw).toInt();

      structureChargesController.text = strutureCharges.toString();
      installationChargesController.text = installationCharges.toString();
      myMarginController.text = myMargin.toString();
      discountController.text = discount.toString();

      calculateTotalAmount();




    }else{
      print('API error: ${extractData['message']}');
    }




    isLoading.value = false;
  }


  Future<void> getTerraceType() async {
    isLoading.value = true;
    http.Response response = await _apiService.getTerraceType();

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      terraceTypesList.value = data.map((item) => CommonItemModel.fromJson(item)).toList();
      selectedTerraceTypeIds.value = terraceTypesList.first.id;
      print('terraceTypesList.value ${terraceTypesList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }


  Future<void> getSolarPanels() async {
    isLoading.value = true;
    http.Response response = await _apiService.getSolarPanels(selectedCategoryIds.value,selectedSubProjectTypeIds.value,selectedBrandIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      solarPanelList.value = data
          .map((item) => SolarPanelModel.fromJson(item))
          .toList();
      print('solarPanelList.value ${solarPanelList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }





  Future<void> getComboKits() async {
    isLoading.value = true;
    http.Response response = await _apiService.getComboKits(selectedBrandIds.value,selectedKilowattIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      comboKitItems.value = data
          .map((item) => ComboKitModel.fromJson(item))
          .toList();
      print('comboKitItems.value ${comboKitItems.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }




  Future<void> getDistrict() async {
    isLoading.value = true;
    http.Response response = await _apiService.getDistrict_ForAddQuote(userId);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      print('data $data');
      distrcitList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('distrcitList.value $distrcitList.value');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }


  Future<void> getCategory() async {

    isLoading.value = true;
      http.Response response = await _apiService.getCategory();

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['success'] == true) {
        List<dynamic> data = jsonResponse['data'];
        print('data $data');
        categoryList.value = data
            .map((item) => CommonItemModel.fromJson(item))
            .toList();
        print('categoryList.value $categoryList.value');
      } else {
        print('API error: ${jsonResponse['message']}');
      }

    isLoading.value = false;
  }


  Future<void> getSubCategory() async {
    isLoading.value = true;
    http.Response response = await _apiService.getSubCategory(selectedCategoryIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      subCategoryList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('categoryList.value $categoryList.value');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;
  }


  Future<void> getProjectTypes() async {
    isLoading.value = true;
    http.Response response = await _apiService.getProjectTypes(selectedSubCategoryIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      projectTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('categoryList.value $categoryList.value');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }

  Future<void> getSubProjectTypes() async {

    isLoading.value = true;
    http.Response response = await _apiService.getSubProjectTypes(selectedProjectTypesIds.value);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      subProjectTypeList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('categoryList.value ${subProjectTypeList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }





  Future<void> getSolarBrands() async {
    isLoading.value = true;

    http.Response response = await _apiService.getSolarBrands();
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      brandList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('brandList.value ${brandList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;

  }


  Future<void> getTechnology() async {
    isLoading.value = true;

    http.Response response = await _apiService.getTechnology();
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      technologyList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('technologyList.value ${technologyList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }

    isLoading.value = false;

  }



  Future<void> getSolarPanelWatt() async {
    isLoading.value = true;

    http.Response response = await _apiService.getSolarPanelWatt();
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      panelWattList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('panelWattList.value ${panelWattList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }


  Future<void> getNoOfPanels() async {
    isLoading.value = true;

    http.Response response = await _apiService.getNoOfPanels(selectedCategory: selectedCategoryIds.value, selectedSubCategory: selectedSubCategoryIds.value, selectedProjectType: selectedProjectTypesIds.value, brandId: selectedBrandIds.value, selectedTechnology: selectedTechnologyIds.value, selectedPanelWatt: selectedPanelWattIds.value);
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data']['availableSolarPanelNumbers'];
      noOfPanelsList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('noOfPanelsList.value ${noOfPanelsList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }


  Future<void> getKilowatt() async {
    isLoading.value = true;

    http.Response response = await _apiService.getKilowatt(selectedPanelWattIds.value,selectedNoOfPanels.value);
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['success'] == true) {
      List<dynamic> data = jsonResponse['data'];
      kilowattList.value = data
          .map((item) => CommonItemModel.fromJson(item))
          .toList();
      print('kilowattList.value ${kilowattList.value}');
    } else {
      print('API error: ${jsonResponse['message']}');
    }
    isLoading.value = false;

  }








}