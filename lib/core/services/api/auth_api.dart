import 'dart:convert';

import 'package:http/http.dart' as h;
//import 'package:gigavus_login/core/utils/loader.dart' as loader;
import 'package:toyskart/global/app_service.dart';

import '../../constants/api.dart';
import '../../utils/alerts.dart';
import '../../utils/loader.dart' as loader;
import '../../utils/misc.dart';

class AuthApiService<T> {
  final AppService app = AppService.to;
  Uri uri = Uri();

  final bool showLoader;
  final bool errToast;
  final String? dataKey;
  final bool msgToast;
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };
  final Map<String, String> defaultQueryParam = {"tenantId": "user"};

  Map<String, dynamic> _body = {};
  T get data => dataKey == null ? _body : _body[dataKey];

  AuthApiService(String endPoint,
      {this.dataKey,
      this.showLoader = true,
      this.msgToast = true,
      this.errToast = true}) {
    uri = Uri.parse("${ApiConst.apiHost}${ApiConst.middlePath}$endPoint");
  }

  void _disposeIndicator() {
    app.inRequest(false);
    loader.hideLoader();
  }

  Future<bool> gets(
      [Map<String, String>? query, Map<String, String>? headers]) {
    if (query != null) {
      query.addAll(defaultQueryParam);

      uri = uri.replace(queryParameters: query);
    }
    if (headers != null) {
      _headers.addAll(headers);
    }

    return _processRequest(h.get(uri, headers: _headers));
  }

  Future<bool> post(
      [Map<String, String>? body, Map<String, String>? headers]) async {
    dPrint(body?.toString());
    if (headers != null) {
      _headers.addAll(headers);
    }
    return await _processRequest(
        h.post(uri, headers: _headers, body: jsonEncode(body)));
  }

  Future<bool> put(
      [Map<String, String>? body, Map<String, String>? headers]) async {
    dPrint(body?.toString());
    if (headers != null) {
      _headers.addAll(headers);
    }
    return await _processRequest(
        h.put(uri, headers: _headers, body: jsonEncode(body)));
  }

  Future<bool> _processRequest(Future<h.Response> request) async {
    app.inRequest(true);
    if (showLoader) loader.showLoader();

    try {
      h.Response response = await request;
      _body = jsonDecode(response.body);
      dPrint(_headers.toString());
      dPrint(_body.toString());
      if (_body.containsKey('ok') && _body['ok']) {
        _disposeIndicator();
        return true;
      }
      if ((_body.containsKey('status') && _body['status'] == 200) ||
          _body.containsKey('statusCode') && _body['statusCode'] == 200) {
        _disposeIndicator();
        if (_body.containsKey('message') && msgToast) toast(_body['message']);
        if (dataKey != null && !_body.containsKey(dataKey)) {
          toast('Parse key not found!');
          return false;
        }
        return true;
      }
      if (!_body.containsKey('ok') || !_body['ok']) {
        if (_body.containsKey('message') && errToast) toast(_body['message']);
      }
    } catch (e) {
      dPrint(e.toString());
    }
    _disposeIndicator();
    return false;
  }
}
