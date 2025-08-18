import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/features/product/shared/widget/appbarwidget.dart';
import 'package:roobai/features/product/shared/widget/navbarwidget.dart';
import 'package:roobai/screens/category/bloc/category_bloc.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  static const categories = [
    {'icon': Icons.laptop, 'label': 'Laptops'},
    {'icon': Icons.phone_iphone, 'label': 'Mobiles'},
    {'icon': Icons.tv, 'label': 'TVs'},
    {'icon': Icons.headphones, 'label': 'Audio'},
    {'icon': Icons.watch, 'label': 'Watches'},
    {'icon': Icons.kitchen, 'label': 'Appliances'},
    {'icon': Icons.toys, 'label': 'Toys'},
    {'icon': Icons.chair, 'label': 'Furniture'},
    {'icon': Icons.book, 'label': 'Books'},
    {'icon': Icons.sports_soccer, 'label': 'Sports'},
    {'icon': Icons.lightbulb, 'label': 'Electronics'},
    {'icon': Icons.shopping_bag, 'label': 'Fashion'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarwidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBarWidget(currentRoute: '/category'),
      body: BlocBuilder<CategoryBloc, Categorystate>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ), 
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildAnimatedCategoryCard(category, index);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedCategoryCard(Map<String, dynamic> category, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1),
      duration: Duration(milliseconds: 500 + (index * 80)),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: InkWell(
        onTap: () {
          debugPrint("Tapped: ${category['label']}");
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.9), Colors.orange.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(4, 4),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 8,
                offset: const Offset(-4, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.orange.shade200, Colors.orange.shade400],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  category['icon'],
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category['label'],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
