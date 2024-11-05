import 'package:base_flutter/plugin/image_loader_plugin.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';

class MyDropdownView extends StatelessWidget {
  const MyDropdownView(
      {super.key,
      required this.label,
      required this.onPress,
      this.readOnly = true,
      this.hint = 'Vui lòng chọn',
      required this.controller});

  final String? label;
  final String hint;
  final bool readOnly;
  final VoidCallback onPress;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (label != null)
            Positioned(
                height: 17,
                left: 0,
                right: 0,
                child:
                    Text(label!, style: Theme.of(context).textTheme.bodySmall)),
          Positioned(
            height: 44,
            top: 22,
            left: 0,
            right: 0,
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onPress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: context.appColors.primary)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: context.appColors.primary)),
                hintText: hint,
                hintStyle: context.textStyles.hintText,
                labelStyle: const TextStyle(
                    fontSize: 13, color: Colors.redAccent), //label style
                suffixIcon: IconButton(
                  onPressed: onPress,
                  padding: const EdgeInsets.only(left: 6),
                  constraints: const BoxConstraints(),
                  icon: const ImageLoaderPlugin(
                    'right-arrow.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
