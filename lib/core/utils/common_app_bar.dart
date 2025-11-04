import 'package:yellow_pass/core/utils/color_constant.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
import 'package:yellow_pass/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({
    super.key,
    this.title,
    this.titleImageUrl,
    this.isTitleImage,
    this.leading,
    this.bottom,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.actions,
    this.icon,
  });

  String? title;
  String? titleImageUrl;
  bool? isTitleImage;
  List<Widget>? actions;
  IconData? icon;
  Widget? leading;
  Color? backgroundColor;
  Color? textColor;
  Color? iconColor;
  PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      bottom: bottom,
      leading: leading,
      title: Column(
        children: [
          isTitleImage != null && isTitleImage == true
              ? Image.network(
                  titleImageUrl ?? "",
                  height: preferredSize.height,
                  fit: BoxFit.contain,
                )
              : Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon,color:iconColor ,),
                  SizedBox(width: getWidth(10),),
                  Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style: AppStyle.txtGilroy.copyWith(
                            color: textColor,
                          ),
                    ),
                ],
              ),
        ],
      ),
      backgroundColor: backgroundColor ?? Colors.transparent,
      iconTheme: IconThemeData(color: ColorConstant.primaryOrange),
      shadowColor: Colors.transparent,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
