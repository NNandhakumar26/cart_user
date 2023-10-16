import 'dart:convert';

import 'package:http/http.dart' as h;
import 'package:toyskart/global/app_service.dart';

import '../../constants/api.dart';
import '../../utils/alerts.dart';
import '../../utils/loader.dart' as loader;
import '../../utils/misc.dart';

class DataApiService<T> {
  final AppService app = AppService.to;

  late Uri uri;
  final String? dataKey;
  final bool msgToast;
  final bool errorToast;
  final bool showLoader;
  final bool appJson;

  Map<String, dynamic> _body = {};
  T get data => dataKey == null ? _body : _body[dataKey];
  Map<String, dynamic> get body => _body;

  void _disposeIndicator() {
    app.inRequest(false);
    if (showLoader) {
      loader.hideLoader();
    }
  }

  final Map<String, String> _headers = {};
  final Map<String, String> defaultQueryParam = {"tenantId": "user"};

  DataApiService(
    String endPoint, {
    this.dataKey,
    this.showLoader = true,
    this.msgToast = true,
    this.appJson = false,
    this.errorToast = true,
  }) {
    uri = Uri.parse("${ApiConst.apiHost}${ApiConst.middlePath}$endPoint");
  }

  /// headers
  Future<Map<String, String>> _getHeaders() async {
    _headers['Authorization'] = 'Bearer ${await app.idToken()}';
    print(_headers);
    if (appJson) {
      _headers["Content-Type"] = "application/json";
    }
    return _headers;
  }

  // * Response parser

  Future<bool> _processRequest(Future<h.Response> request) async {
    if (showLoader) {
      loader.showLoader();
    }
    app.inRequest(true);
    dPrint(uri.toString());
    try {
      h.Response response = await request;
      _body = jsonDecode(response.body);
      dPrint(_body);
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
      if (_body.containsKey('message') && errorToast) toast(_body['message']);
    } catch (e) {
      dPrint(e.toString());
    }
    _disposeIndicator();
    return false;
  }

  // * Request base

  Future<bool> gets([Map<String, String>? query]) async {
    if (query != null) {
      query.addAll(defaultQueryParam);
      uri = uri.replace(queryParameters: query);
    }
    return await _processRequest(h.get(uri, headers: await _getHeaders()));
  }

  Future<bool> post([Object? body, Map<String, String>? query]) async {
    if (query != null) {
      query.addAll(defaultQueryParam);
      uri = uri.replace(queryParameters: query);
    }
    if (body != null && appJson) body = jsonEncode(body);
    return await _processRequest(
        h.post(uri, headers: await _getHeaders(), body: body));
  }

  Future<bool> put([Object? body, Map<String, String>? query]) async {
    if (query != null) {
      query.addAll(defaultQueryParam);
      uri = uri.replace(queryParameters: query);
    }
    if (body != null && appJson) body = jsonEncode(body);
    return await _processRequest(
        h.put(uri, headers: await _getHeaders(), body: body));
  }

  Future<bool> delete([Object? body, Map<String, String>? query]) async {
    if (query != null) {
      query.addAll(defaultQueryParam);
      uri = uri.replace(queryParameters: query);
    }
    if (body != null && appJson) body = jsonEncode(body);
    return await _processRequest(
        h.delete(uri, headers: await _getHeaders(), body: body));
  }
}
