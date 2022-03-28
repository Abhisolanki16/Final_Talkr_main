import 'package:talkr_demo/Final/CUsers.dart';
import 'package:talkr_demo/Final/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageModel{
  String? uid;
  String? message;
  String? recieverId;
  String? sendby;
  DateTime? time;
  
  MessageModel({this.message, this.sendby, this.time,this.uid,this.recieverId});

  MessageModel.fromMap(Map<String,dynamic> map){
    uid = map['uid'];
    message = map['message'];
    sendby = map['sendby'];
    time = map['time'];
    recieverId :map['recieverId'];
  }

  Map<String,dynamic> toMap(){
    return{
      'uid': uid,
      'message': message,
      'sendby': sendby,
      'time': time,
      'recieverId': recieverId
    };
  }

  MessageModel.fromjson(Map<String,dynamic>json , String id){
    uid = id;
    recieverId =json['recieverId'];
    message = json['message'];
    sendby = json['sendby'];
    time = json['time'];
  }

  Map<String,dynamic> toJson(){
    return {
      'recieverId':recieverId,
      'message':message,
      'sendby': sendby,
      'uid':uid,
      'time': time
    };
  }
  //bool get isMe => AuthService().user.uid == senderUid;
}

class MessageFun{
  var msgCollection = FirebaseFirestore.instance.collection("chatroom");

   Stream<List<Message>> getMessage(String recieverId,[bool myMessage = true]){
    return msgCollection.
    where('sendby',isEqualTo: myMessage ? FirebaseAuth.instance.currentUser!.uid:recieverId).
    where('recieverId',isEqualTo: myMessage ? recieverId:FirebaseAuth.instance.currentUser!.uid).
    snapshots().
    map((event) => event.docs.map((e) => Message.fromjson(e.data(),e.id)).toList());
  }

}

class getUsers{
  Stream<List<cUser>> get getDiscussionUser{
  var userCollection = FirebaseFirestore.instance.collection("users");
    return userCollection
    .where("uid",isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots().
    map((event) => event.docs.map((e) => cUser.FromJson(e.data())).toList());
  }
}