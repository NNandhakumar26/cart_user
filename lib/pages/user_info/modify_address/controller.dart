// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart' hide Location;
// import 'package:get/get.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:toyskart/core/constants/api.dart';
// import 'package:toyskart/core/constants/routes.dart';
// import 'package:toyskart/core/services/api/data_api.dart';
// import 'package:toyskart/global/app_service.dart';
// import 'package:toyskart/global/toast.dart';
// import 'package:toyskart/pages/user_info/list_address/model.dart';
// import 'package:location/location.dart';
// import 'package:map_picker/map_picker.dart';

// class AddAddressController extends GetxController {
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   final address1 = TextEditingController();
//   final address2 = TextEditingController();
//   final address3 = TextEditingController();
//   final mobile = TextEditingController();
//   final addressId = TextEditingController();
//   RxBool isSelected = false.obs;
//   bool params = false;
//   //Position? position;
//   // getDeviceLoaction() async {
//   //   position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high);
//   //   final LocationSettings locationSettings = const LocationSettings(
//   //     accuracy: LocationAccuracy.high,
//   //     distanceFilter: 100,
//   //   );
//   //   StreamSubscription<Position> positionStream =
//   //       Geolocator.getPositionStream(locationSettings: locationSettings)
//   //           .listen((Position? position) {
//   //     print(position == null
//   //         ? 'Unknown'
//   //         : '${position.latitude.toString()}, ${position.longitude.toString()}');
//   //   });
//   // }

//   MapPickerController mapPickerController = MapPickerController();

//   CameraPosition? cameraPosition;
//   //CameraPosition? cameraPosition2;

//   GoogleMapController? mapController;
//   final Set<Marker> markers = {};
//   LatLng startLocation = const LatLng(27.7089427, 85.3086209);
//   LocationData? endLocationData;
//   String d = '';
//   var textController = TextEditingController();
//   final TextEditingController startTextController = TextEditingController();
//   setLongLat(locationLongLat) {
//     var locationMark =
//         "${endLocationData!.latitude!},${endLocationData!.longitude!}";
//     d = locationMark;
//     Get.toNamed(RouteConst.addAddress, arguments: locationLongLat);
//   }
//   // Future<Position> getLocation() async {
//   //   // await Geolocator.openAppSettings();
//   //   //await Geolocator.openLocationSettings();
//   //   LocationPermission permission = await Geolocator.requestPermission();
//   //   Position position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high);

//   //   CameraPosition newPosition = CameraPosition(
//   //     target: LatLng(position.latitude, position.longitude),
//   //     zoom: 14.4746,
//   //   );

//   //   CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);

//   //   List<Placemark> placemarks =
//   //       await placemarkFromCoordinates(position.latitude, position.longitude);
//   //   //await placemarkFromCoordinates(12.058183, 79.547626);
//   //   print(placemarks);
//   //   // final coordinates = new Coordinates(position.latitude, position.longitude);
//   //   String palcename =
//   //       "${placemarks.first.administrativeArea}, ${placemarks.first.street}";
//   //   // var first = addresses.first;
//   //   print(palcename);

//   //   double distanceInMeters =
//   //       Geolocator.distanceBetween(12.058183, 79.547626, 12.956010, 80.143532);
//   //   double distanceInKiloMeters = distanceInMeters / 1000;
//   //   double roundDistanceInKM =
//   //       double.parse((distanceInKiloMeters).toStringAsFixed(2));
//   //   //return '${placemarks.first.thoroughfare}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.postalCode}';

//   //   return position;
//   // }

//   Future<LocationData?> _currentLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//     Location location = Location();

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return null;
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }

//     endLocationData = await location.getLocation();
//     startLocation =
//         LatLng(endLocationData!.latitude!, endLocationData!.longitude!);

//     CameraPosition newPosition = CameraPosition(
//       target: LatLng(startLocation.latitude, startLocation.longitude),
//       zoom: 14.4746,
//     );

//     CameraUpdate update1 = CameraUpdate.newCameraPosition(newPosition);

//     mapController!.moveCamera(update1);
//     getCurrentLocation(endLocationData!);
//     update();

//     markers.add(Marker(
//       markerId: MarkerId(startLocation.toString()),
//       position: startLocation,
//       icon: BitmapDescriptor.defaultMarker,
//     ));
//     update();

//     return endLocationData;
//   }

//   void getCurrentLocation(LocationData data) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(data.latitude!, data.longitude!);
//     Placemark place = placemarks[0];
//     startTextController.text =
//         '${placemarks.first.thoroughfare}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.postalCode}';
//     textController.text =
//         '${placemarks.first.thoroughfare}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.postalCode}';
//   }

//   RxList<AddressModel> addressList = <AddressModel>[].obs;

//   getAddress() async {
//     var userDetails = AppService.to.loggedUser[0];
//     var api = DataApiService<List>(
//       ApiConst.savedAddressList,
//       dataKey: "detail",
//       msgToast: false,
//       appJson: true,
//       showLoader: false,
//       errorToast: false,
//     );
//     Map<String, String> params = {
//       "limit": '10',
//       "offset": '0',
//     };
//     if (!await api.gets(params)) return;
//     List details = api.data[0]['paginatedResults'];
//     addressList.clear();
//     AppService.to.globalAaddressList.clear();
//     AppService.to.selectedAddress.clear();
//     for (var doc in details) {
//       addressList.add(AddressModel.fromJson(doc));
//     }
//     for (var sel in addressList) {
//       if (sel.defaultAddress) {
//         AppService.to.selectedAddress.add((sel));
//       }
//     }
//     AppService.to.globalAaddressList = addressList;
//     update();
//   }

