import 'package:flutter/material.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';

class Category {
  final String cid;
  final String category;
  final String categoryImage;
  final String catSlug;
  final int sort;

  Category({
    required this.cid,
    required this.category,
    required this.categoryImage,
    required this.catSlug,
    required this.sort,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      cid: json['cid'] ?? '',
      category: json['category'] ?? '',
      categoryImage: json['category_image'] ?? '',
      catSlug: json['cat_slug'] ?? '',
      sort: int.tryParse(json['sort'].toString()) ?? 0,
    );
  }
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isGridView = true;

  // Sample categories data - replace with your actual data source
  final List<Category> _allCategories = [
    Category(cid: "2", category: "Deals Under 99", categoryImage: "qa3WT.png", catSlug: "deals_under_99", sort: -1),
    Category(cid: "3", category: "Deals Under 199", categoryImage: "bywEB.png", catSlug: "deals_under_199", sort: 1),
    Category(cid: "1", category: "Trending Deals", categoryImage: "i76Ga.png", catSlug: "trending_deals", sort: 2),
    Category(cid: "57", category: "Deal Finder", categoryImage: "wKyrD.png", catSlug: "deal_finder", sort: 3),
    Category(cid: "8", category: "Electronics", categoryImage: "fgpF1.png", catSlug: "electronics", sort: 4),
    Category(cid: "20", category: "Boat Products", categoryImage: "WyYM3.png", catSlug: "boat_products", sort: 5),
    Category(cid: "11", category: "Mobiles", categoryImage: "5mp4s.png", catSlug: "mobiles", sort: 6),
    Category(cid: "10", category: "Audio and Video", categoryImage: "9R5nT.png", catSlug: "audio_and_video", sort: 7),
    Category(cid: "9", category: "Smart Watches", categoryImage: "ibaSd.png", catSlug: "smart_watches", sort: 9),
    Category(cid: "22", category: "Clothing", categoryImage: "qimG3.png", catSlug: "clothing", sort: 10),
    Category(cid: "21", category: "Health and Beauty", categoryImage: "jh31n.png", catSlug: "health_and_beauty", sort: 11),
    Category(cid: "19", category: "Mixer", categoryImage: "sqAmZ.png", catSlug: "mixer", sort: 12),
    Category(cid: "18", category: "Gas Stove", categoryImage: "qgJPx.png", catSlug: "gas_stove", sort: 13),
    Category(cid: "12", category: "Monitors", categoryImage: "ay8GQ.png", catSlug: "monitors", sort: 14),
    Category(cid: "13", category: "Tablets", categoryImage: "CBvVa.png", catSlug: "tablets", sort: 15),
    Category(cid: "14", category: "Printers and Inks", categoryImage: "0qnKJ.png", catSlug: "printers_and_inks", sort: 16),
    Category(cid: "15", category: "Sports", categoryImage: "9MLU2.png", catSlug: "sports", sort: 17),
    Category(cid: "16", category: "Musical Instruments", categoryImage: "4hmVt.png", catSlug: "musical_instruments", sort: 18),
    Category(cid: "23", category: "Furniture and Mattresses", categoryImage: "jvgO9.png", catSlug: "furniture_and_mattresses", sort: 19),
    Category(cid: "24", category: "Car and Bike Accessories", categoryImage: "fPiE3.png", catSlug: "car_and_bike_accessories", sort: 20),
    Category(cid: "7", category: "Mobile Accessories", categoryImage: "rEaX3.png", catSlug: "mobile_accessories", sort: 21),
    Category(cid: "6", category: "Personal Care Appliances", categoryImage: "su9f4.png", catSlug: "personal_care_appliances", sort: 22),
    Category(cid: "5", category: "Laptops", categoryImage: "jb67l.png", catSlug: "laptops", sort: 23),
    Category(cid: "4", category: "Large Appliances", categoryImage: "oyDNP.png", catSlug: "large_appliances", sort: 24),
    Category(cid: "26", category: "Bluetooth Speakers", categoryImage: "lLpoC.png", catSlug: "bluetooth_speakers", sort: 25),
    Category(cid: "27", category: "Kitchen", categoryImage: "GsXU6.png", catSlug: "kitchen", sort: 26),
    Category(cid: "28", category: "Television", categoryImage: "LXvMf.png", catSlug: "television", sort: 27),
    Category(cid: "29", category: "Laptop Accessories", categoryImage: "19Ybq.png", catSlug: "laptop_accessories", sort: 28),
    Category(cid: "30", category: "Home Appliances", categoryImage: "z1h2q.png", catSlug: "home_appliances", sort: 29),
    Category(cid: "31", category: "Kids", categoryImage: "D5hm3.png", catSlug: "kids", sort: 30),
    Category(cid: "32", category: "Footwears", categoryImage: "oc4nu.png", catSlug: "footwears", sort: 31),
    Category(cid: "34", category: "Headphones", categoryImage: "r8qcJ.png", catSlug: "headphones", sort: 33),
    Category(cid: "35", category: "Refrigerator", categoryImage: "DbgHE.png", catSlug: "refrigerator", sort: 34),
    Category(cid: "36", category: "Cameras", categoryImage: "C2bIf.png", catSlug: "cameras", sort: 35),
    Category(cid: "38", category: "Exercise and Fitness", categoryImage: "OpBn0.png", catSlug: "exercise_and_fitness", sort: 37),
    Category(cid: "40", category: "Air Conditioners", categoryImage: "fwd3J.png", catSlug: "air_conditioners", sort: 39),
    Category(cid: "41", category: "Alexa Devices", categoryImage: "pSxbq.png", catSlug: "alexa_devices", sort: 40),
    Category(cid: "42", category: "Lifestyle", categoryImage: "ZMtUE.png", catSlug: "lifestyle", sort: 41),
    Category(cid: "43", category: "Cookware", categoryImage: "o1RvC.png", catSlug: "cookware", sort: 42),
    Category(cid: "44", category: "Fans", categoryImage: "z9rab.png", catSlug: "fans", sort: 43),
    Category(cid: "48", category: "Others", categoryImage: "pknZw.png", catSlug: "others", sort: 47),
    Category(cid: "51", category: "Credit card", categoryImage: "0h1jJ.png", catSlug: "credit_card", sort: 50),
    Category(cid: "56", category: "Watches", categoryImage: "LT7aG.png", catSlug: "watches_", sort: 54),
    Category(cid: "58", category: "Coupon", categoryImage: "CsEX4.png", catSlug: "coupon", sort: 57),
    Category(cid: "59", category: "iPhones", categoryImage: "jbUHt.png", catSlug: "iphones", sort: 58),
    Category(cid: "60", category: "Iron Box", categoryImage: "k05PI.png", catSlug: "iron_box", sort: 59),
    Category(cid: "61", category: "Apple Watch", categoryImage: "kW1YX.png", catSlug: "apple_watch", sort: 60),
    Category(cid: "62", category: "iPad", categoryImage: "wjnWm.png", catSlug: "ipad", sort: 61),
    Category(cid: "63", category: "Power Bank", categoryImage: "pCr5I.png", catSlug: "power_bank", sort: 62),
    Category(cid: "65", category: "Women", categoryImage: "0BV9U.png", catSlug: "women", sort: 64),
    Category(cid: "66", category: "Grocery", categoryImage: "tzD1C.png", catSlug: "grocery", sort: 65),
    Category(cid: "80", category: "Just In", categoryImage: "xNADs.png", catSlug: "just_in", sort: 79),
    Category(cid: "94", category: "Under 10k Mobiles", categoryImage: "VoWe2.png", catSlug: "under_10k_mobiles", sort: 93),
    Category(cid: "95", category: "Under 20k Mobiles", categoryImage: "EcMBJ.png", catSlug: "under_20k_mobiles", sort: 94),
    Category(cid: "96", category: "Under 30k Mobiles", categoryImage: "hZNuk.png", catSlug: "under_30k_mobiles", sort: 95),
  ];

