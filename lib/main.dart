
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/firebase_options.dart';
import 'package:social_media_application/shared/components/constants.dart';
import 'package:social_media_application/shared/cubit/app/app_cubit.dart';
import 'package:social_media_application/shared/cubit/layout/social_layout/cubit.dart';
import 'package:social_media_application/shared/styles/themes/themes.dart';

import 'layout/social_layout.dart';
import 'modules/login/login_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'shared/cubit/app/bloc_observer.dart';
import 'shared/cubit/app/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
 // This is the first line of the main function
  Bloc.observer = MyBlocObserver(); // MyBlocObserver is a custom BlocObserver used to observe the state changes in the app
  // initialize the Dio package
  // Dio means Data I/O, it is a powerful Http client for Dart,
  // which supports Interceptors, Global configuration, FormData,
  // Request Cancellation, File downloading, Timeout etc.
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = await CacheHelper.getData(key: 'uId');

  print('token: $token');



  if(onBoarding!=null){
    if(token != null) widget = SocialLayout();
    else widget = SocialLoginScreen();
  }else{
    widget = OnBoardingScreen();
  }


  runApp(MyApp(
    isDark: isDark ?? false,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final bool isDark;
  final Widget startWidget;
  MyApp({required this.isDark, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AppCubit()..changeAppMode(fromShared: true)),
          BlocProvider(create: (context) => SocialLayoutCubit()..getUserData()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                home: startWidget,
              );
            }));
  }
}
