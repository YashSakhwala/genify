import 'package:get/get.dart';

class RecordeController extends GetxController {
  RxBool isStart = false.obs;
  RxBool isStop = false.obs;
  RxInt seconds = 00.obs;
  RxInt minutes = 00.obs;
  RxInt hours = 00.obs;
}