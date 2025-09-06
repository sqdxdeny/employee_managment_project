import 'package:flutter/material.dart';

final ButtonStyle elevatedButtonTheme = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  backgroundColor: Color(0xFF1A1A1A),
  foregroundColor: Colors.black12,
  elevation: 0,
  side: BorderSide(color: Colors.white, width: 1),
);
