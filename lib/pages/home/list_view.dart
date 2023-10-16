import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/global/functions/photo_url.dart';
import 'package:toyskart/pages/home/controller.dart';
import 'package:toyskart/pages/home/model/model.dart';

class ListViewPage extends GetView<HomeController> {
  const ListViewPage(
      {Key? key,
      this.listData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final ItemList? listData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('tapped 2');
      },
      child: AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation!.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 16),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: callback,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: const Offset(4, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.network(
                                  formatImageUrl(listData!.image[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Theme.of(context).backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                listData!.name,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  children: <Widget>[
                                                    // RatingBar(
                                                    //   initialRating:
                                                    //       listData!.rating,
                                                    //   direction: Axis.horizontal,
                                                    //   allowHalfRating: true,
                                                    //   itemCount: 5,
                                                    //   itemSize: 24,
                                                    //   ratingWidget: RatingWidget(
                                                    //     full: Icon(
                                                    //       Icons.star_rate_rounded,
                                                    //       color: HotelAppTheme
                                                    //               .buildLightTheme()
                                                    //           .primaryColor,
                                                    //     ),
                                                    //     half: Icon(
                                                    //       Icons.star_half_rounded,
                                                    //       color: HotelAppTheme
                                                    //               .buildLightTheme()
                                                    //           .primaryColor,
                                                    //     ),
                                                    //     empty: Icon(
                                                    //       Icons
                                                    //           .star_border_rounded,
                                                    //       color: HotelAppTheme
                                                    //               .buildLightTheme()
                                                    //           .primaryColor,
                                                    //     ),
                                                    //   ),
                                                    //   itemPadding:
                                                    //       EdgeInsets.zero,
                                                    //   onRatingUpdate: (rating) {
                                                    //     print(rating);
                                                    //   },
                                                    // ),
                                                    Text(
                                                      ' Reviews',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, top: 8),
                                      child: Text(
                                        '\u{20B9}${listData!.price}',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                                onTap: () {
                                  controller.wishListFunction(listData!);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    listData!.isWishListed
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: ColorConst.fav,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
