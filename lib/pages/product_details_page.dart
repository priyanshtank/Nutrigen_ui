import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (productData['product_image'] != null &&
                productData['product_image'].toString().isNotEmpty)
              Center(
                child: Image.network(
                  productData['product_image'],
                  height: 200,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            const SizedBox(height: 16),
            Text('Name: ${productData['product_name']}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Brand: ${productData['product_brand']}'),
            Text('Ingredients: ${productData['product_ingredients']}'),
            const Divider(height: 30),
            Text('Energy (kcal): ${productData['energy(kcal)']}'),
            Text('Carbohydrates: ${productData['carbohydrates']} g'),
            Text('Proteins: ${productData['proteins']} g'),
            Text('Sugar: ${productData['sugar']} g'),
            Text('Fat: ${productData['fat']} g'),
            Text('Saturated Fat: ${productData['saturated fat']} g'),
            Text('Salt: ${productData['salt']} g'),
            Text('Fiber: ${productData['fiber']} g'),
            Text('Carbs per serving: ${productData['carbs_per_serving']} g'),
            Text('Energy per serving: ${productData['energy_per_serving']} kcal'),
            Text('Sugars per serving: ${productData['sugars_per_serving']} g'),
          ],
        ),
      ),
    );
  }
}
