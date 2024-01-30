import 'package:book_store/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var fontSize = context.watch<BookStoreNotifier>().fontSize;

    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[500],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/profile.png'),
                      radius: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          "Sajjad Fani",
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Role: Admin",
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            onTap: () => Navigator.pushNamed(context, "/home"),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: Text(
              "Shop",
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            onTap: () => Navigator.pushNamed(context, "/shop"),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              "Setting",
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            onTap: () => Navigator.pushNamed(context, "/setting"),
          ),
        ],
      ),
    );
  }
}
