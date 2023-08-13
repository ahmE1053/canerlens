import 'package:flutter/material.dart';

class DateOfBirthDropDown extends StatelessWidget {
  const DateOfBirthDropDown({
    super.key,
    required this.mq,
    required this.onChanged,
    required this.value,
    required this.values,
    required this.hint,
    required this.disabled,
    required this.errorState,
  });

  final Size mq;
  final int? value;
  final void Function(dynamic value) onChanged;
  final List<int> values;
  final String hint;
  final bool disabled, errorState;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 500,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: errorState
              ? Border.all(
                  color: Colors.red,
                )
              : null,
        ),
        padding: const EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
        child: DropdownButton(
          underline: Container(),
          menuMaxHeight: mq.height * 0.3,
          hint: FittedBox(
            child: Text(
              hint,
              style: TextStyle(
                fontSize: mq.width * 0.04,
                color: Colors.black,
              ),
            ),
          ),
          style: TextStyle(
            fontSize: mq.width * 0.04,
            color: Colors.black,
          ),
          value: value,
          items: values
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text('$e'),
                ),
              )
              .toList(),
          onChanged: disabled ? null : onChanged,
        ),
      ),
    );
  }
}
