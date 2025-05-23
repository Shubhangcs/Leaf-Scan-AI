import "dart:io";

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_cropper/image_cropper.dart";
import "package:leaf_scan/core/args/upload_page_args.dart";
import "package:leaf_scan/core/common/widgets/custom_app_bar.dart";
import "package:leaf_scan/core/common/widgets/custom_card.dart";
import "package:leaf_scan/core/themes/app_colors.dart";
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.greenColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: AppColors.greenColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
        });

        Navigator.pushNamed(
          context,
          "/upload_page",
          arguments: UploadPageArgs(image: _image!),
        );
      }
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.greenColor,
                  size: 24,
                ),
                title: Text(
                  'Take a Photo',
                  style: GoogleFonts.workSans(
                    color: AppColors.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: AppColors.greenColor,
                  size: 24,
                ),
                title: Text(
                  'Upload from Media',
                  style: GoogleFonts.workSans(
                    fontSize: 18,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset("assets/home_hero.png"),
              SizedBox(
                height: 30,
              ),
              CustomCard(
                onTap: () {
                  _showImageSourceActionSheet(context);
                },
                leading: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.greenColor,
                  size: 30,
                ),
                title: "Scan",
                subtitle: "Scan or Upload Leaf Image",
              ),
              SizedBox(
                height: 30,
              ),
              CustomCard(
                onTap: () {
                  Navigator.pushNamed(context, "/chat_history_page");
                },
                leading: Icon(
                  Icons.gesture_rounded,
                  color: AppColors.greenColor,
                  size: 30,
                ),
                title: "Chat",
                subtitle: "View Previous Chat's",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
