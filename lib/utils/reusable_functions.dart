import 'dart:async';

import 'package:efficient_school/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ReusableFunctions {
  static String formatDateTimeWithDateAndTime(DateTime dateTime) {
    DateFormat outputFormat = DateFormat("dd MMM yyyy, h:mm a");

    String formattedDateString = outputFormat.format(dateTime);

    return formattedDateString;
  }

  static String timeAgo(DateTime dateTime) {
    Duration diff = DateTime.now().difference(dateTime);
    if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  static Future<Uint8List?> generateThumbnailFromPath(
      {String? videoPath, int? maxHeight}) async {
    Uint8List? file = await VideoThumbnail.thumbnailData(
      video: videoPath ?? "",
      imageFormat: ImageFormat.WEBP,
      maxHeight: maxHeight ?? 120,
      quality: 75,
    );
    return file;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.error,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }
}
