import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt/utils/app_colors.dart';
import 'package:chat_gpt/view/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.index});
  final String msg;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: index == 0 ? AppColors.backgroundColor : AppColors.cardColor,
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                index == 0
                    ? "assets/images/hacker.png"
                    : "assets/images/chat_logo.png",
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: index == 0
                      ? CustomTextWidget(label: msg)
                      : AnimatedTextKit(
                          repeatForever: false,
                          isRepeatingAnimation: false,
                          displayFullTextOnTap: true,
                          totalRepeatCount: 1,
                          animatedTexts: [
                              TyperAnimatedText(
                                msg.trim(),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ])),
              index == 0
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.thumb_down_outlined,
                          color: Colors.white,
                        )
                      ],
                    )
            ],
          ),
        )
      ],
    );
  }
}
