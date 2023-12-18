import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/transaction_controller.dart';


class AppImagePicker extends StatefulWidget {
  final TransactionController controller;

  const AppImagePicker({super.key, required this.controller});

  @override
  _AppImagePickerState createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  File? _pickedImage;

  Future<void> _pickImage(ImageSource source) async {
    print("picking Image");
    print("=========================================");
    final status = await Permission.camera.request();
    print("picking Image2");
    print("=========================================");
    if (status.isGranted) {
      print("picking Image3");
      print("=========================================");
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: source);

      setState(() {
        if (pickedImage != null) {
          print("picking Image 3.5");
          print("=========================================");
          _pickedImage = File(pickedImage.path); // Update the state variable
          print("picking Image 3.8");
          print(_pickedImage);
          // Update the controller with the selected image
          widget.controller.addReceiptImage(_pickedImage!);
        }
        print("picking Image4");
        print("=========================================");
      });
    } else {
      // Handle the case where the user denied the permission
      if (kDebugMode) {
        print('Camera permission denied');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Take Photo'),
                      onTap: ()  async {
                        print("picking Image");
                        print("=========================================");
                        await _pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Choose from Gallery'),
                      onTap: () async {
                        print("picking Image");
                        print("=========================================");
                       await  _pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add_a_photo),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: _pickedImage == null
              ? const Center(child: Text('No Image selected'))
              : ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.file(
              _pickedImage!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

