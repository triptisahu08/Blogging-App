import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/screens/imagePick.dart';
import 'package:flutter_blog_app/utils/validator.dart';

class CreateBlog extends StatefulWidget {
  CreateBlog({Key key}) : super(key: key);
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final _formKey = GlobalKey<FormState>();
  int _unique = 0;
  String dropdownValue = "Travel";
  TextEditingController blogtitle, description;
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  DatabaseReference refere, keyrefer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    blogtitle = TextEditingController();
    description = TextEditingController();
    refere = FirebaseDatabase.instance.reference().child('BlogDetails');
    keyrefer = FirebaseDatabase.instance.reference();
    _getKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.add_a_photo_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => PickImageDemo()));
              // return showDialog(
              //   context: context,
              //   builder: (ctx) => AlertDialog(
              //     title: Text("Alert Dialog Box"),
              //     content: Text("Work in Progress....."),
              //     actions: <Widget>[
              //       FlatButton(
              //         onPressed: () {
              //           Navigator.of(ctx).pop();
              //         },
              //         child: Text("okay"),
              //       ),
              //     ],
              //   ),
              // );
            },
            color: Colors.redAccent,
            tooltip: 'Create a picture Blog',
          ),
          new IconButton(
              icon: Icon(Icons.note_add),
              onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => CreateBlog()));},
              color: Colors.redAccent,
              tooltip: 'add a new blog',
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Create Blogs',
          style: TextStyle(
            fontSize: 20,
            color: Colors.redAccent,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: new Column(
          children: [
            Expanded(
              child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFF458585), Color(0xFFFF5252)]),

                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              hint: Text(
                "Blog Type",
                style: TextStyle(color: Colors.redAccent),
              ),
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                size: 14.0,
                color: Colors.tealAccent,
              ),
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>["Travel", "Food", "It", "Code", "Quotes"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: new TextFormField(
                controller: blogtitle,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color:Colors.white70),
                  border: InputBorder.none,
                  icon: Icon(Icons.title),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18.0,
                  ),
                ),
                validator: FieldValidator.validateTitle,
              ),
            ),
            Divider(
              height: 10.0,
              thickness: 2.0,
              color: Colors.redAccent,
              indent: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: new TextFormField(
                controller: description,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color:Colors.white70),
                  border: InputBorder.none,
                  icon: Icon(Icons.text_fields),
                  labelText: 'Blog Description',
                  labelStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18.0,
                  ),
                ),
                validator: FieldValidator.validateDescription,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      //print('inside validate');
                      saveBlogdata();
                    } //calling save blog data function to save created blog
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  color: Colors.transparent,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context); //cancel button method
                  },
                  child: Text(
                    'cancel',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  color: Colors.transparent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //to get key
  void _getKey() {
    keyrefer.child("KeyValue").once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        Map data = snapshot.value;
        _unique = data['KeyValue'];
      } else if (snapshot.value == null) {
        _unique = 0;
      }
    });
    print(_unique);
  }

  void saveBlogdata() {
    String title = blogtitle.text;
    String desc = description.text;
    String dropval = dropdownValue;
    String keyValue = (_unique + 1).toString();
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var finaldate = formattedDate.toString();
    Map<String, String> Bloginfo = {
      'blog_title': title,
      'description': desc,
      "timestamp": finaldate,
      'type': dropval,
      'Key': keyValue,
    };
    // assigning key manually to the firebase
    Map<String, int> keyVal = {
      'KeyValue': _unique + 1,
    };
    //saving the Created Blogs category wise.
    if (dropval == 'Travel') {
      refere.child('Travel').child(keyValue).update(Bloginfo).then((value) {
        keyrefer
            .child('KeyValue')
            .update(keyVal)
            .then((value) => Navigator.pop(context));
      });
    } else if (dropval == 'Food') {
      refere.child('Food').child(keyValue).update(Bloginfo).then((value) {
        keyrefer
            .child('KeyValue')
            .update(keyVal)
            .then((value) => Navigator.pop(context));
      });
    } else if (dropval == 'It') {
      refere.child('It').child(keyValue).update(Bloginfo).then((value) {
        keyrefer
            .child('KeyValue')
            .update(keyVal)
            .then((value) => Navigator.pop(context));
      });
    } else if (dropval == 'Code') {
      refere.child('Code').child(keyValue).update(Bloginfo).then((value) {
        keyrefer
            .child('KeyValue')
            .update(keyVal)
            .then((value) => Navigator.pop(context));
      });
    } else if (dropval == 'Quotes') {
      refere.child('Quotes').child(keyValue).update(Bloginfo).then((value) {
        keyrefer
            .child('KeyValue')
            .update(keyVal)
            .then((value) => Navigator.pop(context));
      });
    } else {
      print('this is not an option.');
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
