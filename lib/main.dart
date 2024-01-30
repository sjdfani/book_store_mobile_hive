import 'package:book_store/custom_drawer.dart';
import 'package:book_store/details.dart';
import 'package:book_store/settings.dart';
import 'package:book_store/shop.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class BookStoreNotifier with ChangeNotifier {
  String _theme = 'light';
  ThemeData _themeData = ThemeData.light();
  double _fontSize = 20.0;

  ThemeData get themeData => _themeData;
  String get theme => _theme;
  void setTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", theme);
    _theme = theme;
    if (theme == "light") {
      _themeData = customLightTheme;
    } else if (theme == "blue") {
      _themeData = customBlueTheme;
    } else {
      _themeData = customDarkTheme;
    }
    notifyListeners();
  }

  double get fontSize => _fontSize;
  void setFont(double fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', fontSize);
    _fontSize = fontSize;
    notifyListeners();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 20.0;
    setFont(_fontSize);
    var theme = prefs.getString('theme') ?? 'light';
    setTheme(theme);
  }
}

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('shopping_box');
  await Hive.openBox('books_box');
  runApp(ChangeNotifierProvider<BookStoreNotifier>(
    child: const MyApp(),
    create: (_) => BookStoreNotifier(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var themeData = context.watch<BookStoreNotifier>().themeData;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      darkTheme: ThemeData.dark(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => const HomePage(),
        "/shop": (BuildContext context) => const ShopPage(),
        "/setting": (BuildContext context) => const Setting(),
      },
      initialRoute: "/home",
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _items = [];
  List<dynamic> _shopItems = [];
  final _booksBox = Hive.box('books_box');
  final _shoppingBox = Hive.box('shopping_box');

  void _refreshItems() {
    final data = _booksBox.keys.map((key) {
      final value = _booksBox.get(key);
      return {"key": key, "name": value["name"], "quantity": value['quantity']};
    }).toList();
    setState(() {
      _items = data;
    });
  }

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _booksBox.add(newItem);
    _refreshItems();
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _booksBox.put(itemKey, item);
    _refreshItems();
  }

  Future<void> _deleteItem(int itemKey) async {
    await _booksBox.delete(itemKey);
    _refreshItems();
  }

  void _refreshShopItems() {
    final data = _shoppingBox.keys.map((key) {
      final value = _shoppingBox.get(key);
      return value["name"];
    }).toList();
    setState(() {
      _shopItems = data;
    });
  }

  Future<void> _createShopItem(Map<String, dynamic> newItem) async {
    await _shoppingBox.add(newItem);
    _refreshShopItems();
  }

  @override
  void initState() {
    super.initState();
    _refreshItems();
    _refreshShopItems();
    Future.delayed(Duration.zero, () {
      context.read<BookStoreNotifier>()._loadData();
    });
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
          title: const Text("Books"),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _refreshShopItems();
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopPage(),
                ),
              ),
            ),
          ],
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            _items.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (_, index) {
                        final currentItem = _items[index];
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
                                  icon: Visibility(
                                    visible: !_shopItems
                                        .contains(currentItem["name"]),
                                    child: const Icon(Icons.add_shopping_cart),
                                  ),
                                  onPressed: () {
                                    if (!_shopItems.contains(
                                      currentItem["name"],
                                    )) {
                                      _createShopItem(currentItem);
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    String? name;
                                    int? quantity;

                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Detail(
                                          currentItem['key'],
                                          name: currentItem['name'],
                                          quantity: currentItem['quantity']
                                              .toString(),
                                        ),
                                      ),
                                    ).then((value) {
                                      name = (value as Map)['NA'];
                                      quantity = (value)['QU'];
                                    });
                                    _updateItem(
                                      currentItem['key'],
                                      {'name': name, 'quantity': quantity},
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteItem(currentItem['key']),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? name;
            int? quantity;

            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Detail(-1)),
            ).then(
              (value) {
                name = (value as Map)['NA'];
                quantity = (value)['QU'];
              },
            );
            _createItem({"name": name, "quantity": quantity});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
