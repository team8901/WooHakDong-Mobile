import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woohakdong/service/google/google_sign_in_service.dart';
import 'package:woohakdong/view_model/auth/components/auth_state_provider.dart';

import 'components/auth_state.dart';

final authProvider = StateNotifierProvider((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final GoogleSignInService googleSignInService = GoogleSignInService();
  final Ref ref;

  AuthNotifier(this.ref) : super(null);

  Future<void> checkLoginStatus() async {
    String? accessToken = await secureStorage.read(key: 'accessToken');
    String? refreshToken = await secureStorage.read(key: 'refreshToken');

    if (accessToken != null && refreshToken != null) {
      ref.read(authStateProvider.notifier).state = AuthState.authenticated;
    } else {
      ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
    }
  }

  Future<void> signIn() async {
    try {
      ref.read(authStateProvider.notifier).state = AuthState.loading;

      bool isSignedIn = await googleSignInService.signInWithGoogle();

      if (isSignedIn) {
        ref.read(authStateProvider.notifier).state = AuthState.authenticated;
      } else {
        ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
      }
    } catch (e) {
      ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
    }
  }

  Future<void> signOut() async {
    try {
      bool isSignedOut = await googleSignInService.signOut();

      if (isSignedOut) {
        ref.read(authStateProvider.notifier).state = AuthState.unauthenticated;
      } else {
        ref.read(authStateProvider.notifier).state = AuthState.authenticated;
      }
    } catch (e) {
      ref.read(authStateProvider.notifier).state = AuthState.authenticated;
    }
  }
}
