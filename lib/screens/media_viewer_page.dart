import 'package:efficient_school/utils/media/raw_video_widget.dart';
import 'package:efficient_school/utils/reusable_widgets.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:flutter/material.dart';

class MediaViewerPage extends StatefulWidget {
  final String? title;
  final String? url;
  final String? path;

  const MediaViewerPage({
    super.key,
    this.title,
    this.path,
    this.url,
  });

  @override
  State<MediaViewerPage> createState() => _MediaViewerPageState();
}

class _MediaViewerPageState extends State<MediaViewerPage> {
  final FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();

  String getTitle() {
    if (widget.url != null) {
      return widget.url!.split("/").last;
    } else {
      return widget.path!.split("/").last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          actions: const [
            CloseButton(
              color: Colors.white,
            ),
          ],
        ),
        body: (widget.url ?? "").contains('.mp4')
            ? VideoPreviewRaw(
                url: widget.url,
                showControls: true,
                isMuted: false,
              )
            : ReusableWidgets.buildImage(
                imageUrl: widget.url!,
              ));
  }
}
