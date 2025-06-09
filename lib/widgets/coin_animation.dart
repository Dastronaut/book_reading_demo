import 'package:flutter/material.dart';

class CoinAnimation extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;
  final int coinCount;
  final VoidCallback onComplete;
  final Function(int) onCoinDeducted;

  const CoinAnimation({
    super.key,
    required this.startPosition,
    required this.endPosition,
    required this.coinCount,
    required this.onComplete,
    required this.onCoinDeducted,
  });

  @override
  State<CoinAnimation> createState() => _CoinAnimationState();
}

class _CoinAnimationState extends State<CoinAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<CoinAnimationItem> _coins = [];
  int _coinsDeducted = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    // Create coin items with random paths
    for (int i = 0; i < widget.coinCount; i++) {
      _coins.add(CoinAnimationItem(
        startPosition: widget.startPosition,
        endPosition: widget.endPosition,
        delay: i * 0.3, // Stagger the animations
      ));
    }

    _controller.forward().then((_) {
      // Ensure all coins are deducted
      if (_coinsDeducted < widget.coinCount) {
        widget.onCoinDeducted(widget.coinCount - _coinsDeducted);
      }
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _coins.map((coin) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final progress = _animation.value;
            if (progress < coin.delay) return const SizedBox.shrink();

            final adjustedProgress = (progress - coin.delay) / (1 - coin.delay);
            final position = coin.getPosition(adjustedProgress);

            // Deduct coins sequentially
            final coinIndex = _coins.indexOf(coin);
            if (coinIndex > _coinsDeducted - 1 && adjustedProgress > 0.1) {
              _coinsDeducted++;
              widget.onCoinDeducted(1);
            }

            return Positioned(
              left: position.dx,
              top: position.dy,
              child: Transform.scale(
                scale: 1 - adjustedProgress * 0.3,
                child: Transform.rotate(
                  angle: adjustedProgress * 2 * 3.14159, // Full rotation
                  child: Icon(
                    Icons.monetization_on,
                    color: Colors.yellow.shade700,
                    size: 20,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class CoinAnimationItem {
  final Offset startPosition;
  final Offset endPosition;
  final double delay;
  final double controlPointX;
  final double controlPointY;

  CoinAnimationItem({
    required this.startPosition,
    required this.endPosition,
    required this.delay,
  }) : controlPointX = startPosition.dx + (endPosition.dx - startPosition.dx) * 0.5,
       controlPointY = startPosition.dy - 50; // Control point for the arc

  Offset getPosition(double progress) {
    // Cubic bezier curve for smoother arc movement
    final t = progress;
    final mt = 1 - t;
    
    // Control points for cubic bezier
    final cp1x = startPosition.dx + (controlPointX - startPosition.dx) * 0.5;
    final cp1y = startPosition.dy;
    final cp2x = controlPointX + (endPosition.dx - controlPointX) * 0.5;
    final cp2y = controlPointY;

    // Cubic bezier formula
    final x = mt * mt * mt * startPosition.dx +
        3 * mt * mt * t * cp1x +
        3 * mt * t * t * cp2x +
        t * t * t * endPosition.dx;
    
    final y = mt * mt * mt * startPosition.dy +
        3 * mt * mt * t * cp1y +
        3 * mt * t * t * cp2y +
        t * t * t * endPosition.dy;

    return Offset(x, y);
  }
} 