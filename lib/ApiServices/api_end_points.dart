class ApiEndPoints {
  static const String baseUrl = "https://api.yellowpass.in/api";
  static const String linkedinMobileLogin = "$baseUrl/linkedin/mobile-login";
  static const String userProfileApi = "$baseUrl/profile";
  static const String updateLocation = "$baseUrl/user/location";
  static const String updateVisibilityApi = "$baseUrl/user/visibility";
  
  // Verification
  static const String sendEmailOtp = "$baseUrl/auth/verify/email/send";
  static const String confirmEmailOtp = "$baseUrl/auth/verify/email/confirm";
  static const String sendMobileOtp = "$baseUrl/auth/verify/mobile/send";
  static const String confirmMobileOtp = "$baseUrl/auth/verify/mobile/confirm";

  // Cafes
  static const String cafesCategories = "$baseUrl/cafes/categories";
  static const String cafesApi = "$baseUrl/cafes";
  static String cafeDetails(String id) => "$baseUrl/cafes/$id";
  static String tableTypes(String cafeId) => "$baseUrl/cafes/$cafeId/table-types";
  static const String checkAvailability = "$baseUrl/search/availability";
  static const String notificationsApi = "$baseUrl/notifications";
  static const String contactInfoApi = "$baseUrl/contact-info";
  static const String reviews = "$baseUrl/reviews";
  static const String bookings = "$baseUrl/bookings";
  static const String userBookings = "$baseUrl/bookings/user_bookings";
  static const String checkIn = "$baseUrl/booking/checkin";
  static const String checkOut = "$baseUrl/booking/checkout";
  static const String buyTokens = "$baseUrl/tokens/buy";
  static const String verifyTokens = "$baseUrl/tokens/verify";
  static const String transactionHistoryApi = "$baseUrl/wallet/user-transaction-history";
}
