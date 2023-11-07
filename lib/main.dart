import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:videos/routes/app_routes.dart';
import 'package:videos/state-example/form_widgets.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
      options.tracesSampleRate = 1.0;
      options.debug = true;
      options.sendDefaultPii = true;
      options.reportSilentFlutterErrors = true;
      options.attachScreenshot = true;
      options.screenshotQuality = SentryScreenshotQuality.low;
      options.attachViewHierarchy = true;
      options.considerInAppFramesByDefault = false;
      options.attachThreads = true;
      options.enableWindowMetricBreadcrumbs = true;
      options.environment = "production";
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mobile",
        theme: ThemeData.dark(),
        home: const FormExample()
    );
    /*
    return MaterialApp.router(
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      title: 'Go Router',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(),
      ),
    );
    */
  }
}

