import 'package:flutter/material.dart';
import 'package:oops/models/activity.dart' as model;
import 'package:oops/screens/shared/wave_loading.dart';
import 'package:oops/services/activities.dart';

class Introduction extends StatefulWidget {
  final int currentLevel;

  Introduction({@required this.currentLevel});

  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  bool _loading = true;

  String _title = '';
  String _body = '';

  void _getActivity() async {
    try {
      model.Activity activity =
          await ActivitiesService(currentLevel: widget.currentLevel)
              .fetchActivity();
      setState(() {
        _title = activity.getTitle();
        _body = activity.getBody();
        _loading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _getActivity();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? WaveLoading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent[700],
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              centerTitle: true,
              title: Text(
                'Introdução',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    child: Text(
                      _title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _body,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
