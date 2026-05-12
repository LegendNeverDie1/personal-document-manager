import 'package:documentmanager/models/category_model.dart';
import 'package:documentmanager/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  List<CategoryModel> categories = []; 

  Future<void> loadCategories() async {
    categories = await _categoryService.getCategory();
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    await _categoryService.addCategory(name); 
    await loadCategories();
  }
}