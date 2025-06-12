import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanctuarai/services/auth_service.dart';

class AuthController {
  static final authController = AuthController();

  Future<String?> signUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    if (email.isEmpty || password.isEmpty || userName.isEmpty) {
      return "Please fill all the information";
    }
    try {
      await authService.value.createAccount(email: email, password: password);
      await authService.value.updateUsername(username: userName);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message ?? "unknown error";
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return "Please fill all the information";
    }
    try {
      await authService.value.signIn(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "unknown error";
    }
  }

  Future<String?> logout() async {
    try {
      await authService.value.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "error unknown";
    }
  }

  Future<String?> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    if (email.isEmpty || currentPassword.isEmpty || newPassword.isEmpty) {
      return "Please fill all the information";
    }
    try {
      await authService.value.resetPasswordFromCurrentPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        email: email,
      );
      return null;

    } on FirebaseAuthException catch (e) {
      return e.message ?? "unknown error";
    }
  }

  Future<String?> deleteAccount({
    required String email,
    required String password
}) async{
    if (email.isEmpty || password.isEmpty) {
      return "Please fill all the information";
    }
    try{
      await authService.value.deleteAccount(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e){
      return e.message ?? "unknown error";
    }
  }

  Future<String?> resetPassword({
    required String email
}) async{
    if (email.isEmpty ) {
      return "Please fill all the information";
    }
    try{
      await authService.value.resetPassword(email: email);
      return null;
    }on FirebaseAuthException catch(e){
      return e.message ?? "Unknown error";
    }
  }
}
