import 'package:isar/isar.dart';

part 'document_model.g.dart';

@collection
class DocumentModel {
  Id id = Isar.autoIncrement; 

  late String name; 
  late String path; 
  late String type; 
  late int categoryId; 
  late DateTime createdAt; 
  
}