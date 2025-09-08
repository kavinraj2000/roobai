import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/drawer/bloc/drawe_bloc.dart';
import 'package:roobai/comman/model/category_model.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DraweBloc, DrawerState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [Expanded(child: _buildContent(context, state))],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, DrawerState state) {
    if (state.status == Drawerstatus.loading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
        ),
      );
    }

    if (state.status == Drawerstatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.purple),
            const SizedBox(height: 16),
            Text(
              'Error loading categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<DraweBloc>().add(Loadincategoryevent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.status == Drawerstatus.loaded) {
      return Container(
        color: Colors.grey[50],
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const SizedBox(height: 30),
            Text(
              'Category',
              style: AppConstants.headerblack.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 10),
            _buildCategoriesSection(context, state),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildCategoriesSection(BuildContext context, DrawerState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.category.isEmpty)
          _buildEmptyState()
        else
          ...state.category
              .map((category) => _buildCategoryItem(context, category))
              .toList(),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryModel category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            context.read<DraweBloc>().add(SelectCategory(category));
            context.goNamed(RouteName.category, extra: category);
            Logger().d('_buildCategoryItem::InkWell::$category');
          },
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.08),
              //     blurRadius: 10,
              //     offset: const Offset(0, 4),
              //   ),
              // ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      //   color: const Color.fromARGB(
                      //     255,
                      //     128,
                      //     21,
                      //     182,
                      //   ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child:
                          (category.categoryImage != null &&
                              category.categoryImage!.isNotEmpty)
                          ? Image.network(
                              'https://roobai.com/assets/img/sale_cat_img/${category.categoryImage}',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.restaurant,
                                  color: Colors.purple,
                                  size: 30,
                                );
                              },
                            )
                          : const Icon(
                              Icons.restaurant,
                              color: Colors.purple,
                              size: 30,
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.category ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        const SizedBox(height: 4),

                        if (category.flag != null && category.flag!.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              category.flag!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Arrow icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.purple,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.restaurant_menu, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No categories found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new items',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
