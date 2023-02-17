import 'package:chat_gpt/view/widgets/drop_down.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../view/widgets/custom_text_widget.dart';

class Services {
  static Future<void> showBottomSheet({required context}) async {
    await showModalBottomSheet(
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                child: CustomTextWidget(
                  label: "Choose Model:",
                  fontSize: 16,
                ),
              ),
              Flexible(flex: 2, child: CustomDropDownButton())
            ],
          ),
        );
      },
    );
  }
}
