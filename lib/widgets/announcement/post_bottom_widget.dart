import 'package:carousel_slider/carousel_slider.dart';
import 'package:efficient_school/screens/media_viewer_page.dart';
import 'package:efficient_school/utils/media/raw_video_widget.dart';
import 'package:efficient_school/utils/reusable_widgets.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostBottomWidgetWithMedia extends StatefulWidget {
  final List<String> mediaFiles;
  final bool isShimmer;

  const PostBottomWidgetWithMedia({
    super.key,
    required this.mediaFiles,
    this.isShimmer = false,
  });

  @override
  State<PostBottomWidgetWithMedia> createState() =>
      _PostBottomWidgetWithMediaState();
}

class _PostBottomWidgetWithMediaState extends State<PostBottomWidgetWithMedia> {
  int currentIndex = 0;

  Widget _buildMediaWidget(String link, BuildContext context) {
    var smallLink = link.toLowerCase();
    if (smallLink.contains('.jpg') ||
        smallLink.contains('.jpeg') ||
        smallLink.contains('.png')) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ReusableWidgets.buildImage(
            imageUrl: link,
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.width - 16,
          ));
    } else if (smallLink.contains('.mp4')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: AppColors.tertiary,
          width: double.infinity,
          height: MediaQuery.of(context).size.width - 16,
          child: Center(
            child: VideoPreviewRaw(
              url: link,
            ),
          ),
        ),
      );
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      period: const Duration(seconds: 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.grey[300],
          width: double.infinity,
          height: MediaQuery.of(context).size.width - 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isShimmer) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        period: const Duration(seconds: 1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: MediaQuery.of(context).size.width - 16,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          if (widget.mediaFiles.isNotEmpty)
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.width - 16,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: widget.mediaFiles.map((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) =>
                                MediaViewerPage(url: item),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildMediaWidget(item, context),
                      ),
                    );
                  }).toList(),
                ),
                if (widget.mediaFiles.length > 1)
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentIndex,
                        count: widget.mediaFiles.length,
                        effect: WormEffect(
                          activeDotColor: AppColors.highlight,
                          dotColor: AppColors.highlight.withOpacity(0.2),
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 4,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      );
    }
  }
}
