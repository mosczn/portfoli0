import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../theme/palette.dart';
import 'pellet.dart';

/// Bingy, the albino pleco. He's always suckered to the glass, so the
/// player only ever controls his horizontal position; his y is fixed by
/// whoever places him in the world.
///
/// This component owns Bingy's position, size and hitbox -- the gameplay
/// facts about him. How he's drawn is delegated to a child component
/// ([_PlecoPlaceholder] below) so that swapping in real pixel art later is
/// a one-component change, not a rewrite of this class.
class Bingy extends PositionComponent with CollisionCallbacks {
  Bingy()
    : super(size: Vector2(64, 48), anchor: Anchor.center);

  /// Horizontal bounds Bingy is allowed to move within, in world units.
  /// Set by whoever places Bingy in the world, once the world's width is
  /// known.
  double minX = double.negativeInfinity;
  double maxX = double.infinity;

  /// Called whenever Bingy eats a [Pellet]. The world wires this up so it
  /// can keep score without [Bingy] needing to know what a "score" is.
  void Function()? onEatPellet;

  @override
  Future<void> onLoad() async {
    add(
      RectangleHitbox.relative(
        Vector2(0.7, 0.7),
        parentSize: size,
        anchor: Anchor.center,
      ),
    );
    add(_PlecoPlaceholder(size: size));
  }

  /// Moves Bingy horizontally by [dx] world units, clamped to [minX]/[maxX].
  void moveBy(double dx) {
    x = (x + dx).clamp(minX, maxX);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Pellet) {
      other.removeFromParent();
      onEatPellet?.call();
    }
  }
}

/// Placeholder vector art for Bingy: a chunky pale rounded body with a
/// dark sucker-mouth dot low on the belly. Purely cosmetic -- replace this
/// with a `SpriteComponent` (or `SpriteAnimationComponent`) once real pixel
/// art is ready; nothing in [Bingy] above needs to change.
class _PlecoPlaceholder extends PositionComponent {
  _PlecoPlaceholder({required Vector2 size})
    : super(size: size, anchor: Anchor.center);

  final Paint _bodyPaint = Paint()..color = Palette.bingyBody;
  final Paint _outlinePaint = Paint()
    ..color = Palette.outline
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  final Paint _mouthPaint = Paint()..color = Palette.outline;

  @override
  void render(Canvas canvas) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(12),
    );
    canvas.drawRRect(rrect, _bodyPaint);
    canvas.drawRRect(rrect, _outlinePaint);
    canvas.drawCircle(Offset(size.x / 2, size.y * 0.72), 5, _mouthPaint);
  }
}
