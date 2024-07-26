import 'dart:io';

import 'package:efficient_school/utils/size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utils/reusable_functions.dart';

class VideoPreviewRaw extends StatefulWidget {
  final String? filePath;
  final String? url;
  final bool isLooping;
  final bool isMuted;
  final bool showControls;

  const VideoPreviewRaw({
    super.key,
    this.filePath,
    this.url,
    this.isLooping = false,
    this.isMuted = true,
    this.showControls = false,
  })  : assert(filePath != null || url != null,
            'Either filePath or url is required'),
        assert(filePath == null || url == null,
            'Either filePath or url is required');

  @override
  VideoPreviewRawState createState() => VideoPreviewRawState();
}

class VideoPreviewRawState extends State<VideoPreviewRaw> {
  late VideoPlayerController _controller;
  bool error = false;
  Uint8List? file;

  @override
  void initState() {
    super.initState();
    try {
      if (widget.filePath != null) {
        _controller = VideoPlayerController.file(File(widget.filePath!))
          ..initialize().then((_) {
            if (mounted) setState(() {});
            _controller.setLooping(widget.isLooping);
            _controller.setVolume(widget.isMuted ? 0 : 1);
            _controller.play();
          });
      } else {
        ReusableFunctions.generateThumbnailFromPath(
                videoPath: widget.url,
                maxHeight: (SizeConfig.height - 16).toInt())
            .then((val) {
          file = val;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (mounted) setState(() {});
          });
        });
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!))
          ..initialize().then((_) {
            if (mounted) setState(() {});
            _controller.setLooping(widget.isLooping);
            _controller.setVolume(widget.isMuted ? 0 : 1);
            _controller.play();
          });
      }
    } catch (e) {
      error = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoPreviewRaw oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isMuted != widget.isMuted) {
      _controller.setVolume(widget.isMuted ? 0 : 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return const Center(child: Text('Error loading video'));
    }

    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, child) {
        if (value.hasError) {
          return const Center(child: Text('Error loading video'));
        }
        if (!value.isInitialized) {
          if (file != null) {
            return Image.memory(
              file!,
              fit: BoxFit.cover,
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        if (widget.showControls) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              if (!value.isCompleted)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    icon: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: value.isPlaying
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: const Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                      secondChild: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                      if (mounted) setState(() {});
                    },
                  ),
                ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _controller.setVolume(value.volume == 0 ? 1 : 0);
                    if (mounted) setState(() {});
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: (value.isCompleted)
                    ? IconButton(
                        icon: const Icon(
                          Icons.replay,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _controller.seekTo(const Duration(seconds: 0));
                          _controller.play();
                          if (mounted) setState(() {});
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        }
        return AspectRatio(
          aspectRatio: value.aspectRatio,
          child: VideoPlayer(_controller),
        );
      },
    );
  }
}
