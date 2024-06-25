import 'package:get/get.dart';

import '../app/modules/NewTestPage/bindings/new_test_page_binding.dart';
import '../app/modules/NewTestPage/views/new_test_page_view.dart';
import '../app/modules/appointments/bindings/appointment_bindings.dart';
import '../app/modules/appointments/view/appointment_view.dart';
import '../app/modules/bottom_navigation_bar/bindings/bottom_navigation_bar_bindings.dart';
import '../app/modules/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';
import '../app/modules/change-password/bindings/change-password-bindings.dart';
import '../app/modules/change-password/view/change_password_view.dart';
import '../app/modules/diagnostic_test/bindings/diagnostic_bindings.dart';
import '../app/modules/diagnostic_test/view/diagnostic_view.dart';
import '../app/modules/doctor/binding/doctor_binding.dart';
import '../app/modules/doctor/view/doctor_details_view.dart';
import '../app/modules/doctor/view/doctor_view.dart';
import '../app/modules/e-shop/bindings/eshop_bindings.dart';
import '../app/modules/e-shop/view/cart_view.dart';
import '../app/modules/e-shop/view/eshop_view.dart';
import '../app/modules/emergency/bindings/emergency_bindings.dart';
import '../app/modules/emergency/view/emergency_view.dart';
import '../app/modules/favourite/view/favourite_view.dart';
import '../app/modules/forget_password/bindings/forget_password_bindings.dart';
import '../app/modules/forget_password/view/forget_password_view.dart';
import '../app/modules/health/bindings/health_bindings.dart';
import '../app/modules/health/view/health_view.dart';
import '../app/modules/home/bindings/home_binding.dart';
import '../app/modules/home/views/home_view.dart';
import '../app/modules/hospital/bindings/hospital_bindings.dart';
import '../app/modules/hospital/view/hospital_view.dart';
import '../app/modules/index/bindings/index_binding.dart';
import '../app/modules/index/views/index_view.dart';
import '../app/modules/login/bindings/login_binding.dart';
import '../app/modules/login/views/login_view.dart';
import '../app/modules/personal/bindings/personal_bindings.dart';
import '../app/modules/personal/view/personal_view.dart';
import '../app/modules/profile/bindings/profile_binding.dart';
import '../app/modules/profile/view/profile_view.dart';
import '../app/modules/report/bindings/test_report_binding.dart';
import '../app/modules/report/view/test_report_view.dart';
import '../app/modules/services/bindings/services_bindings.dart';
import '../app/modules/services/view/services_view.dart';
import '../app/modules/signup/bindings/signup_binding.dart';
import '../app/modules/signup/views/signup_view.dart';
import '../app/modules/splash/binding/splash_binding.dart';
import '../app/modules/splash/view/splash_view.dart';
import '../app/modules/video/create_meeting.dart';
import '../app/modules/video/video_call_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.createMeeting;
  static const INITIAL = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INDEX,
      page: () => const IndexView(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.forgetPassword,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.changePassword,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.favouritePage,
      page: () => const FavouriteView(),
      // binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.bottomNavigationBar,
      page: () => BottomNavigationBarView(routeIndex: 0),
      binding: BottomNavigationBarBindings(),
    ),
    GetPage(
      name: _Paths.cartPage,
      page: () => const CartView(),
      binding: EShopBindings(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.profilePage,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.doctorPage,
      page: () => const DoctorView(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: _Paths.doctorDetailsPage,
      page: () => const DoctorDetailView(doctorModel: null),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: _Paths.servicesPage,
      page: () => const ServicesView(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: _Paths.appointmentsPage,
      page: () => const AppointmentView(),
      binding: AppointmentBindings(),
    ),
    GetPage(
      name: _Paths.eShopPage,
      page: () => const EShopView(),
      binding: EShopBindings(),
    ),
    GetPage(
      name: _Paths.emergencyPage,
      page: () => const EmergencyView(),
      binding: EmergencyBinding(),
    ),
    GetPage(
      name: _Paths.personalPage,
      page: () => const PersonalView(),
      binding: PersonalBindings(),
    ),
    GetPage(
      name: _Paths.healthPage,
      page: () => const HealthView(),
      binding: HealthBindings(),
    ),
    GetPage(
      name: _Paths.hospitalInformationPage,
      page: () => const HospitalView(),
      binding: HospitalBindings(),
    ),
    GetPage(
      name: _Paths.diagnosticTestPage,
      page: () => const DiagnosticTestView(),
      binding: DiagnosticBindings(),
    ),
    GetPage(
      name: _Paths.testReportPage,
      page: () => const TestReportView(),
      binding: TestReportBindings(),
    ),
    GetPage(
      name: _Paths.createMeeting,
      page: () => const CreateMeeting(),
    ),
    GetPage(
      name: _Paths.videocall,
      page: () => const VideoCallView(callId: '', userId: '', userName: ''),
    ),
    GetPage(
      name: _Paths.NEW_TEST_PAGE,
      page: () => const NewTestPageView(
        diagnosticPeName: null,
        diagnosticTestName: null,
      ),
      binding: NewTestPageBinding(),
    ),
  ];
}
