import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/drawer/bloc/drawe_bloc.dart';
import 'package:roobai/comman/model/category_model.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DraweBloc, DrawerState>(
      builder: (context, state) {
        return Drawer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8B5CF6),
                  Color(0xFF7C3AED),
                  Color(0xFFE5E7EB),
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
            child: Column(
              children: [
                _buildHeader(context, state),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: _buildContent(context, state),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

Widget _buildHeader(BuildContext context, DrawerState state) {
  return Container(
    padding: const EdgeInsets.only(top: 40, bottom: 12),
    child: Column(
      children: [
        Image.asset(
          'assets/icons/logo.png',
          height: 40, // Reduce logo size if needed
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}


  Widget _buildContent(BuildContext context, DrawerState state) {
    if (state.status == Drawerstatus.loading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
        ),
      );
    }

    if (state.status == Drawerstatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
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
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.status == Drawerstatus.loaded) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
           
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
            Text(
              '${state.category.length} items',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (state.category.isEmpty)
          _buildEmptyState()
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: state.category.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(context, state.category[index]);
            },
          ),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryModel category) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.read<DraweBloc>().add(SelectCategory(category));
context.goNamed(RouteName.category);
          String route = category.url != null && category.url!.isNotEmpty
              ? category.url!
              : '/category/${category.cat_slug ?? category.cid}';
          context.push(route);
          Logger().d('_buildCategoryItem::InkWell::$category');
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: category.categoryImage != null &&
                        category.categoryImage!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://roobai.com/assets/img/sale_cat_img/${category.categoryImage}',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.category,
                              color: Color(0xFF8B5CF6),
                              size: 20,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF8B5CF6),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.category,
                        color: Color(0xFF8B5CF6),
                        size: 20,
                      ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  category.category ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF374151),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (category.flag != null && category.flag!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      category.flag!,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: Colors.red[700],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
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
            'Try adjusting your search terms',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
