import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class CustomActivitiesCardWidget extends StatelessWidget {
  const CustomActivitiesCardWidget({
    super.key,
    required this.imageName,
    required this.label,
    required this.onTap,
    required this.homeController,
    required this.index, 
    required this.width,
    required this.height,
    required this.isDeleverd,
  });

  final String imageName;
  final String label;
  final void Function()? onTap;
  final HomeController homeController;
  final int index;
  final double? width;
  final double? height;
  final bool isDeleverd;

  @override
  Widget build(BuildContext context) {
    final isTaplet = MediaQuery.of(context).size.width > 800;
    final dataFontSize = MediaQuery.of(context).size.width *
        (isTaplet ? 0.03 : 0.07); 
    return GestureDetector(
      onTap: $.role == "store_employee" && label == "Delivered"
          ? () {}
          : () {
              homeController.selectedCardIndex.value = index;
              if (onTap != null) onTap!(); 
            },
      child: Obx(
        () => AnimatedScale(
          scale: homeController.selectedCardIndex.value == index
              ? 1.0
              : 0.9,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: width,
            height: height,
            margin: EdgeInsets.symmetric(vertical: AppSizeH.s20),
            padding: EdgeInsets.all(AppSizeW.s15),
            decoration: BoxDecoration(
              color: $.role == "store_employee" && label == "Delivered"
                  ? AppVar.background
                  : homeController.selectedCardIndex.value == index
                      ? const Color(0xff3AD189)
                      : AppVar.background,
              borderRadius: BorderRadius.circular(AppSizeR.s20),
              border: Border.all(
                  color: $.role == "store_employee" && label == "Delivered"
                      ? const Color.fromARGB(255, 207, 207, 207)
                      : const Color(0xff3AD189),
                  width: AppSizeW.s1)
              ,
              boxShadow: $.role == "store_employee" && label == "Delivered"
                  ? null
                  : [
                      BoxShadow(
                        color: homeController.selectedCardIndex.value == index
                            ? Colors.black.withOpacity(
                                0.4)
                            : Colors.black.withOpacity(0.2),
                        spreadRadius: AppSizeW.s2,
                        blurRadius:
                            homeController.selectedCardIndex.value == index
                                ? AppSizeW.s3
                                : AppSizeW.s3,
                        offset: const Offset(0, 5),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: $.role == "store_employee" && label == "Delivered" ? 0.3 : 1,
                  child: Image.asset(
                    imageName,
                    width: isTaplet
                        ? isDeleverd
                            ? AppSizeW.s120
                            : AppSizeW.s100
                        : isDeleverd
                            ? AppSizeW.s80
                            : AppSizeW.s60,
                    height: isTaplet ? AppSizeH.s100 : AppSizeH.s60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: AppSizeH.s25),
                  child: SizedBox(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: isTaplet ? dataFontSize : AppSizeSp.s16,
                        color: $.role == "store_employee" && label == "Delivered"
                            ? const Color.fromARGB(255, 207, 207, 207)
                            : homeController.selectedCardIndex.value == index
                                ? AppVar.background
                                : AppVar.textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
