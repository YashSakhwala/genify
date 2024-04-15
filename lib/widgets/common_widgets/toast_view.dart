import 'package:fluttertoast/fluttertoast.dart';
import 'package:genify/config/app_colors.dart';

void toastMessage({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: AppColors.greyColor,
    fontSize: 15,
  );
}
