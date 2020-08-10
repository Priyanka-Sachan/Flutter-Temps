import 'package:flutter/material.dart';

import './main_drawer.dart';

class FiltersPage extends StatefulWidget {

  static const routeName = '/filters-page';
  Map<String,bool> filters;
  Function saveFilters;

  FiltersPage(this.filters,this.saveFilters);

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
//  bool _isGlutenFree = false;
//  bool _isLactoseFree = false;
//  bool _isVegan = false;
//  bool _isVegetarian = false;

  SwitchListTile _buildMealSelection(String title, String description,
      bool currentValue, Function changeSelection) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: changeSelection,
    );
  }

  @override
  Widget build(BuildContext context) {

//    @override
//    initState(){
//       _isGlutenFree = widget.filters['Glutten-Free'];
//       _isLactoseFree = widget.filters[''];
//       _isVegan =widget.filters[''];
//       _isVegetarian = widget.filters[''];
//    }

    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Filters',
          textScaleFactor: 1.8,
          style: TextStyle(letterSpacing: 1.5,),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
           onPressed: ()=>widget.saveFilters(
//            {
//              'glutten-free': _isGlutenFree,
//              'lactose-free': _isLactoseFree,
//              'vegan': _isVegan,
//              'vegetarian': _isVegetarian}
           widget.filters
              ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Text(
              'Adjust your meal selection:',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.left,
            ),
          ),
          _buildMealSelection(
              'Glutten-Free', 'Only include Glutten-Free meals.', widget.filters['glutten-free'],
              (newValue) {
            setState(() {
              widget.filters['glutten-free'] = newValue;
            });
          }),
          _buildMealSelection('Lactose-Free',
              'Only include Lactose-Free meals.', widget.filters['lactose-free'], (newValue) {
            setState(() {
              widget.filters['lactose-free'] = newValue;
            });
          }),
          _buildMealSelection('Vegan', 'Only include Vegan meals.', widget.filters['vegan'],
              (newValue) {
            setState(() {
              widget.filters['vegan'] = newValue;
            });
          }),
          _buildMealSelection(
              'Vegetarian', 'Only include Vegetarian meals.', widget.filters['vegetarian'],
              (newValue) {
            setState(() {
              widget.filters['vegetarian'] = newValue;
            });
          })
        ],
      ),
    );
  }
}
