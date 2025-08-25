import 'package:flutter/material.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/screens/homepage/view/mobile/widget/justin_widget.dart';

class JustInSection extends StatelessWidget {
  final List<HomeModel> homeData;

  const JustInSection({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    final justInSection = homeData.firstWhere(
      (element) => element.cat_slug == 'just_in',
      orElse: () => HomeModel(data: []),
    );

    final justInItems = justInSection.data ?? [];

    return CategoryGridWidget(items: justInItems);
  }
}
