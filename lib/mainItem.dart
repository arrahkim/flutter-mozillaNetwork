import 'package:flutter/material.dart';
import 'package:mozilla_network/detail.dart';
import 'package:mozilla_network/model.dart';

class MainItem extends StatefulWidget {
  final Model model;

  const MainItem({Key key, this.model}) : super(key: key);

  @override
  _MainItemState createState() => _MainItemState(model);
}

class _MainItemState extends State<MainItem> {
  final Model model;
  _MainItemState(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Detail(url: model.url),
              ));
        },
        child: Card(
          // child: Padding(
          //   padding: const EdgeInsets.all(16.0),
          child: CustomWidget(
            image: model.image_url,
            title: model.title,
            type: model.type,
            episode: model.episodes.toString(),
            startDate: model.start_date,
            endDate: model.end_date,
          ),
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final String image, title, type, episode, startDate, endDate;
  CustomWidget({
    this.image,
    this.title,
    this.type,
    this.episode,
    this.startDate,
    this.endDate,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage.assetNetwork(
                placeholder: 'img/loading.gif',
                image: image,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 5.0),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(title),
                Text(type),
                Text(episode),
                Text(startDate + "-" + endDate),
              ],
            ),
          )
        ],
      ),
    );
  }
}
