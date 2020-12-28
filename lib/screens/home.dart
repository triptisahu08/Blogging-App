import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/screens/code_blog.dart';
import 'package:flutter_blog_app/screens/food_blog.dart';
import 'package:flutter_blog_app/screens/it_blog.dart';
import 'package:flutter_blog_app/screens/quotes.dart';
import 'package:flutter_blog_app/screens/travel_blog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'create_blog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final globalKey = GlobalKey<ScaffoldState>();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search),
              onPressed: () {return showDialog(
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
              tooltip: 'search for blogs',),
            new IconButton(icon: Icon(Icons.note_add),
              onPressed: ()
              { Navigator.push(context,MaterialPageRoute(builder:(context) => CreateBlog()));},
              color: Colors.redAccent,
              tooltip: 'add new blog',),
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Blogger", style: TextStyle(fontSize: 20, color: Colors.redAccent),)
      ),
      drawer: new Drawer(
        elevation: 20.0,
        child:new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('',style: TextStyle(color: Colors.black87),),
              decoration: BoxDecoration(image: DecorationImage(
                image: AssetImage('assets/blog1.png'),
                fit: BoxFit.contain,
              ),
              gradient: new LinearGradient(
                colors: [Colors.black12, Colors.black87],
              ),),
            ),
            ListTile(
              leading: Icon(Icons.card_travel,color: Colors.redAccent,),
              title: Text('Travel',style: TextStyle(fontSize: 16.0,),),
              subtitle: Text('write your own travel blog here!'),
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> TravelBlog()));
              },
            ),
            new Divider(
              height: 10.0,
              color: Colors.redAccent,
              indent: 10.0,
            ),
            ListTile(
              title: Text('Food',style: TextStyle(fontSize: 16.0,),),
              leading: Icon(Icons.fastfood,color: Colors.redAccent,),
              subtitle: Text('write your own Food blog here!'),
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FoodBlog()));
              },
            ),
            new Divider(
              height: 10.0,
              thickness: 1.0,
              color: Colors.redAccent,
              indent: 10.0,
            ),
            ListTile(
              title: Text('Code',style: TextStyle(fontSize: 16.0,),),
              leading: Icon(Icons.code,color: Colors.redAccent,),
              subtitle: Text('write your own Code blog here!'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => CodeBlog()));
              },
            ),
            new Divider(
              height: 10.0,
              color: Colors.redAccent,
              indent: 10.0,
            ),
            ListTile(
              title: Text('IT',style: TextStyle(fontSize: 16.0,),),
              leading: Icon(Icons.router,color: Colors.redAccent,),
              subtitle: Text('write your own IT blog here!'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => ItBlog()));
              },
            ),
            new Divider(
              height: 10.0,
              thickness: 1.0,
              color: Colors.redAccent,
              indent: 10.0,
            ),
            ListTile(
              title: Text('Quote',style: TextStyle(fontSize: 16.0,),),
              leading: Icon(Icons.format_quote,color: Colors.redAccent,),
              hoverColor: Colors.brown,
              subtitle: Text('write your own Quotes here!'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => QuotesBlog()));
              },
            ),
            new Divider(
              height: 10.0,
              thickness: 1.0,
              color: Colors.redAccent,
              indent: 10.0,
            ),
            ListTile(
              title: Text('close',style: TextStyle(fontSize: 16.0,),),
              leading: Icon(Icons.close,color: Colors.redAccent,),
              hoverColor: Colors.brown,
              subtitle: Text('CLick here to close!'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            new Divider(
              height: 10.0,
              color: Colors.redAccent,
              indent: 10.0,
            ),
            ],

        )
      ),
      body: Container(
        decoration: new BoxDecoration(
          color: Colors.black45,
         gradient: new LinearGradient(
            colors: [Colors.black87, Colors.red[600],Colors.black87],
        ), ),
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.redAccent, Colors.white10],
                ),
              ),
              child: GestureDetector(
                  onTap: () async {
                    const url = 'https://google.com';
                    if (await canLaunch(url)) {
                      await launch(url, forceWebView: true);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: ListTile(
                          leading: Icon(Icons.album, size:40),
                          title: Text(
                              'Browse Blogs',
                              style: TextStyle(fontSize: 14.0)
                          ),
                          subtitle: Text(
                              'You can browse for more blogs over internet.',
                              style: TextStyle(fontSize: 14.0)
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.redAccent, Colors.white10],
                ),
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CodeBlog()));
                },
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.album, size:40),
                        title: Text(
                            'Code Blogs',
                            style: TextStyle(fontSize: 14.0)
                        ),
                        subtitle: Text(
                            'Read your Code blog here.',
                            style: TextStyle(fontSize: 14.0)
                        ),
                      ),
                    ]),
              ),
              ),
            Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.redAccent, Colors.white10],
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuotesBlog()));
                },
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.album, size:40),
                        title: Text(
                            'Quotes',
                            style: TextStyle(fontSize: 14.0)
                        ),
                        subtitle: Text(
                            'Read your fav. Quotes here.',
                            style: TextStyle(fontSize: 14.0)
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.redAccent, Colors.white10],
                ),
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ItBlog()));
                },
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.album, size:40),
                        title: Text(
                            'It Blogs',
                            style: TextStyle(fontSize: 14.0)
                        ),
                        subtitle: Text(
                            'Read your fav. It blog here.',
                            style: TextStyle(fontSize: 14.0)
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.redAccent, Colors.white10],
                ),
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoodBlog()));
                },
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.album, size:40),
                        title: Text(
                            'Food Blogs',
                            style: TextStyle(fontSize: 14.0)
                        ),
                        subtitle: Text(
                            'Read your fav. Food blog here.',
                            style: TextStyle(fontSize: 14.0)
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
            padding: const EdgeInsets.all(8),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.redAccent, Colors.white10],
                ),
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TravelBlog()));
                },
                child: Column(
                 mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                leading: Icon(Icons.album, size:40),
                title: Text(
                'Travel Blogs',
                style: TextStyle(fontSize: 14.0)
                ),
                subtitle: Text(
                'Read your fav. travel blog here.',
                style: TextStyle(fontSize: 14.0)
                ),
                ),
                ]),
              ),
        ),
             ] ),
      ),

      floatingActionButton: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              tooltip:'Create Blogs',
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context) => CreateBlog()));
                },
                child: Icon(Icons.sticky_note_2)

            )
          ],
        ),


    )
    );
  }


}

