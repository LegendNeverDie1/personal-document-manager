// ISAR
import 'package:isar/isar.dart';

// Providers
import 'package:path_provider/path_provider.dart';

// Models
import 'package:documentmanager/models/category_model.dart';
import 'package:documentmanager/models/document_model.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [
        CategoryModelSchema, 
        DocumentModelSchema,
      ],
      directory: dir.path,
    );
  }
}