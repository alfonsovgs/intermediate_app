import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

enum Animals {Cat, Dog, Bird, Lizard, Fish}

class _State extends State<MyApp>  {
  String _value = 'Nothing yet';
  double _value2 = 0.0;
  int counter = 0;
  List<Widget> _list = new List<Widget>();
  Animals _selected = Animals.Cat;
  String _valueAnimals = 'Make a Selection';
  List<PopupMenuEntry<Animals>> _items = new List<PopupMenuEntry<Animals>>();

  void _onPressed() => setState(() => _value = new DateTime.now().toString() );
  void _onClicked() {
    Widget child = _newItem(counter);
    setState(() {
      _list.add(child);
    });
  }
  void _onChange(double value) => setState(() => _value2 = value);

  Widget _newItem(int i) {
    Key key = new Key('Item $i');
    Container child = new Container(
      key: key,
      padding: new EdgeInsets.all(10.0),
      child: new Chip(
          label: new Text('$i Name her'),
          deleteIconColor: Colors.red,
          deleteButtonTooltipMessage: 'Delete',
          onDeleted: () => _removeItem(key),
          avatar: new CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: new Text(i.toString()),
          ),
      ),
    );

    counter++;
    return child;
  }
  void _removeItem(Key key) {
    for(int i = 0; i < _list.length; i++) {
      var child = _list.elementAt(i);
      if(child.key == key)
        {
          setState(() => _list.removeAt(i));
          counter--;
        }
    }
  }

  void _onSelected(Animals animal) {
    setState(() {
      _selected = animal;
      _valueAnimals = 'You selected ${_getDisplay(animal)}';
    });
  }

  String _getDisplay(Animals animal) {
    int index = animal.toString().indexOf('.');
    index++;
    return animal.toString().substring(index);
  }

  @override
  void initState() {
    for(int i = 0; i < 3; i++){
      _list.add(_newItem(i));
    }

    for(Animals animal in Animals.values){
      _items.add(new PopupMenuItem(
          child: new Text(_getDisplay(animal)),
          value: animal,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Intermediate'),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: _onClicked,
          child: new Icon(Icons.add),
      ),

      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(_value),
              new IconButton(
                  icon: new Icon(Icons.timer),
                  onPressed: _onPressed,
                  tooltip: 'Click Me',
              ),
              new Container(
                child: new Column(
                  children: _list,
                ),
              ),
              new Slider(value: _value2, onChanged: _onChange,),
              new Container(
                padding: EdgeInsets.all(32.0),
                child: new LinearProgressIndicator(
                  value: _value2,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                )
              ),
              new Container(
                  padding: EdgeInsets.all(32.0),
                  child: new CircularProgressIndicator(
                    value: _value2,
                  )
              ),

              new Row(
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.all(5.0),
                      child: new Text(_valueAnimals),
                    ),
                    new PopupMenuButton<Animals>(
                      child: new Icon(Icons.input),
                      initialValue: Animals.Cat,
                      onSelected: _onSelected,
                      itemBuilder: (BuildContext context) {
                        return _items;
                      },
                    )
                  ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

