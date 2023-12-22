
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
    _ivsController.setOnErrorCallback(_showErrorDialog);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
           //_ivsController.play('https://fcc3ddae59ed.us-west-2.playback.live-video.net/api/video/v1/us-west-2.893648527354.channel.DmumNckWFTqz.m3u8');
    });

  }

   void _showErrorDialog(String errorMessage) {
    showErrorDialog(context, errorMessage);
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment:MainAxisAlignment.center ,
        children: [
          FloatingActionButton(
            child: Icon(Icons.play_arrow),
            onPressed: (){
              _ivsController.play('https://fcc3ddae59ed.us-west-2.playback.live-video.net/api/video/v1/us-west-2.893648527354.channel.DmumNckWFTqz.m3u8');
            //  _ivsController.play('https://example.com/nonexistentvideo.mp4');
          }),
          FloatingActionButton(
             child: Icon(Icons.stop),
            onPressed: (){
              _ivsController.dispose();
          })
        ],
      ) ,
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

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text(errorMessage),
      );
    },
  );
}


}
