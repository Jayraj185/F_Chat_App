import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiHttp
{
  ApiHttp._();
  static ApiHttp apiHttp = ApiHttp._();
  // fam9KHgISvibaFJAZ2hZKK:APA91bFbdGBG-DFBA_L1WaB9oySG_cZTkzL9QiJRw7ebgnoB7MJae_VQKuqCa7JQMsL3qtq9newlBeVos9YPYACvcT2R9j2Af0qMDsHxfl9yigpRC-2O-nlBJfXTRWntoUCB1w2FsXuR
  // AAAAVWJtRTY:APA91bGN9kaW7dG2KutlAY11sk1K0RX3qsu8f3oCpM0KD3CM8n2Kx5taa_YTjY_ldeBFZtYFMu-KSHFxbHNnhzL9ZMPFoGysI4jXsYk5s4uDleyFnxaONkX36gm4DFjEHkis_FxCshzX
  Future<void> PostNotification({required String title, required String body, required String token})
  async {
    Map requostBody = Map();
    var response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=AAAANhMhBPE:APA91bGLPOFqFaIQZWZjSwp-wEbqGo-Mp-JTtatrj-v29wP11_YYVzF00tlF_lzSkgiMlwh_svocuKGLfjNcKzNdWjyBlZEdPlJ3Ch7zuBGgA_jyyQsQFaHtxj5K9e35F6DQVaD82TWH"
        },
        body: jsonEncode(
            {
              "to": "$token",
              "notification": {
                "title": title,
                "body": body,
                "mutable_content": true,
                "sound": "Tri-tone"
              },

              "data": {
                "url": "<url of media image>",
                "dl": "<deeplink action on tap of notification>"
              }
            }
        )
    );
  }
}