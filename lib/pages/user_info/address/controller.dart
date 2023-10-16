import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toyskart/core/constants/api.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/core/constants/routes.dart';
import 'package:toyskart/core/services/api/data_api.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/global/toast.dart';
import 'package:toyskart/pages/user_info/address/model.dart';
import 'package:toyskart/pages/user_info/address/views/view.dart';

class AddressListController extends GetxController {
  RxList<AddressModel> addressList = <AddressModel>[].obs;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final fullName = TextEditingController();
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final landMark = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final pinCode = TextEditingController();
  final mobile = TextEditingController();
  final alternateMobile = TextEditingController();
  final addressId = TextEditingController();
  RxBool isSelected = false.obs;
  bool params = false;
  List checkoutList = [];

  String d = '';

  var loc;
  bool isEditToogle = false;
  CameraPosition? cameraPositionFinal;
  var textControllerFinal = TextEditingController();

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
    addressList.clear();
    AppService.to.globalAaddressList.clear();
    AppService.to.selectedAddress.clear();
    for (var doc in details) {
      addressList.add(AddressModel.fromJson(doc));
    }
    for (var sel in addressList) {
      if (sel.defaultAddress) {
        AppService.to.selectedAddress.add((sel));
      }
    }
    AppService.to.globalAaddressList = addressList;
    update();
  }

  deleteAddress(id) async {
    var api = DataApiService<List>(
      '${ApiConst.savedAddress}/$id',
      //dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: true,
      errorToast: false,
    );

    if (!await api.delete({}, {})) return;
    addressList.removeWhere((element) => element.id == id);
    AppService.to.globalAaddressList.removeWhere((element) => element.id == id);
    // if (AppService.to.selectedAddress[0].id == id) {
    AppService.to.selectedAddress.removeWhere((element) => element.id == id);
    //}
    toast("Address removed successfully");

    update();
  }

  deletePopUp(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConst.background,
          title: const Text(
            "Confirm",
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorConst.primary, fontSize: 16),
          ),
          content: const Text(
            "Are you sure you want to delete ?",
            style: TextStyle(color: ColorConst.black),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  deleteAddress(id);

                  //   DismissiblePane(onDismissed: () {});
                  // var db = FirebaseFirestore.instance;

                  // db.collection("address").doc(id).delete().then(
                  //       (doc) => {},
                  //       onError: (e) => print("Error updating document $e"),
                  //     );
                  // Get.back();
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  "DELETE",
                  style: TextStyle(color: ColorConst.primary),
                )),
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(color: ColorConst.black),
                )),
          ],
        );
      },
    );
  }

  updateIsselected(AddressModel item, flag) async {
    isSelected.value = flag;

    if (isSelected.value) {
      AppService.to.selectedAddress.add(item);
    } else {
      AppService.to.selectedAddress.clear();
    }
    update();

    var api = DataApiService<List>(
      '${ApiConst.savedAddress}/${item.id}',
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    Map<String, String> params = {
      "fullName": item.fullName,
      "address1": item.address1,
      "address2": item.address2,
      "landMark": item.landMark,
      "city": item.city,
      "state": item.state,
      "pincode": item.pincode,
      "userId": item.userId,
      "addressType": item.addressType.toString(),
      "otherUserName": "otherUserName",
      "receiverName": "receiverName",
      "phoneNo": item.phoneNo,
      "defaultAddress": isSelected.value.toString(),
      "alternatePhn": item.alternatePhn,
    };
    print(params);
    if (!await api.put(params, {})) {
      AppService.to.selectedAddress.clear();
      update();
    }
    //AppService.to.selectedAddress.add(item);
    getAddress();
    update();
  }

  setAddress(AddressModel item) async {
    isEditToogle = true;
    fullName.text = item.fullName;
    city.text = item.city;
    state.text = item.state;
    pinCode.text = item.pincode.toString();
    address1.text = item.address1;
    address2.text = item.address2;
    landMark.text = item.landMark;
    mobile.text = item.phoneNo;
    alternateMobile.text = item.alternatePhn;
    pinCode.text = item.pincode;
    addressId.text = item.id;
    isSelected.value = item.defaultAddress;
    // loc = item.geoLocation;
    update();
    Get.to(() => const ModifyAddress(), arguments: loc);
  }

  addAddress() async {
    var userDetails = AppService.to.fireUser!;

    if (formkey.currentState!.validate()) {
      // var db = FirebaseFirestore.instance.collection('address').doc();
      final jsonData = {
        "fullName": fullName.text,
        "address1": address1.text,
        "address2": address2.text,
        "landMark": landMark.text,
        "userId": userDetails.uid,
        "city": city.text,
        "state": state.text,
        "pincode": pinCode.text,
        "addressType": "1",
        "otherUserName": "otherUserName",
        "receiverName": "receiverName",
        "phoneNo": mobile.text,
        "alternatePhn": alternateMobile.text,
        "defaultAddress": isSelected.value,
      };
      var api = DataApiService<List>(
        ApiConst.savedAddress,
        // dataKey: "detail",
        msgToast: false,
        appJson: true,
        showLoader: false,
        errorToast: false,
      );
      Map<String, String> params = {
        "fullName": fullName.text,
        "address1": address1.text,
        "address2": address2.text,
        "landMark": landMark.text,
        "city": city.text,
        "state": state.text,
        "pincode": pinCode.text,
        "userId": AppService.to.loggedUser[0].id,
        "addressType": "1",
        "otherUserName": "otherUserName",
        "receiverName": "receiverName",
        "phoneNo": mobile.text,
        "alternatePhn": alternateMobile.text,
        "defaultAddress": isSelected.value.toString(),
      };
      print(params);

      if (!await api.post(params, {})) return;
      address1.clear();
      address2.clear();
      landMark.clear();
      city.clear();
      state.clear();
      pinCode.clear();
      AppService.to.globalAaddressList = <AddressModel>[].obs;
      isSelected.value = false;
      mobile.clear();
      toast("Address added successfully");
      Get.offAllNamed(RouteConst.address);

      update();
    }
  }

  updateAddress() async {
    var userDetails = AppService.to.fireUser!;

    if (formkey.currentState!.validate()) {
      // var db = FirebaseFirestore.instance.collection('address').doc();
      var api = DataApiService<List>(
        '${ApiConst.savedAddress}/${addressId.text}',
        dataKey: "detail",
        msgToast: false,
        appJson: true,
        showLoader: false,
        errorToast: false,
      );
      Map<String, String> params = {
        "fullName": fullName.text,
        "addressId": addressId.text,
        "address1": address1.text,
        "address2": address2.text,
        "landMark": landMark.text,
        "city": city.text,
        "state": state.text,
        "pincode": pinCode.text,
        "userId": AppService.to.loggedUser[0].id,
        "addressType": "1",
        "otherUserName": "otherUserName",
        "receiverName": "receiverName",
        "phoneNo": mobile.text,
        "alternatePhn": alternateMobile.text,
        "defaultAddress": isSelected.value.toString(),
      };
      print(params);

      if (!await api.put(params, {})) return;
      address1.clear();
      address2.clear();
      landMark.clear();
      city.clear();
      state.clear();
      pinCode.clear();
      isSelected.value = false;
      mobile.clear();

      AppService.to.globalAaddressList = <AddressModel>[].obs;

      toast("Address updated successfully");
      Get.offAllNamed(RouteConst.address);
      //   Get.back();
      // }
      update();
    }
  }
  // checkOut() {
  //   checkoutItems.clear();

  //   for (var item in foodItemList) {
  //     if (item.count > 0) {
  //       checkoutItems.add(item);
  //     }
  //   }
  //   if (checkoutItems.isEmpty) {
  //     toast('Please Select Foods');
  //   } else {
  //     Get.toNamed(RouteConst.checkout, arguments: checkoutItems);
  //   }
  //   update();
  // }

}
