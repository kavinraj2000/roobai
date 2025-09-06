// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:roobai/comman/drawer/bloc/drawe_bloc.dart';
// import 'package:roobai/comman/model/category_model.dart';

// class CategorySpeedDial extends StatelessWidget {
//   const CategorySpeedDial({Key? key}) : super(key: key);

//   static const String baseUrl = "https://roobai.com/assets/images/category/";

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DraweBloc, DrawerState>(
//       builder: (context, state) {
//         if (state.status == Drawerstatus.loading) {
//           return FloatingActionButton(
//             backgroundColor: Colors.purple,
//             onPressed: () {},
//             child: const CircularProgressIndicator(color: Colors.white),
//           );
//         }

//         if (state.status == Drawerstatus.error) {
//           return FloatingActionButton(
//             backgroundColor: Colors.red,
//             onPressed: () {
//               context.read<DraweBloc>().add(Loadincategoryevent());
//             },
//             child: const Icon(Icons.refresh),
//           );
//         }

//         if (state.status == Drawerstatus.loaded) {
//           return SpeedDial(
//             icon: Icons.category,
//             activeIcon: Icons.close,
//             backgroundColor: Colors.purple,
//             overlayColor: Colors.black,
//             overlayOpacity: 0.5,
//             spacing: 10,
//             spaceBetweenChildren: 8,
//             children: state.category.map((category) {
//               final imageUrl = category.categoryImage != null && category.categoryImage!.isNotEmpty
//                   ? "$baseUrl${category.categoryImage!}"
//                   : null;

//               return SpeedDialChild(
//                 backgroundColor: Colors.white,
//                 label: category.category ?? "Unknown",
//                 labelStyle: const TextStyle(fontSize: 12),
//                 child: CircleAvatar(
//                   radius: 16,
//                   backgroundColor: Colors.purple.withOpacity(0.1),
//                   backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
//                   child: imageUrl == null
//                       ? const Icon(Icons.category, color: Colors.purple)
//                       : null,
//                 ),
//                 onTap: () {
//                   context.read<DraweBloc>().add(SelectCategory(category));
//                   String route = category.url ?? '/category/${category.cat_slug ?? category.cid}';
//                   if (route.isNotEmpty) {
//                     Navigator.of(context).pushNamed(route);
//                   }
//                 },
//               );
//             }).toList(),
//           );
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
