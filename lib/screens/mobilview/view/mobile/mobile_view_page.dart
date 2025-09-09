import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/comman/widgets/appbarwidget.dart';
import 'package:roobai/comman/widgets/datatime_widget.dart';
import 'package:roobai/comman/widgets/loader.dart';
import 'package:roobai/comman/widgets/no_data.dart';
import 'package:roobai/comman/widgets/navbarwidget.dart';
import 'package:roobai/screens/mobilview/bloc/mobilview_bloc.dart';

class Mobileviewpage extends StatefulWidget {
  const Mobileviewpage({super.key});

  @override
  State<Mobileviewpage> createState() => _MobileviewpageState();
}

class _MobileviewpageState extends State<Mobileviewpage> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    scrollController.addListener(() {
      final state = context.read<MobilviewBloc>().state;
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.9 &&
          !state.hasReachedMax &&
          state.status != Mobilviewstatus.loading) {
        context.read<MobilviewBloc>().add(Loadingmobilevent());
      }
    });

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 0),
      body: Stack(
        children: [
          BlocConsumer<MobilviewBloc, Mobilviewstate>(
            listener: (context, state) {},
            builder: (context, state) {
              final Mobiles = state.mobilelist;

              if (state.status == Mobilviewstatus.loading && Mobiles.isEmpty) {
                return const Center(child: LoadingPage());
              }

              if (state.status == Mobilviewstatus.error && Mobiles.isEmpty) {
                return const Center(child: NoDataWidget());
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<MobilviewBloc>().add(Refreshmobiles([]));
                },
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.65,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final Mobile = Mobiles[index];
                          return _buildMobileCard(context, Mobile);
                        }, childCount: Mobiles.length),
                      ),
                    ),
                    if (state.status == Mobilviewstatus.loading &&
                        Mobiles.isNotEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: SafeArea(
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => context.goNamed(RouteName.mainScreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildMobileCard(BuildContext context, ProductModel mobile) {
  final mrp = double.tryParse(mobile.productSalePrice ?? '') ?? 0;
  final offer = double.tryParse(mobile.productOfferPrice ?? '') ?? 0;
  final discount = mrp > 0 ? (((mrp - offer) / mrp) * 100).round() : 0;
  final isExpired = mobile.stockStatus?.toString() == '1';

  return InkWell(
    onTap: () {
      context.read<MobilviewBloc>().add(
        Navigatetomobileurl(mobile.productPageUrl),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: mobile.productImage != null &&
                          mobile.productImage!.isNotEmpty
                      ? Image.network(
                          mobile.productImage!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          errorBuilder: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),
                if (isExpired || discount >= 80)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isExpired ? Colors.red : Colors.deepPurple,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          isExpired ? 'Expired' : 'G.O.A.T',
                          style: AppConstants.headerwhite,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mobile.productName ?? 'Mobile',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppConstants.headerblack,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '₹${offer.toStringAsFixed(0)}',
                      style: AppConstants.headerblack,
                    ),
                    const SizedBox(width: 6),
                    if (mrp > 0)
                      Text(
                        '₹${mrp.toStringAsFixed(0)}',
                        style: AppConstants.offer,
                      ),
                    const Spacer(),
                    if (discount > 0)
                      Row(
                        children: [
                          Text('$discount%', style: AppConstants.textblack),
                          const SizedBox(width: 4),
                          Image.asset(
                            'assets/icons/thunder.png',
                            height: 14,
                            color: _getThunderColor(discount),
                          ),
                        ],
                      ),
                  ],
                ),
                // if (mobile.dateTime != null)
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 4),
                  //   child: Datetimewidget(dateTime: mobile.dateTime),
                  // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.image_outlined, size: 32, color: Colors.grey),
      ),
    );
  }

  Color _getThunderColor(int discount) {
    if (discount >= 80) return Colors.green;
    if (discount >= 50) return Colors.blue;
    if (discount >= 25) return Colors.orange;
    return Colors.red;
  }
}
