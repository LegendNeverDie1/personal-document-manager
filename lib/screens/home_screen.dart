import 'package:flutter/material.dart';

// Providers 
import 'package:documentmanager/providers/category_provider.dart';
import 'package:provider/provider.dart';

// Widgets 
import 'package:documentmanager/widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _categoryController = TextEditingController();
  
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<CategoryProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text('Your Vault'),
      ),

      body: provider.categories.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.folder_open,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'No folders yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Create your first vault category',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )

          : ListView.builder(
              itemCount: provider.categories.length,

              itemBuilder: (context, index) {

                final category = provider.categories[index];

                return CategoryCard(
                  category: category,
                  
                  onTap: () {
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          showDialog(
            context: context,

            builder: (context) {
              return AlertDialog(

                title: const Text('Create Category'),

                content: TextField(
                  controller: _categoryController,

                  decoration: const InputDecoration(
                    hintText: 'Enter folder name',
                  ),
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

                      final name = _categoryController.text.trim();

                      if (name.isEmpty) return;

                      await provider.addCategory(name);

                      _categoryController.clear();

                      Navigator.pop(context);
                    },

                    child: const Text('Create'),
                  ),
                ],
              );
            },
          );
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}