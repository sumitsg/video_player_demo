import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FilePage extends StatefulWidget {
  final VideoPlayerController controller;
  const FilePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  FilePageState createState() => FilePageState();
}

class FilePageState extends State<FilePage> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.controller,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: false,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Video player'),
        ),
        body: Chewie(
          controller: _chewieController,
        ));
  }
}
