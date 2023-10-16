import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toyskart/global/functions/user_model.dart';
import 'package:toyskart/global/model.dart';
import 'package:toyskart/pages/cart/model.dart';
//import 'package:toyskart/pages/categories/model.dart';
import 'package:toyskart/pages/user_info/address/model.dart';

class AppService extends GetxService {
  static AppService get to => Get.find<AppService>();

  User? get fireUser => FirebaseAuth.instance.currentUser;
  RxList<AddressModel> globalAaddressList = <AddressModel>[].obs;
  RxList<AddressModel> selectedAddress = <AddressModel>[].obs;
  RxList<CategoryModel> globalCategoriesList = <CategoryModel>[].obs;
  RxList<CartListModel> globalCartList = <CartListModel>[].obs;
  RxList<UserModel> loggedUser = <UserModel>[].obs;
  //UserModel? user;
  RxInt globalCartCount = 0.obs;
  RxInt globalCartItems = 0.obs;
  // FirebaseFirestore db = FirebaseFirestore.instance;
  String? _idToken = '';

  DateTime _idTokenExpiry = DateTime.now();

  Future<String> idToken() async {
    if (_idToken!.isEmpty || _idTokenExpiry.isBefore(DateTime.now())) {
      _idToken = await fireUser!.getIdToken(true);
      print(_idToken);
      _idTokenExpiry = DateTime.now().add(const Duration(seconds: 3600000));
    }

    return _idToken!;
  }

  /// `redirectUri` holds url / page name to be redirected.
  ///
  /// after [login / splash / deep link]
  Uri? redirectUri;

  final RxBool inRequest = false.obs;

  LatLng location = const LatLng(0, 0);
  String streetAddress = "";

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        _idToken = await user.getIdToken(true);
      } else {
        _idToken = '';
      }
    });
    super.onInit();
  }
}
