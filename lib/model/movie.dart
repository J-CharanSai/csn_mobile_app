import 'package:cinema_social_network/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cinema_social_network/model/user.dart'  as user_info;
import 'mysql.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:cinema_social_network/screens/addmovie.dart';
import 'package:cinema_social_network/screens/profile.dart';

class MyCustomForm extends StatefulWidget {  
  const MyCustomForm({Key? key, required this.pool, required this.n}) : super(key: key);

  final MySQLConnectionPool pool;
  final int n;

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}  
// Create a corresponding State class. This class holds data related to the form.  
class _MyCustomFormState extends State<MyCustomForm> {  
  // Create a global key that uniquely identifies the Form widget  
  // and allows validation of the form.  
  final _formKey = GlobalKey<FormState>(); 
   
  TextEditingController rev = TextEditingController();
  
  @override  
  Widget build(BuildContext context) {  
    // Build a Form widget using the _formKey created above.  
    return Form(  
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  
          TextFormField(  
            controller: rev,
            decoration: const InputDecoration(  
              icon: const Icon(Icons.person),  
              hintText: 'Add Review',  
              labelText: 'Review',  
            ),  
          ),  
           
          new Container(  
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),  
              child: new RaisedButton(  
                child: const Text('Submit'),  
                  onPressed:() {
                    print("Button Pressed");
                    var result = widget.pool.execute(
                        "INSERT INTO review (R_movie_id, R_user_emailid, rating, date_added, review_text) VALUES (:one, :two, :thr, :fo, :fi);",
                                            {
                                              "one": widget.n,
                                              "two": user_info.globalSessionData.email,
                                              "thr": 5,
                                              "fo": "2022-03-31",
                                              "fi": rev.text
                                            });

                    
                    

                    
                  },  
              )),  
        ],  
      ),  
    );  
  }  
}  

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.pool}) : super(key: key);

  final MySQLConnectionPool pool;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Movie {
  final String movie_id;
  final String movie_title;
  final String release_date;
  final String language;
  final String genre;
  final String country;
  final String description;
  final String source;

  Movie(
     this.movie_id,
     this.movie_title,
   this.release_date,
     this.language,
     this.genre,
     this.country,
     this.description,
     this.source,
  );
}




class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;
  // late Future<List<Movie>> movies;
  Future<List<Movie>> fetchmovies() async {

  var result = widget.pool.execute(
      "SELECT * FROM movie");
      List<Movie> mvs = [];
     
      result.then((value) {
        for (var r in value.rows){
        Movie mve = Movie(r.assoc()["movie_id"]!,r.assoc()['movie_title']!,r.assoc()['release_date']!,r.assoc()['language']!,r.assoc()['genre']!,r.assoc()['country']!,r.assoc()['description']!,r.assoc()['source']!);
        mvs.add(mve);
        
      }
      });
      await Future.delayed(Duration(seconds: 2),(){
        print(mvs.length);
      });
      return mvs;
      
}
// void initState() {
//     movies = fetchmovies();
//     print(movies);
//   }
  int _counter = 0;
  var db = new Mysql();
  String? mail = '';

  void _incrementCounter() {
    _counter = _counter + 1;
    print(_counter);
  }

  Widget getTextWidgets(List<String> strings)
  {
    return new Row(children: strings.map((item) => new Text(item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Container(
        child: FutureBuilder(
            future: fetchmovies(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder:(BuildContext context, int index){

                  return Card(child : ListTile(
                    
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data[index].source
                        ) ,
                        ),
                    title: Text(snapshot.data[index].movie_title),
                    subtitle: Text(snapshot.data[index].genre+", "+snapshot.data[index].release_date+"\n"+snapshot.data[index].country),
                    onTap: () {
                      Navigator.push(context, 
                      new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index], widget.pool))
                      );
                    }
                  ));
                } );
            },
          ),
      ),
      bottomNavigationBar: buildMyNavBar(context),
    );
  }
  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(pool: widget.pool)),
                  );
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMovie(pool: widget.pool)),
                  );
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile(pool: widget.pool)),
                  );
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}

// Future<List<Movie>> fetchfilm() async {

//   var result = widget.pool.execute(
//       "SELECT * FROM movie");
//       List<Movie> mvs = [];
     
//       result.then((value) {
//         for (var r in value.rows){
//         Movie mve = Movie(r.assoc()["movie_id"]!,r.assoc()['movie_title']!,r.assoc()['release_date']!,r.assoc()['language']!,r.assoc()['genre']!,r.assoc()['country']!,r.assoc()['description']!,r.assoc()['source']!);
//         mvs.add(mve);
        
//       }
//       });
//       await Future.delayed(Duration(seconds: 2),(){
//         print(mvs.length);
//       });
//       return mvs;
      
// }


class DetailPage extends StatelessWidget {
  int pageIndex = 0;
  final Movie film;
  final MySQLConnectionPool pool;

  DetailPage(this.film, this.pool);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film.movie_title),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
        child: Column(
          children: <Widget>[
            FadeInImage.assetNetwork(
                        alignment: Alignment.topCenter,
                        placeholder: film.source,
                        image: film.source,
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                      ),
            
            Container(child:Card
            (  
              child: Column(children: [
              Text("Release Year : ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            Text(film.release_date,
            style: TextStyle(fontSize: 25),)
            ],)
            ),),
            Text("Genre : ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            Text(film.genre,
            style: TextStyle(fontSize: 25),),
            Text("Language : ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            Text(film.language,
            style: TextStyle(fontSize: 25),),
            Text("Country : ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            Text(film.country,
            style: TextStyle(fontSize: 25),),
            Text("Description : ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            Text(film.description,
            style: TextStyle(fontSize: 23),),
            MyCustomForm(pool:pool, n: int.parse(film.movie_id)),
          ],
        )
      ),
      ),
    );
  }
  
}