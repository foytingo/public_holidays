

import 'package:flutter/material.dart';

class LoadingView{

  LoadingView(this.context);

  late BuildContext context;


  Future<void> startLoading() async {
    return await showDialog(context: context, builder: (BuildContext context){
      return const SimpleDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        children: [Center(child: CircularProgressIndicator())],
      );
    });
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }


}