// lib/screens/price_table_screen.dart

import 'package:admin_app_new/screens/price_table_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class PriceTableScreen extends StatefulWidget {
  const PriceTableScreen({super.key});

  @override
  State<PriceTableScreen> createState() => _PriceTableScreenState();
}

class _PriceTableScreenState extends State<PriceTableScreen> {
  // Filter selections
  List<String> selectedCategories = [];
  List<String> selectedSubCategories = [];
  List<String> selectedProjectTypes = [];
  List<String> selectedSubProjectTypes = [];

  // Multi-select selections
  List<String> selectedComboIds = [];
  List<String> selectedPanelWatts = [];
  String selectedKwId = '';
  String marginAmount = '0';

  final List<String> categoryOptions = [
    'Residential',
    'Commercial',
    'Industrial',
    'Agricultural',
    'Government',
  ];

  final List<String> subCategoryOptions = [
    'Rooftop Solar',
    'Ground Mount',
    'Floating Solar',
    'Hybrid System',
    'Off-Grid System',
  ];

  final List<String> projectTypeOptions = [
    'New Installation',
    'Upgrade Existing',
    'Maintenance Contract',
    'AMC Service',
    'Turnkey Project',
    'EPC Contract',
  ];

  final List<String> subProjectTypeOptions = [
    'On Grid',
    'Off Grid',
    'Hybrid',
  ];

  final List<Map<String, dynamic>> comboKits = [
    {'id': '1', 'name': 'Basic Solar Kit', 'price': '45000'},
    {'id': '2', 'name': 'Premium Solar Kit', 'price': '65000'},
    {'id': '3', 'name': 'Economy Solar Kit', 'price': '35000'},
    {'id': '4', 'name': 'Heavy Duty Kit', 'price': '85000'},
  ];

  final List<Map<String, dynamic>> kwOptions = [
    {'id': '1', 'kilowat': '1', 'no_of_panel': '3', 'total_subsidy': '5000'},
    {'id': '2', 'kilowat': '2', 'no_of_panel': '6', 'total_subsidy': '10000'},
    {'id': '3', 'kilowat': '3', 'no_of_panel': '9', 'total_subsidy': '15000'},
    {'id': '4', 'kilowat': '4', 'no_of_panel': '12', 'total_subsidy': '20000'},
    {'id': '5', 'kilowat': '5', 'no_of_panel': '15', 'total_subsidy': '25000'},
    {'id': '6', 'kilowat': '6', 'no_of_panel': '18', 'total_subsidy': '30000'},
    {'id': '7', 'kilowat': '7', 'no_of_panel': '21', 'total_subsidy': '35000'},
    {'id': '8', 'kilowat': '8', 'no_of_panel': '24', 'total_subsidy': '40000'},
    {'id': '9', 'kilowat': '9', 'no_of_panel': '27', 'total_subsidy': '45000'},
    {'id': '10', 'kilowat': '10', 'no_of_panel': '30', 'total_subsidy': '50000'},
  ];

