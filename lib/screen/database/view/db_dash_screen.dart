import 'package:flutter/material.dart';
import 'package:quotes_app_db/screen/database/view/db_category_view_screen.dart';
import 'package:quotes_app_db/screen/database/view/db_quotes_view_screen.dart';

class DBDashScreen extends StatefulWidget {
  const DBDashScreen({super.key});

  @override
  State<DBDashScreen> createState() => _DBDashScreenState();
}

class _DBDashScreenState extends State<DBDashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Liked Content"),
          bottom: const TabBar(indicatorColor: Colors.blue,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              labelStyle: TextStyle(color: Colors.blue),
              tabs: [
            Tab(text: "Quotes",),
            Tab(text: "Category",)
          ]),
        ),
        body: const TabBarView(children: [
          DBQuotesViewScreen(),
          DBCategoryViewScreen()
        ],),
      ),
    ));
  }
}
