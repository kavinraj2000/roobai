// homepage.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/carsoul_slider.dart';
import 'package:roobai/comman/widgets/loader.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/comman/widgets/no_data.dart';
import 'package:roobai/screens/homepage/bloc/homepage_bloc.dart';
import 'package:roobai/screens/homepage/view/mobile/widget/Homepage_bannerdection.dart';
import 'package:roobai/screens/homepage/view/mobile/widget/categoriessectionwidget.dart';
import 'package:roobai/screens/homepage/view/mobile/widget/feature_banner_wiget.dart';
import 'package:roobai/screens/homepage/view/mobile/widget/home_section_widget.dart';
import 'package:roobai/screens/homepage/view/mobile/widget/justin_section.dart';
import 'package:roobai/screens/homepage/view/mobile/widget/searchbar_widget.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CustomAppBar(),
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (BuildContext context, HomepageState state) {
          if (state.status == HomepageStatus.loading) {
            return const LoadingPage();
          }

          log.d('Homepage::state::${state.homeModel}');

          if (state.status == HomepageStatus.error) {
            return _buildErrorState(context, state.errorMessage);
          }

          final homeModels = state.homeModel ?? [];

          if (homeModels.isEmpty) {
            return _buildEmptyState();
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarWidget(),
                  FeaturedBannerWidget(banners: homeModels,),
                  CategoriesSectionWidget(homeModels: homeModels),
JustInSection(homeData: homeModels)

                  // PlatformCardsWidget(homeModel: homeModels,),
                  // ...homeModels.map(
                  //   (homeModel) => HomeSectionWidget(homeModel: homeModel),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 0),
    );
  }

  Widget _buildErrorState(BuildContext context, String? errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 60, color: Colors.red),
          const SizedBox(height: 16),
          Padding(padding: EdgeInsets.all(16),
          child: NoDataWidget(),),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<HomepageBloc>().add(LoadHomepageData());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 60, color: Colors.grey),
          SizedBox(height: 16),
         Padding(padding: EdgeInsets.all(16),
          child: NoDataWidget(),),
        ],
      ),
    );
  }
}