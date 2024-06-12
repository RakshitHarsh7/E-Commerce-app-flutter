import 'package:ecommerce_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class Choicechip extends StatelessWidget {
  const Choicechip({
    super.key,
    required this.text,
    required this.selected,
    this.onSeleted,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSeleted;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent ),
      child: ChoiceChip(
        label: THelperFunctions.getColor(text) != null
            ? const SizedBox()
            : Text(text),
        selected: selected,
        onSelected: onSeleted,
        // ignore: dead_code
        labelStyle: TextStyle(color: selected ? TColors.white : null),
        avatar: THelperFunctions.getColor(text) != null
            ? TCircularContainer(
                width: 50,
                height: 50,
                backgroundcolor: THelperFunctions.getColor(text)!)
            : null,
        shape: isColor ? const CircleBorder() : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        backgroundColor: isColor ? THelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
