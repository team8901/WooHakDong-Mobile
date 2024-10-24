import 'dart:io';

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
import 'package:woohakdong/view_model/club/current_club_provider.dart';
import 'package:woohakdong/view_model/member/components/member_state.dart';
import 'package:woohakdong/view_model/member/member_provider.dart';
import 'package:woohakdong/view_model/member/member_state_provider.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final memberNotifier = ref.read(memberProvider.notifier);
    final memberState = ref.watch(memberStateProvider);
    final currentClub = ref.watch(currentClubProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          key: ValueKey(currentClub?.clubId ?? 'no_club'),
          title: '우학동: 우리 학교 동아리',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home: Builder(
            builder: (context) {
              if (authState == AuthState.authenticated) {
                return FutureBuilder(
                  future: memberNotifier.getMemberInfo(),
                  builder: (context, memberSnapshot) {
                    if (memberSnapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(body: CustomCircularProgressIndicator());
                    } else if (memberSnapshot.hasError) {
                      // 에러 발생 시 로그인 화면으로 이동
                      return const LoginPage();
                    } else {
                      if (memberState == MemberState.nonMember) {
                        // 우학동 회원가입이 안되어 있으면 회원가입 화면으로 이동
                        FlutterNativeSplash.remove();
                        return const MemberRegisterPage();
                      } else if (memberState == MemberState.member) {
                        if (currentClub == null) {
                          // 동아리 등록이 안되어 있으면 동아리 등록 화면으로 이동
                          FlutterNativeSplash.remove();
                          return const ClubRegisterPage();
                        } else {
                          // 동아리도 등록했으면 메인 화면으로 이동
                          FlutterNativeSplash.remove();
                          return const RoutePage();
                        }
                      } else {
                        // 로그인 실패 시 로그인 화면으로 이동
                        FlutterNativeSplash.remove();
                        return const LoginPage();
                      }
                    }
                  },
                );
              } else {
                // 인증되지 않은 경우 로그인 화면으로 이동
                FlutterNativeSplash.remove();
                return const LoginPage();
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
