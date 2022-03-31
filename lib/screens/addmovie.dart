import 'package:cinema_social_network/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:cinema_social_network/model/movie.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:cinema_social_network/screens/profile.dart';




class AddMovie extends StatefulWidget {
  const AddMovie({Key? key, required this.pool}) : super(key: key);

  final MySQLConnectionPool pool;
  @override
  _AddMovieState createState() => _AddMovieState();

}

class _AddMovieState extends State<AddMovie> {
  int pageIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String genre = "";
  String country ="";
  String movieTitle = "";
  String language = "";
  int releaseDate = 2020;
  String imgSrc = "";
  TextEditingController descriptionController = TextEditingController();
  TextEditingController movieTitleController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController releaseDateController = TextEditingController();
  TextEditingController imgSrcController = TextEditingController();
  TextEditingController languageController = TextEditingController();


  void _submit() {
    print("Button Pressed");
    var result = widget.pool.execute(
        "INSERT INTO movie (movie_title, release_date, language, genre, country, description,source) VALUES (:movie_title, :release_date, :language, :genre, :country, :description,:source);",
                            {
                              "movie_title":movieTitleController.text,
                              "release_date":releaseDateController.text,
                              "language":languageController.text, 
                              "genre":genreController.text,
                              "country":countryController.text, 
                              "description":descriptionController.text,
                              "source":imgSrcController.text
                            });

    

    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(pool: widget.pool)),
                      );
    

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Movie"),
      ),
      
      body: SingleChildScrollView(
        child:Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  
                  // this is where the
                  // input goes
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Movie Title'),
                    keyboardType: TextInputType.multiline,
                    controller: movieTitleController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter a valid movie name';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        movieTitle = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Language'),
                    keyboardType: TextInputType.multiline,
                    controller: languageController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please Enter the language';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        language = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Release Year'),
                    keyboardType: TextInputType.number,
                    controller: releaseDateController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Release Date Cannot be empty';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        releaseDate = int.parse(value);
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Genre'),
                    keyboardType: TextInputType.multiline,
                    controller: genreController,
                    onFieldSubmitted: (value) {
                      setState(() {
                        genre = value;
                      });
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'genre Id cannot be empty';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Country'),
                    keyboardType: TextInputType.multiline,
                    controller: countryController,
                    onFieldSubmitted: (value) {
                      setState(() {
                        country = value;
                      });
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Country cannot be empty';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                    onFieldSubmitted: (value) {
                      setState(() {
                        country = value;
                      });
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Description cannot be empty';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Img Src'),
                    keyboardType: TextInputType.url,
                    controller: imgSrcController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Invalid URL format';
                      }
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        imgSrc = value;
                      });
                    },
                  ),
                  RaisedButton(
                    onPressed: _submit,
                    child: Text("Add Movie"),
                  ),
                ],
              ),
            ),
            // this is where
            // the form field
            // are defined
            SizedBox(
              height: 20,
            ),
            // Column(
            //   children: <Widget>[
            //     movieId.isEmpty ? Text("No data") : Text(movieId),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     movieTitle.isEmpty ? Text("No Data") : Text(movieTitle),
            //   ],
            // )
          ],
        ),
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