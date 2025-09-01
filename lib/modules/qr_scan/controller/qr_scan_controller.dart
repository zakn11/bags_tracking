import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking_system_app/controller/life_cycle_controller.dart';
import 'package:tracking_system_app/model/qr_scan_model.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/shared/shared.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

//NOTE FROM ZAKARIA: if u want to go to any page from the scan page, u should make this:
/*qrController.disposeCamera(); Get.back(); */

class QrScanController extends GetxController {
  RxBool isScanCompleted = false.obs;
  RxBool isFlashOn = false.obs;
  RxString code = "".obs;
  RxString gitQrScanUrl = "".obs;
  Rx<QrScanDataModel> qrScanModel = QrScanDataModel(
    customerName: "",
    bagId: 0,
    newState: "",
  ).obs;
  RxString customerName = "".obs;
  RxInt bagId = 0.obs;
  RxString scanningKind = "".obs;
  MobileScannerController? cameraController;
  RxBool isLoading = false.obs;
  RxBool showLottieAnimationInResult = false.obs;


  // lock orientation to portrait when the page is built
  Future<void> lockOrientation() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // // unlock orientation when leaving   the page
  Future<void> resetOrientation() async {
    final liefCycleController = Get.find<LifecycleController>();
    liefCycleController.exitQrScanView();
    isFlashOn.value = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

//i need it JUST when i open the page in first time
  @override
  void onInit() {
    super.onInit();
    // lock orientation to portrait when the QRScan view is initialized
    lockOrientation();
    disposeCamera();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestCameraPermission();
    });

    if (isCameraStarted) {
      startCamera();
    }
    isCameraStarted = true;
  }

  Future<void> disposeCamera() async {
    // reset orientation to allow all orientations when leaving the QRScan view
    resetOrientation();

    isFlashOn.value = false;
    if (cameraController != null) {
      await cameraController!.stop();
      cameraController!.dispose();
      cameraController = null;
    }

    //i call it because the cameraController being null in all time()and i want it to be null and after go back to the page be MobileScannerController()
    cameraController ??= MobileScannerController();
  }

  Future<void> startCamera() async {
    // check if the camera is already initialized to avoid creating multiple instances
    cameraController ??= MobileScannerController();

    if (cameraController != null) {
      await cameraController!.start();
    }
  }

  // stop and dispose of the camera when the controller is destroyed
  @override
  void onClose() {
    Get.delete<QrScanController>();

    super.onClose();
  }

  // close screen and reset the scan state
  void closeScreen() {
    isScanCompleted.value = false;
  }

  // toggle flash
  void toggleFlash() {
    if (cameraController != null) {
      isFlashOn.value = !isFlashOn.value;

      cameraController!.toggleTorch();
    }
  }

  // retry the scanner after stopping and restarting the camera
  Future<void> retryScanner() async {
    isFlashOn.value = false;
    await cameraController?.stop();
    // await Future.delayed(const Duration(milliseconds: 500));
    await cameraController?.start();
  } //=============================Server side================================================================

  Future<void> sendToServerSide(String qrCodeData) async {
    isLoading.value = true; // Show loading indicator
    try {
      //-------------store_employee-----------
      if ($.role == "store_employee") {
        if (scanningKind.value == "check_in") {
          gitQrScanUrl.value = "${code.value}&action=check_in_warehouse";
        } else if (scanningKind.value == "check_out") {
          gitQrScanUrl.value = "${code.value}&action=check_out_warehouse";
        }
      }
      //-------------Driver-----------
      else if ($.role == "driver") {
        if (scanningKind.value == "check_in") {
          gitQrScanUrl.value = "${code.value}&action=check_in_driver";
        } else if (scanningKind.value == "delivered") {
          gitQrScanUrl.value = "${code.value}&action=delivered";
        } else if (scanningKind.value == "check_out") {
          gitQrScanUrl.value = "${code.value}&action=check_out_driver";
        }
      }
      log("zak $gitQrScanUrl.value");
      final response = await $.getQrScan(
        gitQrScanUrl.value,
      );
      if (response != null) {
        isScanCompleted.value = false;
        qrScanModel.value = QrScanDataModel.fromJson(response["data"]);
        Get.toNamed(Routes.QR_RESULT);
      }


      isLoading.value = false;
      // }
    } catch (e) {
      isScanCompleted.value = false;
      isLoading.value = false;
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onDetectBarcode(String qrData) {
    if (!isScanCompleted.value && !isLoading.value) {
      code.value = qrData;

      isScanCompleted.value = true; // scan completed
      // send to the server side with scanned QR data
      sendToServerSide(qrData);
      // disable the scanner for 5 seconds before re-enabling
      Future.delayed(const Duration(seconds: 3), () {
        isScanCompleted.value = false; // allow scanning again
      });
    }
  }

  //--------------------------RESULT VIEW-----------------------------------------
  Future<void> showLottieAnimationFunction() async {
    showLottieAnimationInResult.value = true;
    await Future.delayed(const Duration(seconds: 3));
    showLottieAnimationInResult.value = false;
  }

  //================================================= PIREMISSION--------------------------------
  Future<void> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    } else if (status.isGranted) {
    }
  }
}
