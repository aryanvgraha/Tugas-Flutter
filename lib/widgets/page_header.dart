import 'package:flutter/material.dart';

import '../core/app_theme.dart';

/// Dekorasi kartu putih dengan bayangan ungu lembut.
BoxDecoration softCard({double radius = 20}) => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(radius),
  border: Border.all(color: AppColors.border),
  boxShadow: [
    BoxShadow(
      color: AppColors.deep.withValues(alpha: 0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ],
);

/// Kotak ikon bergradasi ungu.
class IconBadge extends StatelessWidget {
  final IconData icon;
  final double size;
  const IconBadge({super.key, required this.icon, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.gradient,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(icon, color: Colors.white, size: size * 0.5),
    );
  }
}

/// Kolom pencarian putih yang diletakkan di dalam header.
class HeaderSearch extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const HeaderSearch({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.deep),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(icon: const Icon(Icons.close), onPressed: onClear),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}

/// Header gradasi ungu tua. Secara default semua isinya rata tengah.
class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> actions;
  final Widget? bottom;
  final bool centered;
  final double bottomPadding;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions = const [],
    this.bottom,
    this.centered = true,
    this.bottomPadding = 24,
  });

  Widget _circle(double size, double alpha) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withValues(alpha: alpha),
    ),
  );

  Widget _deco(IconData icon, double size) =>
      Icon(icon, size: size, color: Colors.white.withValues(alpha: 0.25));

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: centered ? TextAlign.center : TextAlign.start,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w800,
      ),
    );
    final subtitleWidget = subtitle == null
        ? null
        : Text(
            subtitle!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
            ),
          );

    final Widget top = centered
        ? Column(
            children: [
              if (leading != null) ...[leading!, const SizedBox(height: 14)],
              titleWidget,
              if (subtitleWidget != null) ...[
                const SizedBox(height: 4),
                subtitleWidget,
              ],
            ],
          )
        : Row(
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 14)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    titleWidget,
                    if (subtitleWidget != null) ...[
                      const SizedBox(height: 2),
                      subtitleWidget,
                    ],
                  ],
                ),
              ),
              ...actions,
            ],
          );

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.gradient),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(top: -60, right: -50, child: _circle(180, 0.10)),
            Positioned(top: 80, left: -70, child: _circle(140, 0.08)),
            Positioned(bottom: -50, right: 60, child: _circle(110, 0.10)),
            Positioned(
              top: 60,
              right: 90,
              child: _deco(Icons.menu_book_rounded, 24),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              child: _deco(Icons.star_rounded, 18),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, bottomPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    top,
                    if (bottom != null) ...[
                      const SizedBox(height: 16),
                      bottom!,
                    ],
                  ],
                ),
              ),
            ),
            // Tombol aksi (mis. muat ulang) tetap di pojok kanan atas.
            if (centered && actions.isNotEmpty)
              Positioned(
                top: 8,
                right: 4,
                child: SafeArea(
                  bottom: false,
                  child: Row(mainAxisSize: MainAxisSize.min, children: actions),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
