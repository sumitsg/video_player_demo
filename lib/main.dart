import 'package:flutter/material.dart';
import 'package:video_player_demo/chewielistitem.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:video_player_demo/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late VideoPlayerController controller;
  File file = File('');

  void getStorageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      setState(() {
        file = file;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FilePage(controller: VideoPlayerController.file(file))));
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Video Player',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: ListView(
        children: [
          // ! 1 from assets folder-->
          ChewieListItem(
            videoPlayerController:
                VideoPlayerController.asset('videos/video1.mp4'),
            looping: true,
          ),
          // ! from URL link-->
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
            looping: true,
          ),
          // ! selecting from file system

          ElevatedButton(
              onPressed: () {
                getStorageFile();
              },
              child: const Text('Pick me'))
        ],
      ),
    );
  }
}
