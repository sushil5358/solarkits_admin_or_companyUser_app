// lib/screens/offer_screen.dart
import 'package:flutter/material.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Offers'),
        actions: [
        ],
      ),
      body: _buildLiveOffers(),
    );
  }

  // Live Offers Tab - with smaller list cards
  Widget _buildLiveOffers() {
    final List<Map<String, dynamic>> offers = [
      {
        'id': 'OFF001',
        'title': 'Summer Sale - 20% Off',
        'description': 'Get 20% discount on all residential solar installations. Limited time offer.',
        'validUntil': '2024-06-30',
        'usageCount': 45,
        'isActive': true,
        'targetAudience': ['Channel Partner', 'Dealer'],
        'image': 'summer_offer.jpg',
      },
      {
        'id': 'OFF002',
        'title': 'Free Installation',
        'description': 'Free installation worth ₹15,000 on commercial solar projects above 10kW.',
        'validUntil': '2024-05-15',
        'usageCount': 23,
        'isActive': true,
        'targetAudience': ['Freelancer', 'Premium Dealer'],
        'image': 'free_install.jpg',
      },
      {
        'id': 'OFF003',
        'title': 'Refer & Earn',
        'description': 'Refer a friend and get ₹5,000 off on your next purchase.',
        'validUntil': '2024-12-31',
        'usageCount': 78,
        'isActive': false,
        'targetAudience': ['All'],
        'image': 'refer_offer.jpg',
      },
      {
        'id': 'OFF004',
        'title': 'Festival Special',
        'description': 'Special festive discounts on solar water heaters and panels.',
        'validUntil': '2024-04-15',
        'usageCount': 112,
        'isActive': true,
        'targetAudience': ['Franchise', 'Channel Partner'],
        'image': 'festival.jpg',
      },
      {
        'id': 'OFF005',
        'title': 'First Time Customer',
        'description': 'First time customers get an additional 10% off on their first solar installation.',
        'validUntil': '2024-05-30',
        'usageCount': 156,
        'isActive': false,
        'targetAudience': ['All'],
        'image': 'first_time.jpg',
      },
      {
        'id': 'OFF006',
        'title': 'Combo Offer',
        'description': 'Buy solar panels + inverter together and save ₹25,000.',
        'validUntil': '2024-04-30',
        'usageCount': 34,
        'isActive': true,
        'targetAudience': ['Premium Dealer', 'Franchise'],
        'image': 'combo_offer.jpg',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // Offers List - responsive cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  return _buildResponsiveOfferCard(context, offer, index, constraints.maxWidth);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // Responsive offer card
  Widget _buildResponsiveOfferCard(BuildContext context, Map<String, dynamic> offer, int index, double maxWidth) {
    // Determine if we're on a small screen (mobile)
    bool isSmallScreen = maxWidth < 600;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: offer['isActive'] ? Colors.green.shade200 : Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: isSmallScreen
          ? _buildMobileCardLayout(context, offer)
          : _buildTabletCardLayout(context, offer),
    );
  }

  // Mobile layout (vertical/small screen)
  Widget _buildMobileCardLayout(BuildContext context, Map<String, dynamic> offer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top gradient section
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: offer['isActive']
                  ? [Colors.green.shade400, Colors.green.shade600]
                  : [Colors.grey.shade400, Colors.grey.shade600],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.local_offer,
              size: 50,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),

        // Content section
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                offer['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: offer['isActive'] ? Colors.black87 : Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 6),

              // Description
              Text(
                offer['description'],
                style: TextStyle(
                  fontSize: 12,
                  color: offer['isActive'] ? Colors.grey.shade700 : Colors.grey.shade500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 10),

              // Target Audience Chips
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: (offer['targetAudience'] as List).map((audience) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      audience,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 10),

              // Footer with usage and validity
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(
                    'Till ${offer['validUntil']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.people, size: 12, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(
                    '${offer['usageCount']} used',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Action buttons row
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     // Edit button
              //     Container(
              //       decoration: BoxDecoration(
              //         color: Colors.green.shade50,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: IconButton(
              //         onPressed: () {
              //           _showEditOfferDialog(context, offer);
              //         },
              //         icon: Icon(Icons.edit, color: Colors.green.shade700, size: 18),
              //         padding: EdgeInsets.zero,
              //         constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              //       ),
              //     ),
              //     const SizedBox(width: 12),
              //     // Delete button
              //     Container(
              //       decoration: BoxDecoration(
              //         color: Colors.red.shade50,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: IconButton(
              //         onPressed: () {
              //           _showDeleteConfirmation(context, offer['title']);
              //         },
              //         icon: Icon(Icons.delete, color: Colors.red.shade700, size: 18),
              //         padding: EdgeInsets.zero,
              //         constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }

  // Tablet/Desktop layout (horizontal/wider screen)
  Widget _buildTabletCardLayout(BuildContext context, Map<String, dynamic> offer) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Image/Icon
        Container(
          width: 100,
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: offer['isActive']
                  ? [Colors.green.shade400, Colors.green.shade600]
                  : [Colors.grey.shade400, Colors.grey.shade600],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.local_offer,
              size: 45,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),

        // Middle - Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  offer['title'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: offer['isActive'] ? Colors.black87 : Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Description
                Text(
                  offer['description'],
                  style: TextStyle(
                    fontSize: 11,
                    color: offer['isActive'] ? Colors.grey.shade700 : Colors.grey.shade500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Target Audience Chips
                Wrap(
                  spacing: 4,
                  children: (offer['targetAudience'] as List).map((audience) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        audience,
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 6),

                // Footer with usage and validity
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 9, color: Colors.grey.shade500),
                    const SizedBox(width: 2),
                    Text(
                      'Till ${offer['validUntil']}',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.people, size: 9, color: Colors.grey.shade500),
                    const SizedBox(width: 2),
                    Text(
                      '${offer['usageCount']} used',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Right side - Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Edit button
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {
                    _showEditOfferDialog(context, offer);
                  },
                  icon: Icon(Icons.edit, color: Colors.green.shade700, size: 16),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(maxWidth: 36, maxHeight: 36),
                ),
              ),
              const SizedBox(height: 12),
              // Delete button
              Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {
                    _showDeleteConfirmation(context, offer['title']);
                  },
                  icon: Icon(Icons.delete, color: Colors.red.shade700, size: 16),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(maxWidth: 36, maxHeight: 36),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.warning_amber, color: Colors.red, size: 50),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete Offer?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Remove "$title"? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Offer deleted successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showEditOfferDialog(BuildContext context, Map<String, dynamic> offer) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Offer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: offer['title'],
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: offer['description'],
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: offer['validUntil'],
                decoration: const InputDecoration(
                  labelText: 'Valid Until',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Offer updated successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}