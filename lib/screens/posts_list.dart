import 'package:flutter/material.dart';
import 'package:http_request_using_rest_api/http_helper.dart';
import 'package:http_request_using_rest_api/screens/post_details.dart';

import 'add_post.dart';

class PostList extends StatefulWidget {
   PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Future<List<Map>> _futurePosts=HTTPHelper().fetchItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("post list"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPosts(

        ),));

      },child: Icon(Icons.add),),
      body: FutureBuilder<List<Map>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          //Check for errors
          if(snapshot.hasError)
            {
              return Center(child: Text("Some error Occured ${snapshot.error}"));
            }

          //Has data arrived
          if(snapshot.hasData){
            List<Map> posts=snapshot.data!;
            return ListView.builder(

              itemCount: posts.length,
              itemBuilder: (context, index) {
                Map thisItem=posts[index];
              return ListTile(
                title: Text("${thisItem['title']}"),
                subtitle: Text("${thisItem['body']}"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetails(thisItem['id'].toString()),));
                },


              );
            },);
          }

          //Display a loader
          return Center(child: CircularProgressIndicator());
        },
      ),
    );

  }
}
