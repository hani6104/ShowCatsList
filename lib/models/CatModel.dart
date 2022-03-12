import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class CatModel {
  int? _length;
  String? _fact;
  String? _image;

  //
  CatModel();

  //
  set length(int l) => _length = l;
  set fact(String f) => _fact = f;
  set image(String img) => _image = img;

  int get length => _length!;
  String get fact => _fact!;
  String get image => _image!;

  //
  factory CatModel.fromJson(Map<String, dynamic> json) {
    CatModel catModel = CatModel();
    int rnd = Random().nextInt(300) + 100;
    catModel.length = json['length'];
    catModel.fact = json['fact'];
    catModel.image = "https://placekitten.com/200/$rnd";
    return catModel;
  }
//

}
