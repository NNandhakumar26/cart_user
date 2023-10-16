import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toyskart/core/constants/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: JumpingDotsProgressIndicator(
                  numberOfDots: 4,
                  fontSize: 60.0,
                  color: ColorConst.primary,
                )),
              ),
            ),
          ),
          // const LinearProgressIndicator(
          //   value: 1,
          //   minHeight: 8,
          //   backgroundColor: Colors.transparent,
          //   color: Color.fromARGB(255, 246, 87, 62),
          // )
        ],
      ),
    );
  }
}
