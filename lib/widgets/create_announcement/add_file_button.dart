import 'package:efficient_school/utils/style.dart';
import 'package:flutter/material.dart';

import '../../utils/size.dart';

class AddFileButton extends StatelessWidget {
  const AddFileButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: SizeConfig.width * 0.25,
        height: SizeConfig.width * 0.25,
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          color: AppColors.highlight.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.50,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: AppColors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Icon(Icons.add, color: AppColors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              'Add File',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
              ),
            ),
            const Text(
              "( jpg, png, mp4 )",
              style: TextStyle(
                fontSize: 10,
                color: AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
