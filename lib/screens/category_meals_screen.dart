
import '../models/meals.dart';

import '../widgets/meals_item.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
   String categoryTitle='';
  late List<Meal> categoryMeals;
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
     categoryTitle = routeArgs['title'] as String;
    final categoryId = routeArgs['id'];
    categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
