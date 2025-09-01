import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class LoginDefultButton extends StatelessWidget {
  const LoginDefultButton({
    super.key,
    required this.buttonColor,
    required this.borderColor,
    @required this.textColor,
    required this.title,
    required this.onPressed,
    required this.fontsize,
    this.icon,
  });

  final Color buttonColor;
  final Color? textColor;
  final Color borderColor;
  final String title;
  final double fontsize;
  final dynamic icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: buttonColor,
        shadowColor: AppVar.textColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppVar.borderradiusprimary + AppSizeR.s10),
            side: BorderSide(color: borderColor, width: AppSizeW.s2)),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, AppSizeH.s30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const Text(''),
          Text(
            title,
            style: TextStyle(
                color: textColor ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? AppVar.seconndTextColor
                        : AppVar.textColor),
                fontSize: fontsize),
          ),
        ],
      ),
    );
  }
}
