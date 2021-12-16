import 'dart:io';
import 'dart:ui';
import 'package:demo_clean_code/core/constant/app_directory.dart';
import 'package:demo_clean_code/core/enum/transaction_action_enum.dart';
import 'package:demo_clean_code/data/model/customer_model.dart';
import 'package:demo_clean_code/presentation/controller/customer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:demo_clean_code/presentation/widget/textbox.dart';

class Customer extends StatefulWidget {
  const Customer({
    Key? key,
    required this.transactionAction,
  }) : super(key: key);

  final TransactionAction transactionAction;

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final CustomerController customerController = Get.find();

  late TextEditingController tecCode;
  late TextEditingController tecName;
  late TextEditingController tecPhone;
  late TextEditingController tecDiscount;
  late TextEditingController tecNote;

  late FocusNode fnCode;
  late FocusNode fnName;

  bool isCropProcessing = false;
  File? pictureFile;

  @override
  void initState() {
    tecCode = TextEditingController();
    tecName = TextEditingController();
    tecPhone = TextEditingController();
    tecDiscount = TextEditingController();
    tecNote = TextEditingController();

    fnCode = FocusNode();
    fnName = FocusNode();

    if (widget.transactionAction == TransactionAction.add) {
      fnCode.requestFocus();
    } else {
      tecCode.text = customerController.selectedCustomer.code;
      tecName.text = customerController.selectedCustomer.name;
      tecPhone.text = customerController.selectedCustomer.phone;
      tecDiscount.text =
          customerController.selectedCustomer.discount.toString();
      if (customerController.selectedCustomer.picture != null) {
        pictureFile = File(customerController.selectedCustomer.picture!);
      }
      tecNote.text = customerController.selectedCustomer.note;
    }

    super.initState();
  }

  @override
  void dispose() {
    tecCode.dispose();
    tecName.dispose();
    tecPhone.dispose();
    tecDiscount.dispose();
    tecNote.dispose();
    fnCode.dispose();
    fnName.dispose();
    super.dispose();
  }

  bool validatorData() {
    if (tecCode.text.trim() == '') {
      fnCode.requestFocus();
      //AlertBox.warning('Please input code!');
      return false;
    }
    if (tecName.text.trim() == '') {
      fnName.requestFocus();
      //AlertBox.warning('Please input customer name!');
      return false;
    }

    return true;
  }

  saveData() async {
    if (validatorData()) {
      //check picture
      var picturePath = '';
      if (pictureFile != null) {
        try {
          final appDir = await getApplicationDocumentsDirectory();
          final imageDir = AppDirectory.appImage + '/';
          final fileName = const Uuid().v1();
          picturePath = '${appDir.path}$imageDir$fileName';
          await pictureFile!.copy(picturePath);
        } catch (e) {
          // AlertBox.error('Can not use image.');
          return;
        }
      }

      if (widget.transactionAction == TransactionAction.add) {
        var model = CustomerModel(
          code: tecCode.text,
          name: tecName.text,
          phone: tecPhone.text,
          discount: int.tryParse(tecDiscount.text) ?? 0,
          picture: picturePath == '' ? null : picturePath,
          note: tecNote.text,
        );
        customerController.saveData(model);
        Get.back();
      } else {
        var entity = CustomerModel(
          id: customerController.selectedCustomer.id,
          code: tecCode.text,
          name: tecName.text,
          phone: tecPhone.text,
          discount: int.parse(tecDiscount.text),
          picture: picturePath == '' ? null : picturePath,
          note: tecNote.text,
        );
        //customerController.updateData(entity);
      }
    }
  }

  getImage(ImageSource imageSource) async {
    var picker = ImagePicker();
    dynamic imageFile;
    try {
      imageFile = await picker.pickImage(source: imageSource);
      if (imageFile != null) {
        //prevent app crash when load image to cropper (iOS)
        setState(() {
          isCropProcessing = true;
        });
        var crop = await ImageCropper.cropImage(
          sourcePath: imageFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 100,
          maxHeight: 100,
          compressFormat: ImageCompressFormat.jpg,
          // androidUiSettings: AndroidUiSettings(
          //   toolbarTitle: '',
          //   toolbarColor: Theme.of(context).scaffoldBackgroundColor,
          //   statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //   dimmedLayerColor: Colors.transparent,
          //   hideBottomControls: true,
          // ),
          // iosUiSettings: const IOSUiSettings(
          //   cancelButtonTitle: 'ចាកចេញ',
          //   doneButtonTitle: 'យល់ព្រម',
          //   rotateButtonsHidden: true,
          //   resetButtonHidden: true,
          //   rotateClockwiseButtonHidden: true,
          // ),
        );

        setState(() {
          isCropProcessing = false;
          pictureFile = crop;
        });
      }
    } catch (e) {
      setState(() {
        isCropProcessing = false;
      });
      //AlertBox.error(e.toString());
    }
  }

  removeImage() {
    setState(() {
      pictureFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //dismiss keyboard if focus
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: widget.transactionAction == TransactionAction.add
              ? const Text(
                  'Add Customer',
                )
              : const Text(
                  'Edit Customer',
                ),
          actions: [
            IconButton(
              onPressed: () {
                saveData();
              },
              icon: const Icon(
                CupertinoIcons.checkmark_alt_circle,
                size: 30,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBox(
                      controller: tecCode,
                      focusNode: fnCode,
                      label: 'លេខកូដ',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBox(
                      controller: tecName,
                      focusNode: fnName,
                      label: 'ឈ្មោះអតិថិជន',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBox(
                      controller: tecPhone,
                      label: 'លេខទូរស័ព្ទ',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBox(
                      controller: tecDiscount,
                      label: 'ចុះថ្លៃ',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBox(
                      controller: tecNote,
                      label: 'សំគាល់',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        pictureFile == null
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade300,
                                ),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.photo,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  pictureFile!,
                                  fit: BoxFit.fill,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 52,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => getImage(ImageSource.gallery),
                            child: const Icon(
                              Icons.photo_library,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 52,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => getImage(ImageSource.camera),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 52,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => removeImage(),
                            child: const Icon(
                              Icons.highlight_off,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //prevent app crash when crop image (iOS)
            isCropProcessing == false
                ? const SizedBox.shrink()
                : Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
