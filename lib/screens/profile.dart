import 'package:flutter/material.dart';
import 'package:cinema_social_network/screens/signup.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:cinema_social_network/model/user.dart'  as user_info;
import 'package:cinema_social_network/model/movie.dart';
import 'package:cinema_social_network/screens/addmovie.dart';
import 'package:cinema_social_network/screens/signin.dart';
class Review {
  final String R_movie_id;
  final String R_user_emailid;
  final String rating;
  final String date_added;
  final String review_text;
  final String movieTitle;

  Review(this.R_movie_id, this.R_user_emailid, this.rating, this.date_added,
      this.review_text, this.movieTitle);
}

class Profile extends StatefulWidget {
  Profile({Key? key, required this.pool}) : super(key: key);

  final MySQLConnectionPool pool;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int pageIndex   = 0;
  TextEditingController passwordController = TextEditingController();
  final String user_name = user_info.globalSessionData.userId;
  Future<List<Review>> fetchReviews() async {
    var result = widget.pool.execute(
        "SELECT * FROM review as re, movie as mv WHERE re.R_movie_id = mv.movie_id AND re.R_user_emailid = :emailid ORDER BY re.date_added DESC",
        {"emailid": user_info.globalSessionData.email});
    // List<Map<String,String?>> movies = [];

    List<Review> mvs = [];

    result.then((value) {
      for (var r in value.rows) {
        print(r.assoc()["movie_title"]);
        Review mve = Review(
            r.assoc()["R_movie_id"]!,
            r.assoc()['R_user_emailid']!,
            r.assoc()['source']!,
            r.assoc()['date_added']!,
            r.assoc()['review_text']!,
            r.assoc()['movie_title']!);
        mvs.add(mve);
      }
    });

    await Future.delayed(Duration(seconds: 2), () {
      print(mvs.length);
    });
    return mvs;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: new EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: Column(
          children: [
            buildTop(),
            buildData(),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  Text(
                    "Reviews",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25),
                  ),
                  Expanded(
                    child: loadComments(),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                      child: const Text('Logout'),
                      onPressed: () {

                              user_info.clearSessionData();
                          
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SigninPage(pool: widget.pool)),
                              );
                      },
                      )
                    ],
                  )
                ],
              ),
              // child:
            )),
          ],
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

  Widget buildData() => Text(
        '$user_name' + '\n',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  Widget loadComments() => Container(
        child: FutureBuilder(
          future: fetchReviews(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(child: Text("Loading...")),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data[index].rating),
                    ),
                    title: Text(snapshot.data[index].movieTitle),
                    subtitle: Text(snapshot.data[index].date_added +
                        "\n" +
                        snapshot.data[index].review_text),
                  ));
                });
          },
        ),
      );

  Widget buildTop() => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 80), child: buildCoverImage()),
          Positioned(top: 160, child: buildProfilImage()),
        ],
      );

  Widget buildCoverImage() => Container(
      color: Colors.grey,
      child: Image.network("https://img.icons8.com/cute-clipart/344/movie.png",
          width: double.infinity, height: 240, fit: BoxFit.cover));

  Widget buildProfilImage() => CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey.shade700,
        backgroundImage: NetworkImage(
          "https://img.icons8.com/external-flaticons-lineal-color-flat-icons/344/external-movie-video-production-flaticons-lineal-color-flat-icons.png",
        ),
      );
}