import 'package:documentmanager/models/category_model.dart';
import 'package:documentmanager/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  List<CategoryModel> categories = []; 

  Future<void> loadCategories(int? parentCategoryId,) async {
    categories = await _categoryService.getCategoriesByParent(parentCategoryId);
    notifyListeners();
  }

  Future<void> addCategory(CategoryModel category) async {
    await _categoryService.addCategory(category); 
    await loadCategories(category.parentCategoryId);
  }
}