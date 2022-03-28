

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'db_service.dart';
import 'CUsers.dart';
import 'package:talkr_demo/Final/db_service.dart';
import 'package:talkr_demo/Final/CUsers.dart';

class AuthService{
  
  final auth = FirebaseAuth.instance;

  
  Future<bool> signIn(String email,String password) async{
  
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch(e){
      return false;
    }
  }

  signUp(String username,String email,String password) async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      await DBService().saveUser(cUser(uid: user.uid,email: user.email,username: username));
      print("Signin done");
      return true;
      
    }on FirebaseAuthException catch(e){
      return false;
    }
  }
  
  User get user{
    if(auth.currentUser == null)
    return FirebaseAuth.instance.currentUser!;
    else
    return FirebaseAuth.instance.currentUser!;
  }

  Stream<User?> get onChangedUser => auth.authStateChanges();

  signOut() async{
    await auth.signOut();
   
  }




  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