  List<Category> get _filteredCategories {
    if (_searchQuery.isEmpty) {
      return _allCategories..sort((a, b) => a.sort.compareTo(b.sort));
    }
    return _allCategories
        .where((category) =>
            category.category.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList()
      ..sort((a, b) => a.sort.compareTo(b.sort));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 3,),
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.deepPurple,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
              ),
            ),
          ),
          
          // Category Count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              '${_filteredCategories.length} categories found',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // Categories Grid/List
          Expanded(
            child: _filteredCategories.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No categories found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : _isGridView
                    ? _buildGridView()
                    : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.85,
      ),
      itemCount: _filteredCategories.length,
      itemBuilder: (context, index) {
        final category = _filteredCategories[index];
        return _buildCategoryCard(category);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _filteredCategories.length,
      itemBuilder: (context, index) {
        final category = _filteredCategories[index];
        return _buildCategoryListItem(category);
      },
    );
  }

  Widget _buildCategoryCard(Category category) {
    return InkWell(
      onTap: () => _onCategoryTap(category),
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Category Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                  child: Image.asset(
                    'assets/images/${category.categoryImage}', // Replace with your image path
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            
            // Category Name
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Text(
                  category.category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryListItem(Category category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => _onCategoryTap(category),
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Category Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/${category.categoryImage}', // Replace with your image path
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 30,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(width: 16.0),
              
              // Category Name
              Expanded(
                child: Text(
                  category.category,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              
              // Arrow Icon
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCategoryTap(Category category) {
    // Handle category tap - navigate to category details or products
    print('Tapped on category: ${category.category} (${category.catSlug})');
    
    // Example navigation (uncomment and modify as needed):
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CategoryDetailPage(category: category),
    //   ),
    // );
    
    // Show a snackbar for demonstration
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opened ${category.category}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

