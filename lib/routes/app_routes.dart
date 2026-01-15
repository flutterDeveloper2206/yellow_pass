
import 'package:yellow_pass/presentation/dashboard_screen/binding/dashboard_screen_binding.dart';
import 'package:yellow_pass/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:yellow_pass/presentation/home_screen/binding/home_screen_binding.dart';
import 'package:yellow_pass/presentation/home_screen/home_screen.dart';
import 'package:yellow_pass/presentation/login_screen/binding/login_screen_binding.dart';
import 'package:yellow_pass/presentation/login_screen/login_screen.dart';
import 'package:yellow_pass/presentation/network_screen/binding/network_screen_binding.dart';
import 'package:yellow_pass/presentation/network_screen/network_screen.dart';
import 'package:yellow_pass/presentation/notification_screen/binding/notification_screen_binding.dart';
import 'package:yellow_pass/presentation/notification_screen/notification_screen.dart';
import 'package:yellow_pass/presentation/onboarding_screen/binding/onboarding_screen_binding.dart';
import 'package:yellow_pass/presentation/profile_screen/binding/profile_screen_binding.dart';
import 'package:yellow_pass/presentation/profile_screen/profile_screen.dart';
import 'package:yellow_pass/presentation/register_screen/binding/register_screen_binding.dart';
import 'package:yellow_pass/presentation/register_screen/register_screen.dart';
import 'package:yellow_pass/presentation/welcome_screen/binding/welcome_screen_binding.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/presentation/splash_screen/binding/splash_screen_binding.dart';
import 'package:yellow_pass/presentation/splash_screen/splash_screen.dart';
import 'package:yellow_pass/presentation/welcome_screen/welcome_screen.dart';

import '../presentation/onboarding_screen/onboarding_screen.dart';
import 'package:yellow_pass/presentation/cafe_details_screen/binding/cafe_details_binding.dart';
import 'package:yellow_pass/presentation/cafe_details_screen/cafe_details_screen.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/binding/cafe_book_binding.dart';
import 'package:yellow_pass/presentation/cafe_book_screen/cafe_book_screen.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/binding/my_bookings_binding.dart';
import 'package:yellow_pass/presentation/my_bookings_screen/my_bookings_screen.dart';
import 'package:yellow_pass/presentation/notification_screen/binding/notification_binding.dart';
import 'package:yellow_pass/presentation/notification_screen/notification_screen.dart';
import 'package:yellow_pass/presentation/profile_details_screen/binding/profile_details_binding.dart';
import 'package:yellow_pass/presentation/profile_details_screen/profile_details_screen.dart';
import 'package:yellow_pass/presentation/settings_screen/binding/settings_binding.dart';
import 'package:yellow_pass/presentation/settings_screen/settings_screen.dart';
import 'package:yellow_pass/presentation/verification_screen/binding/verification_binding.dart';
import 'package:yellow_pass/presentation/verification_screen/verification_screen.dart';
import 'package:yellow_pass/presentation/verify_otp_screen/binding/verify_otp_binding.dart';
import 'package:yellow_pass/presentation/verify_otp_screen/verify_otp_screen.dart';
import 'package:yellow_pass/presentation/wallet_screen/binding/wallet_screen_binding.dart';
import 'package:yellow_pass/presentation/wallet_screen/wallet_screen.dart';
import 'package:yellow_pass/presentation/wallet_history_screen/binding/wallet_history_binding.dart';
import 'package:yellow_pass/presentation/wallet_history_screen/wallet_history_screen.dart';
import 'package:yellow_pass/presentation/my_booking_screen/binding/my_booking_binding.dart';
import 'package:yellow_pass/presentation/my_booking_screen/my_booking_screen.dart';
import 'package:yellow_pass/presentation/qr_scanner_screen/binding/qr_scanner_binding.dart';
import 'package:yellow_pass/presentation/qr_scanner_screen/qr_scanner_screen.dart';
import 'package:yellow_pass/presentation/check_in_success_screen/binding/check_in_success_binding.dart';
import 'package:yellow_pass/presentation/check_in_success_screen/check_in_success_screen.dart';
import 'package:yellow_pass/presentation/support_screen/binding/support_binding.dart';
import 'package:yellow_pass/presentation/support_screen/support_screen.dart';
import 'package:yellow_pass/presentation/search_screen/binding/search_binding.dart';
import 'package:yellow_pass/presentation/search_screen/search_screen.dart';
import 'package:yellow_pass/presentation/check_in_otp_screen/binding/check_in_otp_binding.dart';
import 'package:yellow_pass/presentation/check_in_otp_screen/check_in_otp_screen.dart';

