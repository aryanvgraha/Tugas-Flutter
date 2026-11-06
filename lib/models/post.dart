class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final String
  category; // Tambahan kategori info kampus (Akademik, Keuangan, Kemahasiswaan)

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.category = 'Akademik Kampus',
  });

  factory Post.fromJson(Map<String, dynamic> j) => Post(
    id: j['id'] as int,
    userId: j['userId'] as int,
    title: j['title'] as String,
    body: j['body'] as String,
    category: j['id'] % 2 == 0 ? 'Informasi UKT' : 'Jadwal Ujian',
  );
}
