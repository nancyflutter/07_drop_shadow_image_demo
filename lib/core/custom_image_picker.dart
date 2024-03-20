import 'dart:io';
import 'package:drop_shadow_image_demo/core/console.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
/*

Future<File?> filePiker({required BuildContext context, bool isPopNeeded = false}) async {
  if (isPopNeeded) Get.back(); //Navigator.pop(context);
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path.toString());
      return file;
    } else {
      // User canceled the picker
    }
  } catch (e) {
    Console.debug(e);
  }
}
*/

Future<File?> imgFromCamera({required BuildContext context, bool isPopNeeded = true}) async {
  // if (isPopNeeded) Get.back(); //Navigator.pop(context);
  try {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    File? croppedImage = await cropImage(image?.path);
    return croppedImage;
  } catch (e) {
    Console.debug(e);
    return null;
  }
}

Future<File?> videoFromCamera({required BuildContext context, bool isPopNeeded = true}) async {
  if (isPopNeeded) Get.back(); //Navigator.pop(context);
  try {
    XFile? video = await ImagePicker().pickVideo(source: ImageSource.camera);
    // File? croppedImage = await _cropImage(image.path);
    if (video?.path.isNotEmpty ?? false) {
      Console.debug("Path is not empty");
      return File(video?.path ?? "");
    } else {
      Console.debug("Path is empty");
      return null;
    }
  } catch (e) {
    Console.debug(e);
    return null;
  }
}

Future<File?> videoFromGallery({required BuildContext context, bool isPopNeeded = true}) async {
  if (isPopNeeded) Get.back(); //Navigator.pop(context);
  try {
    XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    // File? croppedImage = await cropImage(video?.path);
    if (video?.path.isNotEmpty ?? false) {
      Console.debug("Path is not empty");
      return File(video?.path ?? "");
    } else {
      Console.debug("Path is empty");
      return null;
    }
  } catch (e) {
    Console.debug(e, key: "Video From Gallery");
    return null;
  }
}

Future<File?> imgFromGallery({required BuildContext context, bool isPopNeeded = true}) async {
  if (isPopNeeded) Get.back();
  try {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File? croppedImg = await cropImage(image?.path);
    if (croppedImg != null) {
      return croppedImg;
    }
  } catch (e) {
    Console.debug(e, key: "Image From Gallery");
    return null;
  }
  return null;
}

Future<File?> cropImage(String? filePath) async {
  try {
    if (filePath == null) {
      return null;
    }
    CroppedFile? croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: filePath,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [CropAspectRatioPreset.original, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3],
    );
    if (croppedImage == null) {
      return null;
    }
    return File(croppedImage.path);
  } catch (e) {
    Console.debug(e, key: "Crop Picker");
    return null;
  }
}

String getExtension(File file) {
  return file.path.split(".").last;
}

String changeImageFileName(File image) {
  return 'doc_${image.path.split('cropper_').last}';
}

/*
Future<IosDeviceInfo> getIOSDetails() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  return iosInfo;
}

Future<AndroidDeviceInfo> getAndroidDetails() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo;
}
*/