class AppRoutes {
  static const String splashScreenRoute = '/splash_screen';
  static const String welcomeScreenRoute = '/welcome_screen';
  static const String loginScreenRoute = '/login_screen';
  static const String registerScreenRoute = '/register_screen';
  static const String dashboardScreenRoute = '/dashboard_screen';
  static const String homeScreenRoute = '/home_screen';
  static const String profileScreenRoute = '/profile_screen';
  static const String networkScreenRoute = '/network_screen';
  static const String onBoardingRoute = '/onBoarding_screen';
  static const String cafeDetailsScreenRoute = '/cafe_details_screen';
  static const String cafeBookScreenRoute = '/cafe_book_screen';
  static const String myBookingsScreenRoute = '/my_bookings_screen';
  static const String notificationScreenRoute = '/notification_screen';
  static const String profileDetailsScreenRoute = '/profile_details_screen';
  static const String settingsScreenRoute = '/settings_screen';
  static const String verificationScreenRoute = '/verification_screen';
  static const String verifyOtpScreenRoute = '/verify_otp_screen';
  static const String walletScreenRoute = '/wallet_screen';
  static const String walletHistoryScreenRoute = '/wallet_history_screen';
  static const String myBookingScreenRoute = '/my_booking_screen';
  static const String qrScannerScreenRoute = '/qr_scanner_screen';
  static const String checkInSuccessScreenRoute = '/check_in_success_screen';
  static const String supportScreenRoute = '/support_screen';
  static const String searchScreenRoute = '/search_screen';
  static const String checkInOtpScreenRoute = '/check_in_otp_screen';

  static List<GetPage> pages = [
    GetPage(
        name: splashScreenRoute,
        page: () => const SplashScreen(),
        bindings: [
          SplashScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: welcomeScreenRoute,
        page: () => const WelComeScreen(),
        bindings: [
          WelComeScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: loginScreenRoute,
        page: () => const LoginScreen(),
        bindings: [
          LoginScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: registerScreenRoute,
        page: () => const RegisterScreen(),
        bindings: [
          RegisterScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: dashboardScreenRoute,
        page: () =>  DashboardScreen(),
        bindings: [
          DashboardScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: homeScreenRoute,
        page: () => const HomeScreen(),
        bindings: [
          HomeScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: profileScreenRoute,
        page: () => const ProfileScreen(),
        bindings: [
          ProfileScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: networkScreenRoute,
        page: () => const NetworkScreen(),
        bindings: [
          NetworkScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: onBoardingRoute,
        page: () =>  OnboardingScreen(),
        bindings: [
          OnboardingScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
      name: cafeDetailsScreenRoute,
      page: () => const CafeDetailsScreen(),
      bindings: [
        CafeDetailsBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: cafeBookScreenRoute,
      page: () => const CafeBookScreen(),
      bindings: [
        CafeBookBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: myBookingsScreenRoute,
      page: () => const MyBookingsScreen(),
      bindings: [
        MyBookingsBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: notificationScreenRoute,
      page: () => const NotificationScreen(),
      bindings: [
        NotificationBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: profileDetailsScreenRoute,
      page: () => const ProfileDetailsScreen(),
      bindings: [
        ProfileDetailsBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: settingsScreenRoute,
      page: () => const SettingsScreen(),
      bindings: [
        SettingsBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: verificationScreenRoute,
      page: () => const VerificationScreen(),
      bindings: [
        VerificationBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: verifyOtpScreenRoute,
      page: () => const VerifyOtpScreen(),
      bindings: [
        VerifyOtpBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: walletScreenRoute,
      page: () => const WalletScreen(),
      bindings: [
        WalletScreenBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: walletHistoryScreenRoute,
      page: () => const WalletHistoryScreen(),
      bindings: [
        WalletHistoryBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: myBookingScreenRoute,
      page: () => const MyBookingScreen(),
      bindings: [
        MyBookingBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: qrScannerScreenRoute,
      page: () => const QrScannerScreen(),
      bindings: [
        QrScannerBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: checkInSuccessScreenRoute,
      page: () => const CheckInSuccessScreen(),
      bindings: [
        CheckInSuccessBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: supportScreenRoute,
      page: () => const SupportScreen(),
      bindings: [
        SupportBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: searchScreenRoute,
      page: () => const SearchScreen(),
      bindings: [
        SearchBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: checkInOtpScreenRoute,
      page: () => const CheckInOtpScreen(),
      bindings: [
        CheckInOtpBinding(),
      ],
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
