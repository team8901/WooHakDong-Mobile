import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../repository/auth/woohakdong_auth_repository.dart';
import '../../service/logger/logger.dart';

class GoogleSignInService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final WoohakdongAuthRepository _auth = WoohakdongAuthRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        logger.w("구글 로그인 취소");
        return false;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final String? googleAccessToken = googleAuth.accessToken;
      final String? googleIdToken = googleAuth.idToken;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAccessToken,
        idToken: googleIdToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      if (googleAccessToken != null) {
        final tokens = await _auth.logIn(googleAccessToken);

        final String accessToken = tokens['accessToken']!;
        final String refreshToken = tokens['refreshToken']!;

        await _secureStorage.write(key: 'accessToken', value: accessToken);
        await _secureStorage.write(key: 'refreshToken', value: refreshToken);

        return true;
      }

      logger.w("구글 액세스 토큰 없음");
      return false;
    } catch (e) {
      logger.e("구글 로그인 실패", error: e);

      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      logger.i("로그아웃 시도");

      final String? refreshToken = await _secureStorage.read(key: 'refreshToken');

      if (refreshToken != null) {
        await _auth.logOut(refreshToken);

        await _firebaseAuth.signOut();
        await _googleSignIn.signOut();
        await _secureStorage.deleteAll();

        return true;
      }

      return false;
    } catch (e) {
      logger.e("로그아웃 실패", error: e);
      return false;
    }
  }
}
