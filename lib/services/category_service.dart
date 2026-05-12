import 'package:documentmanager/database/isar_service.dart';
import 'package:documentmanager/models/category_model.dart';
import 'package:isar/isar.dart';

class CategoryService {
  
  Future<void> addCategory(String name) async {
    final isar = IsarService.isar; 
    
    final categoryModel = CategoryModel()
      ..name = name
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.categoryModels.put(categoryModel);
    });
  }

  Future<List<CategoryModel>> getCategory() async {
    final isar = IsarService.isar;
    return await isar.categoryModels.where().findAll();
  }
}