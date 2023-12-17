import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({super.key});

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  final videolink = "https://youtu.be/0sacQ4oo-P0?feature=shared";
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    final videoid = YoutubePlayer.convertUrlToId(videolink);
    _controller = YoutubePlayerController(
      initialVideoId: videoid!,
      // flags: YoutubePlayerFlags(autoPlay: false, hideControls: false) );
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Video'),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          )
        ],
      ),
    );
  }
}
