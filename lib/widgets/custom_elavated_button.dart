
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../theme/app_style.dart';

class AppElevatedButton extends StatefulWidget {
  final String buttonName;
  final void Function() onPressed;
  final Color? textColor;
  final Color? buttonColor;
  final FontWeight? fontWeight;
  final double? radius;
  final bool? isLoading;
  final double? fontSize;
  final bool? showTextIcon;
   bool? hasGradient=true;
  final String? textIcon;
  final Color? borderColor;

   AppElevatedButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      this.textColor,
      this.textIcon,
      this.borderColor,
      this.fontWeight,
      this.fontSize,
      this.buttonColor,
      this.radius,
      this.showTextIcon,
      this.hasGradient=true,
      this.isLoading = false});

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(40),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: widget.buttonColor??Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius??12))),
        ),
        child: !widget.isLoading!
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.showTextIcon ?? false
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            widget.textIcon ?? ImageConstant.icClose,
                            height: 23,
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    widget.buttonName.toString(),
                    style: AppStyle.txtGilroyBold.copyWith(
                        color: widget.textColor ?? ColorConstant.primaryWhite,
                        fontWeight: widget.fontWeight ?? FontWeight.w400,
                        fontSize: getFontSize(widget.fontSize ?? 16)),
                  ),
                ],
              )
            : Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                  height: getWidth(25),
                  width: getWidth(25),
                  child: const CircularProgressIndicator(
                    color: ColorConstant.primaryWhite,
                    strokeWidth: 2,
                  )),
            ),
      ),
    );
  }
}

class AppElevatedButton2 extends StatelessWidget {
  final String buttonName;
  final void Function() onPressed;
  final Color? textColor;
  final Color? buttonColor;
  final FontWeight? fontWeight;
  final double? radius;
  final bool? isLoading;
  final double? fontSize;
  final bool? showTextIcon;
  bool? hasGradient=true;
  final String? textIcon;
  final Color? borderColor;

  AppElevatedButton2(
      {Key? key,
        required this.buttonName,
        required this.onPressed,
        this.textColor,
        this.textIcon,
        this.borderColor,
        this.fontWeight,
        this.fontSize,
        this.buttonColor,
        this.radius,
        this.showTextIcon,
        this.hasGradient=true,
        this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(44),
      decoration: BoxDecoration(
        border:  hasGradient??false? null:Border.all(color: ColorConstant.primaryOrange,width: getHeight(1)),
        gradient: LinearGradient(colors: [
          hasGradient??false? ColorConstant.gradientStartColor:ColorConstant.primaryWhite,
          hasGradient??false? ColorConstant.gradientEndColor:ColorConstant.primaryWhite,
        ]),
        borderRadius: const BorderRadius.all(Radius.circular(8)),

      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        child: !isLoading!
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showTextIcon ?? false
                ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                textIcon ?? ImageConstant.icClose,
                height: 23,
              ),
            )
                : const SizedBox(),
            Text(
              buttonName.toString(),
              style: AppStyle.txtGilroyBold.copyWith(
                  color: textColor ?? ColorConstant.primaryWhite,
                  fontWeight: fontWeight ?? FontWeight.w400,
                  fontSize: getFontSize(fontSize ?? 16)),
            ),
          ],
        )
            : SizedBox(
            height: getHeight(30),
            width: getHeight(30),
            child: const CircularProgressIndicator(
              color: ColorConstant.primaryWhite,
              strokeWidth: 2,
            )),
      ),
    );
  }
}