//   addAddress() async {
//     var userDetails = AppService.to.fireUser!;

//     if (formkey.currentState!.validate()) {
//       // var db = FirebaseFirestore.instance.collection('address').doc();
//       final jsonData = {
//         "geoLocation": d,
//         "address1": address1.text,
//         "address2": address2.text,
//         "landMark": address3.text,
//         "userId": userDetails.uid,
//         "addressType": "1",
//         "otherUserName": "otherUserName",
//         "receiverName": "receiverName",
//         "receiverPhoneNo": mobile.text,
//         "defaultAddress": isSelected.value,
//       };
//       var api = DataApiService<List>(
//         ApiConst.savedAddress,
//         // dataKey: "detail",
//         msgToast: false,
//         appJson: true,
//         showLoader: false,
//         errorToast: false,
//       );
//       Map<String, String> params = {
//         "geoLocation": d,
//         "address1": address1.text,
//         "address2": address2.text,
//         "landMark": address3.text,
//         "userId": AppService.to.loggedUser[0].id,
//         "addressType": "1",
//         "otherUserName": "otherUserName",
//         "receiverName": "receiverName",
//         "receiverPhoneNo": mobile.text,
//         "defaultAddress": isSelected.value.toString(),
//       };
//       print(params);

//       if (!await api.post(params)) return;
//       address1.clear();
//       address2.clear();
//       address3.clear();
//       isSelected.value = false;
//       mobile.clear();
//       toast("Address added successfully");
//       Get.offNamed(RouteConst.address);
//       // getAddress();

//       // Get.back();
//       // if (params) {
//       //   Get.back();
//       //   Get.back();
//       // }
//       update();
//     }
//   }

//   updateIsselected(id) async {
//     var db = FirebaseFirestore.instance.collection('address').doc(id);
//     final jsonData = {
//       "isSelected": false,
//     };
//     await db.update(jsonData);
//   }

//   updateAddress() async {
//     var userDetails = AppService.to.fireUser!;

//     //if (formkey.currentState!.validate()) {
//     //   var db =
//     //       FirebaseFirestore.instance.collection('address').doc(addressId.text);
//     //   final jsonData = {
//     //     //"id": db.id,
//     //     "address1": address1.text,
//     //     "address2": address2.text,
//     //     "address3": address3.text,
//     //     "userId": userDetails.uid,
//     //     "mobile": mobile.text,
//     //     "isSelected": isSelected.value,
//     //   };
//     //   if (isSelected.value) {
//     //     for (var i in AppService.to.globalAaddressList) {
//     //       if (i.defaultAddress) {
//     //         AppService.to.selectedAddress.clear();
//     //         AppService.to.selectedAddress.add(i);
//     //         await updateIsselected(i.id);
//     //       }
//     //     }
//     //   }
//     //   await db.update(jsonData);
//     //   address1.clear();
//     //   address2.clear();
//     //   address3.clear();
//     //   mobile.clear();
//     //   isSelected.value = false;
//     //   toast("Address updated successfully");
//     //   getAddress();
//     //   if (params) {
//     //     Get.back();
//     //     Get.back();
//     //   }
//     //   //
//     //   update();
//     // }

//     if (formkey.currentState!.validate()) {
//       // var db = FirebaseFirestore.instance.collection('address').doc();
//       var api = DataApiService<List>(
//         '${ApiConst.savedAddress}/${addressId.text}',
//         dataKey: "detail",
//         msgToast: false,
//         appJson: true,
//         showLoader: false,
//         errorToast: false,
//       );
//       Map<String, String> params = {
//         "addressId": addressId.text,
//         "geoLocation": d,
//         "address1": address1.text,
//         "address2": address2.text,
//         "landMark": address3.text,
//         "userId": AppService.to.loggedUser[0].id,
//         "addressType": "1",
//         "otherUserName": "otherUserName",
//         "receiverName": "receiverName",
//         "receiverPhoneNo": mobile.text,
//         "defaultAddress": isSelected.value.toString(),
//       };
//       print(params);

//       if (!await api.put(params)) return;
//       address1.clear();
//       address2.clear();
//       address3.clear();
//       isSelected.value = false;
//       mobile.clear();
//       toast("Address updated successfully");
//       Get.offNamed(RouteConst.address);
//       //   Get.back();
//       // }
//       update();
//     }
//   }

//   bool flag = false;
//   setAddress() {
//     if (Get.parameters != null || Get.parameters != []) {
//       params = true;
//       update();
//     }
//     if (Get.arguments != null) {
//       AddressModel am = Get.arguments;
//       flag = true;
//       print(Get.arguments);
//       address1.text = am.address1;
//       address2.text = am.address2;
//       address3.text = am.address2;
//       mobile.text = am.receiverPhoneNo;
//       addressId.text = am.id;
//       isSelected.value = am.defaultAddress;

//       update();
//       print('arg');
//     } else {
//       print('no arg');
//     }
//   }

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     _currentLocation();
//     setAddress();
//     super.onInit();
//   }
// }
