// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:posts/helpers/ui_layout.dart';

class Margin extends StatelessWidget {
  const Margin({Key? key}) : super(key: key);

  final double _margin = UILayout.margin4;
  final bool _vertical = false;

  factory Margin.margin8() = _Margin8;
  factory Margin.margin12() = _Margin12;
  factory Margin.margin16() = _Margin16;
  factory Margin.margin24() = _Margin24;
  factory Margin.margin36() = _Margin36;
  factory Margin.margin48() = _Margin48;
  factory Margin.vertical() = _Vertical;
  factory Margin.verticalMargin8() = _VerticalMargin8;
  factory Margin.verticalMargin12() = _VerticalMargin12;
  factory Margin.verticalMargin16() = _VerticalMargin16;
  factory Margin.verticalMargin24() = _VerticalMargin24;
  factory Margin.verticalMargin36() = _VerticalMargin36;
  factory Margin.verticalMargin48() = _VerticalMargin48;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _vertical ? 0 : _margin,
      height: _vertical ? _margin : 0,
    );
  }
}

class _Vertical extends Margin {
  @override
  final bool _vertical = true;
}

class _Margin8 extends Margin {
  @override
  final double _margin = UILayout.margin8;
}

class _VerticalMargin8 extends _Margin8 {
  @override
  final bool _vertical = true;
}

class _Margin12 extends Margin {
  @override
  final double _margin = UILayout.margin12;
}

class _VerticalMargin12 extends _Margin12 {
  @override
  final bool _vertical = true;
}

class _Margin16 extends Margin {
  @override
  final double _margin = UILayout.margin16;
}

class _VerticalMargin16 extends _Margin16 {
  @override
  final bool _vertical = true;
}

class _Margin24 extends Margin {
  @override
  final double _margin = UILayout.margin24;
}

class _VerticalMargin24 extends _Margin24 {
  @override
  final bool _vertical = true;
}

class _Margin36 extends Margin {
  @override
  final double _margin = UILayout.margin36;
}

class _VerticalMargin36 extends _Margin36 {
  @override
  final bool _vertical = true;
}

class _Margin48 extends Margin {
  @override
  final double _margin = UILayout.margin48;
}

class _VerticalMargin48 extends _Margin48 {
  @override
  final bool _vertical = true;
}
