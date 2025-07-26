import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'scanner.dart';
// import 'get_started.dart';
import 'profile_page.dart';
import 'chat_screen.dart';

class PrintResultPage extends StatelessWidget {
  final Map<String, dynamic> productData;

  const PrintResultPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    final data = productData['data']['data'];
    final classification = data['classification'] ?? {};
    final overallClassification =
        classification['overall_classification'] ?? '';
    final overallCategory = classification['overall_category'] ?? '';
    final allergenAlert = classification['allergen_alert'] ?? '';
    final genericAllergens = classification['generic_allergens'] ?? '';

    final productName = data['product_name'] ?? 'Unknown';
    final productBrand = data['product_brand'] ?? '';
    final productIngredients = data['product_ingredients'] ?? '';
    final imageUrl = data['product_image'];

    const greenColor = Color.fromARGB(255, 76, 176, 80);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Results"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(productName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(productBrand,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Colorful Stat Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildColorCard(
                  icon: Icons.local_fire_department,
                  title: "Calories",
                  value: "${data['energy_kcal']} kcal",
                  color: Colors.orange.shade200,
                ),
                _buildColorCard(
                  icon: Icons.fitness_center,
                  title: "Protein",
                  value: "${data['proteins']} g",
                  color: Colors.green.shade200,
                ),
                _buildColorCard(
                  icon: Icons.restaurant,
                  title: "Carbs",
                  value: "${data['carbohydrates']} g",
                  color: Colors.blue.shade200,
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(thickness: 1.2),
            const SizedBox(height: 12),

            // Diet Suitability
            Row(
              children: [
                const Text("Diet Suitability: ",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  overallClassification,
                  style: TextStyle(
                    fontSize: 16,
                    color: overallClassification == 'Not Suitable'
                        ? Colors.red
                        : greenColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(thickness: 1.2),
            const SizedBox(height: 12),

            // Generic Allergens (moved here)
            if (genericAllergens.isNotEmpty) ...[
              const Text("Generic Allergens:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(genericAllergens, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              const Divider(thickness: 1.2),
              const SizedBox(height: 12),
            ],

            // Nutrition Facts
            const Text("Nutrition Facts",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildNutritionRow("Total Fat", "${data['fat']} g"),
            _buildNutritionRow("Saturated Fat", "${data['saturated_fat']} g"),
            _buildNutritionRow("Calories", "${data['energy_kcal']} kcal"),
            _buildNutritionRow("Sodium", "${data['salt']} mg"),
            _buildNutritionRow("Total Carbs", "${data['carbohydrates']} g"),
            _buildNutritionRow("Sugars", "${data['sugar']} g"),
            _buildNutritionRow("Protein", "${data['proteins']} g"),
            _buildNutritionRow("Fiber", "${data['fiber']} g"),

            const SizedBox(height: 16),
            const Divider(thickness: 1.2),
            const SizedBox(height: 12),

            // Ingredients Section
            const Text("Ingredients",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                productIngredients,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),

      // Bottom Nav
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
              IconButton(
                icon: const Icon(Icons.home, size: 28, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DashboardScreen()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.restaurant_menu_outlined,
                    size: 26, color: Colors.white),
                onPressed: () {},
              ),
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.qr_code_scanner,
                      size: 30, color: greenColor),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BarcodeScannerPage()));
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline,
                    size: 26, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_outline,
                    size: 28, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PersonalInfoPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Colorful Card for Macronutrients
  Widget _buildColorCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
