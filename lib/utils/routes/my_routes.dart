import 'package:flutter/material.dart';
import 'package:quotes_app_db/screen/home/view/home_screen.dart';
import 'package:quotes_app_db/screen/quotes/view/quotes_screen.dart';

Map <String, WidgetBuilder> appRoutes={
  "/":(context) => HomeScreen(),
  "quotes":(context) => QuotesScreen()
};