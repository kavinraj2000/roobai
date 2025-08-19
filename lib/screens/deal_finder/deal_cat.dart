import 'package:flutter/material.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/features/data/model/deal_model.dart';

class DealCategory extends StatefulWidget {
  Providers provider = Providers();

  DealCategory(this.provider, this.dealCat);
  List<DealCat> dealCat = [];

  @override
  State<DealCategory> createState() => _DealCategoryState();
}

class _DealCategoryState extends State<DealCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lay_bg,
        appBar: AppBar(
        titleSpacing: 0,
        title: Text(' ${widget.provider.title!} Category List', style: TextStyle(color: Colors.white, fontSize: 18),),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),),
          backgroundColor: primaryColor,),
    body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: widget.dealCat.length,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
    return InkWell(onTap: (){
      Navigator.pop(context, widget.dealCat[index]);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child:  Text(widget.dealCat[index].category!,)
          ),
          /*Divider()*/

        ]
    ),);
            })
      ),
    ));
  }
}
