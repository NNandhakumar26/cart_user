import 'dart:io';

import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toyskart/core/constants/api.dart';
import 'package:toyskart/core/services/api/data_api.dart';
import 'package:toyskart/core/utils/loader.dart';
import 'package:toyskart/core/utils/misc.dart';
import 'package:toyskart/global/app_service.dart';
import 'package:toyskart/pages/orders/my_orders/model.dart';

class MyOrderListController extends GetxController {
  RxList<OrderListModel> myOrders = <OrderListModel>[].obs;
  // AddressModel checkoutItems = {};
  List checkoutList = [];
  String? exandingId;
  String htmlString = "";
  int lastPage = -1;
  getOrders() async {
    int currentCount = myOrders.length;
    int offset = currentCount ~/ 10;
    if (lastPage == offset) return;
    lastPage = offset;
    await delay(150);
    var api = DataApiService<List>(
      '${ApiConst.orders}/list',
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    Map<String, String> params = {
      "userId": AppService.to.loggedUser[0].id,
      "offset": '$offset',
      "limit": "20",
      // "sort": "desc"
    };

    if (!await api.gets(params)) return;
    myOrders.clear();
    var details = api.data[0]['paginatedResults'];
    for (var doc in details) {
      myOrders.add(OrderListModel.fromJson(doc));
    }

    update();
  }

  String dateAsReadable(DateTime? dateTime,
      {String format = "dd-MMM-yyyy HH:MM ss", String ifNull = " - "}) {
    if (dateTime == null) return ifNull;

    DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime.toLocal());
  }

  Future<void> createReceipt(OrderListModel item) async {
    Directory appDocDir = await getTemporaryDirectory();
    final targetPath = appDocDir.path;

    showLoader();
    var localString =
        "<div style='width:100%; align-items:center; display:flex; justify-content:center;'><p style='font-weight:600; font-size:28px; color:#1C4587;'>Your Receipt</p></div><p style='padding:0px;'>Thank you for your purchase on Mercury Toys and for your support .</p>'<br><p style='padding:3px 3px 3px 0px; margin:3px 3px 3px 0px;'><b>Order ID:</b> ${item.orderId}</p><br><p style='padding:0px 3px 0px 0px; margin:0px 3px 0px 0px;'><b>Date:</b> ${dateAsReadable(item.orderDate, format: 'dd-MM-yyyy @ hh:mm a')}</p><br><p style='padding:0px 3px 0px 0px; margin:0px 3px 0px 0px;'><b>Shipping Address:</b> ${item.address.fullName}, ${item.address.address1},${item.address.city}, - ${item.address.pincode}, Mobile: ${item.address.phoneNo}</p> ";
    localString +=
        "<table style='width:100% ;border: 1px solid black; border-collapse:collapse; padding:3px 3px 3px 0px; margin:20px 3px 3px 0px;'><tr style='border: 1px solid black; '>   <th style='height:35px; border: 1px solid black;text-align:center;'> <p style='margin-left:8px;'>Product Description</p></th>  <th style='border: 1px solid black;text-align:center; width:25%; '><p style='margin-left:8px;'>Qty * Unit Price</p></th>  <th style='border: 1px solid black;text-align:left; width:15%; '><p style='margin-left:8px;'>Amount</p></th>	</tr>";

    for (var a in item.productsName) {
      localString +=
          "<tr style='border: 1px solid black; height:35px;'> <td style='border: 1px solid black; text-align:left;'><p style='margin-left:8px;' >${a.name}</p></td><td style='border: 1px solid black; text-align:right; width:15%;'><p style='margin-right:12px;'>${a.itemCount} X \u{20B9}${a.actualAmount}</p></td><td style='border: 1px solid black; text-align:right;  width:15%;'><p style='margin-right:8px;'>\u{20B9}${a.itemCount * a.actualAmount}</p></td>";
    }
    localString +=
        "<tr style='border: 1px solid black; height:35px;'> <td colspan='2' style='border: 1px solid black; text-align:right;'><p style='margin-right:12px;' >GST %</p></td><td  style='border: 1px solid black; text-align:right;  width:15%;'><p style='margin-right:8px;'>${item.gstAmount}%</p></td>";
    localString +=
        "<tr style='border: 1px solid black; height:35px;'> <td colspan='2' style='border: 1px solid black; text-align:right;'><p style='margin-right:12px;' >Delivey Charge</p></td><td  style='border: 1px solid black; text-align:right;  width:15%;'><p style='margin-right:8px;'>\u{20B9}${item.deliveryCharge}</p></td>";
    localString +=
        "<tr style='border: 1px solid black; height:35px;'> <td colspan='2' style='border: 1px solid black; text-align:right;'><p style='margin-right:12px;font-size:20px; font-weight:bold;' >Total</p></td><td  style='border: 1px solid black; text-align:right;  width:15%;'><p style='margin-right:8px; font-size:20px; font-weight:bold;'>\u{20B9}${item.totalAmount}</p></td>";
    localString += "</table>";

    update();
    try {
      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          localString, targetPath, "Receipt");
      OpenFile.open(generatedPdfFile.path);
    } catch (e) {
      dPrint(e);
    }

    hideLoader();
  }
}
