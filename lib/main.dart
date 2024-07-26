import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficient_school/firebase_options.dart';
import 'package:efficient_school/screens/splash.dart';
import 'package:efficient_school/services/user_notifier.dart';
import 'package:efficient_school/utils/shared_prefs.dart';
import 'package:efficient_school/utils/size.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'blocs/announcement/announcement_bloc.dart';
import 'repositories/announcement_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final AnnouncementRepository announcementRepository =
      AnnouncementRepository(firestore: FirebaseFirestore.instance);
  await SharedPrefs().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserNotifier(),
        ),
        BlocProvider(
          create: (context) => AnnouncementBloc(announcementRepository),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Efficient School',
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
