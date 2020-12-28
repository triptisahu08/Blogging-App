import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as Path;
import 'dart:io';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File imageFile;
  String uploadedFileURL;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        imageFile = image;
        print(imageFile);
      });
    });
  }


  Future uploadFile() async {
    Reference storageReference = FirebaseStorage.instance.ref().child('Blogdetails/blogs/${Path.basename(imageFile.path)}}');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => print('whenCompletes'));
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL = fileURL;
        print(uploadedFileURL);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore File Upload'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text('Selected Image'),
            SizedBox(height: 20.0),
            imageFile != null
                ? Image.asset(
              imageFile.path,
              height: 150,
            )
                : Container(height: 150),
            imageFile == null
                ? RaisedButton(
              child: Text('Choose File'),
              onPressed: chooseFile,
              color: Colors.cyan,
            )
                : Container(),
            SizedBox(height: 10.0),
            imageFile != null
                ? RaisedButton(
              child: Text('Upload File'),
              onPressed: uploadFile,
              color: Colors.cyan,
            )
                : Container(),
            imageFile != null
                ? RaisedButton(
              child: Text('Clear Selection'),
              onPressed: (){},
            ): Container(),
            Text('Uploaded Image'),
            uploadedFileURL != null
                ? Image.network(
              uploadedFileURL,
              height: 150,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}


