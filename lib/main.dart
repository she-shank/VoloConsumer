import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volo_consumer/screens/splash/splash_screen.dart';
import 'package:volo_consumer/services/navigation_service.dart';
import 'package:volo_consumer/utils/configs/router.dart';
import 'package:volo_consumer/utils/init.dart';
import 'package:volo_consumer/utils/locator.dart';

//TODO: make global theme Service
//TODO: make login ND SIGNUP and intro screen
//TODO: setup native splash, app icon, app name

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
            builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: locator.get<NavigationService>().navigationKey,
              title: 'VOLODeals Consumer App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: _initRoute,
              onGenerateRoute: AppRouter.onGenerateRoute,
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
