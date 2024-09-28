import 'package:google_sign_in/google_sign_in.dart';

import '../logger/logger.dart';

class GoogleSignInService {
  static Future<Map<String, String?>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;
      final String? idToken = googleAuth?.idToken;

      return {
        'accessToken': accessToken,
        'idToken': idToken,
      };
    } catch (e) {
      logger.e(e, error: '로그인 실패');
      return {};
    }
  }

  static Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
  }
}
