import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:yellow_pass/routes/app_routes.dart';
import 'package:yellow_pass/widgets/error_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/utils/initial_bindings.dart';
import 'core/utils/logger.dart';
import 'core/utils/navigation_service.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'packages/OverlayLoading/lib/loader_overlay.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder =
      (FlutterErrorDetails details) => AppFlutterErrorScreen(details: details);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());}
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GlobalLoaderOverlay(
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return const Center(
          child: CircularProgressIndicator(color: Colors.white,)
        );
      },
      overlayColor: Colors.black.withOpacity(0.4),
      child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
        theme: FlexThemeData.light(
          scheme: FlexScheme.blumineBlue,
          colorScheme: flexSchemeLight,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.blumineBlue,
          colorScheme: flexSchemeDark,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog,
          blendLevel: 19,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
        ),
        themeMode: ThemeMode.system,
            locale: Get.deviceLocale,
        navigatorKey: NavigationService.navigatorKey,

        //for setting localization strings
            fallbackLocale: Locale('en', 'US'),
            title: 'Yellow Pass',
            initialBinding: InitialBindings(),
            initialRoute: AppRoutes.splashScreenRoute,
            getPages: AppRoutes.pages,
          ),
    );
  }
}
