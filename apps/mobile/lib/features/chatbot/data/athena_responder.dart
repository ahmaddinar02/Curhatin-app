/// Generator respons empatik lokal untuk Athena sebelum integrasi API backend.
class AthenaResponder {
  static const List<String> quickPrompts = [
    'Aku merasa cemas akhir-akhir ini',
    'Tugas menumpuk dan aku merasa lelah',
    'Aku butuh teman cerita hari ini',
    'Susah tidur karena overthinking',
  ];

  static String replyTo(String input) {
    final text = input.toLowerCase().trim();

    if (_containsAny(text, ['hai', 'halo', 'hello', 'hi', 'pagi', 'siang', 'sore', 'malam'])) {
      return 'Hai! Senang kamu mau mampir ke sini. Aku Athena 💙\n\n'
          'Ceritakan saja apa yang sedang ada di pikiranmu hari ini — tidak perlu terburu-buru, aku siap mendengarkan.';
    }

    if (_containsAny(text, ['cemas', 'gelisah', 'takut', 'panik', 'khawatir', 'deg-degan'])) {
      return 'Aku mengerti rasanya saat cemas datang — dada terasa sesak dan pikiran susah tenang.\n\n'
          'Coba tarik napas perlahan selama 4 detik, tahan 4 detik, lalu hembuskan pelan 6 detik. '
          'Kalau kamu mau, ceritakan hal apa yang paling bikin kamu khawatir saat ini?';
    }

    if (_containsAny(text, ['capek', 'lelah', 'burnout', 'tugas', 'kerja', 'kuliah', 'menumpuk', 'stres'])) {
      return 'Wajar sekali kamu merasa lelah ketika beban terasa menumpuk. '
          'Kamu sudah berusaha keras sejauh ini, dan mengambil jeda sebentar bukan berarti menyerah.\n\n'
          'Dari semua hal yang sedang kamu hadapi, mana satu hal kecil yang paling ingin kamu ringankan dulu hari ini?';
    }

    if (_containsAny(text, ['sedih', 'nangis', 'menangis', 'kecewa', 'sakit', 'patah'])) {
      return 'Terima kasih sudah mau jujur dengan perasaanmu di sini. '
          'Boleh banget kok merasa sedih atau menangis — perasaanmu valid.\n\n'
          'Aku di sini menemani. Mau cerita lebih lanjut tentang apa yang membuatmu merasa seperti ini?';
    }

    if (_containsAny(text, ['tidur', 'insomnia', 'begadang', 'overthinking', 'pikiran'])) {
      return 'Pikiran yang terus berputar di malam hari memang melelahkan ya. '
          'Terkadang menuliskan satu atau dua kalimat kekhawatiran sebelum tidur bisa membantu kepala terasa lebih ringan.\n\n'
          'Pikiran apa yang paling sering muncul belakangan ini?';
    }

    if (_containsAny(text, ['kesepian', 'sendiri', 'sepi', 'tidak ada teman'])) {
      return 'Merasa sendirian itu berat, apalagi saat sedang butuh tempat bersandar. '
          'Ingat ya, kamu tidak sendirian sekarang — aku selalu ada di sini untuk mendengarkan ceritamu 💙';
    }

    if (_containsAny(text, ['marah', 'kesal', 'emosi', 'sebel', 'jengkel'])) {
      return 'Rasa kesal atau marah adalah sinyal bahwa ada batasan atau harapanmu yang terluka. '
          'Kamu boleh meluapkan ceritamu di sini dengan aman tanpa dihakimi.';
    }

    if (_containsAny(text, ['senang', 'bahagia', 'lega', 'syukur', 'baik', 'makasih', 'terima kasih'])) {
      return 'Ikut senang mendengarnya! 💙 Merayakan hal-hal baik sekecil apa pun sangat berarti untuk kesehatan mentalmu. '
          'Ada hal lain yang ingin kamu bagikan hari ini?';
    }

    return 'Terima kasih sudah berbagi cerita itu denganku 💙\n\n'
        'Aku mendengarkan. Bagaimana perasaanmu sekarang setelah mengungkapkannya, '
        'dan bagian mana yang paling ingin kamu bahas lebih dalam?';
  }

  static bool _containsAny(String text, List<String> keywords) {
    for (final keyword in keywords) {
      if (text.contains(keyword)) return true;
    }
    return false;
  }
}
