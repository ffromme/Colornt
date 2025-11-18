import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Future <UserCredential> signIn({
  //   required String email,
  //   required String password,
  // }) async {
  //   return await firebaseAuth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult(
        success: true,
        user: userCredential.user,
        message: 'Login berhasil!',
      );

    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        errorCode: e.code,
        message: _getErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Terjadi kesalahan: $e',
      );
    }
  }

  Future<AuthResult> createAccount({
    required String fullName,
    required String email,
    required String password,
}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult(
          success: true,
          user: userCredential.user,
          message: "Login Berhasil!"
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: "Terjadi Kesalahan: $e",
      );
    }
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername({
    required String displayName,
  }) async {
    await currentUser?.updateDisplayName(displayName);
    await currentUser?.reload();
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await _firebaseAuth.signOut();
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }
}

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

String _getErrorMessage(String code) {
  switch (code) {
    case 'user-not-found':
      return 'Email tidak terdaftar';
    case 'wrong-password':
      return 'Password salah';
    case 'invalid-email':
      return 'Format email tidak valid';
    case 'user-disabled':
      return 'Akun telah dinonaktifkan';
    case 'too-many-requests':
      return 'Terlalu banyak percobaan. Coba lagi nanti';
    case 'invalid-credential':
      return 'Email atau password salah';
    case 'email-already-in-use':
      return 'Email sudah terdaftar';
    case 'weak-password':
      return 'Password terlalu lemah (minimal 6 karakter)';
    case 'network-request-failed':
      return 'Tidak ada koneksi internet';
    case 'operation-not-allowed':
      return 'Operasi tidak diizinkan';
    default:
      return 'Terjadi kesalahan. Silakan coba lagi';
  }
}

class AuthResult {
  final bool success;
  final User? user;
  final String message;
  final String? errorCode;

  AuthResult({
    required this.success,
    this.user,
    required this.message,
    this.errorCode,
  });
}