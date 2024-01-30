import 'package:book_store/custom_drawer.dart';
import 'package:book_store/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    var theme = context.watch<BookStoreNotifier>().theme;
    var fontSize = context.watch<BookStoreNotifier>().fontSize;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Theme Mode:",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            width: 100,
          ),
          Slider(
            min: 0,
            max: 20,
            value: theme == 'light'
                ? 0
                : theme == 'blue'
                    ? 10
                    : 20,
            divisions: 2,
            label: "${_value.round()}",
            activeColor: Colors.green[700],
            inactiveColor: Colors.green[200],
            thumbColor: Colors.blue,
            onChanged: (value) async {
              setState(() {
                _value = value;
                if (value == 0) {
                  context.read<BookStoreNotifier>().setTheme('light');
                } else if (value == 10) {
                  context.read<BookStoreNotifier>().setTheme('blue');
                } else {
                  context.read<BookStoreNotifier>().setTheme('dark');
                }
              });
            },
          ),
          Center(
            child: Text(
              theme[0].toUpperCase() + theme.substring(1),
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Font Size:",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 80,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  context.read<BookStoreNotifier>().setFont(fontSize - 1);
                },
              ),
              Text(
                fontSize.toInt().toString(),
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<BookStoreNotifier>().setFont(fontSize + 1);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          )
        ],
      ),
    );
  }
}
