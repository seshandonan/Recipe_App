import 'package:toast/toast.dart';

import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FliterScreen extends StatefulWidget {
  static const routeName = "fliter-screen";

  final Function saveFilters;

  final Map<String, bool> filters;

  FliterScreen(this.filters, this.saveFilters);

  @override
  _FliterScreenState createState() => _FliterScreenState();
}

class _FliterScreenState extends State<FliterScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  @override
  initState() {
    super.initState();
    _isGlutenFree = widget.filters['gluten'] as bool;
    _isLactoseFree = widget.filters['lactose'] as bool;
    _isVegan = widget.filters['vegan'] as bool;
    _isVegetarian = widget.filters['vegetarian'] as bool;
  }

  Widget _buildSwitchTile(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map<String, bool> selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian,
              };
              widget.saveFilters(selectedFilters);
              Toast.show("Filters Applied", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchTile(
                  "Gluten Free",
                  "Only include gluten-free meals",
                  _isGlutenFree,
                  (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  "Lactose Free",
                  "Only include lactose-free meals",
                  _isLactoseFree,
                  (newValue) {
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  "Vegan",
                  "Only include vegan meals",
                  _isVegan,
                  (newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  "Vegetarian",
                  "Only include vegetarian meals",
                  _isVegetarian,
                  (newValue) {
                    setState(() {
                      _isVegetarian = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
