import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/features/product/data/model/deal_model.dart';


import 'deal_cat.dart';
import 'package:http/http.dart' as http;

class amazon_finder extends StatefulWidget {

  Providers provider = Providers();

  amazon_finder(this.provider, this.dealCat, this.back_colors);

  List<DealCat> dealCat = [];
  List<Color> back_colors = [Color(0xFF64b3f4),Color(0xFFc2e59c)];

  @override
  State<amazon_finder> createState() => _amazon_finderState();
}

class _amazon_finderState extends State<amazon_finder> {


  bool _switchValue = true;

  double _startValue = 10.0;
  double _endValue = 100.0;

  int? _choiceValue = 0;
  int? _starValues = 0;
  String deal_category = '';
  String deal_sub_category = '';

  List<String> _choicesList = ['Relevance', 'Low to High', 'High to Low','Newest Arrival','Avg.Review',];

  List<String> _StarList = ['4 Star & above','3 Star & above','2 Star & above','1 Star & above',];

  String sub_cat_id = '';

  bool vertical = false;


  bool enableList = false;

  int _selectedIndex =1;

  List<DealCat> dealCat = [];


  _onhandleTap() {
    setState(() {
      enableList = !enableList;
    }
    );
  }

  _onChanged(index) {
    setState(() {
      _selectedIndex = index;
      enableList = !enableList;
    });
  }


