import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/item_model.dart';
import '../widgets/page_header.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final List<ItemModel> _items = [
    ItemModel(
      id: 'seed-1',
      title: 'Ujian Akhir Semester (UAS) Pemrograman Mobile',
      description:
          'Membawa laptop terinstal Flutter & koneksi internet mandiri.',
      room: 'Lab Komputer 2',
      date: '15 Jan 2027 • 08:00 WIB',
    ),
    ItemModel(
      id: 'seed-2',
      title: 'Ujian Tengah Semester (UTS) Basis Data Lanjut',
      description: 'Materi mencakup Normalisasi, Stored Procedure, dan Query Optimization.',
      room: 'Ruang Teori A.3.1',
      date: '18 Nov 2026 • 10:00 WIB',
    ),
  ];
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ItemModel> get _filtered {
    if (_query.isEmpty) return _items;
    final q = _query.toLowerCase();
    return _items
        .where(
          (e) =>
              e.title.toLowerCase().contains(q) ||
              e.description.toLowerCase().contains(q) ||
              e.room.toLowerCase().contains(q),
        )
        .toList();
  }

  void _addItem(String title, String desc, String room, String date) {
    setState(() {
      _items.insert(
        0,
        ItemModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          description: desc,
          room: room,
          date: date,
        ),
      );
    });
  }

  void _updateItem(
    String id,
    String title,
    String desc,
    String room,
    String date,
  ) {
    final i = _items.indexWhere((e) => e.id == id);
    if (i == -1) return;
    setState(
      () => _items[i] = _items[i].copyWith(
        title: title,
        description: desc,
        room: room,
        date: date,
      ),
    );
  }

  void _deleteItem(ItemModel item) {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index == -1) return;
    setState(() => _items.removeAt(index));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Jadwal "${item.title}" dihapus'),
          action: SnackBarAction(
            label: 'Urungkan',
            onPressed: () => setState(() => _items.insert(index, item)),
          ),
        ),
      );
  }

  Future<void> _openForm({ItemModel? item}) async {
    final titleC = TextEditingController(text: item?.title ?? '');
    final descC = TextEditingController(text: item?.description ?? '');
    final roomC = TextEditingController(text: item?.room ?? '');
    final dateC = TextEditingController(text: item?.date ?? '');
    final formKey = GlobalKey<FormState>();

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          0,
          24,
          MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item == null ? 'Tambah Jadwal Ujian' : 'Edit Jadwal Ujian',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.deep,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: titleC,
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah / Ujian',
                  prefixIcon: Icon(Icons.menu_book_rounded),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: roomC,
                decoration: const InputDecoration(
                  labelText: 'Ruangan',
                  prefixIcon: Icon(Icons.room_rounded),
                ),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Ruangan wajib diisi'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: dateC,
                decoration: const InputDecoration(
                  labelText: 'Waktu & Tanggal',
                  prefixIcon: Icon(Icons.calendar_month_rounded),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Waktu wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descC,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Catatan / Ketentuan',
                  prefixIcon: Icon(Icons.notes_rounded),
                ),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Catatan wajib diisi'
                    : null,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(ctx, true);
                  }
                },
                child: Text(item == null ? 'Simpan Jadwal' : 'Perbarui Jadwal'),
              ),
            ],
          ),
        ),
      ),
    );

    if (saved == true) {
      final t = titleC.text.trim();
      final d = descC.text.trim();
      final r = roomC.text.trim();
      final dt = dateC.text.trim();
      if (item == null) {
        _addItem(t, d, r, dt);
      } else {
        _updateItem(item.id, t, d, r, dt);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final items = _filtered;

    return Scaffold(
      body: Column(
        children: [
          PageHeader(
            centered: false, // Header Rata Kiri
            title: 'Kelola Jadwal & Ujian',
            subtitle: '${_items.length} agenda ujian terdaftar',
            bottom: HeaderSearch(
              controller: _searchController,
              hint: 'Cari jadwal ujian atau ruangan...',
              onChanged: (v) => setState(() => _query = v.trim()),
              onClear: () {
                _searchController.clear();
                setState(() => _query = '');
              },
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Jadwal tidak ditemukan'))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final item = items[i];
                      return Container(
                        decoration: softCard(),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(14),
                          leading: const IconBadge(
                            icon: Icons.assignment_rounded,
                            size: 44,
                          ),
                          title: Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                '📍 ${item.room}  |  🕒 ${item.date}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deep,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.description,
                                style: TextStyle(
                                  color: scheme.onSurfaceVariant,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _deleteItem(item),
                          ),
                          onTap: () => _openForm(item: item),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Jadwal'),
      ),
    );
  }
}
