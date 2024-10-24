import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:woohakdong/view/club_register/club_register_page.dart';
import 'package:woohakdong/view/login/login_page.dart';
import 'package:woohakdong/view/member_register/member_register_page.dart';
import 'package:woohakdong/view/route_page.dart';
import 'package:woohakdong/view/themes/custom_widget/custom_circular_progress_indicator.dart';
import 'package:woohakdong/view/themes/dark_theme.dart';
import 'package:woohakdong/view/themes/light_theme.dart';
import 'package:woohakdong/view_model/auth/auth_provider.dart';
import 'package:woohakdong/view_model/auth/components/auth_state.dart';
import 'package:woohakdong/view_model/club/club_provider.dart';
import 'package:woohakdong/view_model/club/components/club_state.dart';
import 'package:woohakdong/view_model/club/components/club_state_provider.dart';
import 'package:woohakdong/view_model/member/components/member_state.dart';
import 'package:woohakdong/view_model/member/components/member_state_provider.dart';
import 'package:woohakdong/view_model/member/member_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.photos.request();
  await Permission.storage.request();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HttpOverrides.global = MyHttpOverrides();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeApp();

    FlutterNativeSplash.remove();
  }

  Future<void> _initializeApp() async {
    final memberNotifier = ref.read(memberProvider.notifier);
    await memberNotifier.getMemberInfo();
    final clubNotifier = ref.read(clubProvider.notifier);
    await clubNotifier.getClubList();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final memberState = ref.watch(memberStateProvider);
    final clubState = ref.watch(clubStateProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: '우학동: 우리 학교 동아리',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: SafeArea(child: CustomCircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return const LoginPage();
              } else {
                if (FirebaseAuth.instance.currentUser != null && authState == AuthState.authenticated) {
                  if (memberState == MemberState.memberNotRegistered) {
                    return const MemberRegisterPage();
                  } else if (memberState == MemberState.memberRegistered) {
                    if (clubState == ClubState.clubNotRegistered) {
                      return const ClubRegisterPage();
                    } else {
                      return const RoutePage();
                    }
                  } else {
                    return const LoginPage();
                  }
                } else {
                  return const LoginPage();
                }
              }
            },
          ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
