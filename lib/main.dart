import 'package:flutter/material.dart';
import 'package:demo/animation/animation.dart';

main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        // title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
          // appBar: new AppBar(
          //   title: new Text('Welcome Demo'),
          // ),
          body: new Demo(),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: <Widget>[
        new HeaderImage(),
        new LiveSection(),
        new BtnSection(),
        new TextSection(),
      ],
    );
  }
}

class HeaderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Image.asset(
        'images/fj.jpg',
        height: 240.0,
        fit: BoxFit.cover,
      ),
    );
  }
}

class LiveSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LiveSectionState();
  }
}

class LiveSectionState extends State<LiveSection> {
  int _favoritCount = 40;
  bool _isFavorit = false;
  Widget _currentIcon;
  @override
  Widget build(BuildContext context) {
    this._currentIcon =
        _isFavorit ? new Icon(Icons.star) : new Icon(Icons.star_border);
    // TODO: implement build
    return new Container(
        padding: EdgeInsets.all(32.0),
        child: Row(
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        'Oeschinen Lake Campground',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  new Text(
                    'Kandersteg, Switzerland',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            new IconButton(
              icon: this._currentIcon,
              color: Colors.red,
              onPressed: () {
                if (this._isFavorit) {
                  setState(() {
                    this._favoritCount--;
                    this._isFavorit = false;
                  });
                } else {
                  setState(() {
                    this._favoritCount++;
                    this._isFavorit = true;
                  });
                }
              },
            ),
            new Text('${this._favoritCount}'),
          ],
        ));
  }
}

class Btn extends StatelessWidget {
  Btn(this.icon, this.label);

  final IconData icon;

  final String label;
  @override
  Widget build(BuildContext context) {
    return getColumn(context);
  }

  Column getColumn(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(bottom: 8.0),
          child: new Icon(
            this.icon,
            color: color,
          ),
        ),
        new Text(this.label),
      ],
    );
  }
}

class BtnSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Btn(Icons.phone, 'CALL'),
          new Btn(Icons.near_me, 'ROUTE'),
          new Btn(Icons.share, 'SHARE'),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
        textAlign: TextAlign.left,
      ),
    );
  }
}

