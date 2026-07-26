import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream Login
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current User
  User? get currentUser => _auth.currentUser;

  // ================= REGISTER =================
  Future<UserCredential?> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final user = credential.user;

    if (user != null) {
      // Update Display Name di Authentication
      await user.updateDisplayName(displayName.trim());
      await user.reload();

      // Simpan data user ke Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'displayName': displayName.trim(),
        'email': email.trim(),
        'role': 'user',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    }

    return credential;
  }

  // ================= LOGIN =================
  Future<UserCredential?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final user = credential.user;

    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    return credential;
  }

  // ================= LOGOUT =================
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ================= RESET PASSWORD =================
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  // ================= ERROR MESSAGE =================
  static String getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Akun dengan email ini tidak ditemukan.';
      case 'wrong-password':
        return 'Password yang Anda masukkan salah.';
      case 'email-already-in-use':
        return 'Email ini sudah digunakan akun lain.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'weak-password':
        return 'Password terlalu lemah. Minimal 6 karakter.';
      case 'user-disabled':
        return 'Akun ini telah dinonaktifkan.';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi nanti.';
      case 'network-request-failed':
        return 'Tidak ada koneksi internet.';
      case 'invalid-credential':
        return 'Email atau password salah.';
      default:
        return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
}
