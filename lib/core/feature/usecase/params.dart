import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Params extends Equatable {
  final int number;

  Params({
    @required this.number,
  });

  @override
  List<Object> get props => [number];
}
