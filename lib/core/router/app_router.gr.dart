// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    InfoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InfoScreen(),
      );
    },
    LungRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LungScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    SkinRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SkinScreen(),
      );
    },
    AuthBackgroundRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthBackgroundScreen(),
      );
    },
    SigninRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SigninScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignupScreen(),
      );
    },
    BookAppointmentRoute.name: (routeData) {
      final args = routeData.argsAs<BookAppointmentRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookAppointmentScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    BookAppointmentSuccessRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BookAppointmentSuccessScreen(),
      );
    },
    DoctorInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DoctorInfoRouteArgs>(
          orElse: () => DoctorInfoRouteArgs(id: pathParams.getString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DoctorInfoScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    FavoriteDoctorsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteDoctorsScreen(),
      );
    },
    WrongImageRoute.name: (routeData) {
      final args = routeData.argsAs<WrongImageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrongImageScreen(
          key: args.key,
          text: args.text,
        ),
      );
    },
    IntroRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IntroScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    AnalysisWithoutAuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AnalysisWithoutAuthScreen(),
      );
    },
    AnalysisRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AnalysisScreen(),
      );
    },
    AppointmentsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppointmentsScreen(),
      );
    },
    DoctorsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DoctorsScreen(),
      );
    },
    MessagesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MessagesScreen(),
      );
    },
    CallingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CallingScreen(),
      );
    },
    ChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatScreen(),
      );
    },
    ReceivedCallRoute.name: (routeData) {
      final args = routeData.argsAs<ReceivedCallRouteArgs>(
          orElse: () => const ReceivedCallRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReceivedCallScreen(
          key: args.key,
          isVideo: args.isVideo,
        ),
      );
    },
    OngoingCallRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OngoingCallScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [InfoScreen]
