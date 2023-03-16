import 'package:flutter/material.dart';
import 'package:http_request_using_rest_api/http_helper.dart';

class EditPosts extends StatefulWidget {
   EditPosts(this.post, {Key? key}) : super(key: key);

  final Map post;

  @override
  State<EditPosts> createState() => _EditPostsState();
}

class _EditPostsState extends State<EditPosts> {
  TextEditingController _controllerTitle=TextEditingController();
  TextEditingController _controllerbody=TextEditingController();
  @override
  void initState() {

    super.initState();
    _controllerTitle.text=widget.post['title'];
    _controllerbody.text=widget.post['body'];

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Edit Post")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(child: Column(
          children: [
            TextFormField(
              controller: _controllerTitle,

            ),
            TextFormField(
              controller: _controllerbody,
            ),
            ElevatedButton(onPressed: () async {
              Map dataToUpdate={
                'title':_controllerTitle.text,
                'body':_controllerbody.text
              };
              bool status=await HTTPHelper().updateItem(dataToUpdate, widget.post['id']);
              if(status){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("successsfully updated")));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("failed to update")));
              }

            }, child: Text("Edit"))
          ],
        )),
      ),
    );
  }
}
