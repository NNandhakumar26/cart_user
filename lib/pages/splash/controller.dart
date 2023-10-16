import 'package:get/get.dart';
import 'package:toyskart/core/constants/api.dart';
import 'package:toyskart/core/services/api/data_api.dart';
import 'package:toyskart/core/utils/misc.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/functions/global_functions.dart';
import 'package:toyskart/global/functions/user_model.dart';
import 'package:toyskart/pages/user_info/address/model.dart';

import '../../core/constants/routes.dart';

class SplashPageController extends GetxController {
  var app = AppService.to;
  //GlobalKey<FormState> formkey = GlobalKey<FormState>();
  fistLoad() async {
    await load();
  }

  @override
  void onInit() {
    load();
    //logout();
    super.onInit();
  }

  load() async {
    if (app.fireUser == null) {
      await delay(1500);
      Get.offAllNamed(RouteConst.auth);
      return;
    }
    var api = DataApiService<List>(
      'auth/signIn',
      msgToast: false,
      dataKey: "details",
      appJson: true,
      showLoader: false,
    );

    if (!await api.post({}, {})) return;
    AppService.to.loggedUser.add(UserModel.fromJson(api.data[0]));
    await getAddress();
    // await delay(500);
    await getCategory();
    await delay(400);
    await getCartDetails();
    await delay(200);

    // if (AppService.to.globalAaddressList.isEmpty) {
    //   Get.toNamed(RouteConst.selectLocation);
    //   return;
    // } else {
    await delay(400);
    Get.offNamed(RouteConst.home);
    // }
  }

  getAddress() async {
    // if (AppService.to.globalAaddressList.isNotEmpty) {
    //   return;
    // }
    var userDetails = AppService.to.loggedUser[0];
    var api = DataApiService<List>(
      ApiConst.savedAddressList,
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    Map<String, String> params = {
      "limit": '10',
      "offset": '0',
    };
    if (!await api.gets(params)) return;
    List details = api.data[0]['paginatedResults'];
    // addressList.clear();
    AppService.to.globalAaddressList.clear();
    AppService.to.selectedAddress.clear();
    for (var doc in details) {
      AppService.to.globalAaddressList.add(AddressModel.fromJson(doc));
    }
    for (var sel in AppService.to.globalAaddressList) {
      if (sel.defaultAddress) {
        AppService.to.selectedAddress.add((sel));
      }
    }

    update();
    return AppService.to.globalAaddressList;
  }
}
