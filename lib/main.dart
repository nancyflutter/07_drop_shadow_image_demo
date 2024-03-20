import 'package:drop_shadow_image_demo/ui/image_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const ImagePickerScreen(),
    );
  }
}

/// Image Pick with crop and save with drop shadow as image colors and also able to show black shadow.
/// Using GetX...✨
/// it's just decoration of image which are useful at social media...story or post.
/// Just like below example:
