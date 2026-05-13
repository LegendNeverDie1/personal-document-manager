// FLutter 
import 'package:flutter/material.dart';

// used for file/directory/copying files
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// File Picker
import 'package:file_picker/file_picker.dart';

// Models
import 'package:documentmanager/models/document_model.dart';

// Services
import 'package:documentmanager/services/document_service.dart';

// Widgets
import 'package:documentmanager/widgets/document_card.dart';

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

  @override
  void initState() {
    super.initState();

    loadDocuments();
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
      ..createdAt = DateTime.now();

    await _documentService.addDocument(
      document,
    );

    await loadDocuments();

    print('Saved File: ${savedFile.path}');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.folderName),
      ),

      body: documents.isEmpty

          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.description_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'No documents yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Upload your first document',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )

          : ListView.builder(

              itemCount: documents.length,

              itemBuilder: (context, index) {

                final document = documents[index];

                return  DocumentCard(

                  document: document,

                  onTap: () {

                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          pickDocument();
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}