import 'package:flutter/material.dart';
import 'package:quotes_app_db/screen/database/view/db_dash_screen.dart';
import 'package:quotes_app_db/screen/details/view/details_screen.dart';
import 'package:quotes_app_db/screen/home/view/home_screen.dart';
import 'package:quotes_app_db/screen/splash/view/splash_screen.dart';

Map <String, WidgetBuilder> appRoutes={
  "/":(context) => SplashScreen(),
  "home":(context) => HomeScreen(),
  "details":(context) => DetailsScreen(),
  "dataBase":(context) => DBDashScreen()
};