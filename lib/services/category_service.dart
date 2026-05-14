// ISAR
import 'package:isar/isar.dart';

// Database
import 'package:documentmanager/database/isar_service.dart';

// Model
import 'package:documentmanager/models/category_model.dart';

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

  Future<List<CategoryModel>> getCategoriesByParent(int? parentCategoryId,) async {

    final isar = IsarService.isar;

    if (parentCategoryId == null) {

      return await isar.categoryModels
          .filter()
          .parentCategoryIdIsNull()
          .findAll();
    }

    return await isar.categoryModels
        .filter()
        .parentCategoryIdEqualTo(
          parentCategoryId,
        )
        .findAll();
  }
}