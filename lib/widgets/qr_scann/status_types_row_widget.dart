
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class StatusTypesRowWidget extends StatelessWidget {
  const StatusTypesRowWidget({
    super.key,
    required this.qrController,
    required this.isTaplet,
  });

  final QrScanController qrController;
  final bool isTaplet;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizeR.s15),
        color: Colors.white,
        border: Border.all(
          color: AppVar.textColor,
          width: AppSizeW.s2,
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizeH.s10, horizontal: AppSizeW.s20),
              decoration: BoxDecoration(
                borderRadius:
                    qrController.scanningKind.value ==
                            "check_in"
                        ? BorderRadius.circular(AppSizeR.s13)
                        : null,
                color:
                    qrController.scanningKind.value ==
                            "check_in"
                        ? AppVar.primary
                        : Colors.transparent,
              ),
              child: Text(
                "Check In  ",
                style: TextStyle(
                  color:
                      qrController.scanningKind.value ==
                              "check_in"
                          ? Colors.white
                          : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: isTaplet ? AppSizeSp.s20 : AppSizeSp.s12,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizeH.s10, horizontal: AppSizeW.s20),
              decoration: BoxDecoration(
                border: qrController
                                .scanningKind.value !=
                            "delivered" &&
                        qrController
                                .scanningKind.value ==
                            "check_out"
                    ? Border(
                        left: BorderSide(
                          width: AppSizeW.s1,
                        ),
                      )
                    : qrController.scanningKind.value !=
                                "delivered" &&
                            qrController.scanningKind
                                    .value ==
                                "check_in"
                        ? Border(
                            right: BorderSide(
                              width: AppSizeW.s1,
                            ),
                          )
                        : null,
                borderRadius: qrController
                            .scanningKind.value ==
                        "delivered"
                    ? BorderRadius.circular(AppSizeR.s15)
                    : qrController.scanningKind.value ==
                            "check_in"
                        ? BorderRadius.only(
                            topRight:
                                Radius.circular(AppSizeR.s15),
                            bottomRight:
                                Radius.circular(AppSizeR.s15),
                          )
                        : BorderRadius.only(
                            topLeft:
                                Radius.circular(AppSizeR.s15),
                            bottomLeft:
                                Radius.circular(AppSizeR.s15),
                          ),
                color:
                    qrController.scanningKind.value ==
                            "delivered"
                        ? AppVar.primary
                        : Colors.transparent,
              ),
              child: Text(
                "Delivered",
                style: TextStyle(
                  color:
                      qrController.scanningKind.value ==
                              "delivered"
                          ? Colors.white
                          : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: isTaplet ? AppSizeSp.s20 : AppSizeSp.s12,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizeH.s10, horizontal: AppSizeW.s20),
              decoration: BoxDecoration(
                borderRadius:
                    qrController.scanningKind.value ==
                            "check_out"
                        ? BorderRadius.circular(AppSizeR.s13)
                        : null,
                color:
                    qrController.scanningKind.value ==
                            "check_out"
                        ? AppVar.primary
                        : Colors.transparent,
              ),
              child: Text(
                "Check Out",
                style: TextStyle(
                  color:
                      qrController.scanningKind.value ==
                              "check_out"
                          ? Colors.white
                          : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: isTaplet ? AppSizeSp.s20 : AppSizeSp.s12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}