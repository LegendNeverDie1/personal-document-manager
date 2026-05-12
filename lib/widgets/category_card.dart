import 'package:documentmanager/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {

  final CategoryModel category;

  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      child: InkWell(

        borderRadius: BorderRadius.circular(18),

        onTap: onTap,

        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Row(

            children: [

              const Icon(
                Icons.folder_rounded,
                size: 40,
              ),

              const SizedBox(width: 16),

              Expanded(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      category.name,

                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Created on ${category.createdAt.day}/${category.createdAt.month}/${category.createdAt.year}',

                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}