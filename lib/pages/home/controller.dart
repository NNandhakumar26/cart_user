import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:toyskart/core/constants/api.dart';
import 'package:toyskart/core/services/api/data_api.dart';
import 'package:toyskart/core/utils/loader.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/model.dart';
import 'package:toyskart/pages/home/model/model.dart';

class HomeController extends GetxController {
  List<ItemList> itemsList = [];
  List<MultiSelectItem<CategoryModel>> categoryList = AppService
      .to.globalCategoriesList
      .map((a) => MultiSelectItem<CategoryModel>(a, a.name))
      .toList();
  List<CategoryModel> selectedItems = [];
  RangeValues values = const RangeValues(0, 20000);
  void itemChange(CategoryModel itemValue, bool isSelected) {
    // if (isSelected) {
    //   selectedItems.add(itemValue.id);
    // } else {
    //   selectedItems.remove(itemValue.id);
    // }
  }

  void cancel() {
    Get.back();
  }

  void submit() {
    //  Navigator.pop(context, _selectedItems);
  }
  getItems() async {
    var api = DataApiService<List>(
      ApiConst.menuList,
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    var s = selectedItems.map((e) => e.id);
    Map<String, String> params = {
      "userId": AppService.to.loggedUser[0].id,
      "minPrice": values.start.toStringAsFixed(0),
      "maxPrice": values.end.toStringAsFixed(0),
      "category": s.toString().replaceAll('(', '').replaceAll(')', '')
    };

    if (!await api.gets(params)) return;

    List details = api.data[0]['paginatedResults'];

    for (var item in details) {
      itemsList.add(ItemList.fromJson(item));
    }

    update();
  }

  addToCart(ItemList item, bool isAdd) async {
    if (isAdd) {
      item.cartCount++;
      AppService.to.globalCartCount.value =
          AppService.to.globalCartCount.value + 1;
      AppService.to.globalCartItems.value =
          AppService.to.globalCartItems.value + item.price;
      // AppService.to.globalCartCount.value += 1;
    } else {
      item.cartCount--;
      AppService.to.globalCartCount.value =
          AppService.to.globalCartCount.value - 1;
      AppService.to.globalCartItems.value =
          AppService.to.globalCartItems.value - item.price;
      //AppService.to.globalCartCount.value -= 1;
    }

    update();
    var api = DataApiService<List>(
      ApiConst.cart,
      //dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    Map<String, String> params = {
      "products": '${item.id}~${item.cartCount}',
      "userId": AppService.to.loggedUser[0].id,
      // " AppService.to.globalCartCount.value": '${item.count}'
    };
    showLoader();
    if (!await api.post(params, {})) {
      hideLoader();
      if (isAdd) {
        item.cartCount--;
        AppService.to.globalCartCount.value =
            AppService.to.globalCartCount.value - 1;
        AppService.to.globalCartItems.value =
            AppService.to.globalCartItems.value - item.price;
        //AppService.to.globalCartCount.value -= 1;
      } else {
        item.cartCount++;
        AppService.to.globalCartCount.value =
            AppService.to.globalCartCount.value + 1;
        AppService.to.globalCartItems.value =
            AppService.to.globalCartItems.value + item.price;
        // AppService.to.globalCartCount.value += 1;
      }
      update();
      return;
    }
    hideLoader();

    // getCartDetails();
  }

  Future<void> wishListFunction(ItemList item) async {
    var post = item;
    var currentState = post.isWishListed;
    post.isWishListed = !currentState;

    update();

    if (!await wishListFunctionReturn(post.id, currentState)) {
      post.isWishListed = currentState;

      update();
    } else {
      //updateLike(post.postId, !currentState);
    }
  }

  Future<bool> wishListFunctionReturn(String postId, bool likeFlag) async {
    Map<String, String> params = {
      "productId": postId,
      "userId": AppService.to.loggedUser[0].id,
    };

    if (likeFlag) {
      var api = DataApiService<List>(ApiConst.wishListRemove,
          msgToast: false, appJson: true, showLoader: false, errorToast: false);

      return await api.put(params, {});
    } else {
      var api = DataApiService<List>(ApiConst.wishListRoot,
          msgToast: false, appJson: true, showLoader: false, errorToast: false);

      return await api.post(params, {});
    }
  }

  @override
  void onInit() {
    getItems();
    super.onInit();
  }
}
