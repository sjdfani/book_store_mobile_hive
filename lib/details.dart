import 'package:book_store/custom_drawer.dart';
import 'package:book_store/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  int itemKey;
  String? name, quantity;
  Detail(this.itemKey, {super.key, this.name, this.quantity});

  @override
  State<Detail> createState() =>
      // ignore: no_logic_in_create_state
      _Detail(itemKey, name: name, quantity: quantity);
}

class _Detail extends State<Detail> {
  int itemKey;
  String? name, quantity;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  _Detail(this.itemKey, {this.name, this.quantity});

  @override
  Widget build(BuildContext context) {
    var fontSize = context.watch<BookStoreNotifier>().fontSize;
    _nameController.text = name ?? "";
    _quantityController.text = quantity ?? "";

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Books"),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        drawer: const CustomDrawer(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Quantity'),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var name = _nameController.text;
                  var quantity = _quantityController.text;
                  _nameController.text = '';
                  _quantityController.text = '';

                  Navigator.pop(context, {
                    'NA': name,
                    'QU': int.parse(quantity),
                  });
                },
                style: Theme.of(context).elevatedButtonTheme.style,
                child: Text(
                  itemKey == -1 ? 'Create New' : 'Update',
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
