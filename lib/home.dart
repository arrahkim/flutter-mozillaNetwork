import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mozilla_network/api.dart';
import 'package:mozilla_network/mainItem.dart';
import 'package:mozilla_network/model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<MainItem>> _fetchData() async {
    final request = await http.get(Api.topAnime);

    if (request.statusCode == 200) {
      List response = json.decode(request.body)['top'];

      List<MainItem> data = [];
      for (var i = 0; i < response.length; i++) {
        data.add(MainItem(
          model: Model(
            response[i]['mal_id'],
            response[i]['rank'],
            response[i]['title'],
            response[i]['url'],
            response[i]['image_url'],
            response[i]['type'],
            response[i]['episodes'],
            response[i]['start_date'],
            response[i]['end_date'],
            response[i]['members'],
            response[i]['score'].round(),
          ),
        ));
      }
      return data;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mozilla Space"),
      ),
      body: FutureBuilder(
        future: _fetchData(),
        builder: (_, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return loadingPage();
            case ConnectionState.waiting:
              return loadingPage();
            case ConnectionState.none:
              return errorPage(context, snapshot);
            case ConnectionState.done:
              if (snapshot.hasData) {
                return homePage(snapshot.data);
              } else if (snapshot.hasError) {
                return errorPage(context, snapshot);
              } else {
                return errorPage(context, snapshot);
              }
              break;
            default:
          }
        },
      ),
    );
  }

  Widget loadingPage() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.pink,
      ),
    );
  }

  Widget errorPage(context, snapshot) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('Gagal Mendapatkan Data'),
          RaisedButton(
            onPressed: () {
              setState(() {
                
              });
            },
            child: Text("Coba Lagi"),
          )
        ],
      ),
    );
  }

  Widget homePage(List<MainItem> anime) {
    return ListView.builder(
      itemCount: anime.length,
      itemBuilder: (context, index) {
        return anime[index];
      },
    );
  }
}
