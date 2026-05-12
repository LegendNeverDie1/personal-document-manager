import 'package:documentmanager/models/document_model.dart';
import 'package:documentmanager/services/document_service.dart';
import 'package:flutter/material.dart';

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

    final loadedDocuments =
        await _documentService.getDocumentsByCategory(
      widget.categoryId,
    );

    setState(() {
      documents = loadedDocuments;
    });
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

                return ListTile(

                  leading: Icon(
                    document.type == 'pdf'
                        ? Icons.picture_as_pdf
                        : Icons.image,
                  ),

                  title: Text(document.name),

                  subtitle: Text(
                    document.createdAt.toString(),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {

        },

        child: const Icon(Icons.add),
      ),
    );
  }
}