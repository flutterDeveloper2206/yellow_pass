import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:yellow_pass/core/utils/size_utils.dart';
import 'package:yellow_pass/widgets/custom_image_view.dart';
import '../../core/utils/image_constant.dart';
import '../../routes/app_routes.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreen extends GetWidget<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          body: VideoPlayerWidget(),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  final splashController = Get.find<SplashScreenController>();

  @override
  void initState() {
    super.initState();

    // Hide system UI for fullscreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    videoPlayerController = VideoPlayerController.asset(
      ImageConstant.splashVideo,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
      setState(() {});
      videoPlayerController.play();
    });

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position >=
          videoPlayerController.value.duration) {
        Get.offNamed(AppRoutes.onBoardingRoute);
      }
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();

    // Restore UI after leaving
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController.value.isInitialized
        ? SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover, // makes video full screen without distortion
        child: SizedBox(
          width: videoPlayerController.value.size.width,
          height: videoPlayerController.value.size.height,
          child: VideoPlayer(videoPlayerController),
        ),
      ),
    )
        :  Container(color: Colors.black87,);
  }
}
