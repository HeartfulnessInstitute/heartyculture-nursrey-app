import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../constants.dart';
import 'online_store.dart';

class YoutubeScreen extends StatelessWidget {
  const YoutubeScreen({super.key, required this.videoURl});

  final String videoURl;

  @override
  Widget build(BuildContext context) {
    String? videoId;
    videoId = YoutubePlayerController.convertUrlToId(videoURl);
    final _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId!,
      autoPlay: true,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: YoutubePlayerScaffold(
        controller: _controller,
        builder: (context, player) {
          return Center(child: player);
        },
      ),
    );
  }
}
