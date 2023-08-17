import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/utils/app_routes.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  final Category category;

  void _selectCategory(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.CATEGORIES_MEALS, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).colorScheme.primary,
      onTap: () => _selectCategory(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: [category.color.withOpacity(0.5), category.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Text(category.title),
      ),
    );
  }
}
