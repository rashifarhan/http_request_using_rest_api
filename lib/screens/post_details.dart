import 'package:flutter/material.dart';
import 'package:http_request_using_rest_api/http_helper.dart';
import 'package:http_request_using_rest_api/screens/edit_post.dart';

class PostDetails extends StatefulWidget {
   PostDetails(this.itemId,{Key? key}) : super(key: key){
    _futurePost=HTTPHelper().getOneItem(itemId);

  }
  final String itemId;
   late Future<Map> _futurePost;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
   late Map post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditPosts(post),));
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: () async {
           bool deleted=await HTTPHelper().DeleteItem(widget.itemId);
           if(deleted){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("post deleted")));
           }else{
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("failed to deleted")));
           }
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: FutureBuilder<Map>(
        future: widget._futurePost,
        builder:   (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text("Some error occured${snapshot.error}"),);
          }
          if(snapshot.hasData){
            post=snapshot.data!;
            return Column(
              children: [
                Text("${post['title']}"),
                Text("${post['body']}"),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
