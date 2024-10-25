import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../service/general/general_functions.dart';

class CustomPopScope extends StatefulWidget {
  final Widget child;

  const CustomPopScope({
    super.key,
    required this.child,
  });

  @override
  State<CustomPopScope> createState() => _CustomPopScopeState();
}

class _CustomPopScopeState extends State<CustomPopScope> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) {
        Fluttertoast.cancel();
        final now = DateTime.now();

        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 1500)) {
          currentBackPressTime = now;

          GeneralFunctions.generalToastMessage("'뒤로' 버튼을 한번 더 누르면 종료돼요");

          return;
        } else {
          Fluttertoast.cancel();
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }
}
