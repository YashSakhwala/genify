// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'voice_recorder_view/voice_recorder_common_view.dart'; 

class VoiceRecorderScreen extends StatefulWidget {
  const VoiceRecorderScreen({super.key});

  @override
  State<VoiceRecorderScreen> createState() => _VoiceRecorderScreenState();
}

class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: VoiceRecorderCommonViewScreen(),
      tabletView: VoiceRecorderCommonViewScreen(),
      mobileView: VoiceRecorderCommonViewScreen(),
    );
  }
}
