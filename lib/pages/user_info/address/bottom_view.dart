import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/style.dart';

import 'controller.dart';

class MakeDismissable extends StatelessWidget {
  const MakeDismissable({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(onTap: () {}, child: child),
    );
  }
}

class BuildSheet extends StatelessWidget {
  const BuildSheet({Key? key}) : super(key: key);
  final Color secondaryGrey = const Color(0xffBBBCC5);
  // final List<GButtonModel> items;
  @override
  Widget build(BuildContext context) {
    final screenWidth = kIsWeb ? 400 : MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<AddressListController>(
      init: AddressListController(),
      builder: (_) {
        var con = _;
        return MakeDismissable(
          child: DraggableScrollableSheet(
            initialChildSize: .90,
            builder: (a, controller) => Stack(
              children: [
                Container(
                  height: screenHeight * .80,
                  decoration: const BoxDecoration(
                    color: ColorConst.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        topRight: Radius.circular(6.0)),
                  ),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                        child: PrimaryText(
                            text: 'Select delivery address',
                            size: 16,
                            color: ColorConst.black,
                            fontWeight: FontWeight.w700)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: AppService.to.globalAaddressList.length,
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            var item = AppService.to.globalAaddressList[index];

                            return Container(
                              margin: const EdgeInsets.only(
                                  right: 25, left: 20, top: 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: item.defaultAddress
                                          ? ColorConst.green
                                          : ColorConst.grey3)
                                ],
                                color: ColorConst.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              // width:
                                              //     MediaQuery.of(context)
                                              //             .size
                                              //             .width /
                                              //         2.2,
                                              child: PrimaryText(
                                                  text:
                                                      '${item.address1}, ${item.address2}',
                                                  size: 16,
                                                  color: ColorConst.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              child: PrimaryText(
                                                  text: item.address2,
                                                  size: 16,
                                                  color: ColorConst.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              width: 80,
                                            ),
                                          ),
                                          //Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () async {
                                                if (item.defaultAddress ==
                                                    false) {
                                                  // for (var i in AppService
                                                  //     .to.globalAaddressList) {
                                                  //   if (i.defaultAddress) {
                                                  //     await _.updateIsselected(
                                                  //         i, false);
                                                  //   }
                                                  // }

                                                  await _.updateIsselected(
                                                      item, true);

                                                  AppService.to.selectedAddress
                                                      .add(item);
                                                  _.update();
                                                }
                                                Get.back();
                                              },
                                              child: Container(
                                                //alignment: Alignment.bottomRight,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: item.defaultAddress
                                                          ? ColorConst.green
                                                          : ColorConst.primary,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20),
                                                    )),
                                                child: Column(
                                                  children: [
                                                    PrimaryText(
                                                        text:
                                                            item.defaultAddress
                                                                ? 'Selected'
                                                                : 'Select',
                                                        size: 14,
                                                        color: item
                                                                .defaultAddress
                                                            ? ColorConst.green
                                                            : ColorConst
                                                                .primary,
                                                        fontWeight:
                                                            FontWeight.w700)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 150,
                    )
                  ])),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
