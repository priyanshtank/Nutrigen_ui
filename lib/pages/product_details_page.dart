import 'package:flutter/material.dart';
import 'scanner.dart';
import 'dashboard.dart';
import 'get_started.dart'; // ✅ Import added

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Scan Results'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 140,
                width: 140,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.network(
                  productData['product_image'] ?? '',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    productData['product_name'] ?? 'Unknown Product',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    productData['product_brand'] ?? '',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoCard(
                  label: 'Calories',
                  value: '${productData['energy_per_serving'] ?? '--'}',
                  unit: 'kcal',
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
                _InfoCard(
                  label: 'Protein',
                  value: '${productData['proteins'] ?? '--'}',
                  unit: 'g',
                  icon: Icons.fitness_center,
                  color: Colors.green,
                ),
                _InfoCard(
                  label: 'Carbs',
                  value: '${productData['carbs_per_serving'] ?? '--'}',
                  unit: 'g',
                  icon: Icons.restaurant,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(),
            const Text(
              'Nutrition Facts',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            _buildNutritionRow('Total Fat', '${productData['fat']}g'),
            _buildNutritionRow(
                'Saturated Fat', '${productData['saturated fat']}g'),
            _buildNutritionRow(
                'Calories', '${productData['energy(kcal)']} kcal'),
            _buildNutritionRow('Sodium', '${productData['salt']}g'),
            _buildNutritionRow(
                'Total Carbohydrates', '${productData['carbohydrates']}g'),
            _buildNutritionRow('Dietary Fiber', '${productData['fiber']}g'),
            _buildNutritionRow('Sugars', '${productData['sugar']}g'),
            _buildNutritionRow('Protein', '${productData['proteins']}g'),
            const SizedBox(height: 28),
            const Divider(),
            const Text(
              'Ingredients',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                productData['product_ingredients'] ?? 'Not available',
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, size: 28),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => DashboardScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.restaurant_menu_outlined, size: 26),
                onPressed: () {},
              ),
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: Colors.green.shade400,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.qr_code_scanner, size: 30),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BarcodeScannerPage()),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 26),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, size: 28),
                onPressed: () {
                  // ✅ Navigate to GetStartedPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetStartedPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const _InfoCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: color.withOpacity(0.2),
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 6),
            Text(
              '$value $unit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
