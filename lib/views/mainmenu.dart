import 'package:flutter/material.dart';
import 'package:homestay_raya/views/EnterExitRoute.dart';
import 'package:homestay_raya/views/homestayscreen.dart';
import 'package:homestay_raya/views/porfilescreen.dart';
import 'package:homestay_raya/views/porfilescreen.dart';

import '../../models/user.dart';
import '../serverconfig.dart';
import 'mainscreen.dart';

class MainMenuWidget extends StatefulWidget {
  final User user;
  const MainMenuWidget({super.key, required this.user});

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  @override
  Widget build(BuildContext context) {
    var val = 50;
    return Drawer(
      width: 250,
      elevation: 10,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            accountEmail: Text(widget.user.email.toString()),
            accountName: Text(widget.user.name.toString()),
            currentAccountPicture: CircleAvatar(
              radius: 30.0,
              child: ClipOval(
                child: Image.network(
                    "${ServerConfig.SERVER}assets/profileimages/${widget.user.id}.png?v=$val"),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_work_sharp),
            title: const Text('Homestay'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (content) => MainScreen()));
              Navigator.push(
                  context,
                  EnterExitRoute(
                      exitPage: MainScreen(user: widget.user),
                      enterPage: MainScreen(user: widget.user)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.business_center_sharp),
            title: const Text('Owner'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (content) => const SellerScreen()));
              Navigator.push(
                  context,
                  EnterExitRoute(
                      exitPage: MainScreen(user: widget.user),
                      enterPage: HomestayScreen(user: widget.user)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (content) => const ProfileScreen()));
              Navigator.push(
                  context,
                  EnterExitRoute(
                      exitPage: MainScreen(user: widget.user),
                      enterPage: ProfileScreen(
                        user: widget.user,
                      )));
            },
          ),
        ],
      ),
    );
  }
}
