import 'package:fanar/core/views/screens/actScreens/EndAudoiTest.dart';
import 'package:fanar/core/views/screens/actScreens/ResultScreen.dart';
import 'package:fanar/core/views/screens/actScreens/angerTest.dart';
import 'package:fanar/core/views/screens/actScreens/chatbot.dart';
import 'package:fanar/core/views/screens/actScreens/joyScreen.dart';
import 'package:fanar/core/views/screens/actScreens/sadScreen.dart';
import 'package:fanar/core/views/screens/actScreens/testScreen.dart';
import 'package:fanar/core/views/screens/actScreens/VideoTest.dart';
import 'package:fanar/core/views/screens/actScreens/testplanScreen.dart';
import 'package:fanar/features/application/view/screens/applications_screen.dart';
import 'package:fanar/features/auth/view/screens/auth_wrapper.dart';
import 'package:fanar/features/auth/view/screens/confirm_password_screen.dart';
import 'package:fanar/features/auth/view/screens/login_screen.dart';
import 'package:fanar/features/auth/view/screens/otp_screen.dart';
import 'package:fanar/features/auth/view/screens/register_screen.dart';
import 'package:fanar/features/home/view/recruiter/screens/recruiter_homepage_screen.dart';
import 'package:fanar/features/home/view/screens/homepage_screen.dart';
import 'package:fanar/features/opportunity/view/recruiter/screens/add_opportunity_screen.dart';
import 'package:fanar/features/opportunity/view/recruiter/screens/recruiter_opportunities_screen.dart';
import 'package:fanar/features/profile/view/recruiter/screens/recruiter_edit_profile_screen.dart';
import 'package:fanar/features/profile/view/screens/edit_profile_screen.dart';
import 'package:fanar/features/profile/view/screens/update_profile_image_screen.dart';
import 'package:fanar/features/profile/view/screens/upload_gallery_image.dart';
import 'package:fanar/features/splash/view/screens/splash_screen.dart';
import 'package:fanar/features/unknown_screen/view/screens/unknown_route_screen.dart';
import 'package:fanar/features/welcome/view/screens/welcome_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initialRoute = SplashScreen.routeName;

  static List<GetPage> getPages = [
    GetPage(name: AuthWrapper.routeName, page: () => AuthWrapper()),
    GetPage(name: SplashScreen.routeName, page: () => SplashScreen()),
    GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen()),
    GetPage(name: RegisterScreen.routeName, page: () => RegisterScreen()),
    GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
    GetPage(name: EditProfileScreen.routeName, page: () => EditProfileScreen()),
    GetPage(name: OTPScreen.routeName, page: () => OTPScreen()),
    GetPage(
        name: ConfirmPasswordScreen.routeName,
        page: () => ConfirmPasswordScreen()),
    GetPage(
        name: UpdateProfileImageScreen.routeName,
        page: () => UpdateProfileImageScreen()),
    GetPage(
        name: UploadGalleryImage.routeName, page: () => UploadGalleryImage()),
    GetPage(name: HomepageScreen.routeName, page: () => HomepageScreen()),
    GetPage(
        name: RecruiterHomepageScreen.routeName,
        page: () => RecruiterHomepageScreen()),
    GetPage(
      name: AddOpportunityScreen.routeName,
      page: () => AddOpportunityScreen(),
    ),
    GetPage(
      name: RecruiterEditProfileScreen.routeName,
      page: () => RecruiterEditProfileScreen(),
    ),
    GetPage(
      name: ApplicationsScreen.routeName,
      page: () => ApplicationsScreen(),
    ),
    GetPage(
      name: RecruiterOpportunities.routeName,
      page: () => RecruiterOpportunities(),
    ),
    GetPage(name: '/test', page: () => TestScreen()),
    GetPage(name: '/angertest', page: () => AngertestScreen()),
    GetPage(name: '/joytest', page: () => JoyScreen()),
    GetPage(name: '/sadtest', page: () => sadScreen()),
    GetPage(name: '/EndTestScren', page: () => EndTestScreen()),
    GetPage(name: '/videotest', page: () => videoScreen()),
    GetPage(name: '/ResultScreen', page: () => ResultScreen()),
    GetPage(name: '/TrainPscreen', page: () => TrainingScreen()),
    GetPage(name: '/ChatScren', page: () => ChatbotScreen()),
  ];

  static GetPage unknownScreenGetPage = GetPage(
    name: UnknownRouteScreen.routeName,
    page: () => UnknownRouteScreen(),
  );

  // There is no need to use generateRoutes because we will use getX getPage instead,
  // generateRoutes provide benefits when we need to use dynamic routes like websites,
  // which getX provide a high percentage of it
  // static Route<dynamic> generatesRoutes(RouteSettings settings) {
  //   switch (settings.name) {
  //     case "/HomePage":
  //       return MaterialPageRoute(
  //         builder: (context) => HomePage(),
  //       );
  //     default:
  //       return MaterialPageRoute(
  //         builder: (context) => SplashScreen(),
  //       );
  //   }
  // }
}
