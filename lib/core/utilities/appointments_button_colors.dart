import 'package:flutter/material.dart';

Map<String, Color> appointmentButtonColor(
    ColorScheme colorScheme, ButtonState buttonState) {
  final colorMap = {
    ButtonState.pressed: {
      'background': colorScheme.secondary,
      'onBackground': colorScheme.onSecondary,
    },
    ButtonState.unpressed: {
      'background': colorScheme.surface,
      'onBackground': colorScheme.primary,
    },
  };
  return colorMap[buttonState]!;
}

Map<String, ButtonState> appointmentButtonStateChanger(
    ButtonState thisButtonState, ButtonState otherButtonState) {
  final map = {
    ButtonState.pressed: ButtonState.unpressed,
    ButtonState.unpressed: ButtonState.pressed,
  };
  final otherButtonMap = {
    ButtonState.pressed: ButtonState.unpressed,
    ButtonState.unpressed: ButtonState.unpressed,
  };

  return {
    'this': map[thisButtonState]!,
    'otherButton': otherButtonMap[otherButtonState]!,
  };
}

void onButtonTap(
    ValueNotifier<ButtonState> thisButton,
    ValueNotifier<ButtonState> otherButton,
    AnimationController animationController,
    void Function() remove,
    void Function() returnToNormal) async {
  final newButtonsStates = appointmentButtonStateChanger(
    thisButton.value,
    otherButton.value,
  );
  thisButton.value = newButtonsStates['this']!;
  otherButton.value = newButtonsStates['otherButton']!;
  animationController.forward();
  await Future.delayed(const Duration(milliseconds: 250));
  if (thisButton.value == ButtonState.pressed) {
    remove();
  } else {
    returnToNormal();
  }
}

enum ButtonState {
  pressed,
  unpressed,
}
