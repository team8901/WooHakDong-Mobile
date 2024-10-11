import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woohakdong/service/google/google_sign_in_service.dart';

import 'components/auth_status.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthStatus> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final GoogleSignInService googleSignInService = GoogleSignInService();

  AuthNotifier() : super(AuthStatus.unauthenticated) {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    String? accessToken = await secureStorage.read(key: 'accessToken');
    String? refreshToken = await secureStorage.read(key: 'refreshToken');

    if (accessToken != null && refreshToken != null) {
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> signIn() async {
    bool isSignedIn = await googleSignInService.signInWithGoogle();
    if (isSignedIn) {
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> signOut() async {
    bool isSignedOut = await googleSignInService.signOut();
    if (isSignedOut) {
      state = AuthStatus.unauthenticated;
    } else {
      state = AuthStatus.authenticated;
    }
  }
}
