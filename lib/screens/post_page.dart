import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/post.dart';
import '../services/api_services.dart';
import '../widgets/page_header.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _api = ApiService();
  final _searchController = TextEditingController();

  List<Post> _posts = [];
  bool _loading = true;
  String? _error;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await _api.fetchPosts();
      if (!mounted) return;
      setState(() => _posts = data);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<Post> get _filtered {
    if (_query.isEmpty) return _posts;
    final q = _query.toLowerCase();
    return _posts
        .where(
          (p) =>
              p.title.toLowerCase().contains(q) ||
              p.body.toLowerCase().contains(q),
        )
        .toList();
  }

  void _showDetail(Post post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        maxChildSize: 0.9,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                avatar: const Icon(
                  Icons.person,
                  size: 16,
                  color: AppColors.deep,
                ),
                label: Text('Penulis #${post.userId}'),
                backgroundColor: AppColors.tint,
                side: BorderSide.none,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              post.title,
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.deep,
              ),
            ),
            const SizedBox(height: 12),
            Text(post.body, style: Theme.of(ctx).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final subtitle = _loading
        ? 'Memuat data...'
        : _error != null
        ? 'Gagal memuat data'
        : '${_filtered.length} postingan';

    return Scaffold(
      body: Column(
        children: [
          PageHeader(
            centered: false,
            title: 'Postingan',
            subtitle: subtitle,
            actions: [
              IconButton(
                tooltip: 'Muat ulang',
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                onPressed: _loading ? null : _load,
              ),
            ],
            bottom: HeaderSearch(
              controller: _searchController,
              hint: 'Cari postingan...',
              onChanged: (v) => setState(() => _query = v.trim()),
              onClear: () {
                _searchController.clear();
                setState(() => _query = '');
              },
            ),
          ),
          Expanded(child: _buildBody(scheme)),
        ],
      ),
    );
  }

  Widget _buildBody(ColorScheme scheme) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off_rounded,
                size: 64,
                color: AppColors.soft,
              ),
              const SizedBox(height: 16),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(minimumSize: const Size(160, 48)),
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final items = _filtered;
    if (items.isEmpty) {
      return const Center(child: Text('Tidak ada postingan ditemukan'));
    }

    return RefreshIndicator(
      color: AppColors.deep,
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final p = items[i];
          return Container(
            decoration: softCard(),
            clipBehavior: Clip.antiAlias,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => _showDetail(p),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: AppColors.gradient,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${p.id}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              p.body.replaceAll('\n', ' '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: scheme.onSurfaceVariant),
                            ),
                          ],
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
    );
  }
}
