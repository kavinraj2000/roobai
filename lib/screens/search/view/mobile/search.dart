// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:roobai/app/route_names.dart';
// import 'package:roobai/comman/widgets/appbarwidget.dart';
// import 'package:roobai/comman/widgets/navbarwidget.dart';
// import 'package:roobai/comman/widgets/no_data.dart';
// import 'package:roobai/screens/search/bloc/search_bloc.dart';
// import 'package:roobai/screens/product/model/products.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Search Products'),
//       bottomNavigationBar: BottomNavBarWidget(selectedIndex: 0),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: BlocBuilder<SearchBloc, SearchState>(
//               builder: (context, state) {
//                 return TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search products...',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     suffixIcon: state.searchQuery.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.clear),
//                             onPressed: () {
//                               _searchController.clear();
//                               context
//                                   .read<SearchBloc>()
//                                   .add(SearchQueryChanged(''));
//                             },
//                           )
//                         : const Icon(Icons.search),
//                   ),
//                   onChanged: (query) {
//                     context
//                         .read<SearchBloc>()
//                         .add(SearchQueryChanged(query));
//                   },
//                 );
//               },
//             ),
//           ),

//           // Search results
//           Expanded(
//             child: BlocBuilder<SearchBloc, SearchState>(
//               builder: (context, state) {
//                 // Handle loading state
//                 if (state.isLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 // Handle error state
//                 if (state.status == Searchstatus.failure) {
//                   return const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.error_outline, size: 64, color: Colors.red),
//                         SizedBox(height: 16),
//                         Text(
//                           'Something went wrong',
//                           style: TextStyle(fontSize: 16, color: Colors.red),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Please try again later',
//                           style: TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 // Show empty state initially when no search query
//                 if (state.searchQuery.isEmpty || state.status == Searchstatus.initial) {
//                   return const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.search,
//                           size: 64,
//                           color: Colors.grey,
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'Start typing to search products',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Enter product name or keywords',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 // Show "no results" when search query exists but no matches found
//                 if (state.filteredProducts.isEmpty && state.searchQuery.isNotEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(8),
//                           child: NoDataWidget(),
//                         ),
//                         Text(
//                           'No matching products found for "${state.searchQuery}"',
//                           style: const TextStyle(fontSize: 16, color: Colors.grey),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Try searching with different keywords',
//                           style: TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 // Show search results
//                 return ListView.separated(
//                   itemCount: state.filteredProducts.length,
//                   separatorBuilder: (_, __) => const Divider(height: 1),
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   itemBuilder: (context, index) {
//                     final Product product = state.filteredProducts[index];
//                     final isSelected = product == state.selectedProduct;

//                     return ListTile(
//                       contentPadding: const EdgeInsets.symmetric(vertical: 8),
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: product.productImage != null
//                             ? Image.network(
//                                 product.productImage!,
//                                 width: 60,
//                                 height: 60,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     width: 60,
//                                     height: 60,
//                                     color: Colors.grey[200],
//                                     child: const Icon(Icons.image_not_supported),
//                                   );
//                                 },
//                               )
//                             : Container(
//                                 width: 60,
//                                 height: 60,
//                                 color: Colors.grey[200],
//                                 child: const Icon(Icons.image_not_supported),
//                               ),
//                       ),
//                       title: Text(
//                         product.productName ?? 'Unnamed Product',
//                         style: TextStyle(
//                           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                           fontSize: 16,
//                           color: isSelected ? Colors.deepPurple : Colors.black87,
//                         ),
//                       ),
//                       subtitle: Text(
//                         product.productOfferPrice != null
//                             ? "₹${product.productOfferPrice}"
//                             : "No price available",
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                       trailing: const Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         size: 16,
//                         color: Colors.grey,
//                       ),
//                       tileColor: isSelected
//                           ? Colors.deepPurple.withOpacity(0.05)
//                           : null,
//                       onTap: () {
//                         context.read<SearchBloc>().add(SelectProduct(product));
//                         context.goNamed(
//                           RouteName.productdetail,
//                           extra: product.toMap(),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }