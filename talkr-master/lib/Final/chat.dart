

import 'package:flutter/material.dart';
import 'package:talkr_demo/Final/Message.dart';
import 'package:talkr_demo/Final/MessageComponent.dart';
import 'package:talkr_demo/Final/auth_service.dart';
import 'package:talkr_demo/Final/db_service.dart';
import 'package:talkr_demo/Final/CUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FinalChatPage extends StatelessWidget {
  final cUser? user;
  var msgController = TextEditingController();
   FinalChatPage({ Key? key, this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.username!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
        
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: DBService().getMessage(user!.uid!),
                builder: (context,s1){
                  if(s1.hasData){
                    return  StreamBuilder<List<Message>>(
                      stream: DBService().getMessage(user!.uid!,false),
                      builder: (context,s2){
                      if(s2.hasData){
                    var messages = [...s1.data!, ...s2.data!];
                    messages.sort((i,j)=>i.createdAt!.compareTo(j.createdAt!));
                    messages = messages.reversed.toList();

                    return messages.length == 0 
                    ? const Center(child: Text("No messages"),) 
                    : ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context,index){
                        final msg = messages[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: MessageComponent(msg: msg,
                          )
                        );
                      });

                  }else{return Center(child: const CircularProgressIndicator());
                  }
                },
              );

                  }else{return Center(child: const CircularProgressIndicator());}
                },
              ),
              ),
      
            Row(
              children:[ 
            //      TextFormField(
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10)                   
            //       ),
            //     ),
            //   ),
            // ]),
            // IconButton(onPressed: () async{
            //   var msg = Message(
            //     content: msgController.text,
            //     createdAt: Timestamp.now(),
            //     recieverId: user!.uid,
            //     senderUid: AuthService().user.uid
            //     );
            //     msgController.clear();
            //     await DBService().sendMessage(msg);
            //     },
            //     icon  : const Icon(Icons.send),)

            Container(
                  height: size.height / 12,
                  width: size.width / 1.2,
                  child: TextField(
                    controller: msgController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), 
                      )
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async{
                    var msg = Message(
                content: msgController.text,
                createdAt: Timestamp.now(),
                recieverId: user!.uid,
                senderUid: AuthService().user.uid
                );
                msgController.clear();
                await DBService().sendMessage(msg);
                },
                   
              )
          ],
        ),
          ]),
      )
    );
  }
}