import 'package:flutter/material.dart';
import 'package:untitled/data/models/task.dart';
import 'package:untitled/utils/colors.dart';
import 'package:untitled/utils/extensions.dart';
import 'package:untitled/view/widgets/color_picker_item.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colorNotifier, this.task});

  final ValueNotifier<Color> colorNotifier;
  final Task? task;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  @override
  void initState() {
    super.initState();
    final color = widget.task?.color;
    if(color != null) {
      colors.toggleColor(color);
    } else {
      colors.setAllFalse();
    }
    widget.colorNotifier.value = color ?? Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i in colors.entries)
          GestureDetector(
              onTap: () {
                setState(() {
                  colors.updateAll((key, value) {
                    if (key != i.key) {
                      return value = false;
                    }
                    widget.colorNotifier.value = key;
                    return value = true;
                  });
                });
              },
              child: ColorPickerItem(color: i.key, isChecked: i.value))
      ],
    );
  }
}