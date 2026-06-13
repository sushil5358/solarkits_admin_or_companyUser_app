// lib/screens/combo_kits_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'combo_kit_detail.dart';


class ComboKitsScreen extends StatefulWidget {
  const ComboKitsScreen({super.key});

  @override
  State<ComboKitsScreen> createState() => _ComboKitsScreenState();
}

class _ComboKitsScreenState extends State<ComboKitsScreen> {
  String selectedSort = 'Popular';
  final List<String> sortOptions = ['Popular', 'Price Low to High', 'Price High to Low'];

  List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'SolarMax Elite Pro',
      'brand': 'SolarMax',
      'brandImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_icon5b05bc.png',
      'inverterBrand': 'Growatt',
      'inverterImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_iconf4dcff.png',
      'technology': 'Bifacial',
      'wattage': '540Wp',
      'pricePerKw': '45,000',
      'inStock': true,
      'productImage': 'https://images.unsplash.com/photo-1611365892117-00ac5ef43c90?w=400',
      'panelWarranty': 25,
      'inverterWarranty': 10,
      'performanceWarranty': 90,
      'efficiency': '22.5',
      'description': 'High-efficiency bifacial solar panels with dual-side power generation.',
    },
    {
      'id': '2',
      'name': 'EcoSun Power Plus',
      'brand': 'EcoSun',
      'brandImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_icon5b05bc.png',
      'inverterBrand': 'Sungrow',
      'inverterImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_iconf4dcff.png',
      'technology': 'TOPCon',
      'wattage': '550Wp',
      'pricePerKw': '52,000',
      'inStock': true,
      'productImage': 'https://images.unsplash.com/photo-1509391366360-2e959784a276?w=400',
      'panelWarranty': 30,
      'inverterWarranty': 12,
      'performanceWarranty': 92,
      'efficiency': '23.2',
      'description': 'Advanced TOPCon technology with superior temperature coefficient.',
    },
    {
      'id': '3',
      'name': 'SunPower Horizon',
      'brand': 'SunPower',
      'brandImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_icon5b05bc.png',
      'inverterBrand': 'Huawei',
      'inverterImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_iconf4dcff.png',
      'technology': 'Mono PERC',
      'wattage': '530Wp',
      'pricePerKw': '48,000',
      'inStock': true,
      'productImage': 'https://images.unsplash.com/photo-1613665813446-82a78c0d19e3?w=400',
      'panelWarranty': 25,
      'inverterWarranty': 10,
      'performanceWarranty': 85,
      'efficiency': '21.8',
      'description': 'Mono PERC technology with excellent low-light performance.',
    },
    {
      'id': '4',
      'name': 'Loom Solar Shield',
      'brand': 'Loom Solar',
      'brandImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_icon5b05bc.png',
      'inverterBrand': 'Delta',
      'inverterImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_iconf4dcff.png',
      'technology': 'HJT',
      'wattage': '580Wp',
      'pricePerKw': '58,000',
      'inStock': true,
      'productImage': 'https://images.unsplash.com/photo-1613665813446-82a78c0d19e3?w=400',
      'panelWarranty': 30,
      'inverterWarranty': 12,
      'performanceWarranty': 94,
      'efficiency': '24.1',
      'description': 'Heterojunction technology with highest efficiency.',
    },
    {
      'id': '5',
      'name': 'Adani Solar Prime',
      'brand': 'Adani Solar',
      'brandImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_icon5b05bc.png',
      'inverterBrand': 'Fronius',
      'inverterImage': 'https://crm.sunnovativecrm.com/images/solar_panel_icon/brand_master_iconf4dcff.png',
      'technology': 'Bifacial',
      'wattage': '560Wp',
      'pricePerKw': '49,500',
      'inStock': false,
      'productImage': 'https://images.unsplash.com/photo-1611365892117-00ac5ef43c90?w=400',
      'panelWarranty': 25,
      'inverterWarranty': 10,
      'performanceWarranty': 88,
      'efficiency': '22.8',
      'description': 'Durable bifacial panels with excellent build quality.',
    },
  ];

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
                            ),
                            onConfirm: (List<String> values) {
                              // Handle filter
                            },
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
                            ),
                            onConfirm: (List<String> values) {
                              // Handle filter
                            },
                          ),
                          const SizedBox(height: 20),

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
                            ),
                            onConfirm: (List<String> values) {
                              // Handle filter
                            },
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
                            ),
                            onConfirm: (List<String> values) {
                              // Handle filter
                            },
                          ),
                          const SizedBox(height: 20),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Combo Kits',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Sort by: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedSort,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.green, size: 20),
                      items: sortOptions.map((sort) {
                        return DropdownMenuItem(
                          value: sort,
                          child: Text(
                            sort,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSort = value!;
                          _sortProducts();
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  '${products.length} Products',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.height / 1300,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComboKitDetailScreen(product: product),
                      ),
                    );
                  },
                  child: _buildProductCard(product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  product['productImage'],
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 130,
                      width: double.infinity,
                      color: Colors.green.withOpacity(0.1),
                      child: const Icon(
                        Icons.solar_power,
                        size: 40,
                        color: Colors.green,
                      ),
                    );
                  },
                ),
              ),
              if (!product['inStock'])
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Out of Stock',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.network(
                            product['brandImage'],
                            width: 45,
                            height: 25,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  product['brand'][0],
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 45,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.network(
                            product['inverterImage'],
                            width: 45,
                            height: 25,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  product['inverterBrand'][0],
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product['technology'],
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Icon(Icons.solar_power, size: 10, color: Colors.blue),
                        const SizedBox(width: 2),
                        Text(
                          product['wattage'],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(height: 1),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Price per KW',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '₹${product['pricePerKw']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sortProducts() {
    if (selectedSort == 'Price Low to High') {
      products.sort((a, b) => int.parse(a['pricePerKw'].replaceAll(',', ''))
          .compareTo(int.parse(b['pricePerKw'].replaceAll(',', ''))));
    } else if (selectedSort == 'Price High to Low') {
      products.sort((a, b) => int.parse(b['pricePerKw'].replaceAll(',', ''))
          .compareTo(int.parse(a['pricePerKw'].replaceAll(',', ''))));
    }
    setState(() {});
  }
}