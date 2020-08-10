import 'package:flutter/material.dart';

import './filters_page.dart';

class MainDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void tapHandler(String routeName){
      Navigator.of(context).pushReplacementNamed(routeName);
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Home'),
            onTap: ()=>tapHandler('/'),
          ),
          ListTile(
            leading: Icon(Icons.filter_list),
            title: Text('Filters'),
            onTap: ()=>tapHandler(FiltersPage.routeName),
          ),
        ],
      ),
    );
  }
}
