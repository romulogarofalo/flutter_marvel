// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import './entities/cardHero.dart';
import 'dart:math';

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
  String url = 'http://gateway.marvel.com/v1/public/characters';
  var timeStamp = '2';

  var data;

  String textToMd5 (String text) {
    return md5.convert(utf8.encode(text)).toString();
  }
  
  List<CardHero> _listHeros = new List<CardHero>();

  Future<List<CardHero>> getMarvelData() async {
    var res = await http.get('$url?ts=$timeStamp&apikey=$publicKey&hash='+textToMd5(timeStamp+privateKey+publicKey)+'&limit=10');
    print('$url?ts=$timeStamp&apikey=$publicKey&hash='+textToMd5(timeStamp+privateKey+publicKey)+'&limit=6');
    var listHeros = List<CardHero>();
    print(timeStamp);
    var jsonDecodado = json.decode(res.body);
    //1568340199107
    
    jsonDecodado['data']['results'].forEach((element) => 
      listHeros.add(CardHero.fromJson(element))
    );

    return listHeros;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marvel API"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CustomCard(
            name: _listHeros[index].name,
            urlImage: _listHeros[index].urlImage,
          );
        },
        itemCount: _listHeros.length,
      )
    );
  }
  @override
  void initState() {
    super.initState();
    this.getMarvelData().then((value) {
      setState(() {
        _listHeros.addAll(value);
      });
    });
  }
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
          Text(name),
        ],
      )
    );
  }
}