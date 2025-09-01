import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class QRResultPage extends StatelessWidget {
  final QrScanController qrController = Get.put(QrScanController());

  QRResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        onPopInvokedWithResult: (popDisposition, result) {
          qrController.closeScreen();
          return;
        },
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: const Color(0xffDEFEEF),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  color: AppVar.primary,
                  onPressed: () {
                    qrController.closeScreen();
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              body: Center(
                child: Container(
                  padding: EdgeInsets.all(AppSizeW.s40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizeR.s20),
                    color: const Color(0xffD9FFE3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: AppSizeW.s2,
                        blurRadius: AppSizeW.s10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: AppSizeH.s20),
                        child: Text(
                          "Success",
                          style: TextStyle(
                            color: AppVar.primary,
                            fontSize: AppSizeSp.s40,
                          ),
                        ),
                      ),
                      QrImageView(
                        data: qrController.code.value,
                        size: AppSizeW.s150,
                        version: QrVersions.auto,
                      ),
                      SizedBox(height: AppSizeH.s10),
                      SizedBox(
                        width: AppSizeW.s226,
                        child: Text(
                          "${qrController.qrScanModel.value.customerName}, ${qrController.qrScanModel.value.bagId}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppVar.primary,
                            fontSize: AppSizeSp.s20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizeH.s20),
                      Obx(() {
                        return AnimatedSwitcher(
                          duration: const Duration(
                              milliseconds: 300),
                          child: qrController.showLottieAnimationInResult.value
                              ? SizedBox(
                                  key: const ValueKey(
                                      'lottie'), 
                                  width: AppSizeW.s60,
                                  height: AppSizeH.s60,
                                  child: Lottie.asset(
                                    'assets/Lottie/Animation - 1726871315481.json',
                                    repeat: false,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : GestureDetector(
                                  key: const ValueKey(
                                      'copyButton'),
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text:
                                            "${qrController.qrScanModel.value.customerName}, ${qrController.qrScanModel.value.bagId}"));
                                    qrController.showLottieAnimationFunction();
                                  },
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: qrController
                                            .showLottieAnimationInResult.value
                                        ? 0.0
                                        : 1.0,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: EdgeInsets.only(bottom: AppSizeH.s20),
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppSizeH.s5, horizontal: AppSizeW.s20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSizeR.s10),
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: AppVar.primary,
                                          width: AppSizeW.s2,
                                        ),
                                      ),
                                      child: Text(
                                        "Copy",
                                        style: TextStyle(
                                          fontSize: AppSizeSp.s20,
                                          color: AppVar.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: -62,
              right: -62,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10000),
                    color: Colors.transparent,
                    border: Border.all(
                      color: AppVar.primary,
                      width: 1,
                    )),
              ),
            ),
            Positioned(
              bottom: 220,
              right: -110,
              child: Opacity(
                opacity: .1,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: AppVar.primary,
                      border: Border.all(
                        color: AppVar.primary,
                        width: 1,
                      )),
                ),
              ),
            ),
            Positioned(
              bottom: 300,
              left: -10,
              child: Opacity(
                opacity: .1,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: AppVar.primary,
                      border: Border.all(
                        color: AppVar.primary,
                        width: 1,
                      )),
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: -40,
              child: Opacity(
                opacity: .1,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: AppVar.primary,
                      border: Border.all(
                        color: AppVar.primary,
                        width: 1,
                      )),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 40,
              child: Opacity(
                opacity: .1,
                child: Container(
                  width: 50,
                  height: 50,
                  // margin: const EdgeInsets.only(bottom: 20),
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: AppVar.primary,
                      border: Border.all(
                        color: AppVar.primary,
                        width: 1,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
