// lib/ui/promotion.dart
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Promotion extends StatefulWidget {
  final List<String> images;
  final double height;
  final bool autoplay;
  final Duration autoplayDelay;
  final ValueChanged<int>? onTap;
  final Color activeDotColor;
  final Color inactiveDotColor;

  const Promotion({
    Key? key,
    required this.images,
    this.height = 180.0,
    this.autoplay = true,
    this.autoplayDelay = const Duration(seconds: 4),
    this.onTap,
    this.activeDotColor = Colors.white,
    this.inactiveDotColor = const Color(0x66FFFFFF),
  }) : super(key: key);

  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  late final PageController _controller;
  Timer? _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _current);
    if (widget.autoplay && widget.images.length > 1) _startAutoPlay();
  }

  @override
  void didUpdateWidget(covariant Promotion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoplay != oldWidget.autoplay ||
        widget.autoplayDelay != oldWidget.autoplayDelay ||
        widget.images.length != oldWidget.images.length) {
      _stopAutoPlay();
      if (widget.autoplay && widget.images.length > 1) _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(widget.autoplayDelay, (_) {
      if (!mounted) return;
      if (widget.images.isEmpty) return;
      final next = (_current + 1) % widget.images.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  void _onPageChanged(int idx) {
    setState(() => _current = idx);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: Center(
          child: Container(
            color: Colors.grey.shade200,
            width: double.infinity,
            height: widget.height,
            alignment: Alignment.center,
            child: const Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => widget.onTap?.call(_current),
            onPanDown: (_) => _stopAutoPlay(),
            onPanCancel: () {
              if (widget.autoplay && widget.images.length > 1) _startAutoPlay();
            },
            onPanEnd: (_) {
              if (widget.autoplay && widget.images.length > 1) _startAutoPlay();
            },
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final url = widget.images[index];
                return _buildImage(url);
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: _buildDots(),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return Container(
      color: Colors.grey.shade100,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: NetworkImage(url),
        fit: BoxFit.cover,
        width: double.infinity,
        height: widget.height,
        imageErrorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
          );
        },
      ),
    );
  }

  Widget _buildDots() {
    final dots = List<Widget>.generate(widget.images.length, (i) {
      final isActive = i == _current;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 10 : 8,
        height: isActive ? 10 : 8,
        decoration: BoxDecoration(
          color: isActive ? widget.activeDotColor : widget.inactiveDotColor,
          shape: BoxShape.circle,
        ),
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}

// tiny transparent image used as FadeInImage placeholder
// 1x1 transparent PNG
const List<int> _kTransparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
];
final kTransparentImage = Uint8List.fromList(_kTransparentImage);