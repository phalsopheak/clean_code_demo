import 'dart:io';

import 'package:demo_clean_code/core/enum/transaction_action_enum.dart';
import 'package:demo_clean_code/presentation/controller/customer_controller.dart';
import 'package:demo_clean_code/presentation/screen/customer/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerScreen extends StatelessWidget {
  final CustomerController customerController = Get.find();
  CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const Customer(
                transactionAction: TransactionAction.add,
              ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: customerController.listCustomer
                  .map((x) => Card(
                        child: SizedBox(
                          child: Row(
                            children: [
                              x.picture == null
                                  ? Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey.shade300),
                                      child: const Center(
                                        child: Icon(
                                          CupertinoIcons.photo,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        File(x.picture!),
                                        fit: BoxFit.fill,
                                        width: 45,
                                        height: 45,
                                      ),
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(x.name),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(x.phone),
                            ],
                          ),
                          height: 50,
                          width: double.infinity,
                        ),
                      ))
                  .toList(),
            ),
          )),
    );
  }
}
