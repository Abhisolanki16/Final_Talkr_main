import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkr_demo/screens/feed_screen.dart';
import 'package:talkr_demo/screens/like_screen.dart';
import 'package:talkr_demo/screens/post_screen.dart';
import 'package:talkr_demo/screens/profile_screen.dart';
import 'package:talkr_demo/screens/search_screen.dart';
import 'package:talkr_demo/utils/colors.dart';
import 'package:talkr_demo/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 2;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  //final navigationKey = GlobalKey<CurvedNavigationBarState>();

  final screens = [
    const FeedScreen(),
    const SearchScreen(),
    const PostScreen(),
    const LikeScreen(),
    const ProfileScreen(
      uid: '',
    )
  ];

  late String myEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeIn,
        items: const <Widget>[
          Icon(Icons.home_filled, color: Colors.deepPurpleAccent),
          Icon(
            Icons.search_rounded,
            color: Colors.deepPurpleAccent,
          ),
          Icon(
            Icons.add_a_photo_rounded,
            color: Colors.deepPurpleAccent,
          ),
          Icon(
            Icons.favorite_border_rounded,
            color: Colors.deepPurpleAccent,
          ),
          Icon(
            Icons.person,
            color: Colors.deepPurpleAccent,
          ),
        ],
        //onTap: (index) => setState(() => this.index = index),
        onTap: navigationTapped,
        // currentIndex: _page,
      ),
    );
  }
}
