// ignore_for_file: deprecated_member_use, avoid_print, non_constant_identifier_names, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import 'package:get/get.dart';
import '../../../controller/record_controller.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/dialog_view.dart';
import 'package:record/record.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';

import '../../../widgets/common_widgets/snackbar_view.dart';
import '../../bottom_bar/bottom_bar_screen.dart';

class VoiceRecorderCommonViewScreen extends StatefulWidget {
  const VoiceRecorderCommonViewScreen({Key? key}) : super(key: key);

  @override
  _VoiceRecorderCommonViewScreenState createState() =>
      _VoiceRecorderCommonViewScreenState();
}

class _VoiceRecorderCommonViewScreenState
    extends State<VoiceRecorderCommonViewScreen> {
  RecordeController recordeController = Get.put(RecordeController());

  final TextEditingController savName = TextEditingController();
  Timer? timer;

  void _init() async {
    String musicDir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    Directory folder = Directory("$musicDir/voice recorder");
    if (!await folder.exists()) {
      await folder.create();
    }
    Directory folder1 = Directory("$musicDir/voice recorder/voice");
    Directory folder2 = Directory("$musicDir/voice recorder/save");
    Directory folder3 = Directory("$musicDir/voice recorder/.private");

    if (!await folder1.exists()) {
      await folder1.create();
    }
    if (!await folder2.exists()) {
      await folder2.create();
    }
    if (!await folder3.exists()) {
      await folder3.create();
    }
  }

  void count() async {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (recordeController.seconds.value == 59) {
        recordeController.seconds.value = 0;
        recordeController.minutes.value++;
        if (recordeController.minutes.value == 59) {
          recordeController.minutes.value = 0;
          recordeController.hours.value++;
        }
      } else {
        recordeController.seconds.value++;
      }
    });
  }

  final record = Record();
  void startRecord() async {
    String musicDir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    Directory folder = Directory("$musicDir/voice recorder/.private/tmp.mp3");
    if (await record.hasPermission()) {
      count();
      await record.start(
        path: folder.path,
      );
    }
  }

  void pauseRecorde() async {
    timer!.cancel();
    await record.pause();
  }

  void cancelTime() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    recordeController.seconds.value = 0;
    recordeController.minutes.value = 0;
    recordeController.hours.value = 0;
  }

  void resume() async {
    count();
    await record.resume();
  }

  @override
  void dispose() {
    () async {
      await record.dispose();
    }();
    cancelTime();
    super.dispose();
  }

  @override
  void initState() {
    _init();

    recordeController.isStart.value = false;
    recordeController.isStop.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Voice recorder",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [
            SizedBox(
              height: size.height / 10,
              child: Obx(
                () => recordeController.isStart.value == false
                    ? Image.asset(
                        AppImages.audio_waves,
                      )
                    : recordeController.isStop.value
                        ? Image.asset(
                            AppImages.audio_waves,
                          )
                        : Image.asset(
                            AppImages.audio_waves,
                          ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Obx(
              () => recordeController.isStart.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Obx(
                            () => Text(
                              "${recordeController.hours.value}:${recordeController.minutes.value}:${recordeController.seconds.value}",
                              style: AppTextStyle.smallTextStyle
                                  .copyWith(fontSize: 32),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async {
                                toastView(
                                  msg: "Recording is not saved...",
                                  context: context,
                                );

                                cancelTime();
                                await record.stop();
                                String musicDir = await ExternalPath
                                    .getExternalStoragePublicDirectory(
                                        ExternalPath.DIRECTORY_DOWNLOADS);
                                Directory folder = Directory(
                                    "$musicDir/voice recorder/.private/tmp.mp3");
                                File file = File(folder.path);
                                try {
                                  await file.delete();
                                } catch (e) {
                                  print(e.toString());
                                }
                                recordeController.isStart.value = false;
                                recordeController.isStop.value = false;
                              },
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFFFEEED),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Image.asset(
                                    AppImages.cancel,
                                    color: const Color(0xFFDB2726),
                                    height: 25,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showSaveDialogBox();
                              },
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFEFF3FF),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Image.asset(
                                    AppImages.yes,
                                    color: const Color(0xFF1F70FF),
                                    height: 30,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height / 2.7,
                        ),
                        InkWell(
                          onTap: () async {
                            if (recordeController.isStop.value) {
                              resume();
                            } else {
                              pauseRecorde();
                            }
                            recordeController.isStop.value =
                                !recordeController.isStop.value;
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Obx(
                              () => Center(
                                child: recordeController.isStop.value
                                    ? Image.asset(
                                        AppImages.play,
                                        color: AppColors.whiteColor,
                                        height: 30,
                                      )
                                    : Image.asset(
                                        AppImages.pause,
                                        color: AppColors.whiteColor,
                                        height: 30,
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "00 : 00 : 00",
                            style: AppTextStyle.smallTextStyle
                                .copyWith(fontSize: 32),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 2,
                        ),
                        InkWell(
                          onTap: () {
                            recordeController.isStart.value = true;
                            startRecord();
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                AppImages.recorder,
                                color: AppColors.whiteColor,
                                height: 30,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  showSaveDialogBox() {
    String name = "VoiceRecorder-${DateTime.now().microsecondsSinceEpoch}.mp3";
    savName.text = name;

    dialogBoxView(
      context,
      widget: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFe1ecff),
                AppColors.whiteColor,
              ],
            ),
          ),
          child: Material(
            color: AppColors.transparentColor,
            child: Column(
              children: [
                SizedBox(
                  height: 26,
                ),
                Text(
                  "Save Recording",
                  style: AppTextStyle.smallTextStyle.copyWith(
                    fontSize: 22,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor.withOpacity(0.2),
                  child: TextFormField(
                    controller: savName,
                    style: AppTextStyle.smallTextStyle
                        .copyWith(color: AppColors.blackColor),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonView(
                      width: MediaQuery.of(context).size.width / 4,
                      onTap: () async {
                        toastView(
                          msg: "Recording is not saved...",
                          context: context,
                        );
                        cancelTime();
                        Navigator.of(context).pop();

                        await record.stop();
                        String musicDir = await ExternalPath
                            .getExternalStoragePublicDirectory(
                                ExternalPath.DIRECTORY_DOWNLOADS);
                        Directory folder = Directory(
                            "$musicDir/voice recorder/.private/tmp.mp3");
                        File file = File(folder.path);
                        await file.delete();

                        recordeController.isStart.value = false;
                        recordeController.isStop.value = false;
                      },
                      title: "Cancel",
                    ),
                    ButtonView(
                      onTap: () async {
                        cancelTime();
                        Navigator.of(context).pop();

                        await record.stop();
                        String musicDir = await ExternalPath
                            .getExternalStoragePublicDirectory(
                                ExternalPath.DIRECTORY_DOWNLOADS);

                        Directory folder2 =
                            Directory("$musicDir/voice recorder/voice");
                        Directory folder = Directory(
                            "$musicDir/voice recorder/.private/tmp.mp3");
                        File file = File(folder.path);
                        File saveFile = File("${folder2.path}/${savName.text}");
                        await file.copy(saveFile.path);
                        await file.delete();
                        recordeController.isStart.value = false;
                        recordeController.isStop.value = false;

                        showSnackbar(
                          "Voice recorder",
                          "Your recording download successfully !",
                          saveFile.path,
                        );

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => BottomBarScreen(),
                            ),
                            (route) => false);
                      },
                      width: MediaQuery.of(context).size.width / 4,
                      title: "Save",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
