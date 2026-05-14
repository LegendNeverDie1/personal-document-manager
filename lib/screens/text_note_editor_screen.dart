import 'dart:io'; 
import 'dart:async';

import 'package:flutter/material.dart';

class TextNoteEditorScreen extends StatefulWidget{
  final String notePath; 
  final String noteTitle; 

  final int documentId;
  final int categoryId;

  const TextNoteEditorScreen({
    super.key, 
    required this.notePath,
    required this.noteTitle, 
    required this.documentId,
    required this.categoryId,
  });

  @override 
  State<TextNoteEditorScreen> createState() => _TextNoteEditorScreenState(); 
}


class _TextNoteEditorScreenState extends State<TextNoteEditorScreen> {
  final TextEditingController _controller = TextEditingController(); 

  bool isLoading = true; 
  Timer? _autoSaveTimer;

  @override 
  void initState() {
    super.initState();
    loadNote();
    _controller.addListener(onTextChanged,);
  }

  Future<void> loadNote() async {
    final file = File(widget.notePath);

    if (await file.exists()) {
      final content = await file.readAsString(); 
      _controller.text = content;
    }

    setState(() {
      isLoading = false;
    });
  }

  void onTextChanged() {

    _autoSaveTimer?.cancel();

    _autoSaveTimer = Timer(

      const Duration(seconds: 1),

      () async {

        await saveNote();
      },
    );
  }

  Future<void> saveNote() async {
    final file = File(widget.notePath); 

    await file.writeAsString(_controller.text);
  }

  @override
  void dispose() {

    _autoSaveTimer?.cancel();

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.noteTitle),
      ),

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : Padding(

              padding:
                  const EdgeInsets.all(16),

              child: TextField(

                controller: _controller,

                maxLines: null,

                expands: true,

                decoration:
                    const InputDecoration(
                  hintText:
                      'Write your note...',
                  border: InputBorder.none,
                ),
              ),
            ),
    );
  }
}