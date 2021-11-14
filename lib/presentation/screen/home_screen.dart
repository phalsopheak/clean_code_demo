import 'package:demo_clean_code/core/constant/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Clean Code'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.blueAccent,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.toNamed(AppRoute.product);
              },
              child: const ListTile(
                title: Text('Product'),
                leading: Icon(Icons.code),
              ),
            )
          ],
        ),
      ),
    );
  }
}
