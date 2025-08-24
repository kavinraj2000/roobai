import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userImageUrl;
  final List<DrawerCategory> categories;
  final List<DrawerPlatform> platforms;
  final VoidCallback? onProfileTap;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.userImageUrl,
    required this.categories,
    required this.platforms,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B5CF6), // Purple
              Color(0xFFE0E7FF), // Light purple/blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with logo
              _buildHeader(),
              
              // Search bar
              _buildSearchBar(),
              
              // Profile section
              _buildProfileSection(context),
              
              // Categories section
              _buildCategoriesSection(),
              
              // Platforms section
              _buildPlatformsSection(),
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.spa_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey, size: 20),
            SizedBox(width: 8),
            Text(
              'Search',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile image and name
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(userImageUrl),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Join Us buttons
          ...List.generate(5, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildJoinButton(),
          )),
        ],
      ),
    );
  }

  Widget _buildJoinButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: const Text(
        'Join Us',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: categories.map((category) => 
              Expanded(
                child: _buildCategoryItem(category),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(DrawerCategory category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              category.icon,
              color: Colors.orange,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Platforms',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...platforms.map((platform) => _buildPlatformItem(platform)),
        ],
      ),
    );
  }

  Widget _buildPlatformItem(DrawerPlatform platform) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: platform.onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: platform.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              if (platform.logo != null) 
                platform.logo!
              else
                Icon(
                  platform.icon,
                  color: Colors.white,
                  size: 24,
                ),
              const SizedBox(width: 12),
              Text(
                platform.title,
                style: TextStyle(
                  color: platform.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (platform.subtitle != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    platform.subtitle!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Data models for drawer items
class DrawerCategory {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  DrawerCategory({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class DrawerPlatform {
  final String title;
  final IconData? icon;
  final Widget? logo;
  final Color backgroundColor;
  final Color textColor;
  final String? subtitle;
  final VoidCallback? onTap;

  DrawerPlatform({
    required this.title,
    this.icon,
    this.logo,
    required this.backgroundColor,
    required this.textColor,
    this.subtitle,
    this.onTap,
  });
}

// Example usage
class ExampleUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App with Custom Drawer'),
      ),
      drawer: CustomDrawer(
        userName: 'John Doe',
        userImageUrl: 'https://example.com/profile.jpg',
        categories: [
          DrawerCategory(
            title: 'Women',
            icon: Icons.woman,
            onTap: () => print('Women category tapped'),
          ),
          DrawerCategory(
            title: 'Shoes',
            icon: Icons.shopping_bag,
            onTap: () => print('Shoes category tapped'),
          ),
        ],
        platforms: [
          DrawerPlatform(
            title: 'amazon',
            backgroundColor: const Color(0xFF232F3E),
            textColor: Colors.white,
            subtitle: '20%',
            icon: Icons.shopping_cart,
            onTap: () => print('Amazon tapped'),
          ),
          DrawerPlatform(
            title: 'sand castel',
            backgroundColor: Colors.white,
            textColor: Colors.black87,
            icon: Icons.castle,
            onTap: () => print('Sand castel tapped'),
          ),
        ],
        onProfileTap: () => print('Profile tapped'),
      ),
      body: const Center(
        child: Text('Main Content'),
      ),
    );
  }
}