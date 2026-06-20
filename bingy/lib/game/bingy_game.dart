import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' show Color, TextStyle;

import '../theme/palette.dart';
import 'bingy_world.dart';

/// The Bingy game. A thin shell: it owns the fixed-resolution camera and
/// the background color. Actual gameplay lives in [BingyWorld].
class BingyGame extends FlameGame<BingyWorld> {
  BingyGame()
    : super(
        world: BingyWorld(),
        camera: CameraComponent.withFixedResolution(
          width: BingyWorld.width,
          height: BingyWorld.height,
          hudComponents: [_EatenCounter()],
        ),
      );

  @override
  Color backgroundColor() => Palette.water;
}

/// Diagnostic HUD text for this first milestone: shows how many pellets
/// Bingy has eaten, so we can see the eat mechanic firing without checking
/// logs. Positioned in viewport (screen pixel) space via [hudComponents],
/// so it ignores the camera/world entirely -- it always sits in the same
/// corner regardless of how Bingy or the pellets move.
class _EatenCounter extends TextComponent with HasGameReference<BingyGame> {
  _EatenCounter()
    : super(
        position: Vector2(12, 12),
        textRenderer: TextPaint(
          style: const TextStyle(color: Palette.hudText, fontSize: 18),
        ),
      );

  @override
  void update(double dt) {
    super.update(dt);
    text = 'Eaten: ${game.world.eaten}';
  }
}
