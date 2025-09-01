import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class CustomersListWidget extends StatelessWidget {
  const CustomersListWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    // final isTaplet = MediaQuery.of(context).size.width > 800 &&
    //     MediaQuery.of(context).size.height > 800;
    return Obx(() {
      if (controller.customersList.isEmpty) {
        return Center(
            child: Container(
          alignment: Alignment.center,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: AppSizeW.s100,
                height: AppSizeH.s100,
                child: Image.asset(
                  color: AppVar.primary,
                  "assets/images/customer.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: AppSizeH.s20),
              Text(
                "There is no customers for you",
                style: TextStyle(
                  fontSize: AppSizeSp.s16,
                  fontFamily: "ABeeZee",
                  color: AppVar.primary,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ));
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizeW.s20, vertical: AppSizeH.s30),
        child: Column(
          children: [
            Text(
              "My Costomers",
              style: TextStyle(
                fontSize: AppSizeSp.s30,
                color: AppVar.primary,
                decoration: TextDecoration.none,
              ),
            ),
            Divider(
              color: AppVar.secondary,
              thickness: AppSizeW.s2,
              endIndent: AppSizeW.s20,
              indent: AppSizeW.s20,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.customersList.length,
              itemBuilder: (context, index) {
                final item = controller.customersList[index];
                return GestureDetector(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: AppSizeH.s5),
                    padding:
                        EdgeInsets.symmetric(vertical: AppSizeH.s8, horizontal: AppSizeW.s12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizeR.s7),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                fontSize: AppSizeSp.s13,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              "Bags Ids: ${item.bags}",
                              style: TextStyle(
                                fontSize: AppSizeSp.s13,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizeH.s20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Address:${item.address}",
                              style: TextStyle(
                                fontSize:  AppSizeSp.s13,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              item.phone ?? "",
                              style: TextStyle(
                                fontSize:AppSizeSp.s13,
                                fontWeight: FontWeight.bold,
                                color: AppVar.primary,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
