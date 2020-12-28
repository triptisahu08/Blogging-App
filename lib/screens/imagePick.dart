import 'package:flutter/material.dart';
import 'package:flutter_blog_app/screens/imageUpload.dart';
import 'package:image_picker/image_picker.dart';//for picking Image file
import 'dart:io';
import 'uploadFile.dart';
import 'package:firebase_storage/firebase_storage.dart'; //for File Upload
import 'package:path/path.dart' as Path;
class PickImageDemo extends StatefulWidget {
  PickImageDemo() : super();


  final String title = "Flutter Pick Image demo";

  @override
  _PickImageDemoState createState() => _PickImageDemoState();
}

class _PickImageDemoState extends State<PickImageDemo> {
  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black45,
          gradient: new LinearGradient(
            colors: [Colors.redAccent, Colors.black87],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showImage(),
              RaisedButton(
                color: Colors.black54,
                child: Text("Select Image from Gallery"),
                onPressed: () {
                  pickImageFromGallery(ImageSource.gallery);
                },
              ),
              RaisedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageUpload()));
              })
            ],
          ),
        ),
      ),
    );
  }
}