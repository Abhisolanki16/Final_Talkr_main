import 'package:flutter/material.dart';
import 'package:talkr_demo/Final/CUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkr_demo/fire_auth.dart';
import 'MessageModel.dart';
import 'package:talkr_demo/Final/CUsers.dart';

class ChatUserList extends StatelessWidget {
   final Map<String,dynamic> userMap;
   const ChatUserList({ required this.userMap });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FirebaseAuth.instance.currentUser!.displayName!),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: getUsers(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
                    if(snapshot.hasData){
                      QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                      
                      return  ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataSnapshot.docs.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            leading: CircleAvatar(),
                            title: Text(userMap['email']),
                            
                          );
                        }
                        );
                    }else if(snapshot.hasError){
                      return Text('error');
                    }
                  }else{
                    return Text('Say hii to new friend');
                  }return CircularProgressIndicator();
            
          },
        ),
      ),
      
    );
  }
}



getUsers(){
  
}
