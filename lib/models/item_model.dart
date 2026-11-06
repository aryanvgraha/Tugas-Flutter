class ItemModel {
  final String id;
  final String title;
  final String description;
  final String room; // Tambahan informasi ruang ujian
  final String date; // Tambahan tanggal ujian/kegiatan
  final DateTime createdAt;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    this.room = 'Aula Utama',
    this.date = '10 November 2026',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  ItemModel copyWith({
    String? title,
    String? description,
    String? room,
    String? date,
  }) => ItemModel(
    id: id,
    title: title ?? this.title,
    description: description ?? this.description,
    room: room ?? this.room,
    date: date ?? this.date,
    createdAt: createdAt,
  );
}
