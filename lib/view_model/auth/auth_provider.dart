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
    await googleSignInService.signInWithGoogle();
    state = AuthStatus.authenticated;
  }

  Future<void> signOut() async {
    await googleSignInService.signOutGoogle();
    state = AuthStatus.unauthenticated;
  }
}
