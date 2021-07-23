import './dummy_data.dart';
import 'package:flutter/material.dart';

import './screens/filter_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meals_detail_screen.dart';
import './screens/category_meals_screen.dart';
import 'models/meals.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int op=10;
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavorites(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DonanMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              // ignore: deprecated_member_use
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              // ignore: deprecated_member_use
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealsDetailScreen.routeName: (ctx) =>
            MealsDetailScreen(_toggleFavorites, _isFavorites),
        FliterScreen.routeName: (ctx) => FliterScreen(filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => TabsScreen(favoriteMeals),
        );
      },
    );
  }
}
