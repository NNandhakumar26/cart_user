import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/pages/home/controller.dart';

import 'model/popular_filter_list.dart';
import 'range_slider_view.dart';
import 'slider_view.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<PopularFilterListData> popularFilterListData =
      PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData =
      PopularFilterListData.accomodationList;

  double distValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      // init: MyController(),
      initState: (_) {},
      builder: (_) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                getAppBarUI(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Price',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width > 360
                                            ? 18
                                            : 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            RangeSliderView(
                              values: _.values,
                              onChangeRangeValues: (RangeValues values) {
                                _.values = values;
                                _.update();
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                        const Divider(
                          height: 1,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16, bottom: 8),
                              child: Text(
                                'Categories',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width > 360
                                            ? 18
                                            : 16,
                                    fontWeight: FontWeight.normal),
                              ),

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(right: 16, left: 16),
                              //   child: Column(children: [
                              //     TextButton(
                              //         onPressed: () {
                              //               AlertDialog(
                              //       title: const Text('Select Topics'),
                              //       content: SingleChildScrollView(
                              //         child: ListBody(
                              //           children: _.categoryList
                              //               .map((item) => CheckboxListTile(
                              //                     value: _.selectedItems
                              //                         .contains(item),
                              //                     title: Text(item.name),
                              //                     controlAffinity:
                              //                         ListTileControlAffinity
                              //                             .leading,
                              //                     onChanged: (isChecked) =>
                              //                         _.itemChange(
                              //                             item, isChecked!),
                              //                   ))
                              //               .toList(),
                              //         ),
                              //       ),
                              //       actions: [
                              //         TextButton(
                              //           onPressed: _.cancel,
                              //           child: const Text('Cancel'),
                              //         ),
                              //         ElevatedButton(
                              //           onPressed: _.submit,
                              //           child: const Text('Submit'),
                              //         ),
                              //       ],
                              //     )

                              //         },
                              //         child: const Text('Select Category'))

                              //   ]),
                            ),
                            // MultiSelectChipField(
                            //   items: _.categoryList,
                            //   initialValue: const [],
                            //   title: const Text("Categories"),
                            //   headerColor: Colors.blue.withOpacity(0.5),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //         color: ColorConst.primary, width: 1.8),
                            //   ),
                            //   selectedChipColor: Colors.blue.withOpacity(0.5),
                            //   selectedTextStyle:
                            //       TextStyle(color: Colors.blue[800]),
                            //   onTap: (values) {
                            //     //_selectedAnimals4 = values;
                            //   },
                            // ),
                            // const SizedBox(height: 40),
                            // //################################################################################################
                            // // MultiSelectDialogField with initial values
                            // //################################################################################################
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 16, left: 16),
                              child: MultiSelectDialogField(
                                searchable: true,
                                dialogHeight: 300,
                                searchHint: 'Select Categories',
                                title: const Text("Categories"),
                                unselectedColor: ColorConst.primary,
                                selectedColor: ColorConst.primary,
                                onConfirm: (val) {
                                  _.selectedItems = val;
                                },
                                dialogWidth:
                                    MediaQuery.of(context).size.width * 0.5,
                                items: _.categoryList,
                                initialValue: _
                                    .selectedItems, // setting the value of this in initState() to pre-select values.
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                        const Divider(
                          height: 1,
                        ),
                        // distanceViewUI(),
                        // const Divider(
                        //   height: 1,
                        // ),
                        // allAccommodationUI()
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 8),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          blurRadius: 8,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24.0)),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                          _.getItems();
                        },
                        child: const Center(
                          child: Text(
                            'Apply',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Type of Accommodation',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < accomodationListData.length; i++) {
      final PopularFilterListData date = accomodationListData[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date.titleTxt,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: date.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(
          height: 1,
        ));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (accomodationListData[0].isSelected) {
        for (var d in accomodationListData) {
          d.isSelected = false;
        }
      } else {
        for (var d in accomodationListData) {
          d.isSelected = true;
        }
      }
    } else {
      accomodationListData[index].isSelected =
          !accomodationListData[index].isSelected;

      int count = 0;
      for (int i = 0; i < accomodationListData.length; i++) {
        if (i != 0) {
          final PopularFilterListData data = accomodationListData[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == accomodationListData.length - 1) {
        accomodationListData[0].isSelected = true;
      } else {
        accomodationListData[0].isSelected = false;
      }
    }
  }

  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Distance from city center',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        SliderView(
          distValue: distValue,
          onChangedistValue: (double value) {
            distValue = value;
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  // Widget popularFilter() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding:
  //             const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
  //         child: Text(
  //           'Categories',
  //           textAlign: TextAlign.left,
  //           style: TextStyle(
  //               color: Colors.grey,
  //               fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
  //               fontWeight: FontWeight.normal),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(right: 16, left: 16),
  //         child: Column(
  //           children:[AlertDialog(
  //     title: const Text('Select Topics'),
  //     content: SingleChildScrollView(
  //       child: ListBody(
  //         children:
  //             .map((item) => CheckboxListTile(
  //                   value: _selectedItems.contains(item),
  //                   title: Text(item),
  //                   controlAffinity: ListTileControlAffinity.leading,
  //                   onChanged: (isChecked) => _itemChange(item, isChecked!),
  //                 ))
  //             .toList(),
  //       ),
  //     ),
  //     actions: [
  //       TextButton(
  //         onPressed: _cancel,
  //         child: const Text('Cancel'),
  //       ),
  //       ElevatedButton(
  //         onPressed: _submit,
  //         child: const Text('Submit'),
  //       ),
  //     ],
  //   );]
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 8,
  //       )
  //     ],
  //   );
  // }

  List<Widget> getPList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < popularFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final PopularFilterListData date = popularFilterListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        date.isSelected = !date.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            date.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: date.isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            date.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < popularFilterListData.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  // Widget priceBarFilter() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Text(
  //           'Price',
  //           textAlign: TextAlign.left,
  //           style: TextStyle(
  //               color: Colors.grey,
  //               fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
  //               fontWeight: FontWeight.normal),
  //         ),
  //       ),
  //       RangeSliderView(
  //         values: _values,
  //         onChangeRangeValues: (RangeValues values) {
  //           _values = values;
  //         },
  //       ),
  //       const SizedBox(
  //         height: 8,
  //       )
  //     ],
  //   );
  // }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Filters',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
