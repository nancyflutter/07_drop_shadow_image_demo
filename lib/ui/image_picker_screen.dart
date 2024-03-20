import 'dart:io';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:drop_shadow_image_demo/controller/image_picker_controller.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: ImagePickerController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade300,
            title: const Text("Drop Shadow Image"),
            actions: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  tooltip: 'Pick Image',
                  // onPressed: controller.pickImage,
                  onPressed: () {
                    controller.pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade300,
                child: IconButton(
                  onPressed: () {
                    controller.isBlackShadow.value = !controller.isBlackShadow.value;
                    controller.update();
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: controller.imagePath.isNotEmpty
                ? PageView.builder(
                    itemCount: controller.imagePath.length,
                    itemBuilder: (context, index) {
                      return GetX(
                          init: ImagePickerController(),
                          builder: (controller) {
                            print(controller.str);
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.isBlackShadow.value == false
                                    ? Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                          child: DropShadowImage(
                                            offset: const Offset(10, 10),
                                            scale: 1.01,
                                            blurRadius: 10,
                                            borderRadius: 15,
                                            image: Image.file(
                                              File(controller.imagePath[index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(10, 10),
                                                  blurRadius: 12,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              child: Image.file(
                                                File(controller.imagePath[index]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red, size: 36),
                                  onPressed: () => controller.deleteImage(index),
                                ),
                              ],
                            );
                          });
                    },
                  )
                : const Text('No image selected'),
          ),
        );
      },
    );
  }
}
