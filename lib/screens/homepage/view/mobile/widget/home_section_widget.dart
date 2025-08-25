// widgets/home_section_widget.dart
import 'package:flutter/material.dart';
import 'package:roobai/comman/model/home_model.dart';


class HomeSectionWidget extends StatelessWidget {
  final HomeModel homeModel;

  const HomeSectionWidget({
    super.key,
    required this.homeModel,
  });

  @override
  Widget build(BuildContext context) {
    // Early return if no data
    if (homeModel.data == null || homeModel.data!.isEmpty) {
      return const SizedBox.shrink();
    }

    final sectionTitle = _getSectionTitle();

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  String _getSectionTitle() {
    // Handle null or empty title
    if (homeModel.title == null || homeModel.title.toString().isEmpty) {
      return _getDefaultTitleForType();
    }

    String title = homeModel.title.toString();
    
    // Special case for banner with title '0'
    if (homeModel.type == 'banner' && title == '0') {
      return 'Featured Banners';
    }

    return title;
  }

  String _getDefaultTitleForType() {
    switch (homeModel.type?.toLowerCase()) {
      case 'banner':
        return 'Banners';
      case 'product':
        return 'Products';
      case 'platform':
        return 'Platforms';
      default:
        return 'Section';
    }
  }

}