class InfoRoute extends PageRouteInfo<void> {
  const InfoRoute({List<PageRouteInfo>? children})
      : super(
          InfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'InfoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LungScreen]
class LungRoute extends PageRouteInfo<void> {
  const LungRoute({List<PageRouteInfo>? children})
      : super(
          LungRoute.name,
          initialChildren: children,
        );

  static const String name = 'LungRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SkinScreen]
class SkinRoute extends PageRouteInfo<void> {
  const SkinRoute({List<PageRouteInfo>? children})
      : super(
          SkinRoute.name,
          initialChildren: children,
        );

  static const String name = 'SkinRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthBackgroundScreen]
class AuthBackgroundRoute extends PageRouteInfo<void> {
  const AuthBackgroundRoute({List<PageRouteInfo>? children})
      : super(
          AuthBackgroundRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthBackgroundRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SigninScreen]
class SigninRoute extends PageRouteInfo<void> {
  const SigninRoute({List<PageRouteInfo>? children})
      : super(
          SigninRoute.name,
          initialChildren: children,
        );

  static const String name = 'SigninRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignupScreen]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute({List<PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BookAppointmentScreen]
class BookAppointmentRoute extends PageRouteInfo<BookAppointmentRouteArgs> {
  BookAppointmentRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
          BookAppointmentRoute.name,
          args: BookAppointmentRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'BookAppointmentRoute';

  static const PageInfo<BookAppointmentRouteArgs> page =
      PageInfo<BookAppointmentRouteArgs>(name);
}

class BookAppointmentRouteArgs {
  const BookAppointmentRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'BookAppointmentRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [BookAppointmentSuccessScreen]
class BookAppointmentSuccessRoute extends PageRouteInfo<void> {
  const BookAppointmentSuccessRoute({List<PageRouteInfo>? children})
      : super(
          BookAppointmentSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookAppointmentSuccessRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoctorInfoScreen]
class DoctorInfoRoute extends PageRouteInfo<DoctorInfoRouteArgs> {
  DoctorInfoRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
          DoctorInfoRoute.name,
          args: DoctorInfoRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'DoctorInfoRoute';

  static const PageInfo<DoctorInfoRouteArgs> page =
      PageInfo<DoctorInfoRouteArgs>(name);
}

class DoctorInfoRouteArgs {
  const DoctorInfoRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'DoctorInfoRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [FavoriteDoctorsScreen]
class FavoriteDoctorsRoute extends PageRouteInfo<void> {
  const FavoriteDoctorsRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteDoctorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteDoctorsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WrongImageScreen]
class WrongImageRoute extends PageRouteInfo<WrongImageRouteArgs> {
  WrongImageRoute({
    Key? key,
    required String text,
    List<PageRouteInfo>? children,
  }) : super(
          WrongImageRoute.name,
          args: WrongImageRouteArgs(
            key: key,
            text: text,
          ),
          initialChildren: children,
        );

  static const String name = 'WrongImageRoute';

  static const PageInfo<WrongImageRouteArgs> page =
      PageInfo<WrongImageRouteArgs>(name);
}

class WrongImageRouteArgs {
  const WrongImageRouteArgs({
    this.key,
    required this.text,
  });

  final Key? key;

  final String text;

  @override
  String toString() {
    return 'WrongImageRouteArgs{key: $key, text: $text}';
  }
}

/// generated route for
/// [IntroScreen]
class IntroRoute extends PageRouteInfo<void> {
  const IntroRoute({List<PageRouteInfo>? children})
      : super(
          IntroRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AnalysisWithoutAuthScreen]
class AnalysisWithoutAuthRoute extends PageRouteInfo<void> {
  const AnalysisWithoutAuthRoute({List<PageRouteInfo>? children})
      : super(
          AnalysisWithoutAuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalysisWithoutAuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AnalysisScreen]
class AnalysisRoute extends PageRouteInfo<void> {
  const AnalysisRoute({List<PageRouteInfo>? children})
      : super(
          AnalysisRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalysisRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AppointmentsScreen]
class AppointmentsRoute extends PageRouteInfo<void> {
  const AppointmentsRoute({List<PageRouteInfo>? children})
      : super(
          AppointmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DoctorsScreen]
class DoctorsRoute extends PageRouteInfo<void> {
  const DoctorsRoute({List<PageRouteInfo>? children})
      : super(
          DoctorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DoctorsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MessagesScreen]
class MessagesRoute extends PageRouteInfo<void> {
  const MessagesRoute({List<PageRouteInfo>? children})
      : super(
          MessagesRoute.name,
          initialChildren: children,
        );

  static const String name = 'MessagesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CallingScreen]
class CallingRoute extends PageRouteInfo<void> {
  const CallingRoute({List<PageRouteInfo>? children})
      : super(
          CallingRoute.name,
          initialChildren: children,
        );

  static const String name = 'CallingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChatScreen]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReceivedCallScreen]
class ReceivedCallRoute extends PageRouteInfo<ReceivedCallRouteArgs> {
  ReceivedCallRoute({
    Key? key,
    bool? isVideo,
    List<PageRouteInfo>? children,
  }) : super(
          ReceivedCallRoute.name,
          args: ReceivedCallRouteArgs(
            key: key,
            isVideo: isVideo,
          ),
          initialChildren: children,
        );

  static const String name = 'ReceivedCallRoute';

  static const PageInfo<ReceivedCallRouteArgs> page =
      PageInfo<ReceivedCallRouteArgs>(name);
}

class ReceivedCallRouteArgs {
  const ReceivedCallRouteArgs({
    this.key,
    this.isVideo,
  });

  final Key? key;

  final bool? isVideo;

  @override
  String toString() {
    return 'ReceivedCallRouteArgs{key: $key, isVideo: $isVideo}';
  }
}

/// generated route for
/// [OngoingCallScreen]
class OngoingCallRoute extends PageRouteInfo<void> {
  const OngoingCallRoute({List<PageRouteInfo>? children})
      : super(
          OngoingCallRoute.name,
          initialChildren: children,
        );

  static const String name = 'OngoingCallRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
