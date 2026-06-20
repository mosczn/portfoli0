import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'components/bingy.dart';
import 'components/pellet.dart';

/// Bingy's world: a fixed virtual play area, in world units, that the
/// camera renders at whatever size the device screen actually is. World
/// (0, 0) sits at the center of the screen, x grows to the right, and y
/// grows *downward* -- so things "coming down the screen" means y
/// increasing, matching the glass-scrolls-past-Bingy concept.
class BingyWorld extends World with DragCallbacks, HasCollisionDetection {
  static const double width = 360;
  static const double height = 640;

  late final Bingy bingy;

  final Random _rng = Random();
  double _timeSinceSpawn = 0;
  static const double _spawnInterval = 1.3;

  /// How many pellets Bingy has eaten. Surfaced by the HUD purely so we can
  /// see the eat mechanic firing during this first milestone.
  int eaten = 0;

  @override
  Future<void> onLoad() async {
    bingy = Bingy()
      ..position = Vector2(0, height / 2 - 70)
      ..minX = -width / 2 + 40
      ..maxX = width / 2 - 40
      ..onEatPellet = () => eaten++;
    add(bingy);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceSpawn += dt;
    if (_timeSinceSpawn >= _spawnInterval) {
      _timeSinceSpawn = 0;
      _spawnPellet();
    }
  }

  void _spawnPellet() {
    const margin = 30.0;
    final x = _rng.nextDouble() * (width - margin * 2) - (width / 2 - margin);
    add(
      Pellet()
        ..position = Vector2(x, -height / 2 - 40)
        ..despawnY = height / 2 + 60,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    bingy.moveBy(event.localDelta.x);
  }
}
