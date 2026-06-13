// lib/screens/combo_kit_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComboKitDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const ComboKitDetailScreen({super.key, required this.product});

  @override
  State<ComboKitDetailScreen> createState() => _ComboKitDetailScreenState();
}

class _ComboKitDetailScreenState extends State<ComboKitDetailScreen> {
  int selectedKw = 5;
  final List<int> kwOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 20];
  TextEditingController quotationController = TextEditingController();

  double get basePrice {
    return double.parse(widget.product['pricePerKw'].replaceAll(',', ''));
  }

  double get totalPrice {
    return basePrice * selectedKw;
  }

  double get gstAmount {
    return totalPrice * 0.18;
  }

  double get quotationAmount {
    if (quotationController.text.isEmpty) {
      return totalPrice;
    }
    return double.parse(quotationController.text);
  }

  double get marginAmount {
    return quotationAmount - (totalPrice + gstAmount);
  }

  @override
  void initState() {
    super.initState();
    quotationController.text = totalPrice.toStringAsFixed(0);
  }

  @override
  void dispose() {
    quotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Combo Kit Details',
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
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(widget.product['productImage']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              widget.product['brandImage'],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    widget.product['brand'],
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
                      const SizedBox(width: 12),
                      Container(
                        width: 60,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              widget.product['inverterImage'],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    widget.product['inverterBrand'],
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
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product['name'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (!widget.product['inStock'])
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            'Out of Stock',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.product['technology'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.product['wattage'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Warranty Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildWarrantyCard(
                          'Panel Warranty',
                          '${widget.product['panelWarranty']} Years',
                          Icons.security,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildWarrantyCard(
                          'Inverter Warranty',
                          '${widget.product['inverterWarranty']} Years',
                          Icons.build,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildWarrantyCard(
                          'Performance',
                          '${widget.product['performanceWarranty']}%',
                          Icons.trending_up,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Panel Efficiency',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${widget.product['efficiency']}%',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // const Text(
                  //   'Select System Size (KW)',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                  // const SizedBox(height: 12),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     border: Border.all(color: Colors.grey.shade300),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton<int>(
                  //       isExpanded: true,
                  //       value: selectedKw,
                  //       items: kwOptions.map((kw) {
                  //         return DropdownMenuItem(
                  //           value: kw,
                  //           child: Text(
                  //             '$kw KW',
                  //             style: const TextStyle(
                  //               fontSize: 14,
                  //               color: Colors.black87,
                  //             ),
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (value) {
                  //         setState(() {
                  //           selectedKw = value!;
                  //           quotationController.text = totalPrice.toStringAsFixed(0);
                  //         });
                  //       },
                  //       icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  //
                  // const Text(
                  //   'Quotation Amount',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  // TextField(
                  //   controller: quotationController,
                  //   keyboardType: TextInputType.number,
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  //   decoration: InputDecoration(
                  //     prefixIcon: const Icon(Icons.currency_rupee),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide(color: Colors.grey.shade300),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: const BorderSide(color: Colors.green),
                  //     ),
                  //     hintText: 'Enter quotation amount',
                  //   ),
                  //   onChanged: (value) {
                  //     setState(() {});
                  //   },
                  // ),
                  // const SizedBox(height: 20),
                  //
                  // // Margin Card
                  // Container(
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //     color: marginAmount >= 0
                  //         ? Colors.green.withOpacity(0.1)
                  //         : Colors.red.withOpacity(0.1),
                  //     borderRadius: BorderRadius.circular(16),
                  //     border: Border.all(
                  //       color: marginAmount >= 0 ? Colors.green : Colors.red,
                  //       width: 1.5,
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const Text(
                  //             'Your Margin',
                  //             style: TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.black87,
                  //             ),
                  //           ),
                  //           Text(
                  //             '${marginAmount >= 0 ? '+' : ''}₹${marginAmount.toStringAsFixed(0)}',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: marginAmount >= 0 ? Colors.green : Colors.red,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 8),
                  //       if (marginAmount > 0)
                  //         Text(
                  //           'You are earning ₹${marginAmount.toStringAsFixed(0)} on this quotation',
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.green.shade700,
                  //           ),
                  //         ),
                  //       if (marginAmount < 0)
                  //         Text(
                  //           'You are losing ₹${(-marginAmount).toStringAsFixed(0)} on this quotation',
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.red.shade700,
                  //           ),
                  //         ),
                  //       if (marginAmount == 0)
                  //         Text(
                  //           'No profit or loss on this quotation',
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.grey.shade600,
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 24),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       _showQuotationDialog();
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.green,
                  //       padding: const EdgeInsets.symmetric(vertical: 14),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'Generate Quote',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarrantyCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void _showQuotationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Quote Generated',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              'Quote for ${widget.product['name']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildDetailRow('System Size', '$selectedKw KW'),
                  const SizedBox(height: 6),
                  _buildDetailRow('Total Amount', '₹${totalPrice.toStringAsFixed(0)}'),
                  const SizedBox(height: 6),
                  _buildDetailRow('GST (18%)', '₹${gstAmount.toStringAsFixed(0)}'),
                  const SizedBox(height: 6),
                  _buildDetailRow('Final Amount', '₹${quotationAmount.toStringAsFixed(0)}'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Quote sent successfully!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Send Quote'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}