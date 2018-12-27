import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DemoBox();
  }
}

class DemoBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new DemoBoxState();
  }
}

class DemoBoxState extends State<DemoBox> {
  var topList = <int>[1, 2, 3];
  var bottomList = <int>[5, 6, 7];
  void modiyBottomList(int value, bool isTop) {
    if (isTop) {
      setState(() {
        this.topList.remove(value);
        this.bottomList.add(value);
        print(topList);
      });
    } else {
      setState(() {
        this.bottomList.remove(value);
        this.topList.add(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        new TopBox(topList, this.modiyBottomList),
        new BottomBox(bottomList, this.modiyBottomList),
      ],
    );
  }
}

class TopBox extends StatefulWidget {
  final List<int> _list;
  final Function(int, bool) changed;
  TopBox(this._list, this.changed);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TopBoxState(this._list, this.changed);
  }
}

class TopBoxState extends State<TopBox> {
  List<int> _list;
  final Function(int, bool) changed;
  TopBoxState(this._list, this.changed);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(top: 50.0),
      // height: 100,
      width: MediaQuery.of(context).size.width,
      child: new Column(
        children: this._gen(),
      ),
    );
  }

  List<Container> _gen() {
    List<Container> conList = new List<Container>();

    for (int item in this._list) {
      Container con = new Container(
        key: Key(item.toString()),
        margin: EdgeInsets.only(top: 10.0),

        // color: new Color(0xffff0000),
        child: AnimatedItem(item, this.changed, true),

        width: 100.0,
        height: 100.0,
      );
      conList.add(con);
    }
    return conList;
  }
}

class BottomBox extends StatefulWidget {
  final List<int> _list;
  final Function(int, bool) changed;
  BottomBox(this._list, this.changed);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BottomBoxState(this._list, this.changed);
  }
}

class BottomBoxState extends State<BottomBox> {
  List<int> _list;
  final Function(int, bool) changed;
  BottomBoxState(this._list, this.changed);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 20.0),
      // height: 100,
      width: MediaQuery.of(context).size.width,
      child: new Column(
        children: this._gen(),
      ),
    );
  }

  List<Container> _gen() {
    List<Container> conList = new List<Container>();

    for (int item in this._list) {
      Container con = new Container(
        margin: EdgeInsets.only(top: 10.0),
        key: Key(item.toString()),
        // color: Colors.blue,

        child: AnimatedItem(item, this.changed, false),

        width: 100.0,
        height: 100.0,
      );
      conList.add(con);
    }
    return conList;
  }
}

class AnimatedItem extends StatefulWidget {
  final int value;
  final bool flag;
  final Function(int, bool) changed;
  AnimatedItem(this.value, this.changed, this.flag);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AnimatedItemState(value, this.changed, this.flag);
  }
}

class AnimatedItemState extends State<AnimatedItem>
    with SingleTickerProviderStateMixin {
  final int value;
  bool flag;
  Function(int, bool) changed;
  AnimationController controller;
  Animation<double> animation;
  initState() {
    super.initState();
    // width = 0;
    // height = 0;
    controller = new AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = new Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print(this.value);
          this.changed(this.value, this.flag);
        }
      });
    // animation = new Tween(begin: this.begin, end: this.end).animate(controller)
    //   ..addStatusListener((status) {
    //     print(status);
    //   });
  }

  AnimatedItemState(this.value, this.changed, this.flag) : super();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ScaleTransition(
        scale: animation,
        child: Container(
          child: new FlatButton(
            child: new Text(this.value.toString()),
            onPressed: () {
              print('PRESS');
              controller.forward();
            },
          ),
          color: this.flag ? Colors.pink : Colors.blue,
          // width: width,
          // height: height,
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
