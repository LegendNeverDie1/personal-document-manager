import 'dart:io';

import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentViewerScreen extends StatelessWidget {

  final String documentPath;

  final String documentType;

  final String documentName;

  const DocumentViewerScreen({
    super.key,
    required this.documentPath,
    required this.documentType,
    required this.documentName,
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

          return const Center(
            child: Text(
              'Unsupported file type',
            ),
          );
        },
      ),
    );
  }
}