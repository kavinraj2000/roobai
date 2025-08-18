import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/screens/deal_finder/amazon_fin.dart';
import 'package:roobai/screens/deal_finder/dealfinder/bloc/dealfinder_bloc.dart';



class DealFinderView extends StatelessWidget {
  final List<Color> flip_colors = [Color(0xFF64b3f4), Color(0xFFc2e59c)];
  final List<Color> myntra_colors = [Color(0xFFFe83e8c), Colors.white54];
  final List<Color> amazon_colors = [Color(0xFFFF9900), Colors.black26];

   DealFinderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Deal Finder"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>context.goNamed(RouteName.mainScreen)
        ),
      ),
      body: BlocBuilder<DealFinderBloc, DealfinderState>(
        builder: (context, state) {
          if (state.status==DealfinderStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status==DealfinderStatus.loaded) {
            final main = state.dealModel;
            final providers = main!.providers ?? [];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(main!.title1 ?? "", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(main.title2 ?? "", style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 25),
                    ListView.builder(
                      itemCount: providers.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final provider = providers[index];

                        return InkWell(
                          onTap: () {
                            if (provider.selected == '1') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => amazon_finder(
                                    provider,
                                    main.dealCat!,
                                    provider.type == "flipkart"
                                        ? flip_colors
                                        : provider.type == 'myntra'
                                            ? myntra_colors
                                            : amazon_colors,
                                  ),
                                ),
                              );
                            } else {
                              // Trigger a reload for new deal type
                              context.read<DealFinderBloc>().add(FetchDealFinderData(dealType: provider.type!, navigateOnLoad: true));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 100,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: const Color(0xffDDDDDD), blurRadius: 20.0, spreadRadius: 2.0),
                              ],
                            ),
                            child: Row(
                              children: [
                                Image.network(provider.image!, height: 50, width: 50),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(provider.text!, style: const TextStyle(fontSize: 15)),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_circle_right_outlined, size: 40, color: Colors.black38),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state.status==DealfinderStatus.failure) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
