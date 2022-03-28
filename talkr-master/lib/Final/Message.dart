import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

class Message{
   String? uid;
   String? content;
   String? senderUid;
   String? recieverId;
  Timestamp? createdAt;
  Message({ this.content, this.createdAt, this.recieverId, this.senderUid, this.uid});
  Message.fromjson(Map<String,dynamic>json , String id){
    uid = id;
    content = json['content'];
    senderUid = json['senderUid'];
    recieverId = json['recieverId'];
    createdAt = json['createdAt'];
  }

  Map<String,dynamic> toJson(){
    return {
      'content':content,
      'senderUid': senderUid,
      'recieverId':recieverId,
      'createdAt': createdAt
    };
  }
  
  bool get isMe => AuthService().user.uid == senderUid;



  
}