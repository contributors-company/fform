import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              'FFORM',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 56),
            ),
          ),
          ListTile(
            title: const Text('Login Form'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Create Quest Form'),
            onTap: () {
              Navigator.pushNamed(context, '/create-quest');
            },
          ),
          ListTile(
            title: const Text('Draw Form'),
            onTap: () {
              Navigator.pushNamed(context, '/draw');
            },
          ),
          ListTile(
            title: const Text('Exception Multi Validation'),
            onTap: () {
              Navigator.pushNamed(context, '/fform-exception');
            },
          ),
        ],
      ),
    );
  }
}
