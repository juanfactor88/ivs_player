
import 'package:flutter/material.dart';

import 'Streaming_player/Ivs_player.dart';
import 'Streaming_player/ivs_player_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
      final IvsPlayerController _ivsController = IvsPlayerController();

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    //_ivsController.play('https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8');
  }


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IvsVideoPlayer()
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
