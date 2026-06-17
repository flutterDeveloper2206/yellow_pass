class ApiEndPoints {
  static const String imageBaseUrl = "https://api.yellowpass.in";
  static const String baseUrl = "$imageBaseUrl/api";
  static const String linkedinMobileLogin = "$baseUrl/linkedin/mobile-login";
  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/mobile/login";
  static const String forgotPassword = "$baseUrl/forgot-password";
  static const String resetPassword = "$baseUrl/reset-password";
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
  static String tableTypes(String cafeId) =>
      "$baseUrl/cafes/$cafeId/table-types";
  static const String checkAvailability = "$baseUrl/search/availability";
  static const String notificationsApi = "$baseUrl/notifications";
  static const String contactInfoApi = "$baseUrl/contact-info";
  static const String reviews = "$baseUrl/reviews";
  static const String bookings = "$baseUrl/bookings";
  static const String userBookings = "$baseUrl/bookings/user_bookings";
  static const String checkIn = "$baseUrl/booking/checkin";
  static const String checkOut = "$baseUrl/booking/checkout";
  static const String activeBooking = "$baseUrl/booking/user-active";
  static const String buyTokens = "$baseUrl/tokens/buy";
  static const String verifyTokens = "$baseUrl/tokens/verify";
  static const String transactionHistoryApi =
      "$baseUrl/wallet/user-transaction-history";

  // Nearby
  static const String nearbyUsers = "$baseUrl/users/nearby";
  static const String nearbyCafes = "$baseUrl/cafes";
  static const String activeAdsAPI = "$baseUrl/ads/active-cafes";

  // Subscriptions
  static const String subscriptions = "$baseUrl/subscriptions";
  static const String initiateSubscription = "$baseUrl/subscriptions/initiate";
  static const String verifySubscription = "$baseUrl/subscriptions/verify";
  static const String orders = "$baseUrl/orders";
  static String cancelOrder(String id) => "$baseUrl/orders/$id/cancel";
  static const String meetingRequests = "$baseUrl/meeting-requests";
  static const String incomingMeetingRequests = "$meetingRequests/incoming";
  static const String sentMeetingRequests = "$meetingRequests/sent";
  static String respondMeetingRequest(String id) =>
      "$meetingRequests/$id/respond";
}
