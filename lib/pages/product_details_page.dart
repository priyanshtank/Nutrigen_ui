import 'package:flutter/material.dart';
import 'scanner.dart';
import 'dashboard.dart';
import 'get_started.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDetailsPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    const greenColor = Color.fromARGB(255, 76, 176, 80);

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 80),
            physics: constraints.maxHeight < 700
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
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
                    const SizedBox(height: 20),
                    const Divider(),
                    Row(
                      children: const [
                        Icon(Icons.analytics_outlined, color: Colors.green),
                        SizedBox(width: 6),
                        Text(
                          'Nutrition Facts',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _buildNutritionRow(
                                  'Total Fat', '${productData['fat']}g'),
                              _buildNutritionRow('Calories',
                                  '${productData['energy(kcal)']} kcal'),
                              _buildNutritionRow('Total Carbs',
                                  '${productData['carbohydrates']}g'),
                              _buildNutritionRow(
                                  'Protein', '${productData['proteins']}g'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              _buildNutritionRow('Saturated Fat',
                                  '${productData['saturated fat']}g'),
                              _buildNutritionRow(
                                  'Sodium', '${productData['salt']}g'),
                              _buildNutritionRow(
                                  'Fiber', '${productData['fiber']}g'),
                              _buildNutritionRow(
                                  'Sugars', '${productData['sugar']}g'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    Row(
                      children: const [
                        Icon(Icons.list_alt_outlined, color: Colors.green),
                        SizedBox(width: 6),
                        Text(
                          'Ingredients',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: greenColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        productData['product_ingredients'] ?? 'Not available',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: greenColor,
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ✅ Home Icon (green circle, white icon)
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 76, 176, 80),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.home, size: 28, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardScreen(),
                      ),
                    );
                  },
                ),
              ),

              // Menu Icon
              IconButton(
                icon: const Icon(
                  Icons.restaurant_menu_outlined,
                  size: 26,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),

              // ✅ Scan Icon (white circle, green icon)
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    size: 30,
                    color: greenColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BarcodeScannerPage(),
                      ),
                    );
                  },
                ),
              ),

              // Chat Icon
              IconButton(
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  size: 26,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),

              // Profile Icon
              IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  size: 28,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GetStartedPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNutritionRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    ),
  );
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
              offset: const Offset(0, 2),
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
