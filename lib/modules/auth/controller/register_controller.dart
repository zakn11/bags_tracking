import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/controller/radio_controller.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  // final TextEditingController employeeNumberController =
  //     TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final RadioController jopTitleController =
      Get.put(RadioController(), tag: 'JopTitle');
  final List<String> radioData = ['Store Employee', 'Driver'];
  // final TextEditingController jopTitleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isWaitAdminApproved = false.obs;
  // late AnimationController lottieController;
  var isLoading = false.obs;

  void showLoadingDialog() {
    Get.dialog(
      const Center(
        child: MainLoadingWidget(),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> sendInfoToAdmin() async {
    try {
      final response = await $.post('/register', body: {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        'phone': "+971${phoneNumberController.text}",
        "role": jopTitleController.selectedValue.value == 0
            ? "store_employee"
            : "driver",
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
      });

      if (response != null) {
        isWaitAdminApproved.value = true;
        Future.delayed(const Duration(seconds: 3), () {
          isWaitAdminApproved.value = false;
          Get.offAllNamed(Routes.LOGIN);
        });
      }
      // Get.offAllNamed(Routes.LOGIN);

      isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    }
  }

  void validateForm() {
    if (firstNameController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your Full Name');
      return;
    }

    if (jopTitleController.selectedValue.value == null) {
      CustomToast.errorToast('Error', 'Please choose a job title');
      return;
    }
    // if (employeeNumberController.text.isEmpty) {
    //   Get.closeAllSnackbars();
    //   CustomToast.errorToast('Error', 'Please enter your employee number');
    //   return;
    // }

    if (phoneNumberController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your phone number');

      return;
    }

    final RegExp uaePhoneRegex =
        // RegExp(r'^(?:50|51|52|55|56|58|2|3|4|6|7|9)\d{7}$');
        RegExp(r'^(?:5)\d{8}$');

    if (!uaePhoneRegex.hasMatch(phoneNumberController.text)) {
      Get.closeAllSnackbars();
      CustomToast.errorToast(
          'Error', 'Please enter a valid Emirates phone number');

      return;
    }

    if (passwordController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your password');

      return;
    } else if (passwordController.text.length < 6) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Password must be at least 6 characters');

      return;
    }

    if (confirmPasswordController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please confirm your password');

      return;
    } else if (confirmPasswordController.text != passwordController.text) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Confirmed password does not match');

      return;
    }

    // If all validations pass, proceed
    showLoadingDialog();
    sendInfoToAdmin();
  }

  @override
  void onClose() {
    // lottieController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    // employeeNumberController.dispose();
    jopTitleController.dispose();
    super.dispose();
  }
}
