


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talkr_demo/Final/CUsers.dart';
import 'package:talkr_demo/Personal/NewChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchUser extends StatefulWidget { 
  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  //Map<String,dynamic>? userMap;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();


  String NewChatRoomId(String user1,String user2){
    if(user1[0].toLowerCase().codeUnits[0] > 
      user2.toLowerCase().codeUnits[0]){
        return "$user1$user2";
    }else{
      return "$user2$user1";
    }

  }

  // Search() async{
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //   setState(() {
  //     isLoading = true;
  //   });

  //   await _firestore.collection('users')
  //   .where('email',isEqualTo: _searchController.text)
  //   .get()
  //   .then((value){
  //     setState(() {
  //       userMap = value.docs[0].data();
  //       isLoading = false;
  //     });
  //   });

  //   print(userMap);
  // }

  
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Search Screen',style: TextStyle(color: Colors.white),),
      ),
      body: isLoading 
      ? Center(
        child: Container(
          height: size.height / 20,
          width: size.width / 20,
          child: CircularProgressIndicator(),
        ),
      )
      : Container(
        child: Column(
          children: [
            Container(
              child: SizedBox(
                height: size.height/20,
              ),
            ), 
            Container(
              height : size.height/14,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 14,
                width: size.width/1.2,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Search',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                ),
              ),
      
            ),
            SizedBox(height: size.height/50,),
            ElevatedButton(
              onPressed: () {
                //Search();
                setState(() {
                  
                });
              },
              child: Text('Search'),
            ),
      
            SizedBox(height: size.height/30,),
      
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').where('email',isEqualTo: _searchController.text).snapshots(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.active){
                  if(snapshot.hasData){
                    QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                    if(dataSnapshot.docs.length > 0){
                      Map<String,dynamic> userMap = dataSnapshot.docs[0].data() as Map<String,dynamic>;
                      cUser searchedUser = cUser.fromMap(userMap);
                      return ListTile(  
                        textColor: Colors.white70,
                        onTap: (){
                          if(_auth.currentUser!.displayName != null)
                            {String roomId = NewChatRoomId(
                              _auth.currentUser!.displayName!,
                              userMap['name']);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewChatScreen(roomId,userMap,))); 
                            }else{
                              return null;
                            }
                          },
                        title: Text(userMap['name'] != null ? userMap['name']: '',style: TextStyle(color: Colors.white),),
                        subtitle: Text(searchedUser.email!,),
                      );
                    }else{
                      return Text('No Results Found ... !',style: TextStyle(color: Colors.white),);
                    }
                  }
                  else if(snapshot.hasError){
                    return Text("An error occured",style: TextStyle(color: Colors.white),);
                  }else{
                    return Text('No Results Found...',style: TextStyle(color: Colors.white),);
                  }
                  
                }
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
                
            )
      
      
            // userMap != null 
            // ? ListTile(
            //   onTap: (){
            //     if(_auth.currentUser!.displayName != null)
            //     {String roomId = NewChatRoomId(
            //       _auth.currentUser!.displayName!,
            //        userMap!['name']);
            //      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewChatScreen(roomId,userMap!))); 
            //     }else{
            //       return null;
            //     }
                
            //   },
            //   leading: Icon(Icons.account_box,color: Colors.black,),
            //   title: Text(
            //     userMap!['username'],
            //     //userMap!['username'] != null ? userMap!['username'] : userMap!['name'],
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 17,
            //       fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   subtitle: Text(userMap!['email'] != null ? userMap!['email'] : 'No User'),
              
            //   trailing: IconButton(icon: Icon(Icons.chat) ,onPressed: (){
            //     String roomId = NewChatRoomId(
            //       _auth.currentUser!.displayName!,
            //        userMap!['name']);
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewChatScreen(roomId,userMap!))); 
      
            //   }
      
            //   //trailing: Icon(Icons.chat,color: Colors.black,),
            // ))
            // //)
            // : Container(),
      
          ],
        ),
      ),
    );
  }
  
}
