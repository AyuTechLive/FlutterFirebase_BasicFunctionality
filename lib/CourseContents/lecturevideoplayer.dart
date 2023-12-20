import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LectureVideoPlayer extends StatefulWidget {
  final String videoURL;
  final String videoTitle;
  final String videoSubtitle;
  const LectureVideoPlayer({super.key, required this.videoURL, required this.videoTitle, required this.videoSubtitle});

  @override
  State<LectureVideoPlayer> createState() => _LectureVideoPlayerState();
}

class _LectureVideoPlayerState extends State<LectureVideoPlayer> {
  
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    final videoid = YoutubePlayer.convertUrlToId(widget.videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoid!,
      flags: YoutubePlayerFlags(isLive: true)

      
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
            liveUIColor: Colors.amber,
            
          ),
          Text(widget.videoTitle),
          Text(widget.videoSubtitle)
        ],
      ),
    );
  }
}
