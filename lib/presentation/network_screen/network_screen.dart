
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:yellow_pass/core/utils/app_fonts.dart';
import 'package:yellow_pass/core/utils/color_constant.dart';
import 'controller/network_screen_controller.dart';

class NetworkScreen extends GetWidget<NetworkScreenController> {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstant.primaryWhite,
          body: Container(color: Colors.red,
          child: Text("Welcome",
          style: PMT.style(36,fontColor: Colors.black),),
          )),
    );
  }
}
