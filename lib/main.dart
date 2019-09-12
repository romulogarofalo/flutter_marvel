// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MarvelData(),
  ));
}


class MarvelData extends StatefulWidget {
  @override
  MarvelState createState() => MarvelState();
}


class MarvelState extends State<MarvelData> {

  String publicKey = 'f31864d4ecab68341375aa9d98185d26';
  String privateKey = 'bc0b00bee305028a4ac65520c2656e338ef25ea8';
  String url = 'http://gateway.marvel.com/v1/public/characters?ts=1&apikey=';//+publicKey+'&hash='+ textToMd5('1$publicKey$privateKey'));

  var data;

  String textToMd5 (String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  Future<String> getMarvelData() async {
    print('$url$publicKey&hash='+textToMd5('1$publicKey$privateKey')+'&limit=10');
    var res = await http.get('$url$publicKey&hash='+textToMd5('1'+privateKey+publicKey)+'&limit=10');
    print(json.decode(res.body));
    setState((){
      Map<String, dynamic> user = json.decode(res.body);
      data = user;
    });
    
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marvel API"),
      ),
      body: Center(
        child: 
          // data['data']['results'].map((item) =>
          //   print(item.toString()),
          listeTeste(context)
            // CustomCard(
            //   urlImage: ((data['data']['results'][0]['thumbnail']['path']).toString() +'.'+ data['data']['results'][0]['thumbnail']['extension']),
            //   name: 'romulo'
            // )
          //)
      )
    );
  }
  @override
  void initState() {
    super.initState();
    this.getMarvelData();
  }

  Widget getTextWidgets(List<String> strings){
    return new Row(children: strings.map((item) => new Text(item)).toList());
  }

  Widget listeTeste(BuildContext context){
    return ListView.builder(
      
      padding: EdgeInsets.only(top: 10), 
      itemCount: data['data']['results'].length, 
      itemBuilder: (context, index) {
        return ListTile(title: Text('tetet'));
      }
    );
  }
}

fn(jsonRecive) {
  return jsonRecive['data']['results'];
}


class CustomCard extends StatelessWidget {
  CustomCard({
    @required this.urlImage, 
    @required this.name,
  });

  final String urlImage;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(urlImage),
          Text('nome do mano $name'),
        ],
      )
    );
  }
}