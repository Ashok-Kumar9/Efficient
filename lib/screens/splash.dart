import 'package:efficient_school/screens/announcement_screen.dart';
import 'package:efficient_school/utils/constants/asset_constants.dart';
import 'package:efficient_school/utils/size.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Durations.extralong4);
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AnnouncementScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Container(
            height: SizeConfig.width * 0.3,
            width: SizeConfig.width * 0.3,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(24)),
              image: DecorationImage(
                image: AssetImage(ImageConstants.efficientLogo),
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}
