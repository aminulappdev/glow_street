class Urls {
  // =========================================== Base ================================================ //
  //static const String _baseUrl = 'http://10.10.10.17:5006/api/v1';
  //static const String socketUrl = 'http://10.10.10.17:4000/';

  static const String _baseUrl = 'http://103.186.20.117:6105/api/v1';
  static const String socketUrl = 'http://74.118.168.203:4002/';

  // =========================================== Common ============================================== //
  static const String districtsUrl = '$_baseUrl/districts';
  static const String districtUrl = '$_baseUrl/districts';
  static const String schoolsUrl = '$_baseUrl/schools';
  static const String categoryUrl = '$_baseUrl/categories';
  static const String profileUrl = '$_baseUrl/users/my-profile';
  static const String notificationsUrl = '$_baseUrl/notifications';
  static const String contentUrl = '$_baseUrl/legal';

  // =========================================== Emergency Contact ============================================== //
  static const String allEmergencyContactUrl = '$_baseUrl/emergency-contacts/my-contact';
  static const String addEmergencyContactUrl = '$_baseUrl/emergency-contacts';
  static String editContactById(String id) {
    return '$_baseUrl/emergency-contacts/$id';
  }
   static String deleteContactById(String id) {
    return '$_baseUrl/emergency-contacts/$id';
  }

  // =========================================== Authentication ====================================== //
  static const String signUpUrl = '$_baseUrl/users';
  static const String refreshTokenUrl = '$_baseUrl/auth/refresh-token';
  static const String googleAuthUrl = '$_baseUrl/auth/social-login';
  static const String otpVerifyUrl = '$_baseUrl/otp/verify-otp';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String forgotPasswordUrl = '$_baseUrl/auth/forgot-password';
  static const String changePasswordUrl = '$_baseUrl/auth/change-password';
  static const String deleteAccountUrl = '$_baseUrl/auth/change-password';
  static const String resetPasswordUrl =
      '$_baseUrl/auth/reset-password';

  // =========================================== Profile Block ======================================= //
  static const String updateProfileUrl = '$_baseUrl/users/update-my-profile';
  static const String updateProfilImageUrl =
      '$_baseUrl/teachers/profile/change-image';

  // =========================================== Home Block ========================================== //
  static const String assetsUrl = '$_baseUrl/assets';
  static const String myAssetsUrl = '$_baseUrl/assets/my-posted';
  static const String createAssetUrl = '$_baseUrl/assets';
  static const String myGrabbedUrl = '$_baseUrl/assets/my-grabbed';
  static String assetsDetailsById(String id) {
    return '$_baseUrl/assets/$id';
  }

  static String deleteNotificationById(String id) {
    return '$_baseUrl/notifications/$id';
  }

  // =========================================== Chat Block =========================================== //
  static const String allFriendsChatnUrl = '$_baseUrl/chats/my';
  static const String lastGrappedUrl = '$_baseUrl/assets/last-grabbed';
  static const String createChatUrl = '$_baseUrl/chats';
  static const String imageDecodeUrl = '$_baseUrl/upload-files';
  static const String messageSeenUrl = '$_baseUrl/upload-files';

  static String messagesById(String id) {
    return '$_baseUrl/messages/$id';
  }

  static String messagesSeenById(String id) {
    return '$_baseUrl/messages/seen/$id';
  }

  static String grabbedById(String id) {
    return '$_baseUrl/assets/$id/grab';
  }
}
