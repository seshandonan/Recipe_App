import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../dummy_data.dart';

class MealsDetailScreen extends StatelessWidget {
  static const routeName = 'meal-detail-screen';

  final Function toggleFavorites;
  final Function isFavorites;

  MealsDetailScreen(this.toggleFavorites, this.isFavorites);

  Widget buildSelectTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // ignore: deprecated_member_use
      child: Text(
        text,
        // ignore: deprecated_member_use
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 150,
      width: 300,
      child: child,
    );
  }

  // ignore: missing_return
   buildToast(BuildContext context, String title,String id) {
    if (isFavorites(id)){
      Toast.show('$title is added to favorites', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    else{
       Toast.show('$title is removed from favorites', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${selectedMeal.title}',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSelectTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSelectTitle(context, "Steps"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            isFavorites(mealId) ? Icons.star : Icons.star_border,
          ),
          onPressed: () {
            // Navigator.of(context).pop(mealId);
            toggleFavorites(mealId);
            buildToast(context, selectedMeal.title,mealId);
          }),
    );
  }
}
