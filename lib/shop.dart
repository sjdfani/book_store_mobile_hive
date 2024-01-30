import 'package:book_store/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShopPage createState() => _ShopPage();
}

class _ShopPage extends State<ShopPage> {
  List<Map<String, dynamic>> _shopItems = [];
  final _shoppingBox = Hive.box('shopping_box');

  void _refreshShopItems() {
    final data = _shoppingBox.keys.map((key) {
      final value = _shoppingBox.get(key);
      return {"key": key, "name": value["name"], "quantity": value['quantity']};
    }).toList();
    setState(() {
      _shopItems = data;
    });
  }

  Future<void> _deleteShopItem(int itemKey) async {
    await _shoppingBox.delete(itemKey);
    _refreshShopItems();
  }

  @override
  void initState() {
    super.initState();
    _refreshShopItems();
  }

  @override
  Widget build(BuildContext context) {
    var fontSize = context.watch<BookStoreNotifier>().fontSize;

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Shop Basket (${_shopItems.length})"),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Column(
          children: [
            _shopItems.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'Your Cart is Empty',
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _shopItems.length,
                      itemBuilder: (_, index) {
                        final currentItem = _shopItems[index];
                        return Card(
                          color: Theme.of(context).primaryColor,
                          margin: const EdgeInsets.all(10),
                          elevation: 3,
                          child: ListTile(
                            title: Text(
                              currentItem['name'],
                              style: TextStyle(
                                fontSize: fontSize,
                              ),
                            ),
                            subtitle: Text(
                              currentItem['quantity'].toString(),
                              style: TextStyle(
                                fontSize: fontSize,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_shopping_cart),
                                  onPressed: () =>
                                      _deleteShopItem(currentItem['key']),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
