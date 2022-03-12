import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app/models/CatModel.dart';

class CatsService {
  Future<List<CatModel>> fetchCats() async {
    const String url = "https://catfact.ninja/facts";

    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return (jsonResponse['data'] as List)
          .map((data) => CatModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
