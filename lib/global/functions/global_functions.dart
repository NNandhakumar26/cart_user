import 'package:toyskart/core/constants/api.dart';
import 'package:toyskart/core/services/api/data_api.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/model.dart';
import 'package:toyskart/pages/cart/model.dart';

getCategory() async {
  var api = DataApiService<List>(
    ApiConst.getCategories,
    dataKey: "detail",
    msgToast: false,
    appJson: true,
    showLoader: false,
    errorToast: false,
  );
  Map<String, String> params = {};

  if (!await api.gets(params)) return;

  var details = api.data;

  for (var i in details) {
    AppService.to.globalCategoriesList.add(CategoryModel.fromJson(i));
  }

  return AppService.to.globalCategoriesList;
}

getCartDetails() async {
  AppService.to.globalCartCount.value = 0;
  //AppService.to.globalCartItems.value = 0;
  AppService.to.globalCartList.clear();
  var api = DataApiService<List>(
    '${ApiConst.cartList}/${AppService.to.loggedUser[0].id}',
    dataKey: "detail",
    msgToast: false,
    appJson: true,
    showLoader: false,
    errorToast: false,
  );
  Map<String, String> params = {};

  if (!await api.gets(params)) return;

  var details = api.data;

  for (var i in details) {
    AppService.to.globalCartList.add(CartListModel.fromJson(i));
  }
  AppService.to.globalCartCount.value = AppService.to.globalCartList.length;

  return AppService.to.globalCartList;
}
