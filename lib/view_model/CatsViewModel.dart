import 'package:flutter/cupertino.dart';
import 'package:test_app/models/CatModel.dart';
import 'package:test_app/repository/CatsService.dart';

class CatsViewModel extends ChangeNotifier {
  CatModel catModel;
  //
  CatsViewModel({required this.catModel});

  //
  Future<List<CatsViewModel>> getter() async {
    final results = await CatsService().fetchCats();

    notifyListeners();

    return (results.map((item) => CatsViewModel(catModel: item)).toList());
  }

  int get length => catModel.length;
  String get fact => catModel.fact;
  String get image => catModel.image;
}
