// lib/screens/announcement_screen.dart
import 'package:flutter/material.dart';


class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Announcements'),
        actions: [

        ],
      ),
      body: _buildLiveAnnouncements(),
    );
  }

  // Live Announcements Tab
  Widget _buildLiveAnnouncements() {
    final List<Map<String, dynamic>> announcements = [
      {
        'id': 'ANC001',
        'title': 'New Solar Subsidy Scheme Launched',
        'description': 'Government announces 40% subsidy on solar installations for residential customers. Limited period offer.',
        'image': 'subsidy_scheme.jpg',
        'date': '2024-03-13',
        'time': '10:30 AM',
        'targetAudience': ['Channel Partner', 'Dealer', 'Freelancer'],
        'priority': 'High',
        'views': 245,
        'status': 'active',
      },
      {
        'id': 'ANC002',
        'title': 'Upcoming Training Session',
        'description': 'Technical training on new solar panel installation techniques. All channel partners must attend.',
        'image': 'training.jpg',
        'date': '2024-03-12',
        'time': '02:15 PM',
        'targetAudience': ['Channel Partner', 'Distributor'],
        'priority': 'Medium',
        'views': 189,
        'status': 'active',
      },
      {
        'id': 'ANC003',
        'title': 'Price Revision Notice',
        'description': 'New price list effective from April 1, 2024. Updated catalog attached.',
        'image': 'price_revision.jpg',
        'date': '2024-03-11',
        'time': '11:45 AM',
        'targetAudience': ['Dealer', 'Distributor', 'Channel Partner'],
        'priority': 'High',
        'views': 312,
        'status': 'active',
      },
      {
        'id': 'ANC004',
        'title': 'Holiday Notice - Holi',
        'description': 'Office remains closed on March 25th on account of Holi. Support will be available online.',
        'image': 'holiday.jpg',
        'date': '2024-03-10',
        'time': '09:00 AM',
        'targetAudience': ['All Users'],
        'priority': 'Low',
        'views': 156,
        'status': 'active',
      },
      {
        'id': 'ANC005',
        'title': 'New Product Launch',
        'description': 'Introducing high-efficiency solar panels with 25-year warranty. Special launch offers available.',
        'image': 'new_product.jpg',
        'date': '2024-03-09',
        'time': '03:30 PM',
        'targetAudience': ['All Users'],
        'priority': 'High',
        'views': 421,
        'status': 'active',
      },
    ];

    return Column(
      children: [
        // Announcements List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return _buildAnnouncementCard(context, announcement, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, Map<String, dynamic> announcement, int index) {
    Color priorityColor;
    IconData priorityIcon;

    switch (announcement['priority']) {
      case 'High':
        priorityColor = Colors.red;
        priorityIcon = Icons.priority_high;
        break;
      case 'Medium':
        priorityColor = Colors.orange;
        priorityIcon = Icons.remove;
        break;
      default:
        priorityColor = Colors.green;
        priorityIcon = Icons.low_priority;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade400,
                  Colors.green.shade700,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.campaign,
                    size: 50,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(priorityIcon, color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          announcement['priority'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcement['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  announcement['description'],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Target Audience Chips
                Wrap(
                  spacing: 8,
                  children: (announcement['targetAudience'] as List).map((audience) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        audience,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                // Footer with Date and Views
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          '${announcement['date']} • ${announcement['time']}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.visibility, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          '${announcement['views']} views',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                      ],
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
}
