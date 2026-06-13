import 'package:flutter/material.dart';

class ProjecttypeRatesettings extends StatefulWidget {
  String? margin;
   ProjecttypeRatesettings({super.key,required this.margin});

  @override
  State<ProjecttypeRatesettings> createState() => _ProjecttypeRatesettingsState();
}

class _ProjecttypeRatesettingsState extends State<ProjecttypeRatesettings> {

  // Rate Settings Controllers (For Quick Quote BOM)
  final TextEditingController _companyMarginController = TextEditingController();
  final TextEditingController _userMarginController = TextEditingController();
  final TextEditingController _structureChargesController = TextEditingController();
  final TextEditingController _installationChargesController = TextEditingController();

  // BOM Type Selection
  String _selectedBOMType = 'survey'; // 'survey' or 'quick_quote'

  // Survey BOM Data
  List<Map<String, dynamic>> standardPipes = [
    {'product': 'PVC Pipe 1 inch', 'price': '0', 'controller': TextEditingController()},
    {'product': 'GI Pipe 1.5 inch', 'price': '0', 'controller': TextEditingController()},
    {'product': 'Metal Pipe 2 inch', 'price': '0', 'controller': TextEditingController()},
    {'product': 'Flexible Pipe', 'price': '0', 'controller': TextEditingController()},
  ];

  List<Map<String, dynamic>> accessories = [
    {'product': 'Connectors Set', 'price': '0', 'controller': TextEditingController()},
    {'product': 'Clamps (Pack of 10)', 'price': '0', 'controller': TextEditingController()},
    {'product': 'Junction Box', 'price': '0', 'controller': TextEditingController()},
    {'product': 'MC4 Connectors', 'price': '0', 'controller': TextEditingController()},
    {'product': 'Lightning Arrester', 'price': '0', 'controller': TextEditingController()},
  ];

  List<Map<String, dynamic>> wires = [
    {'product': '4 sqmm DC Wire', 'price': '0', 'controller': TextEditingController()},
    {'product': '6 sqmm DC Wire', 'price': '0', 'controller': TextEditingController()},
    {'product': '10 sqmm AC Wire', 'price': '0', 'controller': TextEditingController()},
    {'product': '16 sqmm AC Wire', 'price': '0', 'controller': TextEditingController()},
    {'product': 'Earthing Wire', 'price': '0', 'controller': TextEditingController()},
  ];

  final List<String> _projectTypes = [
    'Residential', 'Commercial', 'Industrial', 'Agricultural', 'Institutional', 'Government'
  ];

  String? _selectedProjectType;

