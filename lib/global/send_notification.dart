import 'dart:convert';

import 'package:http/http.dart' as http;

sendNotification(String title, String token) async {
  final data = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'id': '1',
    'status': 'done',
    'message': title,
  };

  try {
    http.Response response =
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAApcH6FRA:APA91bGDrYs_hVgLDgRZL690Rdi9zc7hJUYjFk7aljoH8mZXinHVpV_fbsxO_w6ZvJyRnwO9Ldeyb3WSSra5j620TY-MQDTLO2vucu9FlHWQwEBNqg-NuzFCYwv0zrCZsVw8ZHk8bD6r'
            },
            body: jsonEncode(<String, dynamic>{
              'notification': <String, dynamic>{
                'title': 'Order Status',
                'body': 'Your order is : $title'
              },
              'priority': 'high',
              'data': data,
              'to': token
            }));

    if (response.statusCode == 200) {
      print("Yeh notificatin is sended");
    } else {
      print("Error");
    }
  } catch (e) {
    print(e);
  }
}
