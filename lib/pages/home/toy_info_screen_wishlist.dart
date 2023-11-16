import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/global/app_back_button.dart';
import 'package:toyskart/global/app_cart_button.dart';
import 'package:toyskart/global/functions/photo_url.dart';
import 'package:toyskart/pages/home/model/model.dart';
import 'package:toyskart/pages/wish_list/controller.dart';

class ToyInfoScreenWishList extends StatefulWidget {
  const ToyInfoScreenWishList({super.key, required this.listData});

  final ItemList? listData;

  @override
  _ToyInfoScreenWishListState createState() => _ToyInfoScreenWishListState();
}

class _ToyInfoScreenWishListState extends State<ToyInfoScreenWishList>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  final imageViewPageController = PageController();
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  // SmoothPageIndicator(

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 0.30) +
        24.0;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorConst.primary,
          leading: const AppBackButton(),
          actions: const [AppCartButton()],
        ),
        body: GetBuilder<WishListController>(
          //  initState: (_) {},
          builder: (_) {
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        allowImplicitScrolling: true,
                        controller: imageViewPageController,
                        padEnds: false,
                        itemCount: widget.listData!.image.length,
                        itemBuilder: (c, i) {
                          var m = widget.listData!.image[i];

                          return CachedNetworkImage(
                            cacheKey: m,
                            key: ValueKey<String>(m),
                            useOldImageOnUrlChange: true,
                            fit: BoxFit.cover,
                            // placeholder: (context, url) => Center(
                            //     child: Text(
                            //   widget.listData!.name.toUpperCase(),
                            //   style: const TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 48 / 2,
                            //   ),
                            // )),
                            imageUrl: m == null ? '' : formatImageUrl(m),
                            errorWidget: (context, url, error) {
                              return Center(
                                  child: Text(
                                widget.listData!.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 48 / 2,
                                ),
                              ));
                            },
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: ColorConst.primary.withOpacity(.4),
                              ),
                            ),
                            fadeOutDuration: Duration.zero,
                            fadeInDuration: Duration.zero,
                            height: 48,
                            width: 48,
                            imageBuilder: (context, imageProvider) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AspectRatio(
                                aspectRatio: 4 / 2,
                                child: Image(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SmoothPageIndicator(
                        controller: imageViewPageController,
                        count: widget.listData!.image.length,
                        effect: const ScrollingDotsEffect(
                          activeDotColor: ColorConst.primary,
                          activeStrokeWidth: 2.6,
                          maxVisibleDots: 9,
                          radius: 8,
                          dotHeight: 6,
                          dotWidth: 6,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: ColorConst.grey3.withOpacity(0.8),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SingleChildScrollView(
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: infoHeight,
                              // maxHeight: tempHeight > infoHeight
                              //     ? tempHeight
                              //     : infoHeight
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 32.0, left: 18, right: 16),
                                      child: Text(
                                        widget.listData!.name,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: ColorConst.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 32.0, left: 18, right: 16),
                                      child: InkWell(
                                        onTap: () {
                                          _.wishListFunction(widget.listData!);
                                        },
                                        child: ScaleTransition(
                                          alignment: Alignment.center,
                                          scale: CurvedAnimation(
                                              parent: animationController!,
                                              curve: Curves.fastOutSlowIn),
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Center(
                                              child: Icon(
                                                widget.listData!.isWishListed
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: ColorConst.fav,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 8, top: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '\u{20B9}${widget.listData!.price}',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: ColorConst.primary,
                                        ),
                                      ),
                                      const Row(
                                        children: <Widget>[
                                          Text(
                                            '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 22,
                                              letterSpacing: 0.27,
                                              color: ColorConst.grey3,
                                            ),
                                          ),
                                          // Icon(
                                          //   Icons.star,
                                          //   color: ColorConst.primary,
                                          //   size: 24,
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // AnimatedOpacity(
                                //   duration: const Duration(milliseconds: 500),
                                //   opacity: opacity1,
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8),
                                //     child: Row(
                                //       children: <Widget>[
                                //         getTimeBoxUI('24', 'Classe'),
                                //         getTimeBoxUI('2hours', 'Time'),
                                //         getTimeBoxUI('24', 'Seat'),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: ReadMoreText(
                                      widget.listData!.description,
                                      trimLines: 2,
                                      colorClickableText:
                                          ColorConst.primary.withOpacity(0.8),
                                      trimExpandedText: 'Read less',
                                      trimCollapsedText: 'Read more',
                                      trimMode: TrimMode.Line,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.6,
                                        color: ColorConst.black,
                                      ),
                                    ),
                                    //  Text(
                                    //   widget.listData!.description,
                                    //   textAlign: TextAlign.justify,
                                    //   style: const TextStyle(
                                    //     fontWeight: FontWeight.w200,
                                    //     fontSize: 14,
                                    //     letterSpacing: 0.27,
                                    //     color: ColorConst.black,
                                    //   ),
                                    //   maxLines: 3,
                                    //   overflow: TextOverflow.ellipsis,
                                    // ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 75,
                                ),
                                // AnimatedOpacity(
                                //   duration: const Duration(milliseconds: 500),
                                //   opacity: opacity3,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(
                                //         left: 16, bottom: 16, right: 16),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       children: <Widget>[
                                //         Expanded(
                                //           flex: 2,
                                //           child: InkWell(
                                //             onTap: () async {
                                //               if (widget.listData!.cartCount ==
                                //                       0 &&
                                //                   widget.listData!.stockCount >
                                //                       0) {
                                //                 await _.addToCart(
                                //                     widget.listData!, true);
                                //               }
                                //             },
                                //             child: Container(
                                //               alignment: Alignment.bottomRight,
                                //               padding: const EdgeInsets.symmetric(
                                //                   horizontal: 10, vertical: 0),
                                //               height: 48,
                                //               decoration: BoxDecoration(
                                //                 color: ColorConst.primary,
                                //                 borderRadius:
                                //                     const BorderRadius.all(
                                //                   Radius.circular(16.0),
                                //                 ),
                                //                 boxShadow: <BoxShadow>[
                                //                   BoxShadow(
                                //                       color: ColorConst.primary
                                //                           .withOpacity(0.5),
                                //                       offset:
                                //                           const Offset(1.1, 1.1),
                                //                       blurRadius: 10.0),
                                //                 ],
                                //               ),
                                //               child: Column(
                                //                 children: [
                                //                   Center(
                                //                     child: Visibility(
                                //                       visible: widget.listData!
                                //                               .cartCount ==
                                //                           0,
                                //                       child: TextButton(
                                //                         onPressed: () async {
                                //                           if (widget.listData!
                                //                                   .stockCount >
                                //                               0) {
                                //                             await _.addToCart(
                                //                                 widget.listData!,
                                //                                 true);
                                //                           }
                                //                         },
                                //                         child: Text(
                                //                           widget.listData!
                                //                                       .stockCount >
                                //                                   0
                                //                               ? 'Add to cart'
                                //                               : 'Out of stock',
                                //                           style: const TextStyle(
                                //                               color: ColorConst
                                //                                   .white,
                                //                               fontSize: 18,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w600),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ),
                                //                   Visibility(
                                //                     visible: widget
                                //                             .listData!.cartCount >
                                //                         0,
                                //                     child: Row(
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment
                                //                               .spaceBetween,
                                //                       crossAxisAlignment:
                                //                           CrossAxisAlignment
                                //                               .center,
                                //                       children: [
                                //                         IconButton(
                                //                           icon: const Icon(
                                //                             Icons
                                //                                 .remove_circle_outline,
                                //                             color:
                                //                                 ColorConst.white,
                                //                           ),
                                //                           onPressed: () async {
                                //                             if (widget.listData!
                                //                                     .cartCount >
                                //                                 0) {
                                //                               await _.addToCart(
                                //                                   widget
                                //                                       .listData!,
                                //                                   false);
                                //                             }
                                //                           },
                                //                         ),
                                //                         Text(
                                //                           widget
                                //                               .listData!.cartCount
                                //                               .toString(),
                                //                           style: const TextStyle(
                                //                               color: ColorConst
                                //                                   .white,
                                //                               fontSize: 18,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w600),
                                //                         ),
                                //                         IconButton(
                                //                           icon: const Icon(
                                //                             Icons
                                //                                 .add_circle_outline,
                                //                             color:
                                //                                 ColorConst.white,
                                //                           ),
                                //                           onPressed: () async {
                                //                             await _.addToCart(
                                //                                 widget.listData!,
                                //                                 true);
                                //                           },
                                //                         )
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: MediaQuery.of(context).padding.bottom,
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Positioned(
                //   top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child:
                //    Container(
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).backgroundColor,
                //       borderRadius: const BorderRadius.only(
                //           topLeft: Radius.circular(32.0),
                //           topRight: Radius.circular(32.0)),
                //       boxShadow: <BoxShadow>[
                //         BoxShadow(
                //             color: ColorConst.grey3.withOpacity(0.8),
                //             offset: const Offset(1.1, 1.1),
                //             blurRadius: 10.0),
                //       ],
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 8, right: 8),
                //       child: SingleChildScrollView(
                //         child: Container(
                //           constraints: BoxConstraints(
                //             minHeight: infoHeight,
                //             // maxHeight: tempHeight > infoHeight
                //             //     ? tempHeight
                //             //     : infoHeight
                //           ),
                //           child: Column(
                //             //mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 32.0, left: 18, right: 16),
                //                     child: Text(
                //                       widget.listData!.name,
                //                       textAlign: TextAlign.left,
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.w600,
                //                         fontSize: 22,
                //                         letterSpacing: 0.27,
                //                         color: ColorConst.black,
                //                       ),
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 32.0, left: 18, right: 16),
                //                     child: InkWell(
                //                       onTap: () {
                //                         _.wishListFunction(widget.listData!);
                //                       },
                //                       child: ScaleTransition(
                //                         alignment: Alignment.center,
                //                         scale: CurvedAnimation(
                //                             parent: animationController!,
                //                             curve: Curves.fastOutSlowIn),
                //                         child: SizedBox(
                //                           width: 40,
                //                           height: 40,
                //                           child: Center(
                //                             child: Icon(
                //                               widget.listData!.isWishListed
                //                                   ? Icons.favorite
                //                                   : Icons.favorite_border,
                //                               color: ColorConst.fav,
                //                               size: 30,
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   )
                //                 ],
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.only(
                //                     left: 16, right: 16, bottom: 8, top: 16),
                //                 child: Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: <Widget>[
                //                     Text(
                //                       '\u{20B9}${widget.listData!.price}',
                //                       textAlign: TextAlign.left,
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.w200,
                //                         fontSize: 22,
                //                         letterSpacing: 0.27,
                //                         color: ColorConst.primary,
                //                       ),
                //                     ),
                //                     Row(
                //                       children: const <Widget>[
                //                         Text(
                //                           '',
                //                           textAlign: TextAlign.left,
                //                           style: TextStyle(
                //                             fontWeight: FontWeight.w200,
                //                             fontSize: 22,
                //                             letterSpacing: 0.27,
                //                             color: ColorConst.grey3,
                //                           ),
                //                         ),
                //                         // Icon(
                //                         //   Icons.star,
                //                         //   color: ColorConst.primary,
                //                         //   size: 24,
                //                         // ),
                //                       ],
                //                     )
                //                   ],
                //                 ),
                //               ),
                //               // AnimatedOpacity(
                //               //   duration: const Duration(milliseconds: 500),
                //               //   opacity: opacity1,
                //               //   child: Padding(
                //               //     padding: const EdgeInsets.all(8),
                //               //     child: Row(
                //               //       children: <Widget>[
                //               //         getTimeBoxUI('24', 'Classe'),
                //               //         getTimeBoxUI('2hours', 'Time'),
                //               //         getTimeBoxUI('24', 'Seat'),
                //               //       ],
                //               //     ),
                //               //   ),
                //               // ),
                //               AnimatedOpacity(
                //                 duration: const Duration(milliseconds: 500),
                //                 opacity: opacity2,
                //                 child: Padding(
                //                   padding: const EdgeInsets.only(
                //                       left: 16, right: 16, top: 8, bottom: 8),
                //                   child: ReadMoreText(
                //                     widget.listData!.description,
                //                     trimLines: 2,
                //                     colorClickableText:
                //                         ColorConst.primary.withOpacity(0.8),
                //                     trimExpandedText: 'Read less',
                //                     trimCollapsedText: 'Read more',
                //                     trimMode: TrimMode.Line,
                //                     textAlign: TextAlign.justify,
                //                     style: const TextStyle(
                //                       fontWeight: FontWeight.w200,
                //                       fontSize: 14,
                //                       letterSpacing: 0.6,
                //                       color: ColorConst.black,
                //                     ),
                //                   ),
                //                   //  Text(
                //                   //   widget.listData!.description,
                //                   //   textAlign: TextAlign.justify,
                //                   //   style: const TextStyle(
                //                   //     fontWeight: FontWeight.w200,
                //                   //     fontSize: 14,
                //                   //     letterSpacing: 0.27,
                //                   //     color: ColorConst.black,
                //                   //   ),
                //                   //   maxLines: 3,
                //                   //   overflow: TextOverflow.ellipsis,
                //                   // ),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 75,
                //               ),
                //               // AnimatedOpacity(
                //               //   duration: const Duration(milliseconds: 500),
                //               //   opacity: opacity3,
                //               //   child: Padding(
                //               //     padding: const EdgeInsets.only(
                //               //         left: 16, bottom: 16, right: 16),
                //               //     child: Row(
                //               //       mainAxisAlignment: MainAxisAlignment.center,
                //               //       crossAxisAlignment:
                //               //           CrossAxisAlignment.center,
                //               //       children: <Widget>[
                //               //         Expanded(
                //               //           flex: 2,
                //               //           child: InkWell(
                //               //             onTap: () async {
                //               //               if (widget.listData!.cartCount ==
                //               //                       0 &&
                //               //                   widget.listData!.stockCount >
                //               //                       0) {
                //               //                 await _.addToCart(
                //               //                     widget.listData!, true);
                //               //               }
                //               //             },
                //               //             child: Container(
                //               //               alignment: Alignment.bottomRight,
                //               //               padding: const EdgeInsets.symmetric(
                //               //                   horizontal: 10, vertical: 0),
                //               //               height: 48,
                //               //               decoration: BoxDecoration(
                //               //                 color: ColorConst.primary,
                //               //                 borderRadius:
                //               //                     const BorderRadius.all(
                //               //                   Radius.circular(16.0),
                //               //                 ),
                //               //                 boxShadow: <BoxShadow>[
                //               //                   BoxShadow(
                //               //                       color: ColorConst.primary
                //               //                           .withOpacity(0.5),
                //               //                       offset:
                //               //                           const Offset(1.1, 1.1),
                //               //                       blurRadius: 10.0),
                //               //                 ],
                //               //               ),
                //               //               child: Column(
                //               //                 children: [
                //               //                   Center(
                //               //                     child: Visibility(
                //               //                       visible: widget.listData!
                //               //                               .cartCount ==
                //               //                           0,
                //               //                       child: TextButton(
                //               //                         onPressed: () async {
                //               //                           if (widget.listData!
                //               //                                   .stockCount >
                //               //                               0) {
                //               //                             await _.addToCart(
                //               //                                 widget.listData!,
                //               //                                 true);
                //               //                           }
                //               //                         },
                //               //                         child: Text(
                //               //                           widget.listData!
                //               //                                       .stockCount >
                //               //                                   0
                //               //                               ? 'Add to cart'
                //               //                               : 'Out of stock',
                //               //                           style: const TextStyle(
                //               //                               color: ColorConst
                //               //                                   .white,
                //               //                               fontSize: 18,
                //               //                               fontWeight:
                //               //                                   FontWeight
                //               //                                       .w600),
                //               //                         ),
                //               //                       ),
                //               //                     ),
                //               //                   ),
                //               //                   Visibility(
                //               //                     visible: widget
                //               //                             .listData!.cartCount >
                //               //                         0,
                //               //                     child: Row(
                //               //                       mainAxisAlignment:
                //               //                           MainAxisAlignment
                //               //                               .spaceBetween,
                //               //                       crossAxisAlignment:
                //               //                           CrossAxisAlignment
                //               //                               .center,
                //               //                       children: [
                //               //                         IconButton(
                //               //                           icon: const Icon(
                //               //                             Icons
                //               //                                 .remove_circle_outline,
                //               //                             color:
                //               //                                 ColorConst.white,
                //               //                           ),
                //               //                           onPressed: () async {
                //               //                             if (widget.listData!
                //               //                                     .cartCount >
                //               //                                 0) {
                //               //                               await _.addToCart(
                //               //                                   widget
                //               //                                       .listData!,
                //               //                                   false);
                //               //                             }
                //               //                           },
                //               //                         ),
                //               //                         Text(
                //               //                           widget
                //               //                               .listData!.cartCount
                //               //                               .toString(),
                //               //                           style: const TextStyle(
                //               //                               color: ColorConst
                //               //                                   .white,
                //               //                               fontSize: 18,
                //               //                               fontWeight:
                //               //                                   FontWeight
                //               //                                       .w600),
                //               //                         ),
                //               //                         IconButton(
                //               //                           icon: const Icon(
                //               //                             Icons
                //               //                                 .add_circle_outline,
                //               //                             color:
                //               //                                 ColorConst.white,
                //               //                           ),
                //               //                           onPressed: () async {
                //               //                             await _.addToCart(
                //               //                                 widget.listData!,
                //               //                                 true);
                //               //                           },
                //               //                         )
                //               //                       ],
                //               //                     ),
                //               //                   ),
                //               //                 ],
                //               //               ),
                //               //             ),
                //               //           ),
                //               //         )
                //               //       ],
                //               //     ),
                //               //   ),
                //               // ),
                //               // SizedBox(
                //               //   height: MediaQuery.of(context).padding.bottom,
                //               // )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                //   right: 35,
                //   child: InkWell(
                //     onTap: () {
                //       _.wishListFunction(widget.listData!);
                //     },
                //     child: ScaleTransition(
                //       alignment: Alignment.center,
                //       scale: CurvedAnimation(
                //           parent: animationController!,
                //           curve: Curves.fastOutSlowIn),
                //       child: Card(
                //         color: widget.listData!.isWishListed
                //             ? ColorConst.white
                //             : ColorConst.fav,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(50.0)),
                //         shadowColor: ColorConst.grey3.withOpacity(1),
                //         elevation: 10.0,
                //         child: SizedBox(
                //           width: 60,
                //           height: 60,
                //           child: Center(
                //             child: Icon(
                //               Icons.favorite,
                //               color: widget.listData!.isWishListed
                //                   ? ColorConst.fav
                //                   : ColorConst.white,
                //               size: 30,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, bottom: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () async {
                                if (widget.listData!.cartCount == 0 &&
                                    widget.listData!.stockCount > 0) {
                                  await _.addToCart(widget.listData!, true);
                                }
                              },
                              child: Container(
                                alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: ColorConst.primary,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color:
                                            ColorConst.primary.withOpacity(0.5),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Visibility(
                                        visible:
                                            widget.listData!.cartCount == 0,
                                        child: TextButton(
                                          onPressed: () async {
                                            if (widget.listData!.stockCount >
                                                0) {
                                              await _.addToCart(
                                                  widget.listData!, true);
                                            }
                                          },
                                          child: Text(
                                            widget.listData!.stockCount > 0
                                                ? 'Add to cart'
                                                : 'Out of stock',
                                            style: const TextStyle(
                                                color: ColorConst.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.listData!.cartCount > 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: ColorConst.white,
                                            ),
                                            onPressed: () async {
                                              if (widget.listData!.cartCount >
                                                  0) {
                                                await _.addToCart(
                                                    widget.listData!, false);
                                              }
                                            },
                                          ),
                                          Text(
                                            widget.listData!.cartCount
                                                .toString(),
                                            style: const TextStyle(
                                                color: ColorConst.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              color: ColorConst.white,
                                            ),
                                            onPressed: () async {
                                              await _.addToCart(
                                                  widget.listData!, true);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: ColorConst.grey3.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ColorConst.primary,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ColorConst.grey3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
