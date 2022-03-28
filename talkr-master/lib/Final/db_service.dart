import 'package:cloud_firestore/cloud_firestore.dart';
import 'Message.dart';
import 'auth_service.dart';
import 'CUsers.dart';

class DBService{
  var userCollection = FirebaseFirestore.instance.collection("users");
  var msgCollection = FirebaseFirestore.instance.collection("Message");

  saveUser(cUser user) async {
    await userCollection.doc(user.uid).set(user.toJSon());
  
  }

  Stream<List<cUser>> get getDiscussionUser{
    return userCollection
    .where("uid",isNotEqualTo: AuthService().user.uid)
    .snapshots().
    map((event) => event.docs.map((e) => cUser.FromJson(e.data())).toList());
  }

  Stream<List<Message>> getMessage(String recieverId,[bool myMessage = true]){
    return msgCollection.
    where('senderUid',isEqualTo: myMessage ? AuthService().user.uid:recieverId).
    where('recieverId',isEqualTo: myMessage ? recieverId:AuthService().user.uid).
    snapshots().
    map((event) => event.docs.map((e) => Message.fromjson(e.data(),e.id)).toList());
  }

  Future<bool> sendMessage(Message msg) async{
    try{
      await msgCollection.doc().set(msg.toJson());
      return true;
    }catch (e) {
      return false;

    }
  }
}