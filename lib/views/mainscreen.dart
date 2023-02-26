import 'package:flutter/material.dart';

import '../../models/user.dart';

import 'mainmenu.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String titlecenter = "No Data";

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Homestay")),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
          child: Text(titlecenter,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
      drawer: MainMenuWidget(user: widget.user),
    );
  }
}
