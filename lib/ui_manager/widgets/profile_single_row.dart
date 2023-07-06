import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayaratech/ui_manager/colors_manager.dart';

import '../fixed_numbers_manager.dart';
import '../sized_box_manager.dart';

class SingleProfileRow extends StatelessWidget {
  final Icon? icon;
  final String? title;
  final VoidCallback? onTap;
  final bool? divider;
  final bool? automaticallyTailButton;
  final Widget? tail;
  final Color? titleColor;
  const SingleProfileRow(
      {Key? key,
      required this.icon,
      required this.title,
      this.onTap,
      this.divider,
      this.automaticallyTailButton = true,
      this.tail,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: fixedPadding - 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    icon!,
                    fixedSizedBoxWidth,
                    fixedSizedBoxWidth,
                    Text(
                      title!,
                      style: Get.textTheme.titleMedium!
                          .copyWith(color: titleColor),
                    ),
                  ],
                ),
                automaticallyTailButton!
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: fixedPadding),
                        child: Icon(
                          Icons.navigate_next,
                          color: greyColor,
                        ),
                      )
                    : tail ?? Container()
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: fixedMainPadding * 1.5),
          child: divider == null || divider == true
              ? Divider(
                  color: Theme.of(context).focusColor.withOpacity(0.3),
                )
              : Container(),
        )
      ],
    );
  }
}
