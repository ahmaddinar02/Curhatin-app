import '../models/relaxation_item_model.dart';
import '../models/relaxation_content_model.dart';

class DummyRelaxationData {
  // ── Menu utama Pojok Relaksasi ──────────────────────────────────────────────
  static const List<RelaxationItem> menuItems = [
    RelaxationItem(
      id: 'meditation',
      type: RelaxationType.meditation,
      title: 'Meditasi',
      description: '5–10 menit untuk melepaskan beban & cemas',
      duration: '5–10 menit',
      illustrationEmoji: '🧘',
    ),
    RelaxationItem(
      id: 'music',
      type: RelaxationType.music,
      title: 'Musik Relaksasi',
      description: 'Menenangkan pikiran musik untuk menenangkan pikiran',
      duration: 'Bebas',
      illustrationEmoji: '🎵',
    ),
    RelaxationItem(
      id: 'breathing',
      type: RelaxationType.breathing,
      title: 'Pernapasan',
      description: 'Mengatur fokus melalui pernapasan',
      duration: '3–5 menit',
      illustrationEmoji: '🌬️',
    ),
    RelaxationItem(
      id: 'story',
      type: RelaxationType.story,
      title: 'Ruang Cerita',
      description: 'Menemukan makna melalui cerita',
      duration: '10–15 menit',
      illustrationEmoji: '📖',
    ),
    RelaxationItem(
      id: 'reading',
      type: RelaxationType.reading,
      title: 'Ruang Baca',
      description: 'Temukan inspirasi dalam tulisan',
      duration: '5–15 menit',
      illustrationEmoji: '📚',
    ),
  ];

  // ── Meditasi ────────────────────────────────────────────────────────────────
  static const List<MeditationSession> meditationSessions = [
    MeditationSession(
      id: 'm1',
      title: 'Meditasi Pagi — Mulai Hari dengan Tenang',
      description:
          'Sesi singkat untuk menenangkan pikiran sebelum memulai aktivitas.',
      durationMinutes: 5,
      steps: [
        'Duduk dengan nyaman, tutup mata perlahan.',
        'Tarik napas dalam selama 4 hitungan.',
        'Tahan napas selama 4 hitungan.',
        'Hembuskan perlahan selama 6 hitungan.',
        'Fokuskan perhatian pada momen sekarang.',
        'Ulangi selama 5 menit.',
      ],
    ),
    MeditationSession(
      id: 'm2',
      title: 'Meditasi Tubuh — Body Scan',
      description:
          'Lepaskan ketegangan di setiap bagian tubuh secara perlahan.',
      durationMinutes: 10,
      steps: [
        'Berbaring atau duduk dengan nyaman.',
        'Tutup mata dan tarik napas dalam.',
        'Fokuskan perhatian ke ujung jari kaki.',
        'Perlahan naikkan perhatian ke betis, lutut, paha.',
        'Lanjutkan ke perut, dada, bahu, leher, dan kepala.',
        'Rasakan setiap bagian tubuh menjadi lebih rileks.',
      ],
    ),
    MeditationSession(
      id: 'm3',
      title: 'Meditasi Malam — Lepas Beban Hari Ini',
      description: 'Siapkan pikiran untuk tidur yang berkualitas.',
      durationMinutes: 8,
      steps: [
        'Berbaring di tempat tidur dengan nyaman.',
        'Lepaskan semua pikiran tentang hari ini.',
        'Bayangkan cahaya hangat yang menyelimuti tubuhmu.',
        'Tarik napas perlahan dan rasakan beban menghilang.',
        'Izinkan dirimu untuk istirahat sepenuhnya.',
      ],
    ),
  ];

  // ── Pernapasan ──────────────────────────────────────────────────────────────
  static const List<BreathingExercise> breathingExercises = [
    BreathingExercise(
      id: 'b1',
      title: 'Teknik 4-7-8',
      description:
          'Menenangkan sistem saraf dan mengurangi kecemasan dengan cepat.',
      inhaleSeconds: 4,
      holdSeconds: 7,
      exhaleSeconds: 8,
      rounds: 4,
    ),
    BreathingExercise(
      id: 'b2',
      title: 'Napas Kotak (Box Breathing)',
      description: 'Meningkatkan fokus dan ketenangan dalam hitungan menit.',
      inhaleSeconds: 4,
      holdSeconds: 4,
      exhaleSeconds: 4,
      rounds: 6,
    ),
    BreathingExercise(
      id: 'b3',
      title: 'Napas Perut (Diaphragmatic)',
      description: 'Mengaktifkan respons relaksasi tubuh secara alami.',
      inhaleSeconds: 5,
      holdSeconds: 2,
      exhaleSeconds: 5,
      rounds: 8,
    ),
  ];

