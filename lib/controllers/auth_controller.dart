import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanctuarai/services/auth_service.dart';

class AuthController{

  static final authController = AuthController();
  Future<String?> signUp({
    required String email,
    required String password,
    required String userName
}) async{
    try{
      await authService.value.createAccount(email: email, password: password);
      await authService.value.updateUsername(username: userName);
      return null;
    }on FirebaseAuthException catch(e){
      print(e.message);
      return e.message ?? "unknown error";
    }

  }

  Future<String?> login({
    required String email,
    required String password
})async{
    try{
      await authService.value.signIn(email: email, password: password);
      return null;
    }on FirebaseAuthException catch (e){
      return e.message ?? "unknown error";
    }

  }
}