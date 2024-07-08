import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      token = await Methods.instance.returnUserToken();
    });

    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('asset/images/Logoanimation.mp4');

    _videoPlayerController.initialize().then((value) {
      _videoPlayerController.setLooping(false);
      Timer(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            _videoPlayerController.play();
          });
        }
      });
    });

    Future.delayed(const Duration(milliseconds: 5000), () {
      _videoPlayerController.dispose();
      Navigator.pushNamedAndRemoveUntil(
          context,
          token == null || token == 'noToken' ? Routes.login : Routes.main,
          (route) => false);
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController),
        ),
      ),
    );
  }
}
