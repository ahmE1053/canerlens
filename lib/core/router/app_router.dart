import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Presentation/Screens/analysis_screens/info_screen.dart';
import '../../Presentation/Screens/analysis_screens/lung_screen.dart';
import '../../Presentation/Screens/analysis_screens/skin_screen.dart';
import '../../Presentation/Screens/analysis_screens/profile_screen.dart';
import '../../Presentation/Screens/auth_screens/auth_background_screen.dart';
import '../../Presentation/Screens/auth_screens/sign_in_screen.dart';
import '../../Presentation/Screens/auth_screens/sign_up_screen.dart';
import '../../Presentation/Screens/doctors_related_screens/book_appointment.dart';
import '../../Presentation/Screens/doctors_related_screens/book_appointment_success.dart';
import '../../Presentation/Screens/doctors_related_screens/doctor_info_screen.dart';
import '../../Presentation/Screens/doctors_related_screens/favorite_doctors_screen.dart';
import '../../Presentation/Screens/error_screens/wrong_image_screen.dart';
import '../../Presentation/Screens/intro_screen/introduction_screen.dart';
import '../../Presentation/Screens/main_screen.dart';
import '../../Presentation/Screens/main_screen_without_authentication.dart';
import '../../Presentation/Screens/main_sections_screens/analysis_screen.dart';
import '../../Presentation/Screens/main_sections_screens/appointments_screen.dart';
import '../../Presentation/Screens/main_sections_screens/messages_screen.dart';
import '../../Presentation/Screens/main_sections_screens/doctors_screen.dart';
import '../../Presentation/Screens/messages_screens/calling_screen.dart';
import '../../Presentation/Screens/messages_screens/chat_screen.dart';
import '../../Presentation/Screens/messages_screens/incoming_call_screen.dart';
import '../../Presentation/Screens/messages_screens/ongoing_call_screen.dart';
import '../../Presentation/Screens/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  final analysisRouteWithAuth = AutoRoute(
    path: 'analysis',
    page: AnalysisRoute.page,
    children: [
      RedirectRoute(path: '', redirectTo: 'skin'),
      AutoRoute(
        path: 'skin',
        page: SkinRoute.page,
      ),
      AutoRoute(
        path: 'lung',
        page: LungRoute.page,
      ),
      AutoRoute(
        path: 'profile',
        page: ProfileRoute.page,
      ),
      AutoRoute(
        path: 'info',
        page: InfoRoute.page,
      ),
    ],
  );
  final analysisRouteWithoutAuth = AutoRoute(
    path: '/analysisWithoutAuth',
    page: AnalysisWithoutAuthRoute.page,
    children: [
      RedirectRoute(path: '', redirectTo: 'skin'),
      AutoRoute(
        path: 'skin',
        page: SkinRoute.page,
      ),
      AutoRoute(
        path: 'lung',
        page: LungRoute.page,
      ),
      AutoRoute(
        path: 'profile',
        page: ProfileRoute.page,
      ),
      AutoRoute(
        path: 'info',
        page: InfoRoute.page,
      ),
    ],
  );
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          path: '/splash',
          page: SplashRoute.page,
        ),
        AutoRoute(
          path: '/intro',
          page: IntroRoute.page,
        ),
        analysisRouteWithoutAuth,
        AutoRoute(
          path: '/home',
          page: MainRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: 'analysis'),
            analysisRouteWithAuth,
            AutoRoute(
              path: 'doctors',
              page: DoctorsRoute.page,
            ),
            AutoRoute(
              path: 'appointments',
              page: AppointmentsRoute.page,
            ),
            AutoRoute(
              path: 'messages',
              page: MessagesRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/home/doctors/:id',
          page: DoctorInfoRoute.page,
        ),
        AutoRoute(
          path: '/home/doctors/appointments/:id',
          page: BookAppointmentRoute.page,
        ),
        AutoRoute(
          path: '/home/doctors/appointmentsSuccess',
          page: BookAppointmentSuccessRoute.page,
        ),
        AutoRoute(
          path: '/home/doctors/favorites',
          page: FavoriteDoctorsRoute.page,
        ),
        AutoRoute(
          path: '/home/messages/chat',
          page: ChatRoute.page,
        ),
        AutoRoute(
          path: '/home/messages/incoming_call',
          page: ReceivedCallRoute.page,
        ),
        AutoRoute(
          path: '/home/messages/ongoing_call',
          page: OngoingCallRoute.page,
        ),
        AutoRoute(
          path: '/home/messages/calling',
          page: CallingRoute.page,
        ),
        AutoRoute(
          path: '/auth',
          page: AuthBackgroundRoute.page,
          children: [
            RedirectRoute(
              path: '',
              redirectTo: 'signin',
            ),
            AutoRoute(
              path: 'signin',
              page: SigninRoute.page,
              maintainState: false,
            ),
            AutoRoute(
              path: 'signup',
              page: SignupRoute.page,
              maintainState: false,
            ),
          ],
        ),
      ];

  // @override
  // void onNavigation(NavigationResolver resolver, StackRouter router) {
  //   if (FirebaseAuth.instance.currentUser != null ||
  //       resolver.route.name == AuthBackgroundRoute.name) {
  //     resolver.next();
  //   } else {
  //     resolver.redirect(
  //       const AuthBackgroundRoute(),
  //     );
  //   }
  // }
}

final appRouterProvider = Provider((ref) => AppRouter());
