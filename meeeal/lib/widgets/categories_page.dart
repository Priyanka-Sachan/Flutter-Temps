import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/category.dart';
import './category_card.dart';

class CategoriesPage extends StatelessWidget {
  final List<Category> dummyData = DUMMY_CATEGORIES;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) {
            return CategoryCard(dummyData[index]);
          },
          itemCount: dummyData.length,
        ),
      );
  }
}
