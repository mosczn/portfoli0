import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../theme/palette.dart';

/// A food pellet drifting down through the water. Bingy eats it on contact;
/// otherwise it's removed once it drifts past the bottom of the world.
///
/// This component handles position/movement/hitbox only; the look of the
/// pellet is a swappable child component (see [_PelletPlaceholder]), and
/// "what happens when Bingy eats it" is handled by [Bingy] itself, not here.
class Pellet extends PositionComponent with CollisionCallbacks {
  Pellet() : super(size: Vector2.all(26), anchor: Anchor.center);

  /// Downward speed in world units per second.
  double speed = 220;

  /// y beyond which this pellet is considered missed and removed. Set by
  /// whoever spawns it, once the world's height is known.
  double despawnY = double.infinity;

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
    add(_PelletPlaceholder(radius: size.x / 2));
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += speed * dt;
    if (y > despawnY) {
      removeFromParent();
    }
  }
}

/// Placeholder vector art for a pellet: a chunky bright dot with a black
/// outline. Replace with a `SpriteComponent` later; [Pellet]'s movement,
/// hitbox and collision logic above won't need to change.
class _PelletPlaceholder extends PositionComponent {
  _PelletPlaceholder({required double radius})
    : super(size: Vector2.all(radius * 2), anchor: Anchor.center);

  final Paint _fillPaint = Paint()..color = Palette.pellet;
  final Paint _outlinePaint = Paint()
    ..color = Palette.outline
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  @override
  void render(Canvas canvas) {
    final center = Offset(size.x / 2, size.y / 2);
    final radius = size.x / 2;
    canvas.drawCircle(center, radius, _fillPaint);
    canvas.drawCircle(center, radius, _outlinePaint);
  }
}
