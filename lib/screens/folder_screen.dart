// FLutter 
import 'package:documentmanager/screens/text_note_editor_screen.dart';
import 'package:documentmanager/widgets/category_card.dart';
import 'package:flutter/material.dart';

// used for file/directory/copying files
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// File Picker
import 'package:file_picker/file_picker.dart';

// Models
import 'package:documentmanager/models/document_model.dart';
import 'package:documentmanager/models/category_model.dart';

// Services
import 'package:documentmanager/services/document_service.dart';
import 'package:documentmanager/services/category_service.dart';

// Widgets
import 'package:documentmanager/widgets/document_card.dart';

// Screens
import 'package:documentmanager/screens/document_viewer_screen.dart';

class FolderScreen extends StatefulWidget {

  final String folderName;

  final int categoryId;

  const FolderScreen({
    super.key,
    required this.folderName,
    required this.categoryId,
  });

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {

  final DocumentService _documentService = DocumentService();

  List<DocumentModel> documents = [];

  final CategoryService _categoryService = CategoryService();

  List<CategoryModel> subfolders = [];

  final TextEditingController _folderController = TextEditingController(); 

  @override
  void initState() {
    super.initState();

    loadDocuments();

    loadSubfolders();
  }

  Future<void> loadSubfolders() async {
    final loadedCategories = await _categoryService.getCategoriesByParent(widget.categoryId,);

    setState(() {
      subfolders = loadedCategories;
    });
  }

  Future<void> loadDocuments() async {

    final loadedDocuments = await _documentService.getDocumentsByCategory( widget.categoryId,);

    setState(() {
      documents = loadedDocuments;
    });
  }

  Future<void> pickDocument() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'jpg',
        'png',
        'jpeg',
      ],
    );

    if ( result == null ) {
      return;
    }

    final pickedFile = result.files.first;

    if (pickedFile.path == null) return;

    final appDir = await getApplicationDocumentsDirectory();

    final categoryFolder = Directory(
      path.join(
        appDir.path, 
        'AppDocuments', 
        widget.folderName,
      ),
    );

    if (!await categoryFolder.exists()) {
      await categoryFolder.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch; 

    final fileName = '${timestamp}_${pickedFile.name}';

    final savedPath = path.join(
      categoryFolder.path, 
      fileName,
    );

    final savedFile = await File(
      pickedFile.path!, 
    ).copy(savedPath);

    final extension = path
      .extension(pickedFile.name)
      .toLowerCase();

    final type = extension == '.pdf'
      ? 'pdf'
      : 'image';

    final document = DocumentModel()
      ..name = pickedFile.name
      ..path = savedFile.path
      ..type = type
      ..categoryId = widget.categoryId
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now(); 

    await _documentService.addDocument(
      document,
    );

    await _categoryService.updateCategoryTimestamp(widget.categoryId); 

    await loadDocuments();

    print('Saved File: ${savedFile.path}');
  }

  Future<void> showCreateFolderDialog() async {
    _folderController.clear(); 

    await showDialog(
      context: context, 

      builder: (context) {
        return AlertDialog(
          title: const Text('Create Folder',),

          content: TextField(
            controller: _folderController, 
            decoration: const InputDecoration(hintText: 'Folder Name'),
          ),

          actions: [
             TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {

                final folderName =
                    _folderController.text
                        .trim();

                if (folderName.isEmpty) {
                  return;
                }

                final category =
                    CategoryModel()

                      ..name = folderName

                      ..parentCategoryId =
                          widget.categoryId

                      ..createdAt = DateTime.now()
                      ..updatedAt = DateTime.now();

                await _categoryService
                    .addCategory(category);

                await _categoryService.updateCategoryTimestamp(widget.categoryId);

                await loadSubfolders();

                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showCreateNoteDialog() async {

    final controller = TextEditingController();

    await showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Create Text Note',
          ),

          content: TextField(

            controller: controller,

            decoration:
                const InputDecoration(
              hintText: 'Note title',
            ),
          ),

          actions: [

            ElevatedButton(

              onPressed: () {

                Navigator.pop(context);
              },

              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(

              onPressed: () async {

                final noteTitle =
                    controller.text.trim();

                if (noteTitle.isEmpty) {
                  return;
                }

                Navigator.pop(context);

                await createTextNote(
                  noteTitle,
                );
              },

              child: const Text(
                'Create',
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> createTextNote(String noteTitle,) async {

    final appDir = await getApplicationDocumentsDirectory();

    final folderPath = '${appDir.path}/${widget.folderName}';

    await Directory(folderPath).create(recursive: true,);

    final notePath = '$folderPath/$noteTitle.txt';

    final file = File(notePath);

    await file.writeAsString('');

    final now = DateTime.now();

    final document = DocumentModel()

      ..name = '$noteTitle.txt'

      ..path = notePath

      ..type = 'text'

      ..categoryId = widget.categoryId

      ..createdAt = now

      ..updatedAt = now;

    await _documentService.addDocument(
      document,
    );

    await _categoryService.updateCategoryTimestamp(widget.categoryId, );

    await loadDocuments();

    if (!mounted) {
      return;
    }

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (context) =>
            TextNoteEditorScreen(

          notePath: notePath,

          noteTitle: '$noteTitle.txt',

          documentId: document.id,
          categoryId: widget.categoryId,
        ),
      ),
    );
  }


  void showExplorerActions() {

    showModalBottomSheet(

      context: context,

      builder: (context) {

        return SafeArea(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              ListTile(

                leading: const Icon(
                  Icons.create_new_folder,
                ),

                title: const Text(
                  'Create Folder',
                ),

                onTap: () {

                  Navigator.pop(context);

                  showCreateFolderDialog();
                },
              ),

              ListTile(

                leading: const Icon(
                  Icons.upload_file,
                ),

                title: const Text(
                  'Upload File',
                ),

                onTap: () {

                  Navigator.pop(context);

                  pickDocument();
                },
              ),

              ListTile(

                leading: const Icon(
                  Icons.note_add,
                ),

                title: const Text(
                  'Create Text Note',
                ),

                onTap: () {

                  Navigator.pop(context);

                  showCreateNoteDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final hasSubfolders = subfolders.isNotEmpty;

    final hasDocuments = documents.isNotEmpty;

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.folderName),
      ),

      body: (!hasSubfolders && !hasDocuments)

          ? const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.folder_open,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Folder is empty',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Add subfolders or documents',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )

          : SingleChildScrollView(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // SUBFOLDERS SECTION

                  if (hasSubfolders) ...

                    [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Folders',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      ...subfolders.map(
                        (category) {

                          return CategoryCard(

                            category: category,

                            onTap: () {

                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder: (context) =>
                                      FolderScreen(

                                    folderName:
                                        category.name,

                                    categoryId:
                                        category.id,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],

                  // DOCUMENTS SECTION

                  if (hasDocuments) ...

                    [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Documents',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      ...documents.map(
                        (document) {

                          return DocumentCard(

                            document: document,

                            onTap: () {
                              // Text Page below 
                              if (document.type == 'text') {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (context) =>
                                        TextNoteEditorScreen(

                                      notePath: document.path,
                                      noteTitle: document.name,
                                      documentId: document.id,
                                      categoryId: widget.categoryId,
                                    ),
                                  ),
                                );

                                return;
                              }
                              // Document Page below 
                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder: (context) =>
                                      DocumentViewerScreen(

                                    documentPath:
                                        document.path,

                                    documentType:
                                        document.type,

                                    documentName:
                                        document.name,

                                    documentId: document.id,
                                    categoryId: widget.categoryId,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                ],
              ),
            ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          showExplorerActions();
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}