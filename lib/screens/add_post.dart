import 'package:flutter/material.dart';
import 'package:http_request_using_rest_api/http_helper.dart';

class AddPosts extends StatefulWidget {
   AddPosts({Key? key}) : super(key: key);

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  TextEditingController _controllerTitle=TextEditingController();

  TextEditingController _controllerBody=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add a post"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(child: Column(
        children: [
          TextFormField(
            controller: _controllerTitle,
            decoration: InputDecoration(
              labelText: "Add a title"
            ),
          ),
          TextFormField(
            controller: _controllerBody,
            decoration: InputDecoration(
              labelText: "Add a body"
            ),
          ),
          ElevatedButton(onPressed: () async {
            Map data={
              'tittle':_controllerTitle.text,
              'body':_controllerBody.text
            };
            bool status=await HTTPHelper().addItem(data);
            if(status){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post added")));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add")));
            }
          }, child: Text("Add post"))
        ],
      )),
    ),
    );
  }
}
