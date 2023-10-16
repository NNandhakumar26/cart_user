import 'package:toyskart/core/constants/api.dart';

/// some image urls may have path only, so we need to format it
String formatImageUrl(String url) {
  if (url.startsWith('http')) {
    return url;
  }
  return '${ApiConst.apiHost}/$url';
}
