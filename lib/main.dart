import 'dart:async';

import 'package:flutter/material.dart';
import 'musique.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spoticherif',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Spoticherif'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Musique> maListeDeMusiques = [
  new Musique ('Hello guys','Zero','images/un.jpg','https://codabee.com/wp-content/uploads/2018/06/un.mp3'),
  new Musique ('Whoa','Kira','images/deux.jpg','https://codabee.com/wp-content/uploads/2018/06/deux.mp3')
  ];
  StreamSubscription positionSub;
  StreamSubscription stateSubscription;
  Musique maMusiqueActuelle;
  Duration position = new Duration(seconds: 0);
  AudioPlayer audioPlayer;
  void initState(){
    super.initState();
    maMusiqueActuelle = maListeDeMusiques[0];
  }

  //@override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[800],
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Card(
              elevation: 9.0,
              child : new Container(
                width: MediaQuery.of(context).size.height /2.5,
                child: new Image.asset(maMusiqueActuelle.imagePath),

              ),
            ),
            texteAvecStyle(maMusiqueActuelle.titre, 1.5),
            texteAvecStyle(maMusiqueActuelle.artiste, 1.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                buton(Icons.fast_rewind,30.0,ActionMusic.rewind),
                buton(Icons.play_arrow,45.0,ActionMusic.play),
                buton(Icons.fast_forward, 30.0, ActionMusic.forward)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                texteAvecStyle('0:00', 0.8),
                texteAvecStyle('0:20', 0.8)
              ],
            ),
           /* new Slider(
                value: position.inSeconds.toDouble(),
                min:0.0,
                max:30.0,
                inactiveColor: Colors.white,
                activeColor:Colors.red,
                onChanged: (double d){
                  setState(() {
                    Duration nouvelleDuration = new Duration(seconds : d.toInt());
                    position = nouvelleDuration ;
                  });
                }
                )*/
          ],
        ),
      ),
    );
  }
  IconButton buton(IconData icone,double taille, ActionMusic action) {
    return new IconButton(
        iconSize: taille,
        color: Colors.white,
        icon:Icon(icone) ,
        onPressed: (){
          switch (action){
            case ActionMusic.play:
              print('play');
              break;
            case ActionMusic.pause:
              print('pause');
              break;
            case ActionMusic.rewind:
              print('rewind');
              break;
            case ActionMusic.forward:
              print('forward');
              break;
          }
        }
        );
  }
  Text texteAvecStyle(String data, double scale){
    return new Text(
      data,
      textAlign : TextAlign.center,
      textScaleFactor: scale,
      style: new TextStyle(
        color : Colors.white,
        fontSize: 20.0,
        fontStyle: FontStyle.italic

      ),
    );
  }
  void configurationAudioPlayer(){
    audioPlayer = new AudioPlayer();
    positionSub = audioPlayer.onAudioPositionChanged.listen(
        (pos)=>setState(()=> position = pos)
    );
  }
}
enum ActionMusic{
  play,
  pause,
  rewind,
  forward
}
enum PlayerState{
  playing,
  stopped,
  paused
}