import 'dart:io';

import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// Screens
import 'package:documentmanager/screens/text_note_editor_screen.dart';

class DocumentViewerScreen extends StatelessWidget {

  final String documentPath;

  final String documentType;

  final String documentName;
  final int documentId; 
  final int categoryId;

  const DocumentViewerScreen({
    super.key,
    required this.documentPath,
    required this.documentType,
    required this.documentName,
    required this.documentId, 
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(documentName),
      ),

     body: Builder(
        builder: (context) {

          if (documentType == 'pdf') {
            return SfPdfViewer.file(
              File(documentPath),
            );
          }

          if (documentType == 'image') {
            return PhotoView(
              imageProvider: FileImage(
                File(documentPath),
              ),
            );
          }

          if (documentType == 'text') {

            return TextNoteEditorScreen(

              notePath: documentPath,

              noteTitle: documentName,
              documentId: documentId,
              categoryId: categoryId,
            );
          }

          return const Center(
            child: Text(
              'Unsupported document type',
            ),
          );
        },
      ),
    );
  }
}