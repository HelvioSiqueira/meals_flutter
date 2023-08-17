import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorite_screen.dart';

import '../models/meal.dart';

class TabsScreens extends StatefulWidget {
  const TabsScreens({Key? key, required this.favoriteMeals}) : super(key: key);

  final List<Meal> favoriteMeals;

  @override
  State<TabsScreens> createState() => _TabsScreensState();
}

class _TabsScreensState extends State<TabsScreens> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens = [];

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _screens = [
      {"title": 'Lista de Categorias', "screen": const CategoriesScreen()},
      {
        "title": 'Meus Favoritos',
        "screen": FavoriteScreen(
          favoriteMeals: widget.favoriteMeals,
        )
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((_screens[_selectedScreenIndex]['title'] as String)),
      ),
      drawer: const MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categoria"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritos")
        ],
      ),
    );
  }
}
