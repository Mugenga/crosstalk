import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> sendHttpRequest(Uri url,
    {Map<String, dynamic> data = const {},
    String method = "get",
    String token = ''}) async {
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Connection": "keep-alive"
  };
  if (token != '') headers["Authorization"] = "Bearer $token";
  try {
    http.Response response;
    if (method == 'patch') {
      print('patch');
      response =
          await http.patch(url, body: json.encode(data), headers: headers);
    } else if (method == 'get') {
      print('get');
      response = await http.get(url);
    } else {
      print('post');
      response =
          await http.post(url, body: json.encode(data), headers: headers);
    }
    return json.decode(response.body);
  } catch (error) {
    rethrow;
  }
}
