import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

 void deleteData (BuildContext context ,String delKey, String delType)
{
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Delete your blog"),
      content: Container(
        child:Text('delete ')),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            deleteBlog(context,delKey, delType);
          },
          child: Text("Delete"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    ),
  );
  // FirebaseDatabase.instance.reference().child('BlogDetails').child(delType).child(delKey).remove();

}

void updateData(BuildContext context, String upKey , String upType,String upTitle, String upDescription)
{
  TextEditingController _blogtitle = TextEditingController();
  TextEditingController _blogDescription = TextEditingController();
  _blogtitle.text = upTitle;
  _blogDescription.text = upDescription;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Update your blog"),
      content: Container(
        child: Form(child:Column(
          children: [
            TextFormField(
             // initialValue: 'title',
            validator: (String value ){
        if(value.isEmpty)
        {
        return 'this is value is required';
        }
        return null;
        } ,
          //autofocus: true,
          //focusNode: nodeOne,
          controller: _blogtitle,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.title),
            labelText: 'Title',
            labelStyle: TextStyle(
              color: Colors.redAccent,
              fontSize: 18.0,
            ),
            //hintText: 'Enter Your Blog title here'
          ),
            ),
            TextFormField(
             // initialValue:'text',
              validator: (String value ){
                if(value.isEmpty)
                {
                  return 'this is value is required';
                }
                return null;
              } ,
              //autofocus: true,
              //focusNode: nodeOne,
              controller: _blogDescription,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.title),
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18.0,
                ),
                //hintText: 'Enter Your Blog title here'
              ),
            ),
          ],
        )),
      ),
      actions: <Widget>[
        FlatButton(

          onPressed: () {
            updateBlog(context, upKey, upType,_blogtitle.text,_blogDescription.text);
          },
          child: Text("Update"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    ),
  );
  //FirebaseDatabase.instance.reference().child('BlogDetails').child(upType).child(upKey).update();
}

void updateBlog(BuildContext context, String kk , String ty ,String tt ,String des)
{

  Map<String , String > updateInfo ={
    'blog_title': tt,
    'description': des,
  };
  FirebaseDatabase.instance.reference().child('BlogDetails').child(ty).child(kk).update(updateInfo).then((value) => Navigator.pop(context));

}
void deleteBlog( BuildContext context ,String keyy , String typ)
{
  FirebaseDatabase.instance.reference().child('BlogDetails').child(typ).child(keyy).remove().then((value) => Navigator.pop(context));
}