import '../screens/filter_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(IconData icon, String title, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            child: Text(
              "Cooking UP!!",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                  fontSize: 30),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(Icons.restaurant, "Meals", () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile(Icons.settings, "Filters", () {
            Navigator.of(context).pushReplacementNamed(FliterScreen.routeName);
          }),
        ],
      ),
    );
  }
}
