import 'package:firebase_app/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository{

  Stream<User?> get user;

  Future<void> signIn(String email, String pass);

  Future<void> logOut();

  Future<MyUser> signUp(MyUser myUser, String pass);

  Future<void> resetPass(String email);

  Future<void> setUserData(MyUser myUser);

  Future<MyUser> getUserData(String myUserId);
}