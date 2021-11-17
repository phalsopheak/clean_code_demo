import 'package:demo_clean_code/core/constant/app_route.dart';
import 'package:demo_clean_code/core/di/main_binding.dart';
import 'package:demo_clean_code/presentation/screen/home_screen.dart';
import 'package:demo_clean_code/presentation/screen/product/add_product.dart';
import 'package:demo_clean_code/presentation/screen/product/edit_product.dart';
import 'package:demo_clean_code/presentation/screen/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: AppTheme.red(),
      // locale: AppLocalization.locale,
      // fallbackLocale: AppLocalization.fallbackLocale,
      // translations: AppLocalization(),
      initialBinding: MainBinding(),
      // initialRoute: AppConfig.welcomeScreenStartUp == true
      //     ? RouteName.language
      //     : RouteName.home,
      initialRoute: AppRoute.home,
      getPages: [
        GetPage(
          name: AppRoute.home,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: AppRoute.product,
          page: () => ProductScreen(),
        ),
        GetPage(
          name: AppRoute.addProduct,
          page: () => const AddProduct(),
        ),
        GetPage(
          name: AppRoute.editProduct,
          page: () => const EditProduct(),
        ),
      ],
    );
  }
}
