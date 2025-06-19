class Urls {
  static const String _baseUrl = 'http://115.127.156.131:7000/api/v1';
  // static const String _baseUrl = 'http://192.168.10.22:7000/api/v1';
  static const String createUserUrl = '$_baseUrl/users';
  static const String otpVerifyrUrl = '$_baseUrl/otp/verify-otp';
  static const String signInUrl = '$_baseUrl/auth/login'; 
  static const String forgotPasswordUrl = '$_baseUrl/auth/forgot-password';
  static const String resendOTPUrl = '$_baseUrl/otp/resend-otp';
  static const String resetPasswordUrl = '$_baseUrl/auth/reset-password';
  static const String googleAuthUrl = '$_baseUrl/auth/google-login';
  static const String getProfileUrl = '$_baseUrl/users/my-profile';
  static const String updateProfileUrl = '$_baseUrl/users/update-my-profile';
  static const String categoryUrl = '$_baseUrl/categories';
  static const String productUrl = '$_baseUrl/products';
  static const String ordertUrl = '$_baseUrl/orders';
  static const String addToCartUrl = '$_baseUrl/add-to-card';
  static const String myOrderUrl = '$_baseUrl/orders/my-orders';
  static const String allShopsUrl = '$_baseUrl/shop';
  static const String paymentUrl = '$_baseUrl/payments/checkout';
  static const String changePasswordtUrl = '$_baseUrl/auth/change-password';
  static const String notificationUrl = '$_baseUrl/notifications';
  static const String contentByParam = '$_baseUrl/contents';

  static String productDetailsById(
    String id,
  ) {
    return '$_baseUrl/products/$id';
  }

  

  static String confirmedPaymentUrlsById(
    String id,
  ) {
    return '$_baseUrl/payments/order/$id';
  }

  static String deleteCartById(
    String id,
  ) {
    return '$_baseUrl/add-to-card/$id';
  }
}
