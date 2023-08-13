import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum LoadingState { nonLoading, loading, complete }

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.loading,
    required this.mq,
    required this.text,
    required this.onTap,
  });

  final ValueNotifier<LoadingState> loading;
  final Size mq;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [
              Color(0xffd4bbf3),
              Color(0xff8e83f1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: loading.value == LoadingState.loading ||
                  loading.value == LoadingState.complete
              ? mq.width * 0.1
              : mq.width * 0.3,
          height: mq.height * 0.03,
          // child:
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: loading.value == LoadingState.loading
                ? const SpinKitDoubleBounce(
                    color: Colors.white,
                  )
                : loading.value == LoadingState.complete
                    ? const FittedBox(
                        child: Icon(
                          Icons.check,
                          size: 50,
                          color: Colors.white,
                        ),
                      )
                    : FittedBox(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: mq.width * 0.06,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
