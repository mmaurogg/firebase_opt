import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.stock,
  });

  final String title;
  final double price;
  final String? imageUrl;
  final String? stock;

  @override
  Widget build(BuildContext context) {
    final stockText = stock != null ? 'Stock: $stock' : 'Stock no disponible';
    return true
        ? ListTile(
            leading: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.image, size: 50),
            title: Text(title),
            subtitle: Text('\$${price.toStringAsFixed(2)}'),
            trailing: Text(stockText),
          )
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    imageUrl != null
                        ? Image.network(
                            imageUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image, size: 50),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),

                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),

                            Spacer(),

                            Text(
                              stockText,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
