// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tracking_system_app/modules/auth/controller/login_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.isLandscape,
    required this.screenHeight,
    required this.screenWidth,
  });

  final bool isLandscape;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizeW.s40,
          //IF TAPLATE
          vertical: screenWidth > 850 ? AppSizeH.s40 : 0),
      child: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: isLandscape
                ? LoginBodyBody(
                    controller: controller,
                    isLandscape: isLandscape,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth)
                : ListView(
                    children: [
                      LoginBodyBody(
                          controller: controller,
                          isLandscape: isLandscape,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class LoginBodyBody extends StatelessWidget {
  const LoginBodyBody({
    super.key,
    required this.isLandscape,
    required this.screenHeight,
    required this.screenWidth,
    required this.controller,
  });

  final bool isLandscape;
  final double screenHeight;
  final double screenWidth;
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isLandscape ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight / 7),
        Padding(
          padding: screenWidth > 850
              ? const EdgeInsets.all(0)
              : EdgeInsets.only(top: isLandscape ? AppSizeH.s20 : 0),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: AppVar.background,
                    border:
                        Border.all(width: AppSizeW.s3, color: AppVar.primary)),
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/images/Logo1.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isLandscape ? screenHeight * 0.05 : 0),
        SizedBox(height: AppSizeH.s20),
        Padding(
          padding: EdgeInsets.only(bottom: AppSizeH.s30, top: AppSizeH.s30),
          child: Text(
            "Sign In",
            style: TextStyle(
              color: AppVar.seconndTextColor,
              fontSize: AppSizeSp.s40,
              shadows: [
                Shadow(
                  color: const Color.fromARGB(255, 79, 79, 79),
                  offset: Offset(AppSizeW.s2, AppSizeH.s4),
                  blurRadius: AppSizeW.s5,
                ),
              ],
            ),
          ),
        ),
        CustomeLoginTextFormField(
          hintText: 'Phone Number',
          inputType: TextInputType.number,
          title: 'Phone Number',
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizeW.s8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/uae_flag.png',
                  width: AppSizeW.s24,
                  height: AppSizeH.s24,
                ),
                SizedBox(width: AppSizeW.s5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSizeW.s5),
                  decoration: BoxDecoration(
                      border: Border(
                    right: BorderSide(
                      color: AppVar.seconndTextColor,
                      width: AppSizeW.s1,
                    ),
                  )),
                  child: Text(
                    '+971',
                    style: TextStyle(
                      fontSize: AppSizeSp.s14,
                      color: AppVar.seconndTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          controller: controller.phoneNumberController,
          validator: null,
        ),
        CustomeLoginTextFormField(
          prefixIcon: null,
          inputType: TextInputType.text,
          hintText: '••••••••••••••••',
          title: 'Password',
          controller: controller.passwordController,
          validator: null,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.FORGOT_PASSWORD);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizeH.s15),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot password?",
                style: TextStyle(
                    fontSize: AppSizeSp.s13, color: AppVar.seconndTextColor),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSizeH.s15),
        LoginDefultButton(
          fontsize: AppSizeSp.s16,
          buttonColor:  AppVar.buttonColor,
          borderColor: Colors.transparent,
          textColor: AppVar.seconndTextColor,
          title: "SIGN IN",
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              controller.validateForm();
            }
          },
        ),
        SizedBox(height: AppSizeH.s15),
        Padding(
          padding: EdgeInsets.only(bottom: AppSizeH.s30),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: AppVar.seconndTextColor,
                    fontSize: AppSizeSp.s14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.white, width: AppSizeW.s1)),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizeSp.s14,
                        color:  AppVar.buttonColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
