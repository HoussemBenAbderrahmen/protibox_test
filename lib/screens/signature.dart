import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proti_box/screens/sign_in.dart';

import '../action_button.dart';
import '../auth.dart';
import '../theme.dart';

class SignatureScreen extends StatefulWidget {
  static const String routeName = "/SignatureScreen";

  const SignatureScreen({Key? key}) : super(key: key);

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  GlobalKey _globalKey = new GlobalKey();
  List<DrawnLine> lines = <DrawnLine>[];
  DrawnLine? line;
  Color selectedColor = Colors.black;
  double selectedWidth = 2.0;

  StreamController<List<DrawnLine>> linesStreamController =
      StreamController<List<DrawnLine>>.broadcast();
  StreamController<DrawnLine> currentLineStreamController =
      StreamController<DrawnLine>.broadcast();

  Future<void> clear() async {
    setState(() {
      lines = [];
      line = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Themings.darkTheme,
      child: Auth(children: [
        Text(
          "Signature",
          style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
        ),
        Text(
          "Veuillez ajouter votre signature électronique",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 24,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Stack(
                children: [buildAllPaths(context), buildCurrentPath(context), buildClearButton()]),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ActionButton(
            text: "Enregistrer",
            onPressed: lines.isNotEmpty
                ? () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  }
                : null),
      ]),
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.topLeft,
            child: StreamBuilder<DrawnLine>(
              stream: currentLineStreamController.stream,
              builder: (context, snapshot) {
                return CustomPaint(
                  size: Size(100, 100),
                  painter: Sketcher(
                    lines: line != null ? [line!] : [],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAllPaths(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.topLeft,
          child: StreamBuilder<List<DrawnLine>>(
            stream: linesStreamController.stream,
            builder: (context, snapshot) {
              return CustomPaint(
                size: Size(100, 100),
                painter: Sketcher(
                  lines: lines,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onPanStart(DragStartDetails details) {
    Offset point = details.localPosition;
    line = DrawnLine([point], selectedColor, selectedWidth);
  }

  void onPanUpdate(DragUpdateDetails details) {
    Offset point = details.localPosition;
    print("x: ${point.dx}: y: ${point.dy}");

    if (line != null) {
      List<Offset> path = List.from(line!.path)..add(point);
      line = DrawnLine(path, selectedColor, selectedWidth);
      currentLineStreamController.add(line!);
    }
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      lines = List.from(lines)..add(line!);
    });

    linesStreamController.add(lines);
  }

  Widget buildClearButton() {
    return GestureDetector(
      onTap: clear,
      child: Container(
        alignment: Alignment.topRight,
        child: CircleAvatar(
          child: Icon(
            Icons.create,
            size: 20.0,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
    );
  }
}

class DrawnLine {
  final List<Offset> path;
  final Color color;
  final double width;

  DrawnLine(this.path, this.color, this.width);
}

class Sketcher extends CustomPainter {
  final List<DrawnLine> lines;

  Sketcher({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < lines.length; ++i) {
      if (lines[i] == null) continue;
      for (int j = 0; j < lines[i].path.length - 1; ++j) {
        paint.color = lines[i].color;
        paint.strokeWidth = lines[i].width;
        canvas.drawLine(lines[i].path[j], lines[i].path[j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }
}
