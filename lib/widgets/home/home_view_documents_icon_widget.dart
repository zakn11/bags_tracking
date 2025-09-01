import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/widgets/home/customers_list_widget.dart';
import 'package:tracking_system_app/style/values_manager.dart';

import '../../style/app_var.dart';

class HomeViewCustomersIconWidget extends StatelessWidget {
  const HomeViewCustomersIconWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged.map((list) => list.first),
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none
              ? Obx(() {
                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 100),
                        child: GestureDetector(
                          onTap: () {
                            controller.isCostumersIconPressed.value = false;
                          },
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: controller.isCostumersIconPressed.value
                                ? 0.9
                                : 0.0,
                            child: Container(
                              width: controller.isCostumersIconPressed.value
                                  ? MediaQuery.sizeOf(context).width
                                  : 0,
                              height: controller.isCostumersIconPressed.value
                                  ? MediaQuery.sizeOf(context).height
                                  : 0,
                              color: const Color(0xffD4D4D4),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            controller.isCostumersIconPressed.value =
                                !controller.isCostumersIconPressed.value;
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      if (controller.isCostumersIconPressed.value)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSizeH.s20),
                          child: snapshot.data == ConnectivityResult.none
                              ? _noInternetWidget()
                              : CustomersListWidget(controller: controller),
                        ),
                    ],
                  );
                })
              : SingleChildScrollView(
                  child: Obx(() {
                    return Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 100),
                          child: GestureDetector(
                            onTap: () {
                              controller.isCostumersIconPressed.value = false;
                            },
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: controller.isCostumersIconPressed.value
                                  ? 0.9
                                  : 0.0,
                              child: Container( 
                                width: controller.isCostumersIconPressed.value
                                    ? MediaQuery.sizeOf(context).width
                                    : 0,
                                height: controller.isCostumersIconPressed.value
                                    ? MediaQuery.sizeOf(context).height
                                    : 0,
                                color: const Color(0xffD4D4D4),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: IconButton(
                            color: AppVar.primary,
                            onPressed: () {
                              controller.isCostumersIconPressed.value =
                                  !controller.isCostumersIconPressed.value;
                            },
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        if (controller.isCostumersIconPressed.value)
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: AppSizeH.s20),
                            child: CustomersListWidget(controller: controller),
                          ),
                      ],
                    );
                  }),
                );
        });
  }

  Widget _noInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage("assets/images/no-internet.png"),
            width: AppSizeW.s150,
            height: AppSizeH.s150,
          ),
          SizedBox(height: AppSizeH.s10),
          Text(
            "Connect to Internet and try again",
            style: TextStyle(
              fontSize: AppSizeSp.s16,
              fontFamily: "ABeeZee",
              color: AppVar.primary,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}
