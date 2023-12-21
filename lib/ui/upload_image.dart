import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();
  Future getimageGallery() async {
    final pickedfile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      } else {
        Utils().toastMessage('No image Picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: getimageGallery,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Icon(Icons.image),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
              title: 'Upload',
              onTap: () {
               
       String fileExtension = _image!.uri.pathSegments.last.split('.').last;

  // Create the full file name with timestamp and extension
  String fileName = '${DateTime.now().microsecondsSinceEpoch}.$fileExtension';

  // Reference to the Firebase Storage path
  firebase_storage.Reference ref = storage.ref('/foldername/$fileName');

  // Set custom metadata
  firebase_storage.SettableMetadata metadata = firebase_storage.SettableMetadata(
    contentType: 'image/$fileExtension', // Assuming the extension is a valid image type
    contentDisposition: 'inline; filename="$fileName"', // Forces the browser to display the image
  );
                firebase_storage.UploadTask uploadTask =
                    ref.putFile(_image!.absolute,metadata);
                Future.value(uploadTask).then(
                  (value) async{
                    var newurl = await ref.getDownloadURL();
                Utils().toastMessage(newurl.toString());
                  },
                );
                
              },
            )
          ],
        ),
      ),
    );
  }
}
