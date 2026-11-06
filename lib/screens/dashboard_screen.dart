import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../services/auth_state.dart';
import '../widgets/page_header.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigate;

  const DashboardScreen({super.key, this.onNavigate});

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 11) return 'Selamat pagi';
    if (h < 15) return 'Selamat siang';
    if (h < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    const menus = [
      _MenuItem(
        'Pengumuman Kampus',
        'Info akademik & ujian',
        Icons.campaign_rounded,
        1,
      ),
      _MenuItem(
        'Jadwal & UKT',
        'Kelola jadwal & tagihan',
        Icons.edit_note_rounded,
        2,
      ),
      _MenuItem(
        'Profil Mahasiswa',
        'NIM, status & akun',
        Icons.person_rounded,
        3,
      ),
      _MenuItem(
        'Layanan Akademik',
        'KRS & Transkrip nilai',
        Icons.school_rounded,
        null,
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListenableBuilder(
              listenable: AuthState.instance,
              builder: (context, _) {
                final name = AuthState.instance.name;
                return PageHeader(
                  centered: false, // Header Rata Kiri sesuai permintaan
                  title: 'Halo, $name!',
                  subtitle:
                      '${_greeting()}! Selamat datang di Portal Akademik Unigal',
                  bottomPadding: 64,
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        color: AppColors.deep,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                );
              },
            ),
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Kartu Informasi Cepat / Status UKT
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: AppColors.gradient,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.deep.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Status Pembayaran UKT',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'LUNAS',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Rp 4.500.000',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Semester Ganjil 2026/2027 • Gelombang 2',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Menu Utama Kampus',
                      style: text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: menus.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 240,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 156,
                          ),
                      itemBuilder: (context, i) {
                        final m = menus[i];
                        return Container(
                          decoration: softCard(),
                          clipBehavior: Clip.antiAlias,
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () {
                                if (m.tabIndex != null) {
                                  onNavigate?.call(m.tabIndex!);
                                } else {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${m.label} segera hadir',
                                        ),
                                      ),
                                    );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconBadge(icon: m.icon),
                                    const SizedBox(height: 12),
                                    Text(
                                      m.label,
                                      style: text.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      m.caption,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: text.bodySmall?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final String label;
  final String caption;
  final IconData icon;
  final int? tabIndex;
  const _MenuItem(this.label, this.caption, this.icon, this.tabIndex);
}
