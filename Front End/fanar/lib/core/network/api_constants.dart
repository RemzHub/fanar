class ApiConstants {
  ///Constants
  // static const String baseUrl = 'http://192.168.137.1:8000';
  // static const String basePath = 'http://192.168.137.1:8000/api';
  static const String basePath = 'http://10.0.2.2:8000/api';
  static const String baseUrl = 'http://10.0.2.2:8000';
  static const String apiKey = '';

  // Ping
  static const String ping = '$basePath/ping';

  // Auth
  static const String register = '$basePath/register';
  static const String login = '$basePath/login';
  static const String checkUsername = '$basePath/username/check';
  static const String checkPhone = '$basePath/phone/check';
  static String userById(int id) => '$basePath/user/$id';

  // Profile
  static const String performerProfile = '$basePath/performer/update_profile';
  static const String recruiterProfile = '$basePath/recruiter/update_profile';

  // Media
  static const String mediaPath = '$basePath/media';
  static const String uploadMedia = '$mediaPath/upload';
  static const String deleteMedia = '$mediaPath/delete';
  static const String userGallery = '$mediaPath/gallery';
  static String mediaPreview(String url) => '$baseUrl/storage/$url';
  static String previewProfileImage(String url) => '$baseUrl/storage/$url';

  // Opportunities
  static const String opportunitiesPath = '$basePath/opportunities';
  static const String allOpportunities = '$opportunitiesPath/all';
  static const String createOpportunity = '$opportunitiesPath/create';

  // Applications
  static const String applicationsPath = '$basePath/applications';
  static const String createApplication = '$applicationsPath/create';
  static const String performerApplications =
      '$applicationsPath/performer/fetch';
  static const String recruiterApplications =
      '$applicationsPath/recruiter/fetch';
  static const String switchApplicationStatus =
      '$applicationsPath/status/switch';

  // Countries
  static const String countryPath = '$basePath/countries';
  static const String allCountries = '$countryPath/all';
  static const String allSupportedCountries = '$countryPath/supported/all';

  // Cities
  static const String cityPath = '$basePath/cities';
  static const String allCities = '$cityPath/all';

  // Countries
  static const String rolesPath = '$basePath/roles';
  static const String allRoles = '$rolesPath/all';

  // Countries
  static const String genderPath = '$basePath/genders';
  static const String allGenders = '$genderPath/all';

  // OTP
  static const String otpPath = '$basePath/otp';
  static const String sendOTP = '$otpPath/send';
  static const String checkOTP = '$otpPath/check';

  ///Functions
  // static String movieDetailPath(int movieId) => '$moviePath/$movieId?$apiKey';

  // static String imageUrl(String path) => '$baseImageUrl$path';
}
