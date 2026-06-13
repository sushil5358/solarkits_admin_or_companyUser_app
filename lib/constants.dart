// lib/utils/constants.dart
import 'dart:ui';

class AppConstants {
  static const String appName = 'SolarKits Admin';
  static const String baseUrl = 'http://your-server.com/solarkits/api';

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color accentColor = Color(0xFF8BC34A);

  static const double defaultPadding = 16.0;
  static const double borderRadius = 16.0;

  static const List<String> reportTypes = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
    'Custom',
  ];

  static const Map<String, Color> statusColors = {
    'new': Color(0xFF2196F3),
    'contacted': Color(0xFFFF9800),
    'converted': Color(0xFF4CAF50),
    'pending': Color(0xFFFFC107),
    'completed': Color(0xFF4CAF50),
    'cancelled': Color(0xFFF44336),
  };
}