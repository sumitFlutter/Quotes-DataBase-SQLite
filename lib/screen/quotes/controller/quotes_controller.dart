import 'package:get/get.dart';
import 'dart:math';
class QuotesController extends GetxController{
  RxInt indexAPI=0.obs;
  RxInt fIndexJson=0.obs;
  RxInt lIndexJson=0.obs;
  RxInt randomWallpaper=1.obs;
  int randomFont=1;
  void random(int min, int max) {
    randomWallpaper.value=(min + Random().nextInt(max - min));
  }
  void randomFontFamilyGetter(int min, int max) {
    randomFont=(min + Random().nextInt(max - min));
    update();
  }
}