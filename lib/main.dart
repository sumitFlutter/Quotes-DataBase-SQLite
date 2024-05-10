import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/screen/splash/controller/theme_controller.dart';
import 'package:quotes_app_db/utils/client/client_handshake.dart';
import 'package:quotes_app_db/utils/routes/my_routes.dart';
ThemeController themeController=Get.put(ThemeController());
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global=MyHttpOverrides();
  runApp(
    Obx(() {
      themeController.getTheme();
      themeController.theme=themeController.pTheme;
      return
              GetMaterialApp(
              debugShowCheckedModeBanner: false,
              routes: appRoutes,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeController.mode.value,
              );
    },

    ),
  );
}