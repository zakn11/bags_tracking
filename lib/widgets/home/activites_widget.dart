import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/controller/life_cycle_controller.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/modules/qr_scan/controller/qr_scan_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/home/custom_activites_widget.dart';
import 'package:tracking_system_app/widgets/home/note_widget.dart';

class ActivitesWidget extends StatelessWidget {
  const ActivitesWidget({
    super.key,
    required this.homeController,
  });
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    final isTaplet = MediaQuery.of(context).size.width > 800;
    final dataFontSize =
        MediaQuery.of(context).size.width * (0.066);
    return Center(
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: AppSizeH.s20, horizontal: isTaplet ? AppSizeW.s40 : AppSizeW.s20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizeR.s60),
            topRight: Radius.circular(AppSizeR.s60),
          ),
          color: AppVar.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizeH.s10),
              child: Text(
                "Activities",
                style: TextStyle(
                  fontSize: isTaplet ? dataFontSize - 20 : dataFontSize,
                  color: AppVar.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomActivitiesCardWidget(
                  isDeleverd: false,
                  width: isTaplet ? AppSizeW.s200 : null,
                  height: isTaplet ? AppSizeH.s296 : null,
                  imageName: "assets/images/boxes (1).png",
                  label: "Check In",
                  onTap: () {
                    final qrScanController = Get.put(QrScanController());
                    qrScanController.scanningKind.value = "check_in";
                    qrScanController.lockOrientation();
                    final liefCycleController = Get.find<LifecycleController>();
                    liefCycleController.enterQrScanView();

                    Get.toNamed(Routes.QR_SCANN);
                  },
                  homeController: homeController,
                  index: 0,
                ),
                CustomActivitiesCardWidget(
                  isDeleverd: true,
                  width: isTaplet ? AppSizeW.s200 : null,
                  height: isTaplet ? AppSizeH.s296 : null,
                  imageName: "assets/images/scooter.png",
                  label: "Delivered",
                  onTap: () {
                    final qrScanController = Get.put(QrScanController());
                    qrScanController.scanningKind.value = "delivered";
                    qrScanController.lockOrientation();
                    final liefCycleController = Get.find<LifecycleController>();
                    liefCycleController.enterQrScanView();

                    Get.toNamed(Routes.QR_SCANN);
                  },
                  homeController: homeController,
                  index: 1,
                ),
                CustomActivitiesCardWidget(
                  isDeleverd: false,
                  width: isTaplet ? AppSizeW.s200 : null,
                  height: isTaplet ? AppSizeH.s296 : null,
                  imageName: "assets/images/Character (1).png",
                  label: "Check Out",
                  onTap: () {
                    final qrScanController = Get.put(QrScanController());
                    qrScanController.scanningKind.value = "check_out";
                    qrScanController.lockOrientation();
                    final liefCycleController = Get.find<LifecycleController>();
                    liefCycleController.enterQrScanView();

                    Get.toNamed(Routes.QR_SCANN);
                  },
                  homeController: homeController,
                  index: 2,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizeH.s20),
              child: Text(
                "Explanations",
                style: TextStyle(
                  fontSize: isTaplet ? dataFontSize - 20 : dataFontSize,
                  color: AppVar.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            NoteWidget(
              title: "Check In: ",
              content: "The bag entered the warehous",
            ),
            Divider(
              thickness: AppSizeW.s2,
              color: AppVar.secondary,
            ),

            NoteWidget(
              title: "Delivered: ",
              content: "The bag arrived to the client",
            ),
            Divider(
              thickness: AppSizeW.s2,
              color: AppVar.secondary,
            ),
            NoteWidget(
              title: "Check Out: ",
              content: "The bag leave the warehous",
            ),
          ],
        ),
      ),
    );
  }
}
