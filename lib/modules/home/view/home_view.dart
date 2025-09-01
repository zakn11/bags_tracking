import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/home/activites_widget.dart';
import 'package:tracking_system_app/widgets/home/home_view_documents_icon_widget.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTaplet = MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.height > 800;

    final dataFontSize = MediaQuery.of(context).size.width * (0.066);
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Obx(() {
        if (homeController.isMyInfoLoading.value) {
          return const Scaffold(
              backgroundColor: Colors.white, body: MainLoadingWidget());
        }
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/HomeBackground.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  color: AppVar.primary.withValues(alpha: .9),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: isLandscape
                    ? isTaplet
                        ? screenHeight * 0.3
                        : screenHeight * 0.1
                    : screenHeight * 0.5,
                color: AppVar.background,
              ),
            ),
            Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    homeController.showCustomSignOutDialog(context);
                  },
                  icon: Icon(
                    size: isTaplet ? AppSizeSp.s40 : null,
                    Icons.logout,
                    color: AppVar.seconndTextColor,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeController.showCustomMessageDialog(
                          context, homeController);
                    },
                    icon: Icon(
                      size: isTaplet ? AppSizeSp.s40 : null,
                      Icons.messenger_outline,
                      color: AppVar.seconndTextColor,
                    ),
                  ),
                  if ($.role != "store_employee")
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizeW.s15),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            homeController.isCostumersIconPressed.value =
                                !homeController.isCostumersIconPressed.value;
                            homeController.initializeCustomersTypes();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: homeController.isCostumersIconPressed.value
                                ? AppSizeW.s23
                                : AppSizeW.s20,
                            height: homeController.isCostumersIconPressed.value
                                ? AppSizeH.s21
                                : AppSizeH.s18,
                            child: Image.asset(
                              color: Colors.white,
                              "assets/images/customer.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              body: OrientationBuilder(builder: (context, orientation) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: AppSizeH.s20,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        isTaplet ? AppSizeW.s40 : AppSizeW.s20,
                                    left:
                                        isTaplet ? AppSizeW.s40 : AppSizeW.s20,
                                    bottom: 0),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        log("zak ${$.token1}");
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppSizeR.s100),
                                        child: SizedBox(
                                          width: isTaplet
                                              ? AppSizeW.s90
                                              : AppSizeW.s60,
                                          height: isTaplet
                                              ? AppSizeH.s90
                                              : AppSizeH.s60,
                                          child: homeController.myInfoModel
                                                      .value.image !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: homeController
                                                      .myInfoModel.value.image
                                                      .toString(),
                                                  placeholder: (context, url) =>
                                                      const MainLoadingWidget(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    "assets/images/user.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/images/user.png",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom:
                                          isTaplet ? AppSizeH.s8 : AppSizeH.s4,
                                      right:
                                          isTaplet ? AppSizeW.s8 : AppSizeW.s4,
                                      child: Container(
                                        width: AppSizeW.s10,
                                        height: AppSizeH.s10,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          color: const Color.fromARGB(
                                              255, 13, 218, 119),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: AppSizeH.s10),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        isTaplet ? AppSizeW.s40 : AppSizeW.s20),
                                child: Text(
                                  "Hi ${homeController.myInfoModel.value.firstName.split(' ')[0]}!",
                                  style: TextStyle(
                                    fontFamily: "Allerta",
                                    fontSize: dataFontSize,
                                    color: AppVar.seconndTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        isTaplet ? AppSizeW.s40 : AppSizeW.s20),
                                child: Text(
                                  "ID: ${homeController.myInfoModel.value.id} / ${homeController.myInfoModel.value.role}",
                                  style: TextStyle(
                                    fontSize: AppSizeSp.s18,
                                    color: AppVar.seconndTextColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: AppSizeH.s50),
                        ActivitesWidget(homeController: homeController),
                      ],
                    ),
                  ),
                );
              }),
            ),
            Obx(() {
              if (homeController.isCustomersLoading.value) {
                return Stack(
                  children: [
                    Center(
                        child: Opacity(
                      opacity: 0.9,
                      child: Container(
                          height: screenHeight,
                          width: MediaQuery.of(context).size.width,
                          color: const Color(0xffD4D4D4),
                          padding: EdgeInsets.all(AppSizeW.s40),
                          child: const MainLoadingWidget()),
                    )),
                    Positioned(
                      left: 0,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          homeController.isCostumersIconPressed.value =
                              !homeController.isCostumersIconPressed.value;
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                  ],
                );
              }
              return HomeViewCustomersIconWidget(controller: homeController);
            }),
          ],
        );
      }),
    );
  }
}
