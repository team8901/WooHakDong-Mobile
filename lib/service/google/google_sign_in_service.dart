import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../repository/auth/auth.dart';
import '../../service/logger/logger.dart'; // TokenManage 클래스 경로

class GoogleSignInService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Auth _tokenManage = Auth();
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

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (googleAccessToken != null) {
        final tokens = await _tokenManage.logIn(googleAccessToken);

        if (tokens != null) {
          final String accessToken = tokens['accessToken']!;
          final String refreshToken = tokens['refreshToken']!;

          await _secureStorage.write(key: 'accessToken', value: accessToken);
          await _secureStorage.write(key: 'refreshToken', value: refreshToken);

          logger.i("토큰 발급 성공");
          return true;
        } else {
          await _firebaseAuth.signOut();
          logger.e("서버로부터 토큰 발급에 실패하여 Firebase 로그아웃 처리됨");
          return false;
        }
      } else {
        logger.e("Google Access Token을 가져오지 못했습니다.");
        return false;
      }
    } catch (e) {
      logger.e("구글 로그인 실패: $e");
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      final String? refreshToken = await _secureStorage.read(key: 'refreshToken');

      if (refreshToken != null) {
        await _tokenManage.logOut(refreshToken);
      } else {
        logger.e("저장된 Refresh Token이 없습니다.");
        return false;
      }

      await _secureStorage.delete(key: 'accessToken');
      await _secureStorage.delete(key: 'refreshToken');

      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      logger.i("로그아웃이 성공적으로 처리되었습니다.");
      return true;
    } catch (e) {
      logger.e("로그아웃 실패", error: e);
      return false;
    }
  }
}
