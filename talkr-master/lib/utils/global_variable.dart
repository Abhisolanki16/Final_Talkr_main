import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talkr_demo/screens/add_post_screen.dart';
import 'package:talkr_demo/screens/feed_screen.dart';
import 'package:talkr_demo/screens/profile_screen.dart';
import 'package:talkr_demo/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
