import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaveLoading extends StatelessWidget {
  const WaveLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[900],
      child: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
