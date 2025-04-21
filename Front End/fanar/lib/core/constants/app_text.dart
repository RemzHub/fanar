class AppText {
  // Debug
  static const String dash24 = '------------------------';
  static const String dash64 =
      '----------------------------------------------------------------';

  static const String dateTime = 'Datetime:';

  // Network

  static String requestSent(String url) => 'Request has been sent to: $url';

  static String requestBody(String body) => 'Request body: $body';

  static const String requestDone = 'Request Done';
  static const String requestError = 'Request Error';
  static const String connectionTimeout =
      'Connection timeout, please try again.';
  static const String sendTimeout = 'Send timeout, check your connection';
  static const String receiveTimeout =
      'Receive timeout, check your connection.';
  static const String badCertificate = 'Bad certificate.';
  static const String badResponse = 'Bad response.';
  static const String cancel = 'Request was cancel.';
  static const String connectionError = 'No internet connection.';
  static const String unknown = 'Unexpected error.';
  static const String somethingWrong = 'Connection timeout, please try again.';
}
