import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePickerController extends GetxController {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  RxBool isBlackShadow = RxBool(false);
  RxString str = RxString("image");

  RxList<String> imagePath = RxList<String>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    loadImages();
    super.onInit();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      cropImage(pickedImage.path, 0);
    }
    /* imagePath.add(pickedImage!.path);
    imagePath.refresh();
    saveImages(imagePath.toList());*/
  }

  Future cropImage(filePath, type) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      compressQuality: 25,
      aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],
    );
    if (croppedImage != null) {
      final croppedFile = File(croppedImage.path);
      final decodedImage = await decodeImageFromList(await croppedFile.readAsBytes());
      print('Cropped Image Dimensions: ${decodedImage.width} x ${decodedImage.height}');

      // Rest of your existing code
      imagePath.add(croppedImage.path);
      imagePath.refresh();
      saveImages(imagePath.toList());
    }
  }

  Future<void> loadImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imageList = prefs.getStringList('imageList') ?? [];
    imagePath.assignAll(imageList);
    imagePath.refresh();
  }

  Future<void> saveImages(List<String> imageList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('imageList', imageList);
  }

  void deleteImage(int index) {
    imagePath.removeAt(index);
    imagePath.refresh();
    saveImages(imagePath.toList());
  }
}
