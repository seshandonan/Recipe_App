import 'package:flutter/material.dart';

import '../dummy_data.dart';

import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES.map((ci) {
        return CategoryItem(
        ci.id,
        ci.title, 
        ci.color,
        );
      }).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        childAspectRatio: 4/3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
