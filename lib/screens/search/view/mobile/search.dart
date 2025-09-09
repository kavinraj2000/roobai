import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/comman/widgets/no_data.dart';
import 'package:roobai/screens/search/bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ensure products are loaded when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchBloc = context.read<SearchBloc>();
      if (searchBloc.state.allProducts.isEmpty) {
        searchBloc.add(LoadAllProducts());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Search Products'),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: state.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context
                                  .read<SearchBloc>()
                                  .add(SearchQueryChanged(''));
                            },
                          )
                        : const Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    context
                        .read<SearchBloc>()
                        .add(SearchQueryChanged(query));
                  },
                );
              },
            ),
          ),

          // Show total products count when loaded
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.allProducts.isNotEmpty && state.searchQuery.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${state.allProducts.length} products available',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // Search results
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                // Handle loading state
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Handle error state
                if (state.status == Searchstatus.failure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        const Text(
                          'Something went wrong',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Please try again later',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<SearchBloc>().add(LoadAllProducts());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                // Show empty state initially when no search query
                if (state.searchQuery.isEmpty || state.status == Searchstatus.initial) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Start typing to search products',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Search by name, category, brand, or description',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state.filteredProducts.isEmpty && state.searchQuery.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: NoDataWidget(),
                        ),
                        Text(
                          'No matching products found for "${state.searchQuery}"',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Try searching with different keywords',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return InkWell(
                  onTap: (){
                    context.read<SearchBloc>().add(NavigateToProductEvent(state.filteredProducts.first.productUrl));
                  },
                  child: Column(
                    children: [
                      // Results count
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${state.filteredProducts.length} result${state.filteredProducts.length == 1 ? '' : 's'} found',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      
                      Expanded(
                        child:ListView.separated(
                    itemCount: state.filteredProducts.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final product = state.filteredProducts[index];
                      final isSelected = product == state.selectedProduct;
                  
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: product.productImage != null
                              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: product.productImage!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (_, __, ___) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported),
                  ),
                                )
                              : Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported),
                                ),
                        ),
                        title: Text(
                          product.productName ?? 'Unnamed Product',
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 16,
                            color: isSelected ? Colors.deepPurple : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          product.productOfferPrice != null
                              ? "₹${product.productOfferPrice}"
                              : "No price available",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                        tileColor: isSelected ? Colors.deepPurple.withOpacity(0.05) : null,
                        onTap: () {
                          context.read<SearchBloc>().add(SelectProduct(product));
                          context.goNamed(
                            RouteName.productdetail,
                            extra: product.toJson(),
                          );
                        },
                      );
                    },
                  )
                  
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}