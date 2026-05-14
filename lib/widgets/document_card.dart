import 'package:documentmanager/models/document_model.dart';
import 'package:documentmanager/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class DocumentCard extends StatelessWidget {

  final DocumentModel document;

  final VoidCallback onTap;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final isPdf = document.type == 'pdf';

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

              Icon(
                isPdf
                    ? Icons.picture_as_pdf
                    : Icons.image,
                size: 40,
              ),

              const SizedBox(width: 16),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      document.name,

                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),

                    const SizedBox(height: 6),

                    Text(formatUpdatedAt(document.updatedAt,),

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