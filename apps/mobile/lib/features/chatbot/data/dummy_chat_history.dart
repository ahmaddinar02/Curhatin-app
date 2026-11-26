import '../models/chat_message_model.dart';

/// Data riwayat percakapan awal (dummy) sebelum integrasi backend.
class DummyChatHistory {
  static List<ChatSessionModel> createInitialSessions() {
    final now = DateTime.now();

    return [
      _session(
        id: 'h1',
        title: 'Masalah pertemanan',
        updatedAt: now.subtract(const Duration(hours: 2)),
        userText: 'Akhir-akhir ini aku sering merasa dijauhi teman kelasku.',
        botText:
            'Pasti rasanya tidak nyaman ya merasa seperti itu. Mau ceritakan sejak kapan kamu mulai merasakan perubahan sikap mereka?',
      ),
      _session(
        id: 'h2',
        title: 'Pacaran',
        updatedAt: now.subtract(const Duration(hours: 5)),
        userText: 'Aku bingung harus bagaimana saat pasanganku susah diajak komunikasi.',
        botText:
            'Komunikasi yang tersendat memang bisa bikin pikiran penuh. Coba ungkapkan perasaanmu dengan tenang tanpa menyalahkan, ya 💙',
      ),
      _session(
        id: 'h3',
        title: 'Masalah keluarga',
        updatedAt: now.subtract(const Duration(days: 1)),
        userText: 'Di rumah lagi sering ada perbedaan pendapat sama orang tua.',
        botText:
            'Menghadapi perbedaan pandangan dengan keluarga memang menguras emosi. Aku di sini kalau kamu butuh ruang untuk bercerita.',
      ),
      _session(
        id: 'h4',
        title: 'Takut gagal kuliah',
        updatedAt: now.subtract(const Duration(days: 2)),
        userText: 'Aku takut kalau usahaku selama ini sia-sia dan hasilnya tetap gagal...',
        botText:
            'Wajar kalau kamu merasa takut. Kamu tidak harus menghadapi semuanya sekaligus. Coba jalani satu per satu, ya.',
      ),
      _session(
        id: 'h5',
        title: 'Overthinking malam hari',
        updatedAt: now.subtract(const Duration(days: 3)),
        userText: 'Setiap malam sebelum tidur pikiranku susah berhenti.',
        botText:
            'Pikiran yang ramai di malam hari memang melelahkan. Coba tarik napas dalam dan lepaskan pelan sebelum memejamkan mata.',
      ),
      _session(
        id: 'h6',
        title: 'Beban tugas menumpuk',
        updatedAt: now.subtract(const Duration(days: 4)),
        userText: 'Deadline berdekatan dan aku merasa kewalahan.',
        botText:
            'Mari pecah satu tugas paling kecil yang bisa dikerjakan 10 menit dulu. Kamu tidak harus menyelesaikan semuanya sekaligus.',
      ),
      _session(
        id: 'h7',
        title: 'Merasa kesepian',
        updatedAt: now.subtract(const Duration(days: 5)),
        userText: 'Di tengah keramaian pun aku tetap merasa sendiri.',
        botText:
            'Perasaan itu valid, dan kamu tidak sendirian sekarang. Aku selalu siap mendengarkan ceritamu kapan pun kamu butuh.',
      ),
      _session(
        id: 'h8',
        title: 'Ragu ambil keputusan',
        updatedAt: now.subtract(const Duration(days: 6)),
        userText: 'Aku takut salah langkah memilih magang semester ini.',
        botText:
            'Wajar merasa ragu saat menghadapi pilihan penting. Apa hal yang paling kamu pertimbangkan dari masing-masing pilihan?',
      ),
      _session(
        id: 'h9',
        title: 'Susah fokus belajar',
        updatedAt: now.subtract(const Duration(days: 7)),
        userText: 'Hari ini aku sulit sekali berkonsentrasi saat membaca materi.',
        botText:
            'Tubuh dan pikiranmu mungkin sedang butuh jeda singkat. Minum segelas air dan istirahat 5 menit bisa membantu menyegarkan fokus.',
      ),
      _session(
        id: 'h10',
        title: 'Berbagi kabar baik',
        updatedAt: now.subtract(const Duration(days: 8)),
        userText: 'Hari ini aku berhasil presentasi dengan lancar!',
        botText:
            'Wah, selamat ya! 💙 Jangan lupa apresiasi dirimu atas keberanian dan persiapan yang sudah kamu lakukan.',
      ),
    ];
  }

  static ChatSessionModel _session({
    required String id,
    required String title,
    required DateTime updatedAt,
    required String userText,
    required String botText,
  }) {
    return ChatSessionModel(
      id: id,
      title: title,
      updatedAt: updatedAt,
      messages: [
        ChatMessageModel(
          id: '${id}_u',
          text: userText,
          sender: ChatSender.user,
          timestamp: updatedAt.subtract(const Duration(minutes: 1)),
        ),
        ChatMessageModel(
          id: '${id}_b',
          text: botText,
          sender: ChatSender.bot,
          timestamp: updatedAt,
        ),
      ],
    );
  }
}
