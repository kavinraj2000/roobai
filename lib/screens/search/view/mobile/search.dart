import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/screens/search/bloc/search_bloc.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: Scaffold(
        // appBar: const Appbarwidget(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.purple,
          elevation: 6,
          shape: const CircleBorder(),
          child: const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    bottomNavigationBar: BottomNavBarWidget(selectedIndex:0 ),

        body: Column(
          children: [
            // Search input field
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      suffixIcon: state.searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                context.read<SearchBloc>().add(SearchQueryChanged(''));
                              },
                            )
                          : null,
                    ),
                    onChanged: (query) {
                      context.read<SearchBloc>().add(SearchQueryChanged(query));
                    },
                  );
                },
              ),
            ),

            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.filteredProducts.isEmpty) {
                    return const Center(
                      child: Text('No matching products found.'),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.filteredProducts.length,
                    separatorBuilder: (_, __) => const Divider(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemBuilder: (context, index) {
                      final product = state.filteredProducts[index];
                      final isSelected = product == state.selectedProduct;

                      return ListTile(
                        leading: Icon(
                          isSelected ? Icons.check_circle : Icons.shopping_bag_outlined,
                          color: isSelected ? Colors.orange : Colors.grey,
                        ),
                        title: Text(
                          product,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.orange : Colors.black,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.done, color: Colors.orange)
                            : null,
                        tileColor: isSelected ? Colors.orange.withOpacity(0.05) : null,
                        onTap: () {
                          context.read<SearchBloc>().add(SelectProduct(product));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
