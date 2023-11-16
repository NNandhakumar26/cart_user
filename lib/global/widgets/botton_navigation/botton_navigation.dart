import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/pages/profile_settings/view.dart';

class BottomNavCustom extends StatefulWidget {
  BottomNavCustom({super.key, this.indexValue = 0});
  int indexValue;
  @override
  _BottomNavCustomState createState() => _BottomNavCustomState();
}

class _BottomNavCustomState extends State<BottomNavCustom> {
  //int selectedIndex = widget.indexValue;
  Color backgroundColorNav = Colors.white;

  List<NavigationItem> items = [
    NavigationItem(
      const Icon(
        Icons.home,
        color: Color.fromRGBO(91, 55, 183, 1),
      ),
      const Text(
        'Home',
        style: TextStyle(
            color: Color.fromRGBO(91, 55, 183, 1), fontWeight: FontWeight.bold),
      ),
      const Color.fromRGBO(223, 215, 243, 1),
    ),
    NavigationItem(
        const Icon(
          Icons.favorite,
          color: ColorConst.fav,
        ),
        const Text(
          'Favorite',
          style: TextStyle(color: ColorConst.fav, fontWeight: FontWeight.bold),
        ),
        const Color.fromRGBO(244, 211, 235, 1)),
    NavigationItem(
        const Icon(
          Icons.list_alt,
          color: Color.fromRGBO(230, 169, 25, 1),
        ),
        const Text(
          'Orders',
          style: TextStyle(
              color: Color.fromRGBO(230, 169, 25, 1),
              fontWeight: FontWeight.bold),
        ),
        const Color.fromRGBO(251, 239, 211, 1)),
    NavigationItem(
        const Icon(Icons.manage_accounts_rounded,
            color: Color.fromRGBO(17, 148, 170, 1)),
        const Text(
          'Settings',
          style: TextStyle(
              color: Color.fromRGBO(17, 148, 170, 1),
              fontWeight: FontWeight.bold),
        ),
        const Color.fromRGBO(211, 235, 239, 1))
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 50,
      width: isSelected ? 120 : 50,
      padding: isSelected ? const EdgeInsets.only(left: 16, right: 16) : null,
      decoration: isSelected
          ? BoxDecoration(
              color: item.color,
              borderRadius: const BorderRadius.all(Radius.circular(50)))
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                  size: 24,
                  color: isSelected ? backgroundColorNav : Colors.black,
                ),
                child: item.icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: isSelected
                    ? DefaultTextStyle.merge(
                        style: TextStyle(color: backgroundColorNav),
                        child: item.title)
                    : Container(),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          //var itemIndex = widget.indexValue;
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () async {
              if (widget.indexValue == itemIndex) {
                return;
              }
              if (itemIndex <= 2) {
                setState(() {
                  widget.indexValue = itemIndex;
                });
              }
              if (itemIndex == 0) {
                // await delay(100);
                // setState(() {
                //   selectedIndex = widget.indexValue;
                // });

                Get.offNamed(RouteConst.home);
                print('Index is 0');
                return;
              } else if (itemIndex == 1) {
                // await delay(100);

                // setState(() {
                //   selectedIndex = widget.indexValue;
                // });

                Get.offAllNamed(RouteConst.wishList);
                return;

                print('Index is 1');
              } else if (itemIndex == 2) {
                // await delay(100);

                // setState(() {
                //   selectedIndex = widget.indexValue;
                // });

                Get.offAllNamed(RouteConst.myorder);
                return;

                print('Index is 1');
              } else if (itemIndex == 3) {
                Get.bottomSheet(const ProfileSettingsPage());
              }
            },
            child: _buildItem(item, widget.indexValue == (itemIndex)),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color color;

  NavigationItem(this.icon, this.title, this.color);
}
