import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class HTTPHelper {
  //--Fetching all the items
  Future<List<Map>> fetchItems() async {
    List<Map> items = [];
    //--Get the data from API
   http.Response response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
   if(response.statusCode==200){
     String jsonString=response.body;

     List data=jsonDecode(jsonString);
     items=data.cast<Map>();


   }


    return items;
  }

  //--Fetching details of one item
  Future<Map> getOneItem(itemId) async {
    Map item = {};
    http.Response response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));
    if(response.statusCode==201||response.statusCode==200){
      String jsonString=response.body;

      item=jsonDecode(jsonString);
    }

    return item;
  }

  //--Add new item
  Future<bool> addItem(Map data) async {
    bool status = false;
    //Add the item to the database,call the api
   http.Response response= await http.post(
       Uri.parse("https://jsonplaceholder.typicode.com/posts"),
     body: jsonEncode(data),
     headers: {
         'Content-type':'application/json'
     }
   
   );
   if(response.statusCode==201||response.statusCode==200)
     {
       status=response.body.isNotEmpty;
     }

    return status;
  }

  //--Update an item
  Future<bool> updateItem(Map data,String itemId) async {
    bool status = false;
    http.Response response= await http.put(
        Uri.parse("https://jsonplaceholder.typicode.com/posts$itemId"),
        body: jsonEncode(data),
        headers: {
          'Content-type':'application/json'
        }

    );
    if(response.statusCode==201||response.statusCode==200)
    {
      status=response.body.isNotEmpty;
    }

    return status;
  }

//--Delete an item
  Future<bool> DeleteItem(String itemId) async {
    bool status = false;
    http.Response response=await http.delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));
    if(response.statusCode==201||response.statusCode==200)
    {
      status=response.body.isNotEmpty;
    }

    return status;
  }

}
