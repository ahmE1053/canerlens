import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//this gets a list of animations values that takes the animation controller
//and the number of widgets to be animated then generates corresponding animations
//for each widget so that so move and fade from the screen one by one

List<double> getAnimations(
    {required AnimationController controller,
    required int numOfWidgets,
    bool reverse = false}) {
  double interval = 1 / numOfWidgets;
  double begin = 0;
  return List<double>.generate(
    numOfWidgets,
    (index) {
      begin += interval;
      return useAnimation(
        (reverse
                ? Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  )
                : Tween<double>(
                    begin: 1.0,
                    end: 0.0,
                  ))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              begin - interval - (begin - interval) * 0.2,
              begin > 1 ? 1 : begin,
              curve: Curves.easeIn,
            ),
          ),
        ),
      );
    },
  );
}
