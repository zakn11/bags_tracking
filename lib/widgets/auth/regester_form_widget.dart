import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/controller/radio_controller.dart';
import 'package:tracking_system_app/modules/auth/controller/register_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class RegesterFormWidget extends StatelessWidget {
  const RegesterFormWidget({
    super.key,
    required this.controller,
    required this.isLandscape,
    required this.isTablet,
    required this.screenWidth,
    required this.screenHeight,
  });
  final RegisterController controller;
  final bool isLandscape;
  final bool isTablet;
  final double screenWidth;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment:
            isLandscape ? MainAxisAlignment.start : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: AppVar.background,
                    border: Border.all(width: 3, color: AppVar.primary)),
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/images/Logo1.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          if (screenWidth > 850) SizedBox(height: AppSizeH.s20),
          if (screenWidth <= 850) SizedBox(height: AppSizeH.s40),
          Padding(
            padding: EdgeInsets.only(bottom: AppSizeH.s10, top: AppSizeH.s0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: AppVar.seconndTextColor,
                fontSize: AppSizeSp.s40,
                shadows: [
                  Shadow(
                    color: Color.fromARGB(255, 79, 79, 79),
                    offset: Offset(AppSizeW.s2, AppSizeH.s4),
                    blurRadius: AppSizeW.s5,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSizeH.s30),
          CustomeLoginTextFormField(
            isFilledTextFild: false,
            filledTextFildData: "",
            prefixIcon: null,
            inputType: TextInputType.text,
            hintText: 'First Name',
            title: 'First Name',
            controller: controller.firstNameController,
            validator: null,
          ),

          SizedBox(height: AppSizeH.s15),
          CustomeLoginTextFormField(
            isFilledTextFild: false,
            filledTextFildData: "",
            prefixIcon: null,
            inputType: TextInputType.text,
            hintText: 'Last Name',
            title: 'Last Name',
            controller: controller.lastNameController,
            validator: null,
          ),

          SizedBox(height: AppSizeH.s15),
          Text(
            "Job Title:",
            style: TextStyle(color: Color(0xffC9DBD3)),
          ),
          _buildRadioButtonGroup(
              "Jop Title", controller.jopTitleController, context),

          CustomeLoginTextFormField(
            isFilledTextFild: false,
            filledTextFildData: "",
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
            hintText: 'Password',
            title: 'Password',
            controller: controller.passwordController,
            validator: null,
            isFilledTextFild: false,
            filledTextFildData: "",
          ),
          CustomeLoginTextFormField(
            prefixIcon: null,
            inputType: TextInputType.text,
            hintText: 'Confirm Password',
            title: 'Password',
            controller: controller.confirmPasswordController,
            validator: null,
            isFilledTextFild: false,
            filledTextFildData: "",
          ),
          SizedBox(height: AppSizeH.s50),
          // Sign Up Button
          LoginDefultButton(
            fontsize: isTablet ? AppSizeSp.s20 : AppVar.mainFontSize,
            buttonColor: AppVar.buttonColor,
            borderColor: Colors.transparent,
            textColor: AppVar.seconndTextColor,
            title: "SIGN UP",
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.validateForm();
              }
            },
          ),
          SizedBox(height: AppSizeH.s10),
          Padding(
            padding: EdgeInsets.only(bottom: AppSizeH.s10),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: AppVar.seconndTextColor,
                      fontSize: AppVar.littelFontSize,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white, width: AppSizeW.s1))),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppVar.buttonColor,
                          fontSize: AppVar.littelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButtonGroup(
      String title, RadioController controller1, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildRadioButtons(controller.radioData, controller1, context),
    );
  }

  List<Widget> _buildRadioButtons(List<String> radioData,
      RadioController controller, BuildContext context) {
    return List<Widget>.generate(
      radioData.length,
      (index) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width * .5 - AppSizeW.s60,
          child: Obx(() => RadioListTile<int>(
                contentPadding: EdgeInsets.zero,
                activeColor: AppVar.secondary,
                title: Text(
                  radioData[index],
                  style: TextStyle(
                      fontSize: AppSizeSp.s12, color: AppVar.background),
                ),
                value: index,
                groupValue: controller.selectedValue.value,
                onChanged: (int? value) {
                  controller.setSelectedValue(value!);
                },
              )),
        );
      },
    );
  }
}
