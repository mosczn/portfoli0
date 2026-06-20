import 'package:flutter/material.dart';

/// Bingy's retro DOS/EGA-inspired palette.
///
/// Everything in the game should pull its colors from here. Keeping the
/// palette in one place means the whole game's look can be retuned (or
/// swapped for a different retro feel) by editing a handful of lines, and
/// it keeps placeholder shapes visually consistent until real sprites
/// replace them.
class Palette {
  Palette._();

  /// The water behind the glass -- deep EGA blue.
  static const Color water = Color(0xFF0000AA);

  /// Bingy's body: pale, off-white, true to an albino pleco.
  static const Color bingyBody = Color(0xFFF4ECD8);

  /// Chunky black outline used on every placeholder shape, EGA-cartoon style.
  static const Color outline = Color(0xFF000000);

  /// A food pellet floating in the water.
  static const Color pellet = Color(0xFFFFFF55);

  /// HUD text color.
  static const Color hudText = Color(0xFFFFFFFF);
}
