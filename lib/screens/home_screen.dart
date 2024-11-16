import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/apis.dart';
import '../auth/login_screen.dart';
import '../main.dart';
// Import the LoginScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Logout method
  Future<void> _signOut() async {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Sign out from Google
    await GoogleSignIn().signOut();

    // Optionally navigate to the login screen after sign out
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const LoginScreen()), // Navigate to login screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("We Chat"),
        leading: const Icon(CupertinoIcons.home),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),

          // The PopupMenuButton to show the logout option
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'logout') {
                _signOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2166173236.
          stream: APIs.fire.collection('users').snapshots(),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:900398008.
          builder: (context, snapshot) {
            final list = [];
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              // ignore: unused_local_variable
              for (var i in data!) {
                log('Data: ${json.encode(i.data())}');
                list.add(i.data()['name']);
              }
            }
            if (list.isEmpty) {
              return const Center(child: Text('No data available.'));
            }
            return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: mq.height * .01),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  // return const ChatUserCard();
                  return Text('Name: ${list[index]}');
                });
          }),
    );
  }
}
