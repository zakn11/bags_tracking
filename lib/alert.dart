import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/helpers/helpers.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class Alert {
  static bool? _progressDialog;

  static toast(String msg) {
    Get.showSnackbar(GetSnackBar(
      message: tr(msg),
      duration: const Duration(seconds: 3),
      isDismissible: true,
    ));
  }

  static Future progress() async {
    _progressDialog = true;
    return Get.dialog(
      Dialog(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizeR.s10)),
        child: Wrap(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizeW.s20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: AppSizeH.s25),
                  text01(
                    '${tr('Please Wait')}..',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    ).then((_) => _progressDialog = false);
  }

  static Future hideProgress() async {
    if (_progressDialog ?? false) Navigator.of(Get.overlayContext!).pop();
  }

  static Future confirmDialog(
      {required String? message, required VoidCallback onOk}) {
    return Get.dialog(
      Dialog(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizeR.s10)),
        child: Wrap(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizeW.s20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  text01(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: AppSizeH.s20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(Get.overlayContext!).pop();
                        },
                        child: Container(
                          width: (MediaQuery.of(Get.context!).size.width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(AppSizeW.s10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(AppSizeR.s5),
                          ),
                          child: text01(
                            'No',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(Get.overlayContext!).pop();
                          onOk();
                        },
                        child: Container(
                          width: (MediaQuery.of(Get.context!).size.width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(AppSizeW.s10),
                          decoration: BoxDecoration(
                            color: AppVar.primary,
                            borderRadius: BorderRadius.circular(AppSizeR.s5),
                          ),
                          child: text01(
                            'Yes',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future smallBoxDialog(
      {required String? message,
      required TextEditingController messageController,
      required VoidCallback onOk}) {
    return Get.dialog(
      Dialog(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizeR.s10)),
        child: Wrap(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizeW.s20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  text01(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: AppSizeH.s20,
                  ),
                  TextField01(
                    minLines: 6,
                    maxLines: 8,
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    textDirection: AppVar.LANG_CODE == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    decoration: InputDecoration(
                        labelText: tr('Message to patient'),
                        errorStyle: TextStyle(
                            color: Colors.redAccent, fontSize: AppSizeSp.s16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizeR.s5))),
                  ),
                  SizedBox(
                    height: AppSizeH.s20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(Get.overlayContext!).pop();
                        },
                        child: Container(
                          width: (MediaQuery.of(Get.context!).size.width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(AppSizeW.s10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(AppSizeR.s5),
                          ),
                          child: text01(
                            'No',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(Get.overlayContext!).pop();
                          onOk();
                        },
                        child: Container(
                          width: (MediaQuery.of(Get.context!).size.width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(AppSizeW.s10),
                          decoration: BoxDecoration(
                            color: AppVar.primary,
                            borderRadius: BorderRadius.circular(AppSizeR.s5),
                          ),
                          child: text01(
                            'Yes',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future infoDialog({required String message}) {
    return Get.dialog(
      Dialog(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizeR.s10)),
        child: Directionality(
          child: Container(
            padding: EdgeInsets.all(AppSizeW.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                text01(
                  message,
                ),
                SizedBox(
                  height: AppSizeH.s20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(Get.overlayContext!).pop();
                      },
                      child: Container(
                        width: (MediaQuery.of(Get.context!).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(AppSizeW.s10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(AppSizeR.s5),
                        ),
                        child: text01('Ok',
                            style: TextStyle(
                              color: AppVar.textColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          textDirection:
              AppVar.LANG_CODE == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        ),
      ),
      barrierDismissible: false,
    );
  }
}
