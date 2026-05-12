// ISAR
import 'package:isar/isar.dart';

// Database
import 'package:documentmanager/database/isar_service.dart';

// Model
import 'package:documentmanager/models/document_model.dart';

class DocumentService {
  Future<void> addDocument(DocumentModel document) async {
    final isar = IsarService.isar; 

    await isar.writeTxn(() async {
      await isar.documentModels.put(document);
    });
  }

  Future<List<DocumentModel>> getDocumentsByCategory(int categoryId) async {
    final isar = IsarService.isar; 

    return await isar.documentModels
        .filter()
        .categoryIdEqualTo(categoryId)
        .findAll();
  }
}