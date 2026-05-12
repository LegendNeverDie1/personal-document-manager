import 'package:documentmanager/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

                return ListTile(

                  leading: const Icon(Icons.folder),

                  title: Text(category.name),

                  subtitle: Text(
                    category.createdAt.toString(),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {},

        child: const Icon(Icons.add),
      ),
    );
  }
}