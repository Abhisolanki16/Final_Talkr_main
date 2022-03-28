
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talkr_demo/Final/auth_service.dart';
import 'package:talkr_demo/Final/chat.dart';
import 'package:talkr_demo/Final/db_service.dart';
import 'package:talkr_demo/Final/CUsers.dart';

class FinalHomePage extends StatelessWidget {
  const FinalHomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AuthService().user.displayName}"),
      ),
      body: StreamBuilder<List<cUser>>(
        stream: DBService().getDiscussionUser,
        builder: (context,snapshot){
        if(snapshot.hasData){
          final users = snapshot.data;
          return users!.length == 0 
            ? Center(child: Text('No user'),)
            : ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx,i){
            final user = users[i];
            return  ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FinalChatPage(user: user,),));
              },
              leading: Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(.5)
                ),
                child: Icon(Icons.person),
              ),
              title: Text(user.username!,style: TextStyle(color: Colors.black),),
              subtitle: Text(user.email!),
            );
          });
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}