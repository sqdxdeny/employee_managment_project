import 'package:employee_managment_project/domain/requets/request.dart';
import 'package:flutter/material.dart';

extension RequestsSortStyle on RequestsSort {
  Color get color {
    switch (this) {
      case RequestsSort.all:
        return Colors.transparent;
      case RequestsSort.private:
        return Colors.red;
      case RequestsSort.social:
        return Colors.blue;
    }
  }
}
