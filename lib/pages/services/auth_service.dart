import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<void> signInIfNeeded() async {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      try {
        await auth.signInAnonymously();
        print('✅ Anonymous user signed in');
      } catch (e) {
        print('❌ Anonymous sign-in failed: $e');
      }
    } else {
      final user = auth.currentUser!;
      if (user.isAnonymous) {
        print('👤 Already signed in anonymously (UID: ${user.uid})');
      } else {
        print(
            '👤 Signed in with provider (UID: ${user.uid}, Email: ${user.email})');
      }
    }
  }

  static Future<String?> getToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final token = await user.getIdToken();
      print('🔐 Token generated: $token');
      return token;
    }
    return null;
  }
}
