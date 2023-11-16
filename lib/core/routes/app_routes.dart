import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/pages/auth/auth/controller.dart';
import 'package:toyskart/pages/auth/auth/view.dart';
import 'package:toyskart/pages/auth/auth/views/otp_verifiation.dart';
import 'package:toyskart/pages/checkout/controller.dart';
import 'package:toyskart/pages/checkout/view.dart';
import 'package:toyskart/pages/home/controller.dart';
import 'package:toyskart/pages/home/view.dart';
import 'package:toyskart/pages/order_placed/status.dart';
import 'package:toyskart/pages/orders/my_orders/controller.dart';
import 'package:toyskart/pages/orders/my_orders/view.dart';
import 'package:toyskart/pages/splash/controller.dart';
import 'package:toyskart/pages/splash/view.dart';
import 'package:toyskart/pages/user_info/address/controller.dart';
import 'package:toyskart/pages/user_info/address/view_list.dart';
import 'package:toyskart/pages/wish_list/controller.dart';
import 'package:toyskart/pages/wish_list/view.dart';

List<GetPage<dynamic>> appPages() {
  return [
    GetPage(
      name: RouteConst.initial,
      page: () => const SplashPage(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder.put(() => SplashPageController()),
    ),
    // GetPage(
    //   name: RouteConst.add,
    //   page: () => const AddItem(),
    //   binding: BindingsBuilder.put(() => AddItemsController()),
    // ),
    // GetPage(
    //   name: RouteConst.manageList,
    //   page: () => const ManageFoodList(),
    //   binding: BindingsBuilder.put(() => ManageFoodListController()),
    // ),
    GetPage(
      name: RouteConst.wishList,
      page: () => const WishList(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder.put(() => WishListController()),
    ),
    GetPage(
      name: RouteConst.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder.put(() => HomeController()),
    ),
    GetPage(
      name: RouteConst.checkout,
      page: () => const CheckOut(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder.put(() => CheckoutController()),
    ),
    GetPage(
      name: RouteConst.address,
      page: () => const AddressList(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder.put(() => AddressListController()),
    ),

    // GetPage(
    //   name: RouteConst.categoryList,
    //   page: () => const CategoryList(),
    //   binding: BindingsBuilder.put(() => CategoriesController()),
    // ),
    // // GetPage(
    // //   name: RouteConst.addAddress,
    // //   page: () => const AddAddress(),
    // //   binding: BindingsBuilder.put(() => AddAddressController()),
    // // ),
    // GetPage(
    //   name: RouteConst.selectLocation,
    //   page: () => const SelectLocation(),
    //   binding: BindingsBuilder.put(() => LocationController()),
    // ),
    // GetPage(
    //   name: RouteConst.chooseLocation,
    //   page: () => const ChooseLocation(),
    //   binding: BindingsBuilder.put(() => ChooseLocationController()),
    // ),
    // GetPage(
    //   name: RouteConst.checkLocation,
    //   page: () => const CheckDeliveryLocation(),
    //   binding: BindingsBuilder.put(() => CheckDeliveryLocationController()),
    // ),
    // GetPage(
    //   name: RouteConst.welcome,
    //   page: () => const WelcomePage(),
    //   children: [
    //     GetPage(
    //       name: RouteConst.walkthrough,
    //       page: () => const WalkthroughPage(),
    //       transition: Transition.topLevel,
    //       binding: BindingsBuilder.put(() => WalkthroughPageController()),
    //     ),
    //   ],
    // ),
    GetPage(
      name: RouteConst.auth,
      page: () => const AuthPage(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder.put(() => AuthPageController()),
    ),
    GetPage(
      name: RouteConst.otpVerify,
      page: () => const OtpVerifyPage(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder.put(() => AuthPageController()),
    ),
    GetPage(
      name: RouteConst.success,
      transition: Transition.fadeIn,

      page: () => const PaymentStatus(),
      //binding: BindingsBuilder.put(() => AuthPageController()),
    ),

    GetPage(
      name: RouteConst.myorder,
      page: () => const MyOrderList(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder.put(() => MyOrderListController()),
    ),

    // GetPage(
    //   name: RouteConst.checkout,
    //   page: () => const CheckOut(),
    //   transition: Transition.fadeIn,
    //   binding: BindingsBuilder.put(() => CheckoutController()),
    // ),
    // GetPage(
    //   name: RouteConst.home,
    //   page: () => const HomePage(),
    //   transition: Transition.topLevel,
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.search,
    //   page: () => const SearchPage(),
    //   transition: Transition.topLevel,
    //   middlewares: [MustAuthenticatedMiddleware()],
    //   binding: Get.isRegistered<SearchPageController>()
    //       ? null
    //       : BindingsBuilder.put(() => SearchPageController()),
    // ),
    // GetPage(
    //   name: RouteConst.myProfile,
    //   page: () => MyProfileView(
    //     userId: Get.parameters['id']!,
    //   ),
    //   transition: Transition.topLevel,
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.editProfile,
    //   page: () => const EditMyProfile(),
    //   transition: Transition.topLevel,
    //   binding: Get.isRegistered<EditMyProfileController>()
    //       ? null
    //       : BindingsBuilder.put(() => EditMyProfileController()),
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.activity,
    //   page: () => const Activities(),
    //   transition: Transition.topLevel,
    //   binding: Get.isRegistered<ActivitiesController>()
    //       ? null
    //       : BindingsBuilder.put(() => ActivitiesController()),
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.accountSettings,
    //   page: () => const AccountSettingsPage(),
    //   transition: Transition.topLevel,
    //   binding: Get.isRegistered<EditMyProfileController>()
    //       ? null
    //       : BindingsBuilder.put(() => EditMyProfileController()),
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.savedItems,
    //   page: () => const SavedItems(),
    //   transition: Transition.topLevel,
    //   // binding: Get.isRegistered<SavedItemsController>()
    //   //     ? null
    //   //     : BindingsBuilder.put(() => SavedItemsController()),
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.follower,
    //   page: () => const Followers(),
    //   transition: Transition.topLevel,
    //   binding: Get.isRegistered<FollowersController>()
    //       ? null
    //       : BindingsBuilder.put(() => FollowersController()),
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.terms,
    //   page: () => const TermsOfUse(),
    //   transition: Transition.topLevel,
    //   binding: Get.isRegistered<TermsOfUseController>()
    //       ? null
    //       : BindingsBuilder.put(() => TermsOfUseController()),
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.privacy,
    //   page: () => const PrivacyPolicy(),
    //   transition: Transition.topLevel,
    //   binding: Get.isRegistered<PrivacyPolicyController>()
    //       ? null
    //       : BindingsBuilder.put(() => PrivacyPolicyController()),
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.viewInfo,
    //   page: () => const ViewInfo(),
    //   transition: Transition.fade,
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //     name: RouteConst.chat,
    //     page: () => const ChatMessenger(),
    //     transition: Transition.topLevel,
    //     middlewares: [
    //       MustAuthenticatedMiddleware()
    //     ],
    //     children: [
    //       GetPage(
    //         name: '/:roomId',
    //         page: () => const ChatConversationPage(),
    //         transition: Transition.topLevel,
    //         middlewares: [MustAuthenticatedMiddleware()],
    //       ),
    //     ]),
    // GetPage(
    //   name: RouteConst.calendar,
    //   page: () => const EventsCalendarPage(),
    //   transition: Transition.topLevel,
    //   middlewares: [MustAuthenticatedMiddleware()],
    //   binding: Get.isRegistered<EventsCalenderController>()
    //       ? null
    //       : BindingsBuilder.put(() => EventsCalenderController()),
    // ),
    // GetPage(
    //   name: RouteConst.category,
    //   page: () => const HomeCategoriesPage(),
    //   transition: Transition.topLevel,
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.manageMySlots,
    //   page: () => const ManageMySlots(),
    //   transition: Transition.topLevel,
    //   middlewares: [MustAuthenticatedMiddleware()],
    // ),
    // GetPage(
    //   name: RouteConst.createContent,
    //   page: () => const CreateContentPage(),
    //   transition: Transition.topLevel,
    //   middlewares: [MustAuthenticatedMiddleware()],
    //   binding: Get.isRegistered<CreateContentController>()
    //       ? null
    //       : BindingsBuilder.put(() => CreateContentController()),
    // ),
  ];
}

GetPage unknownRoute() {
  return GetPage(
    name: '/404',
    page: () => const Material(
      child: Center(
        child: Text('Page not found - 404'),
      ),
    ),
  );
}
