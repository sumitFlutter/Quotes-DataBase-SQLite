import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../utils/helpers/db_helper.dart';
import '../../home/controller/home_controller.dart';
import '../controller/db_controller.dart';

class DBQuotesViewScreen extends StatefulWidget {
  const DBQuotesViewScreen({super.key});

  @override
  State<DBQuotesViewScreen> createState() => _DBQuotesViewScreenState();
}

class _DBQuotesViewScreenState extends State<DBQuotesViewScreen> {
  DBController dbController=Get.put(DBController());
  HomeController homeController=Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Obx(
            () => ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(dbController.dbQuotesModelList[index].quote!,style: TextStyle(fontWeight: FontWeight.bold,),),
                subtitle: Text("${dbController.dbQuotesModelList[index].author!}\n(${dbController.dbQuotesModelList[index].category!})",style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: IconButton(onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text("Are you sure?"),
                      actions: [
                        ElevatedButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: Text("No!")),
                        ElevatedButton(onPressed: () {
                          DBHelper.dbHelper.deleteQuotes(id: dbController.dbQuotesModelList[index].id!);
                          dbController.readQuotes();
                          Navigator.pop(context);
                        }, child: Text("Yes!"))
                      ],
                    );
                  },);
                }, icon: Icon(Icons.delete,)),
              ),
            );
          },itemCount: dbController.dbQuotesModelList.length,),
      ),
    );
  }
}