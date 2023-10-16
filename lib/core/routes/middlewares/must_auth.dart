import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/global/app_service.dart';

import '../../utils/misc.dart';

class MustAuthenticatedMiddleware extends GetMiddleware {
  var app = AppService.to;
  @override
  RouteSettings? redirect(String? route) {
    dPrint('In middleware');
    // if (app.user == null) {
    //   dPrint('[Middleware] redirect to splash : $route');
    //   app.redirectUri = Uri.tryParse(route!);
    //   return const RouteSettings(name: RouteConst.initial);
    // }
    return null;
  }
}
