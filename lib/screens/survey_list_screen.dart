// lib/view/survey_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../appColors.dart';
import '../constants.dart';


class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<Map<String, dynamic>> surveys = [
    {
      'id': '1',
      'surveyNo': 'SUR-2024-001',
      'customerName': 'Rahul Sharma',
      'customerMobile': '+91 98765 43210',
      'customerAddress': 'Green Park Society, Rajkot',
      'quoteNo': 'QT-2024-001',
      'kw': '10',
      'panelCount': '24',
      'surveyDate': '2024-04-15',
      'status': 'Completed',
      'terraceArea': '250 sq.ft',
      'panelDirection': 'South',
      'estimatedPanels': 24,
      'surveyor': 'Rajesh Patel',
    },
    {
      'id': '2',
      'surveyNo': 'SUR-2024-002',
      'customerName': 'Priya Mehta',
      'customerMobile': '+91 98765 43211',
      'customerAddress': 'Sunrise Apartments, Surat',
      'quoteNo': 'QT-2024-002',
      'kw': '15',
      'panelCount': '36',
      'surveyDate': '2024-04-16',
      'status': 'Completed',
      'terraceArea': '380 sq.ft',
      'panelDirection': 'East',
      'estimatedPanels': 36,
      'surveyor': 'Sunil Mehta',
    },
    {
      'id': '3',
      'surveyNo': 'SUR-2024-003',
      'customerName': 'Amit Desai',
      'customerMobile': '+91 98765 43212',
      'customerAddress': 'Eco Complex, Vadodara',
      'quoteNo': 'QT-2024-003',
      'kw': '5',
      'panelCount': '12',
      'surveyDate': '2024-04-14',
      'status': 'Completed',
      'terraceArea': '120 sq.ft',
      'panelDirection': 'West',
      'estimatedPanels': 12,
      'surveyor': 'Amit Desai',
    },
    {
      'id': '4',
      'surveyNo': 'SUR-2024-004',
      'customerName': 'Neha Gupta',
      'customerMobile': '+91 98765 43213',
      'customerAddress': 'Shiv Complex, Ahmedabad',
      'quoteNo': 'QT-2024-004',
      'kw': '8',
      'panelCount': '20',
      'surveyDate': '2024-04-17',
      'status': 'Completed',
      'terraceArea': '210 sq.ft',
      'panelDirection': 'South-East',
      'estimatedPanels': 20,
      'surveyor': 'Neha Gupta',
    },
    {
      'id': '5',
      'surveyNo': 'SUR-2024-005',
      'customerName': 'Vikram Singh',
      'customerMobile': '+91 98765 43214',
      'customerAddress': 'Green Valley, Bhavnagar',
      'quoteNo': 'QT-2024-005',
      'kw': '12',
      'panelCount': '30',
      'surveyDate': '2024-04-18',
      'status': 'Completed',
      'terraceArea': '420 sq.ft',
      'panelDirection': 'South',
      'estimatedPanels': 30,
      'surveyor': 'Vikram Singh',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: const Text(
          'Site Surveys',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () {
            // Get.offAll(()=>HomeScreen());
          },
        ),
      ),
      body: surveys.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 80, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(
              'No surveys found',
              style: TextStyle(fontSize: 18, color: AppColors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Create a survey from quotation',
              style: TextStyle(fontSize: 12, color: AppColors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: surveys.length,
        itemBuilder: (context, index) {
          final survey = surveys[index];
          return _buildSurveyCard(survey);
        },
      ),
    );
  }

  Widget _buildSurveyCard(Map<String, dynamic> survey) {
    return InkWell(
      onTap: () {
        // Get.to(()=>SurveyMap());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowGrey,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row - Survey No and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  survey['surveyNo'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: AppColors.successGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Customer Name and Mobile
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryOrange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      survey['customerName'][0],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryOrange,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        survey['customerName'],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        survey['customerMobile'],
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Address
            Row(
              children: [
                Icon(Icons.location_on, size: 10, color: AppColors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    survey['customerAddress'],
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.darkGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Quote Details Row
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSmallInfo('Quote No', survey['quoteNo'], Icons.receipt),
                  _buildSmallInfo('KW', '${survey['kw']} KW', Icons.solar_power),
                  _buildSmallInfo('Panels', survey['panelCount'].toString(), Icons.grid_view),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Survey Results
            // Container(
            //   padding: const EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     color: AppColors.veryLightGrey,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       _buildSmallResult('Area', survey['terraceArea'], Icons.crop_square),
            //       _buildSmallResult('Direction', survey['panelDirection'], Icons.compass_calibration),
            //       _buildSmallResult('Panels', survey['estimatedPanels'].toString(), Icons.solar_power),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 8),

            // Footer - Survey Date and Surveyor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 10, color: AppColors.grey),
                    const SizedBox(width: 4),
                    Text(
                      survey['surveyDate'],
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Icon(Icons.person, size: 10, color: AppColors.grey),
                //     const SizedBox(width: 4),
                //     Text(
                //       survey['surveyor'],
                //       style: TextStyle(
                //         fontSize: 9,
                //         color: AppColors.grey,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 12, color: AppColors.primaryBlue),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallResult(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 12, color: AppColors.secondaryOrange),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryOrange,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}