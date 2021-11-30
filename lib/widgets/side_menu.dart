import 'package:flutter/material.dart';

//TODO : use cubit for getting user

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: DrawerHeader(
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  child: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffFF879B),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text("Dark Theme"),
            trailing: Switch(value: true, onChanged: (bool newValue) {}),
          ),
          ListTile(
            leading: Icon(Icons.thumb_up_alt_sharp),
            title: Text('Liked Deals'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text('Contact Us'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
