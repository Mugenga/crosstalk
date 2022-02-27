import 'package:crosstalk/helpers/http_request.dart';
import 'package:flutter/material.dart';

class Words extends ChangeNotifier {
  List<dynamic> _words = [];

  Map<String, dynamic> get word {
    return _words[0];
  }

  Future<void> getWordsByCategory(String category) async {
    Uri getWordsUrl = Uri.parse(
        'https://crosstalkrw.herokuapp.com/words/$category/categories');
    var response = await sendHttpRequest(getWordsUrl);

    _words = response['data'];
    notifyListeners();
  }
}
