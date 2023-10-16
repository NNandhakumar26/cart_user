import 'package:get/get.dart';
import 'package:toyskart/core/constants/api.dart';
import 'package:toyskart/core/services/api/data_api.dart';
import 'package:toyskart/core/utils/loader.dart';
import 'package:toyskart/core/utils/misc.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/pages/home/model/model.dart';

class WishListController extends GetxController {
  List<ItemList> itemsList = [];
  int lastPage = -1;

  getItems() async {
    int currentCount = itemsList.length;
    int offset = currentCount ~/ 10;
    if (lastPage == offset) return;
    lastPage = offset;
    await delay(150);
    var api = DataApiService<List>(
      '${ApiConst.wishList}/${AppService.to.loggedUser[0].id}',
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    Map<String, String> params = {
      "userId": AppService.to.loggedUser[0].id,
      'offset': '$offset',
      'limit': '10',
    };

    if (!await api.gets(params)) return;

    List details = api.data[0]['paginatedResults'];

    for (var item in details) {
      item['isWishListed'] = true;
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