  final List<String> panelWatts = ['400', '540', '650'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Price Table',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Column(
              children: [
                // First Row - Combo Kit and Panel Watt
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildCustomMultiSelect(
                        label: 'Combo Kit',
                        selectedValues: selectedComboIds,
                        items: comboKits,
                        onConfirm: (values) {
                          setState(() {
                            selectedComboIds = values;
                          });
                        },
                        hint: 'Select Kit',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildCustomMultiSelect(
                        label: 'Panel Watt',
                        selectedValues: selectedPanelWatts,
                        items: panelWatts.map((w) => {'id': w, 'name': '$w WP'}).toList(),
                        onConfirm: (values) {
                          setState(() {
                            selectedPanelWatts = values;
                          });
                        },
                        hint: 'Select Watt',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Second Row - System Size and Margin
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        label: 'System Size',
                        value: selectedKwId,
                        items: kwOptions.map((kw) => {
                          'id': kw['id'].toString(),
                          'name': '${kw['kilowat']} KW (${kw['no_of_panel']} Panels)',
                        }).toList(),
                        onChanged: (value) => setState(() => selectedKwId = value!),
                        hint: 'Select KW',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Margin/Commission',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              hintText: 'Enter margin',
                              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                              suffixText: 'Suggest: 5000',
                              suffixStyle: const TextStyle(fontSize: 9, color: Colors.grey),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(() => marginAmount = value.isEmpty ? '0' : value),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: selectedComboIds.isNotEmpty && selectedKwId.isNotEmpty && selectedPanelWatts.isNotEmpty
                ? ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: selectedComboIds.length,
              itemBuilder: (context, comboIndex) {
                final selectedCombo = comboKits.firstWhere((k) => k['id'] == selectedComboIds[comboIndex]);
                return Column(
                  children: [
                    _buildPriceTable(selectedCombo),
                    if (comboIndex < selectedComboIds.length - 1)
                      const SizedBox(height: 16),
                  ],
                );
              },
            )
                : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.price_change, size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Please select all options to view price table',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomMultiSelect({
    required String label,
    required List<String> selectedValues,
    required List<Map<String, dynamic>> items,
    required Function(List<String>) onConfirm,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            _showMultiSelectDialog(context, selectedValues, items, onConfirm, label);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedValues.isEmpty
                        ? (hint ?? 'Select $label')
                        : '$label (${selectedValues.length})',
                    style: TextStyle(
                      fontSize: 13,
                      color: selectedValues.isEmpty ? Colors.grey : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showMultiSelectDialog(
      BuildContext context,
      List<String> selectedValues,
      List<Map<String, dynamic>> items,
      Function(List<String>) onConfirm,
      String title,
      ) {
    List<String> tempSelected = List.from(selectedValues);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text('Select $title'),
              content: Container(
                width: double.maxFinite,
                height: 300,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = tempSelected.contains(item['id'].toString());
                    return CheckboxListTile(
                      title: Text(item['name'].toString()),
                      value: isSelected,
                      activeColor: Colors.green,
                      onChanged: (bool? selected) {
                        setStateDialog(() {
                          if (selected == true) {
                            tempSelected.add(item['id'].toString());
                          } else {
                            tempSelected.remove(item['id'].toString());
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    onConfirm(tempSelected);
                    Navigator.pop(context);
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Data',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Project Type Multi-Select
                          const Text(
                            'Select Project Type',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          MultiSelectDialogField(
                            items:  [
                              MultiSelectItem('Residential', 'Residential'),
                              MultiSelectItem('Commercial', 'Commercial'),
                              MultiSelectItem('Industrial', 'Industrial'),
                            ],
                            title: const Text('Select Project Type'),
                            buttonText: const Text('Select Project Type'),
                            buttonIcon: const Icon(Icons.business_center),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ), onConfirm: (List<String> p1) {  },
                          ),
                          const SizedBox(height: 20),

                          // Sub Project Type Multi-Select
                          const Text(
                            'Select Sub Project Type',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          MultiSelectDialogField(
                            items:  [
                              MultiSelectItem('Off Grid', 'Off Grid'),
                              MultiSelectItem('On Grid', 'On Grid'),
                              MultiSelectItem('Hybrid', 'Hybrid'),
                            ],
                            title: const Text('Select Sub Project Type'),
                            buttonText: const Text('Select Sub Project Type'),
                            buttonIcon: const Icon(Icons.electrical_services),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ), onConfirm: (List<String> p1) {  },
                          ),
                          const SizedBox(height: 20),

                          // Category Multi-Select
                          const Text(
                            'Select Category',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          MultiSelectDialogField(
                            items:  [
                              MultiSelectItem('Solar Rooftop', 'Solar Rooftop'),
                              MultiSelectItem('Solar Pump', 'Solar Pump'),
                              MultiSelectItem('Solar Light', 'Solar Light'),
                            ],
                            title: const Text('Select Category'),
                            buttonText: const Text('Select Category'),
                            buttonIcon: const Icon(Icons.category),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ), onConfirm: (List<String> p1) {  },
                          ),
                          const SizedBox(height: 20),

                          // Sub Category Multi-Select
                          const Text(
                            'Select Sub Category',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          MultiSelectDialogField(
                            items:  [
                              MultiSelectItem('Residential 3 to 10 KW', 'Residential 3 to 10 KW'),
                              MultiSelectItem('Residential >3 KW', 'Residential >3 KW'),
                              MultiSelectItem('Common Meter', 'Common Meter'),
                            ],
                            title: const Text('Select Sub Category'),
                            buttonText: const Text('Select Sub Category'),
                            buttonIcon: const Icon(Icons.subdirectory_arrow_right),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ), onConfirm: (List<String> p1) {  },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red.shade400),
                            foregroundColor: Colors.red.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Clear All'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Apply Filters',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterMultiSelect({
    required String title,
    required List<String> items,
    required List<String> selectedValues,
    required Function(List<String>) onConfirm,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        _showFilterMultiSelectDialog(context, title, items, selectedValues, onConfirm, color);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedValues.isEmpty
                    ? title
                    : '$title (${selectedValues.length})',
                style: TextStyle(
                  fontSize: 14,
                  color: selectedValues.isEmpty ? Colors.grey : color,
                  fontWeight: selectedValues.isNotEmpty ? FontWeight.w500 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  void _showFilterMultiSelectDialog(
      BuildContext context,
      String title,
      List<String> items,
      List<String> selectedValues,
      Function(List<String>) onConfirm,
      Color color,
      ) {
    List<String> tempSelected = List.from(selectedValues);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(title),
              content: Container(
                width: double.maxFinite,
                height: 300,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = tempSelected.contains(item);
                    return CheckboxListTile(
                      title: Text(item),
                      value: isSelected,
                      activeColor: color,
                      onChanged: (bool? selected) {
                        setStateDialog(() {
                          if (selected == true) {
                            tempSelected.add(item);
                          } else {
                            tempSelected.remove(item);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    onConfirm(tempSelected);
                    Navigator.pop(context);
                  },
                  child: Text('OK', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _applyFilters() {
    String filterMessage = '';
    if (selectedCategories.isNotEmpty) {
      filterMessage += 'Categories: ${selectedCategories.join(", ")}\n';
    }
    if (selectedSubCategories.isNotEmpty) {
      filterMessage += 'Sub Categories: ${selectedSubCategories.join(", ")}\n';
    }
    if (selectedProjectTypes.isNotEmpty) {
      filterMessage += 'Project Types: ${selectedProjectTypes.join(", ")}\n';
    }
    if (selectedSubProjectTypes.isNotEmpty) {
      filterMessage += 'Sub Project Types: ${selectedSubProjectTypes.join(", ")}';
    }

    if (filterMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Filters applied!\n$filterMessage'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No filters selected'),
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<Map<String, dynamic>> items,
    required Function(String?) onChanged,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value?.isEmpty == true ? null : value,
              isExpanded: true,
              hint: hint != null ? Text(hint, style: const TextStyle(fontSize: 13, color: Colors.grey)) : null,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item['id'].toString(),
                  child: Text(
                    item['name'].toString(),
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceTable(Map<String, dynamic> selectedCombo) {
    final selectedKw = kwOptions.firstWhere((k) => k['id'] == selectedKwId);

    double kw = double.parse(selectedKw['kilowat']);
    double total = double.parse(selectedCombo['price']) * kw;
    double margin = double.parse(marginAmount) * kw;
    double subsidy = double.parse(selectedKw['total_subsidy']);

    double gstPercentage = 12.0;
    double gst = total * gstPercentage / 100;
    double finalPrice = total + gst + margin - subsidy;

    int selectedIndex = kwOptions.indexWhere((k) => k['id'] == selectedKwId);
    List<Map<String, dynamic>> displayOptions = kwOptions.sublist(0, selectedIndex + 1);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedCombo['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    selectedPanelWatts.join(', '),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width - 24,
              ),
              child: Table(
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade200, width: 1),
                  verticalInside: BorderSide(color: Colors.grey.shade200, width: 1),
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                  left: BorderSide(color: Colors.grey.shade300, width: 1),
                  right: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                columnWidths: {
                  0: const FixedColumnWidth(90),
                  1: const FixedColumnWidth(70),
                  2: const FixedColumnWidth(100),
                  3: const FixedColumnWidth(100),
                  4: const FixedColumnWidth(110),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                    ),
                    children: [
                      _buildHeaderCell('System Size\n(KW)'),
                      _buildHeaderCell('No. of\nPanels'),
                      _buildHeaderCell('Sub Total\n(₹)'),
                      _buildHeaderCell('Subsidy\n(₹)'),
                      _buildHeaderCell('Total\n(₹)'),
                    ],
                  ),
                  ...displayOptions.map((kwItem) {
                    double itemKw = double.parse(kwItem['kilowat']);
                    double itemTotal = double.parse(selectedCombo['price']) * itemKw;
                    double itemMargin = double.parse(marginAmount) * itemKw;
                    double itemSubsidy = double.parse(kwItem['total_subsidy']);
                    double itemGst = itemTotal * gstPercentage / 100;
                    double itemFinalPrice = itemTotal + itemGst + itemMargin - itemSubsidy;

                    bool isSelectedRow = kwItem['id'] == selectedKwId;

                    return TableRow(
                      decoration: BoxDecoration(
                        color: isSelectedRow ? Colors.green.withOpacity(0.05) : Colors.white,
                      ),
                      children: [
                        _buildDataCell('${kwItem['kilowat']} KW', isSelectedRow),
                        _buildDataCell(kwItem['no_of_panel'], isSelectedRow),
                        _buildDataCell('₹${itemTotal.toStringAsFixed(0)}', isSelectedRow),
                        _buildDataCell('₹${itemSubsidy.toStringAsFixed(0)}', isSelectedRow),
                        _buildDataCell(
                          '₹${itemFinalPrice.toStringAsFixed(0)}',
                          isSelectedRow,
                          isBold: true,
                          color: Colors.green,
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                if (margin > 0)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Margin Added: ',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          '₹${margin.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(()=>PdfViewerScreen());
                    },
                    icon: const Icon(Icons.picture_as_pdf, size: 18),
                    label: const Text('View PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(String text, bool isSelectedRow, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: color ?? (isSelectedRow ? Colors.green : Colors.black87),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _showQuotationSummary(Map<String, dynamic> combo, Map<String, dynamic> kw,
      double finalPrice, double total, double gst, double margin, double subsidy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Quotation Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Combo Kit', combo['name']),
                  const Divider(),
                  _buildSummaryRow('System Size', '${kw['kilowat']} KW'),
                  _buildSummaryRow('No. of Panels', kw['no_of_panel']),
                  _buildSummaryRow('Panel Watt', selectedPanelWatts.join(', ')),
                  const Divider(),
                  _buildSummaryRow('Sub Total', '₹${total.toStringAsFixed(0)}'),
                  _buildSummaryRow('GST (12%)', '₹${gst.toStringAsFixed(0)}'),
                  if (margin > 0) _buildSummaryRow('Margin', '₹${margin.toStringAsFixed(0)}'),
                  _buildSummaryRow('Subsidy', '₹${subsidy.toStringAsFixed(0)}'),
                  const Divider(),
                  _buildSummaryRow('Final Amount', '₹${finalPrice.toStringAsFixed(0)}', isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Thank you for choosing us!',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('PDF generated and downloaded successfully!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.download, size: 18),
            label: const Text('Download PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.green : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}