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
            children: [
              Expanded(child: _buildContent(context, state)),
            ],
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
            const Icon(Icons.error_outline, size: 48, color: Colors.purple),
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          children: [
            const SizedBox(height: 30),
            Text(
              'Categories',
              style: AppConstants.headerblack.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 10),
            if (state.category.isEmpty)
              _buildEmptyState()
            else
              ...state.category.map(
                (category) => _buildCategoryItem(context, category),
              ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildCategoryItem(BuildContext context, CategoryModel category) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(
        category.category ?? 'Unknown',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.purple, size: 16),
      onTap: () {
        context.read<DraweBloc>().add(SelectCategory(category));
        context.goNamed(RouteName.category, extra: category);
        Logger().d('Selected Category: ${category.category}');
      },
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.list_alt, size: 48, color: Colors.grey),
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
