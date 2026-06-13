import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF1976D2);  // Darker Blue (Primary)
  static const Color secondaryOrange = Color(0xFFF5A623);  // Orange (Accent)

  // Blue Shades
  static const Color lightBlue = Color(0xFF64B5F6);
  static const Color darkBlue = Color(0xFF1565C0);
  static const Color veryLightBlue = Color(0xFFE3F2FD);
  static const Color aliceBlue = Color(0xFFF0F8FF);

  // Orange Shades
  static const Color lightOrange = Color(0xFFFF9800);
  static const Color darkOrange = Color(0xFFE65100);

  // Green Shades (for success/order)
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xFFE8F5E9);

  // Red Shades (for errors/cancel)
  static const Color errorRed = Color(0xFFF44336);
  static const Color lightRed = Color(0xFFFFEBEE);

  // Grey Shades
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color black87 = Color(0xDD000000);
  static const Color black54 = Color(0x8A000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF757575);
  static const Color lightGrey = Color(0xFFBDBDBD);
  static const Color veryLightGrey = Color(0xFFF5F5F5);
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color dividerGrey = Color(0xFFE0E0E0);
  static const Color shadowGrey = Color(0xFFEEEEEE);

  // Status Colors
  static const Color statusNew = Color(0xFFFF9800);
  static const Color statusApproved = Color(0xFF4CAF50);
  static const Color statusPending = Color(0xFFFF9800);
  static const Color statusRejected = Color(0xFFF44336);
  static const Color statusCompleted = Color(0xFF4CAF50);

  // Gradient Colors
  static const List<Color> splashGradient = [
    Color(0xFFE3F2FD),
    Color(0xFFBBDEFB),
    Color(0xFF90CAF9),
  ];

  static const List<Color> loginGradient = [
    Color(0xFFF0F8FF),
    Color(0xFFE3F2FD),
    Colors.white,
  ];

  static const List<Color> buttonGradient = [
    Color(0xFF1976D2),
    Color(0xFF1565C0),
  ];
}

class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.black87,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black87,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black87,
  );

  static const TextStyle heading4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black87,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black87,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black87,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGrey,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black87,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGrey,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  );

  // Button Text
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Special
  static const TextStyle welcomeText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBlue,
  );

  static const TextStyle amountText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryBlue,
  );

  static const TextStyle priceText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryBlue,
  );
}

class AppDecorations {
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowGrey,
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration buttonDecoration = BoxDecoration(
    color: AppColors.primaryBlue,
    borderRadius: BorderRadius.circular(16),
  );

  static BoxDecoration orangeButtonDecoration = BoxDecoration(
    color: AppColors.secondaryOrange,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration statusBadgeDecoration(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    );
  }

  static BoxDecoration avatarDecoration = BoxDecoration(
    color: AppColors.primaryBlue.withOpacity(0.1),
    shape: BoxShape.circle,
  );

  static BoxDecoration inputDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowGrey,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

class AppDurations {
  static const Duration splashDelay = Duration(milliseconds: 3000);
  static const Duration animationDuration = Duration(milliseconds: 2200);
  static const Duration pageTransition = Duration(milliseconds: 600);
  static const Duration snackBarDuration = Duration(seconds: 2);
  static const Duration apiTimeout = Duration(seconds: 30);
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 40.0;
}

class AppStrings {
  // App Name
  static const String appName = 'Solar Marketplace';
  static const String solar = 'SOLAR';
  static const String marketplace = 'MARKETPLACE';

  // Splash Screen
  static const String tagline = 'Clean Energy for Tomorrow';
  static const String subTagline = 'Power Your World with Solar';
  static const String loadingMessage = 'Preparing your solar experience...';

  // Login Screen
  static const String welcomeBack = 'Welcome Back! 👋';
  static const String enterMobile = 'Enter your mobile number to continue';
  static const String mobileNumber = 'Mobile Number';
  static const String continueText = 'Continue';
  static const String otpInfo = 'We\'ll send you an OTP for verification';
  static const String byContinuing = 'By continuing, you agree to our';
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';
  static const String solarBeta = 'Solar Beta';

  // Home Screen
  static const String welcomeBackUser = 'Welcome Back!';
  static const String manageBusiness = 'Manage your solar business';
  static const String quickActions = 'Quick Actions';
  static const String quotations = 'Quotations';
  static const String quotationsSub = 'Create & Manage Quotes';
  static const String myOrders = 'My Orders';
  static const String myOrdersSub = 'Track Your Orders';
  static const String myInstallation = 'Assign Installation';

  // Drawer
  static const String heyUser = 'Hey User!';
  static const String welcomeToSolar = 'Welcome to Solar Marketplace';
  static const String myCashback = 'My Cashback';
  static const String myEarnings = 'My Earnings';
  static const String myOrderHistory = 'My Order History';

  // Price Table
  static const String priceTable = 'Price Table';
  static const String projectType = 'Project Type';
  static const String comboKit = 'Combo Kit';
  static const String panelWatt = 'Panel Watt (WP)';
  static const String systemSize = 'System Size (KW)';
  static const String marginCommission = 'Margin/Commission (₹ per KW)';
  static const String suggestiveAmount = 'Max: ₹';
  static const String selectKit = 'Select Kit';
  static const String selectWatt = 'Select Watt';
  static const String selectKW = 'Select KW';
  static const String enterAmount = 'Enter amount';
  static const String noSelection = 'Select Combo Kit, Panel Watt & KW';

  // Quotations
  static const String quotationsTitle = 'Quotations';
  static const String newQuotation = 'New Quotation';
  static const String totalAmount = 'Total Amount';
  static const String order = 'Order';
  static const String quoteNo = 'Quote #';
  static const String noQuotes = 'No quotations yet';
  static const String addFirstQuote = 'Tap the + button to add your first quotation';

  // Common
  static const String comingSoon = 'Coming Soon!';
  static const String orderPlaced = 'Order placed successfully!';
  static const String confirmOrder = 'Confirm Order';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String delete = 'Delete';
  static const String viewDetails = 'View Details';

  // Errors
  static const String enterValidMobile = 'Enter valid 10-digit mobile number';
  static const String enterNumbersOnly = 'Enter numbers only';
  static const String somethingWentWrong = 'Something went wrong';
  static const String noInternet = 'No internet connection';
}

class AppSizes {
  // Avatar Sizes
  static const double avatarSmall = 40.0;
  static const double avatarMedium = 50.0;
  static const double avatarLarge = 80.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 20.0;
  static const double iconLarge = 24.0;
  static const double iconXLarge = 32.0;

  // Button Sizes
  static const double buttonHeight = 56.0;
  static const double buttonSmallHeight = 40.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  static const double radiusCircle = 100.0;

  // Padding
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 12.0;
  static const double paddingLarge = 16.0;
  static const double paddingXLarge = 20.0;

  // Logo Size
  static const double logoWidth = 200.0;
  static const double logoHeight = 200.0;
}