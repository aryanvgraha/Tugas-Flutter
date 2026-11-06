import 'package:flutter/material.dart';

/// Logo aplikasi. Ganti isi `child` dengan Image.asset(...) jika punya file logo sendiri.
class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.08),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3F2B96), Color(0xFF9B7BFF)],
          ),
        ),
        child: Icon(
          Icons.school_rounded,
          size: size * 0.5,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Header gradasi ungu dengan lingkaran dan ikon dekoratif, logo, judul, dan subjudul.
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBack;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBack = false,
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
      Icon(icon, size: size, color: Colors.white.withValues(alpha: 0.28));

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3F2B96), Color(0xFF6A4CE0), Color(0xFF9B7BFF)],
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Lingkaran dekoratif
            Positioned(top: -60, right: -50, child: _circle(190, 0.10)),
            Positioned(top: 110, left: -70, child: _circle(150, 0.08)),
            Positioned(bottom: -60, right: 50, child: _circle(130, 0.10)),
            Positioned(bottom: 30, left: 30, child: _circle(36, 0.12)),
            // Ikon dekoratif
            Positioned(
              top: 70,
              right: 30,
              child: _deco(Icons.menu_book_rounded, 30),
            ),
            Positioned(
              top: 150,
              left: 26,
              child: _deco(Icons.edit_rounded, 24),
            ),
            Positioned(
              bottom: 70,
              right: 24,
              child: _deco(Icons.star_rounded, 22),
            ),
            Positioned(
              top: 40,
              left: 90,
              child: _deco(Icons.auto_stories_rounded, 22),
            ),

            // Konten utama (rata tengah)
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 68),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppLogo(),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'UNIVERSITAS GALUH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          letterSpacing: 1.6,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (showBack)
              Positioned(
                top: 0,
                left: 4,
                child: SafeArea(
                  bottom: false,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Kerangka halaman login/register: header, kartu form yang menimpa header, dan footer.
class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBack;
  final Widget card;
  final Widget footer;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.card,
    required this.footer,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(title: title, subtitle: subtitle, showBack: showBack),
            // Kartu ditarik ke atas supaya menimpa bagian bawah header.
            Transform.translate(
              offset: const Offset(0, -40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: scheme.surface,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: scheme.outlineVariant.withValues(
                                alpha: 0.4,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.10),
                                blurRadius: 30,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: card,
                        ),
                        const SizedBox(height: 12),
                        footer,
                        const SizedBox(height: 8),
                        Text(
                          '© Universitas Galuh',
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  final String text;
  const OrDivider({super.key, this.text = 'atau lanjutkan dengan'});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outline;
    return Row(
      children: [
        Expanded(child: Divider(color: color.withValues(alpha: 0.4))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
        Expanded(child: Divider(color: color.withValues(alpha: 0.4))),
      ],
    );
  }
}

class SocialButtons extends StatelessWidget {
  final ValueChanged<String> onTap;
  const SocialButtons({super.key, required this.onTap});

  Widget _btn(String label, IconData icon) => Expanded(
    child: OutlinedButton.icon(
      style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48)),
      onPressed: () => onTap(label),
      icon: Icon(icon, size: 22),
      label: Text(label),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _btn('Google', Icons.g_mobiledata_rounded),
        const SizedBox(width: 12),
        _btn('Apple', Icons.apple),
      ],
    );
  }
}
