import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roobai/comman/constants/color_constansts.dart';

class flipkart_finder extends StatefulWidget {
  @override
  State<flipkart_finder> createState() => _flipkart_finderState();
}

class _flipkart_finderState extends State<flipkart_finder> {
  bool _switchValue = true;

  double _startValue = 0.0;
  double _endValue = 100.0;

  int? _value = 0;

  List<String> _choicesList = ['Relevance', 'Low to High', 'High to Low','NewestFirst','Popularity',];

  List<String> _StarList = ['4 Star & above','3 Star & above','2 Star & above','1 Star & above',];

  bool vertical = false;


  @override
  Widget build(BuildContext context) {

    // final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
        // backgroundColor: Color(0xFF2874f0),
        appBar: AppBar(
          backgroundColor:ColorConstants.primaryColor,
          title: Text(
            "Flipkart Deal Finder",
            style: TextStyle(fontSize: 20),
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
                LinearGradient( begin: Alignment.topCenter,end:Alignment.bottomCenter,colors: [Color(0xFF64b3f4),Color(0xFFc2e59c)]
                ),

            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  height: 800,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
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
                      //   "Flipkart Deal Finder",
                      //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "DEAL FINDER",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // CupertinoSwitch(
                          //   value: _switchValue,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _switchValue = value;
                          //     });
                          //   },
                          // ),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeColor: Colors.blue,
                              value: _switchValue,
                              onChanged: (bool value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                          ),
                          Spacer(),
                          Image.asset(
                            "assets/icons/fk_asd.png",
                            height: 60,
                            width: 90,
                          )
                        ],
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(width: 300, height: 45),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for Products, Brands or Categories',
                            hintStyle: TextStyle(fontSize: 13),
                            contentPadding: EdgeInsets.all(10.0),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(children: [
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(width: 300, height: 45),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for Products, Brands or Categories',
                                hintStyle: TextStyle(fontSize: 13),
                                contentPadding: EdgeInsets.all(10.0),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Discount between 45% and 90%",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      RangeSlider(
                        min: 0,
                        max: 100,
                        activeColor: Colors.blue,
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
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Min Price',
                                      hintStyle: TextStyle(fontSize: 13),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(width: 100, height: 45),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Max Price',
                                      hintStyle: TextStyle(fontSize: 13),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
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
                                  selectedColor: Colors.blue.shade100,
                                  backgroundColor: Colors.grey[100],
                                  label: Text(_choicesList [index],),
                                  selected: _value == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _value = selected ? index : null;
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
                              selectedColor: Colors.blue.shade100,
                              backgroundColor: Colors.grey[100],
                              label: Text(_StarList [index],),
                              selected: _value == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _value = selected ? index : null;
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
                                      fontSize:17,
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
                                  backgroundColor:Colors.blue),
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
                                      fontSize:17,
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
}
