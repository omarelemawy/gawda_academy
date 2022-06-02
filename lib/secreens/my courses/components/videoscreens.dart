import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class ChewieVideo extends StatefulWidget {
  // final String url;
  final String videoCode;

  const ChewieVideo({
    Key? key,
    required this.videoCode,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ChewieVideoState();
  }
}

class _ChewieVideoState extends State<ChewieVideo> {
  // VideoPlayerController _videoPlayerController1;
  // ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // initializePlayer();
  }

  @override
  void dispose() {
    // _videoPlayerController1.dispose();
    // _chewieController.dispose();
    super.dispose();
  }

  // Future<void> initializePlayer() async {
  //   _videoPlayerController1 = VideoPlayerController.network(
  //     widget.url,
  //   );
  //   await _videoPlayerController1.initialize();
  //   _chewieController = ChewieController(
  //     videoPlayerController: _videoPlayerController1,
  //     autoPlay: false,
  //     allowFullScreen: true,
  //     fullScreenByDefault: true,
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return VimeoPlayer(
      videoId: widget.videoCode,
    );
    // return Center(
    //   child: _chewieController != null &&
    //           _chewieController.videoPlayerController.value.initialized
    //       ? Theme(
    //           data: Theme.of(context).copyWith(
    //             dialogBackgroundColor: Colors.white,
    //           ),
    //           child: Chewie(
    //             controller: _chewieController,
    //           ),
    //         )
    //       : Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: const [
    //             CircularProgressIndicator(),
    //             SizedBox(height: 20),
    //             Text(
    //               'loading',
    //             ),
    //           ],
    //         ),
    // );
  }
}
