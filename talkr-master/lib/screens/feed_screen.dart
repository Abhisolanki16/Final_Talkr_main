import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkr_demo/Personal/SearchUser.dart';
import 'package:talkr_demo/utils/colors.dart';
import 'package:talkr_demo/utils/global_variable.dart';
import 'package:talkr_demo/widgets/post_card.dart';
import 'package:talkr_demo/widgets/progress.dart';
import 'chat_screen.dart';
import 'package:talkr_demo/Final/FinalHomePage.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor:
      //     width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              toolbarHeight: 35,
              backgroundColor: Colors.deepPurpleAccent,
              title: const Text(
                "Feed",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Lato",
                  // fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FinalHomePage()));
                //    Navigator.of(context).push(
                //  MaterialPageRoute(builder: (context) => SearchUser()));
                  },
                ),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
