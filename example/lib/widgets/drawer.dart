import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('FFORM'),
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Create Quest'),
            onTap: () {
              Navigator.pushNamed(context, '/create-quest');
            },
          ),
        ],
      ),
    );
  }
}
