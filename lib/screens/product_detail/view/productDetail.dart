import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product_detail/bloc/product_detail_bloc.dart';
import 'package:roobai/screens/product_detail/view/mobile/product_detail_screen.dart';

class ProductDeatil extends StatelessWidget{
  final Map<String,dynamic> initialvalue;
  const ProductDeatil({super.key,required this.initialvalue});

  @override
  Widget build(BuildContext context) {
    Logger().d('ProductDeatil::in itialvalue::$initialvalue');
 return BlocProvider<ProductDetailBloc>(create: (context) => ProductDetailBloc()..add(Initialvalueevent(initialvalue)),child: ProductDetailScreen(data: initialvalue,));  }

}