  // ── Cerita & Bacaan ─────────────────────────────────────────────────────────
  static const List<RelaxationStory> stories = [
    RelaxationStory(
      id: 's1',
      title: 'Pohon yang Belajar Diam',
      author: 'Tim Curhatin',
      excerpt:
          'Di sebuah hutan yang ramai, hiduplah pohon jati yang selalu ingin tumbuh lebih tinggi dari yang lain...',
      content:
          'Di sebuah hutan yang ramai, hiduplah pohon jati yang selalu ingin tumbuh lebih tinggi dari yang lain. '
          'Ia memaksakan dirinya ke atas, mengabaikan hujan yang membasahi akarnya dan angin yang menyejukkan daunnya.\n\n'
          'Suatu hari, badai besar datang. Pohon-pohon yang kaku patah satu per satu. '
          'Namun pohon jati yang belajar lentur dari bambu tetangganya — bertahan.\n\n'
          'Kekuatan sejati bukan pada ketegaran, melainkan pada kemampuan membungkuk tanpa patah. '
          'Begitu pula hatimu — ia boleh melentur dalam kesedihan, asal tidak kehilangan akarnya.',
      readingMinutes: 3,
    ),
    RelaxationStory(
      id: 's2',
      title: 'Surat untuk Diri Sendiri',
      author: 'Tim Curhatin',
      excerpt:
          'Hei kamu, ya kamu yang sedang membaca ini. Sudahkah kamu tahu betapa kuatnya dirimu?',
      content:
          'Hei kamu, ya kamu yang sedang membaca ini.\n\n'
          'Sudahkah kamu tahu betapa kuatnya dirimu? Setiap hari kamu bangkit, '
          'meski terkadang beban terasa tak tertanggungkan. Itu bukan hal kecil — itu luar biasa.\n\n'
          'Kamu boleh lelah. Kamu boleh menangis. Tapi jangan lupa bahwa setiap badai pasti berlalu, '
          'dan setelah hujan selalu ada pelangi yang menantimu.\n\n'
          'Kamu tidak sendirian. Dan kamu jauh lebih berharga dari yang kamu bayangkan. 💙',
      readingMinutes: 2,
    ),
    RelaxationStory(
      id: 's3',
      title: 'Gelombang dan Tepi Pantai',
      author: 'Tim Curhatin',
      excerpt:
          'Gelombang tidak pernah takut menghantam tepi pantai, karena ia tahu...',
      content:
          'Gelombang tidak pernah takut menghantam tepi pantai, karena ia tahu '
          'ia akan selalu kembali ke laut yang menopangnya.\n\n'
          'Perasaanmu seperti gelombang — ia datang, ia terasa kuat, lalu ia pergi. '
          'Kecemasan, kesedihan, kemarahan — semuanya hanya tamu sementara.\n\n'
          'Kamu adalah tepi pantai itu. Kuat, tenang, dan selalu ada meski gelombang datang silih berganti. '
          'Biarkan perasaan itu datang dan pergi tanpa kamu hanyut bersamanya.',
      readingMinutes: 3,
    ),
  ];

  static const List<RelaxationStory> readings = [
    RelaxationStory(
      id: 'r1',
      title: '5 Cara Sederhana Menjaga Kesehatan Mental',
      author: 'Dr. Rina Kusuma, Psikolog',
      excerpt:
          'Kesehatan mental bukan kemewahan — ia adalah kebutuhan dasar setiap manusia.',
      content:
          'Kesehatan mental bukan kemewahan — ia adalah kebutuhan dasar setiap manusia.\n\n'
          '**1. Tidur yang Cukup**\nTidur 7–9 jam per malam membantu otak memproses emosi dan memperbarui energi.\n\n'
          '**2. Gerak Tubuh Setiap Hari**\nCukup 30 menit jalan kaki dapat meningkatkan mood secara signifikan.\n\n'
          '**3. Batasi Media Sosial**\nTerlalu banyak scroll dapat memperburuk kecemasan dan perasaan tidak cukup baik.\n\n'
          '**4. Berbicara dengan Seseorang**\nJangan pendam sendiri. Cerita kepada teman atau profesional.\n\n'
          '**5. Lakukan Hal yang Kamu Sukai**\nSisihkan waktu untuk hobi dan aktivitas yang membawa kebahagiaan.',
      readingMinutes: 5,
    ),
    RelaxationStory(
      id: 'r2',
      title: 'Mindfulness: Hadir di Momen Ini',
      author: 'Tim Curhatin',
      excerpt:
          'Pikiran kita sering melanglang ke masa lalu atau masa depan. Mindfulness membawa kita kembali.',
      content:
          'Pikiran kita sering melanglang ke masa lalu atau masa depan. Mindfulness membawa kita kembali ke momen ini.\n\n'
          'Cobalah latihan sederhana ini:\n\n'
          '• Lihat 5 hal di sekitarmu\n'
          '• Sentuh 4 benda berbeda\n'
          '• Dengarkan 3 suara\n'
          '• Cium 2 aroma\n'
          '• Rasakan 1 rasa\n\n'
          'Teknik 5-4-3-2-1 ini membantu mengembalikan pikiranmu ke saat ini dan mengurangi kecemasan dengan cepat.',
      readingMinutes: 4,
    ),
  ];
}
