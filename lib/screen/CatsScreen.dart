import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/CatModel.dart';
import 'package:test_app/view_model/CatsViewModel.dart';

class CatsScreen extends StatelessWidget {
  // late ScrollController controller;
  CatsViewModel catsViewModel = CatsViewModel(catModel: CatModel());

  CatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // controller = ScrollController()
    //   ..addListener(() {
    //     var maxScroll = controller.position.maxScrollExtent;
    //     var currentPosition = controller.position.pixels;
    //     if (currentPosition == maxScroll) {
    //       Provider.of<CatsViewModel>(context, listen: false).getter();
    //     }
    //   });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cats List"),
      ),
      body: Container(
        height: h,
        width: w,
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: FutureBuilder<List<CatsViewModel>>(
          future: catsViewModel.getter(),
          builder: (context, snapshot) {
            // Future.delayed(const Duration(milliseconds: 500), () {});
            if (snapshot.hasData) {
              List<CatsViewModel>? data = snapshot.data;
              return Consumer<CatsViewModel>(
                  builder: (context, value, child) => ListView.builder(
                      itemCount: data!.length,
                      // controller: controller,
                      itemBuilder: (BuildContext context, int index) {
                        return listItem(data: data, index: index, width: w);
                      }));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget listItem(
      {required List<CatsViewModel> data, required int index, required width}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue, width: 2)),
      margin: const EdgeInsets.only(top: 25),
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.only(bottom: 10),
                child: Image.network(data[index].image, fit: BoxFit.fill)),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 65,
                    child: const Text(
                      "FACT:",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      width: width - 130,
                      child: Text(
                        data[index].fact,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.blueGrey),
                      )),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: 65,
                child: const Text(
                  "LENGTH:",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Text("${data[index].length}"),
            ])
          ],
        ),
      ),
    );
  }

  // Future<void> _onScrollUpdated() async {
  //   var maxScroll = controller.position.maxScrollExtent;
  //   var currentPosition = controller.position.pixels;
  //   if (currentPosition == maxScroll) {
  //     catsViewModel.getter();
  //   }
  // }

}
