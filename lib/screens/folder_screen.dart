import 'package:flutter/material.dart';

class FolderScreen extends StatelessWidget {

  final String folderName;

  const FolderScreen({
    super.key,
    required this.folderName,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(folderName),
      ),

      body: const Center(
        child: Text(
          'No documents yet',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}