  Widget _buildSearchList() => Container(
    height: 150.0,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.white,
    ),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    margin: EdgeInsets.only(top: 5.0),
    child: ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics:
        BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: widget.dealCat.length,
        itemBuilder: (context,index) {
          return InkWell(
            onTap: () {
            _onChanged(index);
            },
            child: Container(
              // padding: widget.padding,
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                    color:  index == _selectedIndex
                        ? Colors.grey[200]
                        : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                child: Text(widget.dealCat[index].category!,style: TextStyle(color: Colors.black),)),
          );
        }),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "${widget.provider.title} Deal Finder",
            style: TextStyle(fontSize: 18),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient:
              LinearGradient( begin: Alignment.topCenter,end:Alignment.bottomCenter,colors: widget.back_colors
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow:[
                    BoxShadow(
                      color: Color(0xffDDDDDD),
                      blurRadius: 20.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ]
                  ),
                  child: Column(
                    children: [
                      // Text(
                      //   "Amazon Deal Finder",
                      //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      Row(
                        children: [
                          Icon(Icons.search, size: 16,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "DEAL FINDER",
                            style: TextStyle(fontSize: 13),
                          ),

                          Spacer(),
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              activeColor: Color(0xFFFF9900),
                              value: _switchValue,
                              onChanged: (bool value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/icons/prime_pr.png",
                            height: 20,
                            width: 60,
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width, height: 45),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for Products, Brands or Categories',
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.all(10.0),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Divider(
                                color: Colors.black26,
                              )),
                        ),
                        Text("or Select with"),
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Divider(
                                color: Colors.black26,
                              )),
                        ),
                      ]),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Category",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          SizedBox(
                            height: 6,
                          ),


                          InkWell(
                            onTap: _onhandleTap,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: enableList
                                        ? Colors.black
                                        : Colors.grey,
                                    width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              height: 48.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                      child:Text(
                                _selectedIndex != null
                                ? widget.dealCat[_selectedIndex].category!
                                : "Select value",
                                style: TextStyle(fontSize: 12),
                              ),
                                      // Text(deal_category.isEmpty ?"Search for Products, Brands or Categories": deal_category,style: TextStyle(fontSize: 12),),
                                  ),
                                  Icon(Icons.expand_more,
                                      size: 24.0, color: Color(0XFFbbbbbb)),
                                ],
                              ),
                            ),
                          ),
                          enableList ? _buildSearchList() : Container(),
                      /*    InkWell(
                            onTap: () async {
                              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => DealCategory(widget.provider, widget.dealCat)));
                              if(result != null && result.toString().isNotEmpty){
                                setState(() {
                                  DealCat dealcat = result;
                                  sub_cat_id = dealcat.categoryid!;
                                  deal_category = dealcat.category!;
                                  onPagedataCall();
                                });
                              }
                            },
                            child:  Container(
                              width: MediaQuery.of(context).size.width,
                              height: 44,
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 1,
                                  ),
                              ),
                              child: Text(deal_category.isEmpty ?"Search for Products, Brands or Categories" : deal_category,style: TextStyle(fontSize: 12),),
                            ),
                          ),*/
                        ],
                      ),
                      dealCat1.length > 0 ?
                      SizedBox(
                        height: 15,
                      ): Container(),
                      dealCat1.length > 0 ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Sub Category",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: () async {
                              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => DealCategory(widget.provider, dealCat1)));
                              if(result != null && result.toString().isNotEmpty){
                                setState(() {
                                  DealCat dealcat = result;
                                  //sub_cat_id = dealcat.parentid!;
                                  deal_sub_category = dealcat.category!;
                                });
                              }
                            },
                            child:  Container(
                              width: MediaQuery.of(context).size.width,
                              height: 44,
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: Colors.black26,
                                  width: 1,
                                ),
                              ),
                              child: Text(deal_sub_category.isEmpty ? "-- Select --" : deal_sub_category, style: TextStyle(fontSize: 12),),
                            ),
                          ),
                        ],
                      )
                      : Container(),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Discount between ${_startValue.round()}% and ${_endValue.round()}%",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),

                      RangeSlider(
                        min: 0,
                        max: 100,
                        activeColor:Color(0xFFFF9900),
                        inactiveColor: Colors.black26,
                        values: RangeValues(_startValue, _endValue),
                        onChanged: (RangeValues value) {
                          setState(() {
                            _startValue = value.start;
                            _endValue = value.end;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Price Range",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(width: 100, height: 45),
                                  child:  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Min Price',
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(7),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(width: 100, height: 45),
                                  child:  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Max Price',
                                      hintStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                   // maxLength: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // ToggleButtons(
                      //   direction: vertical ? Axis.vertical : Axis.horizontal,
                      //   onPressed: (int index) {
                      //     setState(() {
                      //       // The button that is tapped is set to true, and the others to false.
                      //       for (int i = 0; i < _selectedFruits.length; i++) {
                      //         _selectedFruits[i] = i == index;
                      //       }
                      //     });
                      //   },
                      //   borderRadius: const BorderRadius.all(Radius.circular(8)),
                      //   selectedBorderColor: Colors.blue,
                      //   selectedColor: Colors.white,
                      //   fillColor: Colors.blue,
                      //   color: Colors.black,
                      //   constraints: const BoxConstraints(
                      //     minHeight: 40.0,
                      //     minWidth: 80.0,
                      //   ),
                      //   isSelected: _selectedFruits,
                      //   children: fruits,
                      // ),
                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Sort by",style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Wrap(
                            spacing: 5.0,
                            children: List<Widget>.generate(
                              _choicesList.length,
                                  (int index) {
                                return ChoiceChip(
                                  pressElevation: 21.0,
                                  selectedColor: Color(0xFFFF9900),
                                  backgroundColor: Colors.grey[100],
                                  label: Text(_choicesList [index],),
                                  selected: _choiceValue == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _choiceValue = selected ? index : null;
                                    });
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text("Average Customer Review",style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          _StarList.length,
                              (int index) {
                            return ChoiceChip(
                              pressElevation: 21.0,
                              selectedColor: Color(0xFFFF9900),
                              backgroundColor: Colors.grey[100],
                              label: Text(_StarList [index],),
                              selected: _starValues == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _starValues = selected ? index : null;
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),

                      SizedBox(height: 10),

                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style:ElevatedButton.styleFrom(
                                    backgroundColor:Colors.black26),
                                child:Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children:[
                                    Icon(
                                      Icons.share,
                                      color:Colors.white,
                                    ),
                                    SizedBox(
                                      width:5,
                                    ),
                                    Text(
                                      'Share',
                                      style:TextStyle(
                                        fontSize:14,
                                        fontWeight:FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),
                                onPressed:(){},
                              ),
                              SizedBox(
                                width:10,
                              ),
                              ElevatedButton(
                                style:ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF9900),),
                                child:Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children:[
                                    Icon(
                                      Icons.card_giftcard,
                                      color:Colors.white,
                                    ),
                                    SizedBox(
                                      width:5,
                                    ),
                                    Text(
                                      'Find Deals',
                                      style:TextStyle(
                                        fontSize:14,
                                        fontWeight:FontWeight.bold,
                                      ),
                                    ),


                                  ],
                                ),
                                onPressed:(){},
                              ),
                            ],
                          )
                      ),



                      //   Wrap(
                      //   alignment: WrapAlignment.center,
                      //   spacing: 12.0,
                      //   children: List<Widget>.generate(
                      //     3,
                      //         (int index) {
                      //       return ChoiceChip(
                      //         pressElevation: 0.0,
                      //         selectedColor: Colors.blue,
                      //         backgroundColor: Colors.grey[100],
                      //         label: Text("item $index"),
                      //         selected: _value == index,
                      //         onSelected: (bool selected) {
                      //           setState(() {
                      //             _value = (selected ? index : null)!;
                      //           });
                      //         },
                      //       );
                      //     },
                      //   ).toList(),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));

  }
  List<DealCat> dealCat1 = [];
  Future<List<DealCat>> onPagedataCall() async {

    showLoader1(context);

    print("https://roo.bi/api/flutter/v12.0/deal_sub_cat/" + widget.provider.type! +"/$sub_cat_id/");

    var response = await http.get(Uri.parse(/*Base_url*/ "https://roo.bi/api/flutter/v12.0/deal_sub_cat/" + widget.provider.type! +"/$sub_cat_id/"
    ), /*body: json.encode(aa),*/ headers: APIS.headers);
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      dealCat1 = responseJson.map((m) => DealCat.fromJson(m)).toList();
      Navigator.pop(context);
      setState(() {});
    } else {

      throw Exception('Failed to load post');
    }
    return dealCat1;
  }
}