  @override
  void dispose() {
    _companyMarginController.dispose();
    _userMarginController.dispose();
    _structureChargesController.dispose();
    _installationChargesController.dispose();
    for (var item in standardPipes) {
      item['controller'].dispose();
    }
    for (var item in accessories) {
      item['controller'].dispose();
    }
    for (var item in wires) {
      item['controller'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'User Rate Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // BOM Type Selection Toggle
              Container(
                padding: const EdgeInsets.all(8),
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
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBOMType = 'survey';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedBOMType == 'survey' ? Colors.green.shade50 : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: _selectedBOMType == 'survey'
                                ? Border.all(color: Colors.green.shade400)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Survey BOM',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _selectedBOMType == 'survey' ? Colors.green.shade700 : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBOMType = 'quick_quote';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedBOMType == 'quick_quote' ? Colors.green.shade50 : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: _selectedBOMType == 'quick_quote'
                                ? Border.all(color: Colors.green.shade400)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Quick Quote BOM',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _selectedBOMType == 'quick_quote' ? Colors.green.shade700 : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Show different content based on selected BOM type
              if (_selectedBOMType == 'quick_quote')
                _buildQuickQuoteBOMSection()
              else
                _buildSurveyBOMSection(),

              const SizedBox(height: 24),

              // Update Rate Settings Button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade700],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedProjectType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a project type'),
                          backgroundColor: Colors.orange,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Rate settings updated for $_selectedProjectType'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Update Rate Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Quick Quote BOM - Shows Rate Settings only
  Widget _buildQuickQuoteBOMSection() {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Icon(Icons.currency_rupee, color: Colors.green.shade700),
              const SizedBox(width: 8),
              const Text(
                'Rate Settings',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Project Type Dropdown
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedProjectType,
              hint: const Text('Select Project Type'),
              isExpanded: true,
              items: _projectTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProjectType = value;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: Icon(Icons.category, size: 20),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedProjectType,
              hint: const Text('Select Terrace Type'),
              isExpanded: true,
              items: ['Slant Roof','Rcc Roof'].map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProjectType = value;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: Icon(Icons.category, size: 20),
              ),
            ),
          ),

          if(widget.margin == '1')
          const SizedBox(height: 20),

          // Rate Fields


          if(widget.margin == '1')
          _buildRateField(
            controller: _userMarginController,
            label: 'User Suggestive Margin (₹)',
            hint: 'Enter amount',
            icon: Icons.trending_up,
            suffix: '₹',
          ),
          const SizedBox(height: 16),

          _buildRateField(
            controller: _structureChargesController,
            label: 'Structure Charges (₹)',
            hint: 'Enter amount ',
            icon: Icons.build,
            suffix: '₹',
          ),
          const SizedBox(height: 16),

          _buildRateField(
            controller: _installationChargesController,
            label: 'Installation Charges (₹)',
            hint: 'Enter amount',
            icon: Icons.handyman,
            suffix: '₹',
          ),
        ],
      ),
    );
  }

  // Survey BOM - Shows Standard Pipes, Accessories, and Wires
  Widget _buildSurveyBOMSection() {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedProjectType,
              hint: const Text('Select Project Type'),
              isExpanded: true,
              items: _projectTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProjectType = value;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: Icon(Icons.category, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          const Text(
            'Survey BOM',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Standard Pipes Section
          _buildBOMSection(
            title: 'Standard Pipes',
            items: standardPipes,
            icon: Icons.pix,
            onAddProduct: () => _showAddProductDialog('Standard Pipes', standardPipes),
          ),
          const SizedBox(height: 16),

          // Accessories Section
          _buildBOMSection(
            title: 'Accessories',
            items: accessories,
            icon: Icons.build,
            onAddProduct: () => _showAddProductDialog('Accessories', accessories),
          ),
          const SizedBox(height: 16),

          // Wires Section
          _buildBOMSection(
            title: 'Wires',
            items: wires,
            icon: Icons.electrical_services,
            onAddProduct: () => _showAddProductDialog('Wires', wires),
          ),
        ],
      ),
    );
  }

  Widget _buildBOMSection({
    required String title,
    required List<Map<String, dynamic>> items,
    required IconData icon,
    required VoidCallback onAddProduct,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: Colors.green.shade700),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
              // Add Product Button
              GestureDetector(
                onTap: onAddProduct,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Add Product',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildBOMItemRow(items[index], index, () {
                setState(() {
                  items.removeAt(index);
                });
              });
            },
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(String sectionName, List<Map<String, dynamic>> items) {
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController productPriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Add Product to $sectionName',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                hintText: 'Enter product name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.production_quantity_limits),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: productPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price per Unit (₹)',
                hintText: 'Enter price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.currency_rupee),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(fontSize: 14)),
          ),
          ElevatedButton(
            onPressed: () {
              if (productNameController.text.isNotEmpty && productPriceController.text.isNotEmpty) {
                setState(() {
                  items.add({
                    'product': productNameController.text,
                    'price': productPriceController.text,
                    'controller': TextEditingController(text: productPriceController.text),
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product added to $sectionName'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter product name and price'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Add Product'),
          ),
        ],
      ),
    );
  }

  Widget _buildBOMItemRow(Map<String, dynamic> item, int index, VoidCallback onDelete) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                item['product'],
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: item['controller'],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Price/Unit',
                prefixIcon: const Icon(Icons.currency_rupee, size: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
              style: const TextStyle(fontSize: 12),
              onChanged: (value) {
                item['price'] = value;
              },
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.delete_outline, size: 16, color: Colors.red.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade600),
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}