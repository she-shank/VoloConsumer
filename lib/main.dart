import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volo_consumer/screens/home/logic/home_cubit.dart';
import 'package:volo_consumer/screens/login/logic/login_cubit.dart';
import 'package:volo_consumer/screens/signup/logic/signup_cubit.dart';
import 'package:volo_consumer/screens/splash/splash_screen.dart';
import 'package:volo_consumer/services/navigation_service.dart';
import 'package:volo_consumer/services/services.dart';
import 'package:volo_consumer/utils/configs/router.dart';
import 'package:volo_consumer/utils/init.dart';
import 'package:volo_consumer/utils/locator.dart';

//TODO: make global theme Service
//TODO: make login ND SIGNUP and intro screen
//TODO: setup native splash, app icon, app name
//TODO: implement PostFrontEnd
//TODO: change mRating type to double from String in post datamodel class

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: SplashScreen());
        } else if (snapshot.connectionState == ConnectionState.done) {
          String _initRoute;
          if (snapshot.hasData) {
            _initRoute = snapshot.data;
          } else {
            _initRoute = "/dEfAuLtCaSe";
          }

          return ScreenUtilInit(
            designSize: const Size(500, 2000),
            builder: () => BlocBuilder<ThemeCubit, ThemeState>(
              bloc: ThemeCubit(),
              builder: (context, state) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => HomeCubit()),
                    BlocProvider(create: (context) => LoginCubit()),
                    BlocProvider(create: (context) => SignupCubit()),
                  ],
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    navigatorKey:
                        locator.get<NavigationService>().navigationKey,
                    title: 'VOLODeals Consumer App',
                    theme: state.themeData,
                    initialRoute: _initRoute,
                    onGenerateRoute: AppRouter.onGenerateRoute,
                  ),
                );
              },
            ),
          );
        } else {
          return const MaterialApp(
              home: Center(
            child: Text("please restart"),
          ));
        }
      },
    );
  }
}
