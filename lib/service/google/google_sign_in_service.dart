import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:woohakdong/repository/auth/woohakdong_sign_in.dart';

import '../logger/logger.dart';

class GoogleSignInService {
  final WoohakdongSignIn _woohakdongSignIn = WoohakdongSignIn();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final String? googleAccessToken = googleAuth.accessToken;

        if (googleAccessToken != null) {
          final Map<String, String>? tokens = await _woohakdongSignIn.woohakdongSignIn(googleAccessToken);

          if (tokens != null) {
            await _secureStorage.write(key: 'accessToken', value: tokens['accessToken']);
            await _secureStorage.write(key: 'refreshToken', value: tokens['refreshToken']);

            logger.i('우학동 로그인 성공');
          } else {
            logger.e('토큰 받아 오기 실패');
          }
        } else {
          logger.e('우학동 로그인 실패');
        }
      } else {
        logger.e('구글 유저 정보 없음');
      }
    } catch (e) {
      logger.e('구글 로그인 실패', error: e);
    }
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
  }
}
