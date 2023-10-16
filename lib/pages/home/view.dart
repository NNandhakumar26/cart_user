import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/global/app_cart_button.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/functions/willpop.dart';
import 'package:toyskart/global/widgets/botton_navigation/botton_navigation.dart';
import 'package:toyskart/pages/home/controller.dart';
import 'package:toyskart/pages/home/list_view.dart';
import 'package:toyskart/pages/home/toy_info_screen.dart';

import 'filters_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;

  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context),
        child: WillPopScope(
          onWillPop: () async {
            return backPressed(context);
          },
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: ColorConst.primary,
                leading: const SizedBox.square(),
                title: const Text(
                  'Explore',
                ),
                actions: const [AppCartButton()],
              ),
              bottomNavigationBar: SizedBox(
                height: 70,
                child: BottomNavCustom(indexValue: 0),
              ),
              body: GetBuilder<HomeController>(
                //init: MyController(),
                initState: (_) {},
                builder: (_) {
                  if (_.itemsList.isEmpty) {
                    return Obx(() => Center(
                          child: Container(
                              height: 100,
                              margin: const EdgeInsets.only(
                                  top: 0, left: 0, bottom: 0),
                              child: AppService.to.inRequest()
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Center(
                                            child: JumpingDotsProgressIndicator(
                                          numberOfDots: 4,
                                          fontSize: 60.0,
                                          color: ColorConst.primary,
                                        )),
                                      ),
                                    )
                                  : Text(
                                      'No Items Found',
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xffB3B3BF)),
                                    )),
                        ));
                  }
                  return Stack(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Column(
                          children: <Widget>[
                            getAppBarUI(),
                            Expanded(
                              child: NestedScrollView(
                                controller: _scrollController,
                                headerSliverBuilder: (BuildContext context,
                                    bool innerBoxIsScrolled) {
                                  return <Widget>[
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: const <Widget>[
                                            // getSearchBarUI(),
                                          ],
                                        );
                                      }, childCount: 1),
                                    ),
                                    SliverPersistentHeader(
                                      pinned: true,
                                      floating: true,
                                      delegate: ContestTabHeader(
                                        getFilterBarUI(),
                                      ),
                                    ),
                                  ];
                                },
                                body: Container(
                                  color: Theme.of(context).backgroundColor,
                                  child: ListView.builder(
                                    itemCount: _.itemsList.length,
                                    padding: const EdgeInsets.only(top: 8),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final int count = _.itemsList.length > 10
                                          ? 10
                                          : _.itemsList.length;
                                      final Animation<double> animation =
                                          Tween<double>(begin: 0.0, end: 1.0)
                                              .animate(CurvedAnimation(
                                                  parent: animationController!,
                                                  curve: Interval(
                                                      (1 / count) * index, 1.0,
                                                      curve: Curves
                                                          .fastOutSlowIn)));
                                      animationController?.forward();
                                      return ListViewPage(
                                        callback: () {
                                          Get.to(() => ToyInfoScreen(
                                                listData: _.itemsList[index],
                                              ));
                                        },
                                        listData: _.itemsList[index],
                                        animation: animation,
                                        animationController:
                                            animationController!,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )),
        ));
  }

  // Widget getListUI() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).backgroundColor,
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Colors.grey.withOpacity(0.2),
  //             offset: const Offset(0, -2),
  //             blurRadius: 8.0),
  //       ],
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(
  //           height: MediaQuery.of(context).size.height - 156 - 50,
  //           child: FutureBuilder<bool>(
  //             future: getData(),
  //             builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
  //               if (!snapshot.hasData) {
  //                 return const SizedBox();
  //               } else {
  //                 return ListView.builder(
  //                   itemCount: itemsList.length,
  //                   scrollDirection: Axis.vertical,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     final int count =
  //                         itemsList.length > 10 ? 10 : itemsList.length;
  //                     final Animation<double> animation =
  //                         Tween<double>(begin: 0.0, end: 1.0).animate(
  //                             CurvedAnimation(
  //                                 parent: animationController!,
  //                                 curve: Interval((1 / count) * index, 1.0,
  //                                     curve: Curves.fastOutSlowIn)));
  //                     animationController?.forward();

  //                     return itemsListView(
  //                       callback: () {},
  //                       hotelData: itemsList[index],
  //                       animation: animation,
  //                       animationController: animationController!,
  //                     );
  //                   },
  //                 );
  //               }
  //             },
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget getHotelViewList() {
  //   final List<Widget> itemsListViews = <Widget>[];
  //   for (int i = 0; i < itemsList.length; i++) {
  //     final int count = itemsList.length;
  //     final Animation<double> animation =
  //         Tween<double>(begin: 0.0, end: 1.0).animate(
  //       CurvedAnimation(
  //         parent: animationController!,
  //         curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
  //       ),
  //     );
  //     itemsListViews.add(
  //       itemsListView(
  //         callback: () {},
  //         hotelData: itemsList[i],
  //         animation: animation,
  //         animationController: animationController!,
  //       ),
  //     );
  //   }
  //   animationController?.forward();
  //   return Column(
  //     children: itemsListViews,
  //   );
  // }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.search,
                      size: 20, color: Theme.of(context).backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '', // '${itemsList.length} result(s) found',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  void showDemoDialog({BuildContext? context}) {
    // showDialog<dynamic>(
    //   context: context!,
    //   builder: (BuildContext context) => CalendarPopupView(
    //     barrierDismissible: true,
    //     minimumDate: DateTime.now(),
    //     //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
    //     initialEndDate: endDate,
    //     initialStartDate: startDate,
    //     onApplyClick: (DateTime startData, DateTime endData) {
    //       setState(() {
    //         startDate = startData;
    //         endDate = endData;
    //       });
    //     },
    //     onCancelClick: () {},
    //   ),
    // );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: SizedBox(
        //   width: AppBar().preferredSize.height + 40,
        //height: AppBar().preferredSize.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
