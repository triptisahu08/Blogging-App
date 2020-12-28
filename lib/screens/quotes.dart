import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/models/commonClass.dart';
import 'create_blog.dart';

class QuotesBlog extends StatefulWidget {
  @override
  _QuotesBlogState createState() => _QuotesBlogState();
}

class _QuotesBlogState extends State<QuotesBlog> {
  DatabaseReference quotesref , refnew;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refnew = FirebaseDatabase.instance.reference();
    quotesref = FirebaseDatabase.instance.reference().child('BlogDetails').child('Quotes');
  }

  Widget  Blogslist ({Map blog})
  {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.black45,
        gradient: new LinearGradient(
          colors: [Colors.black12, Colors.black87],
        ), ),
      padding: EdgeInsets.all(30.0),
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 150.0,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(child: Icon(Icons.title,color: Colors.redAccent,)),
              SizedBox(
                width: 10,
              ),
              Text(
                blog['blog_title'],
                overflow:TextOverflow.ellipsis,
               // blog.keys.toString(),
                style: TextStyle(color: Colors.red[100],fontWeight: FontWeight.w400,fontSize:22.0),),
              new Spacer(flex: 3,),
              IconButton(onPressed:  (){
                deleteData(context,blog['Key'], blog['type']);
              },icon:Icon(Icons.delete,color: Colors.red[100])),
              new SizedBox(height:10.0),
              GestureDetector(child: Icon(Icons.edit,color: Colors.red[100],textDirection: TextDirection.ltr),
                onTap: (){
                  updateData(context, blog['Key'],blog['type'],blog['blog_title'],blog['description']);
                     },
              onLongPress: (){},),
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Row(
              children:<Widget> [
                Icon(Icons.description,color: Colors.redAccent,),
                SizedBox(
                  width: 10,
                ),
                Divider(
                  height: 10.0,
                  thickness: 5.0,
                  color: Colors.redAccent,
                ),
                Flexible(
                  child: Text(
                    blog['description'],
                    overflow:TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.red[300],fontWeight: FontWeight.w400,fontSize: 18.0),),
                ),
                new Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.add_a_photo_rounded),
            onPressed: () {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Alert Dialog Box"),
                  content: Text("Work in Progress....."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("okay"),
                    ),
                  ],
                ),
              );
            },
            color: Colors.redAccent,
            tooltip: 'Create a picture Blog',),
          new IconButton(
            icon: Icon(Icons.note_add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => CreateBlog()));
            },
            color: Colors.redAccent,
            tooltip: 'add a new blog',),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title:Text('QUOTES',style: TextStyle(fontSize: 20,color:Colors.redAccent,),),
      ),
      body: Container(
        decoration: new BoxDecoration(
          color: Colors.black45,
          gradient: new LinearGradient(
            colors: [Colors.redAccent, Colors.white12],
          ), ),
        child: Column(
          children: [
            Expanded(child: Container(
              height:double.maxFinite,
              alignment: Alignment.bottomCenter,
              child: FirebaseAnimatedList(
                  scrollDirection: Axis.vertical,
                  query:quotesref,
                  itemBuilder:(BuildContext context, DataSnapshot snapshot,Animation<double>animation,int index)
                  {
                    Map blog1 = snapshot.value;
                    print(blog1.keys);
                    return Blogslist(blog: blog1);
                  }),
            ),
            ),
            SizedBox(height:40.0),
          ],
        ),
      ),
    );
  }
  // void deleteBlog(keys) {
  //   //print(refnew.child('BlogDetails').onChildAdded);
  //   refnew.child('BlogDetails/blogs').once().then((DataSnapshot snapshot){
  //     print(snapshot.key);
  //   });
  //   //refnew.child(keys.toString()).remove();
  //     print("success");
  //
  // }
  // void updateData(){
  //   print(" data has been updated");
  //   quotesref.child('blogs').update({
  //     'description': 'this is the pudated description',
  //     'blog_title' :  'this is the updated title',
  //
  //   });
  // }
}







