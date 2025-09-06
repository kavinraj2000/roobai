// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
// import 'package:roobai/screens/homepage/view/mobile/card.dart';

// class ProductList extends StatefulWidget {
//   const ProductList({super.key});

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();

//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//           _scrollController.position.maxScrollExtent * 0.9) {
//         // Trigger next page load
//         context.read<HomepageBloc>().add(LoadHomepageData());
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomepageBloc, HomepageState>(
//       builder: (context, state) {
//         if (state.status==HomepageStatus.loading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (state.status==HomepageStatus.loaded) {
//           final products = state.justscroll;

//           return ListView.builder(
//             controller: _scrollController,
//             itemCount: products.length + 1,
//             itemBuilder: (context, index) {
//               if (index < products.length) {
//                 return ProductCard(product: products[index]);
//               } else {
//                 // Show loader at bottom
//                 return const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               }
//             },
//           );
//         }

//         return const Center(child: Text("No products found"));
//       },
//     );
//   }
// }
