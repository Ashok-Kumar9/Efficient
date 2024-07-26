import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:efficient_school/utils/size.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ReusableWidgets {
  static Widget buildImage({
    required String imageUrl,
    double? height,
    double? width,
    BoxFit fit = BoxFit.fitWidth,
  }) {
    return SizedBox(
      width: height ?? SizeConfig.width,
      height: width ?? SizeConfig.height,
      child: CachedNetworkImage(
        key: UniqueKey(),
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => const BlurHash(
          hash: "LEHV6nWB2yk8pyo0adR*.7kCMdnj",
          imageFit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(
            Icons.error,
            color: AppColors.error,
          ),
        ),
      ),
    );
  }

  static Widget buildProfileImage({
    String profileImageUrl = "",
    double size = 44,
    String userName = "U",
    double border = 1,
  }) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(border * 2),
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.grey,
          width: border,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: profileImageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const BlurHash(
            hash: "LEHV6nWB2yk8pyo0adR*.7kCMdnj",
          ),
          errorWidget: (context, url, error) => Center(
            child: Text(
              userName[0].toUpperCase(),
              style: TextStyle(color: AppColors.white, fontSize: size / 2),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildImageLocal({required String imagePath, double size = 48}) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.grey,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Text(
              imagePath[0].toUpperCase(),
              style: TextStyle(color: AppColors.white, fontSize: size / 2),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField({
    required TextEditingController controller,
    required String hintText,
    int minLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: minLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.secondary,
        hintStyle: const TextStyle(
            color: AppColors.grey, fontSize: 18, fontWeight: FontWeight.w300),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: const TextStyle(
          color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w300),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget customButton({
    Function()? onTap,
    required String title,
    bool isLoading = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: SizeConfig.height * 0.06,
        width: SizeConfig.width * 0.6,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grey, width: 0.2),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 3),
              blurRadius: 0,
              spreadRadius: 0,
              color: AppColors.highlight,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0)
                    .copyWith(right: 16),
                child: const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            Text(
              isLoading ? 'Uploading...' : title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
