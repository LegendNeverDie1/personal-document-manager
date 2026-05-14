// ISAR
import 'package:isar/isar.dart';

// Database
import 'package:documentmanager/database/isar_service.dart';

// Model
import 'package:documentmanager/models/category_model.dart';

class CategoryService {
  
  Future<void> addCategory(
    CategoryModel category,
  ) async {

    final isar = IsarService.isar;

    await isar.writeTxn(() async {

      await isar.categoryModels.put(
        category,
      );
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