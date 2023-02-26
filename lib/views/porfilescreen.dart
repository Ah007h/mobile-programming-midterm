import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/user.dart';

import 'mainmenu.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Random random = Random();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: const Center(child: Text("Profile"))),
        drawer: MainMenuWidget(
          user: widget.user,
        ));
  }
}
