import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/utils/client/client_handshake.dart';
import 'package:quotes_app_db/utils/routes/my_routes.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global=MyHttpOverrides();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
    ),
  );
}