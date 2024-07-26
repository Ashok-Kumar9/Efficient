import 'package:efficient_school/blocs/announcement/announcement_event.dart';
import 'package:efficient_school/blocs/announcement/announcement_state.dart';
import 'package:efficient_school/utils/shared_prefs.dart';
import 'package:efficient_school/utils/size.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:efficient_school/widgets/create_user/create_user_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../blocs/announcement/announcement_bloc.dart';
import '../widgets/announcement/announcement_list.dart';
import 'create_announcement_screen.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AnnouncementBloc>(context).add(LoadAnnouncements());
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        extendBodyBehindAppBar: true,
        body: BlocBuilder<AnnouncementBloc, AnnouncementState>(
          builder: (context, state) {
            if (state is AnnouncementLoading) {
              return Center(
                child: Lottie.asset(
                  "assets/animation/animated_logo.json",
                  height: SizeConfig.width * 0.3,
                  width: SizeConfig.width * 0.3,
                ),
              );
            } else if (state is AnnouncementLoaded) {
              return AnnouncementList(announcements: state.announcements);
            } else {
              return const Center(child: Text('Failed to load announcements'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.highlight,
          onPressed: () {
            if (SharedPrefs().getCurrentUser == null) {
              showDialog(
                context: context,
                builder: (BuildContext context) => const CreateUserPopup(),
              );
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateAnnouncementScreen()),
            );
          },
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
