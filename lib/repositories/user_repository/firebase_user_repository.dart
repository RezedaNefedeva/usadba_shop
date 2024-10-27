import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/entities/entities.dart';
import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_app/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserRepository implements UserRepository{
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> signIn(String email, String pass) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: pass);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String pass) async {
    try{
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email,
          password: pass);

      myUser = myUser.copyWith(
        id: user.user!.uid,
      );

      return myUser;
    } catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async{
    try{
      await _firebaseAuth.signOut();
    } catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPass(String email) async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch(e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getUserData(String myUserId) async {
    try{
      return userCollection.doc(myUserId).get().then((value) =>
      MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try{
      await userCollection.doc(myUser.id).set(myUser.toEntity().toDocument());
    } catch(e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  // TODO: implement user
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }

}