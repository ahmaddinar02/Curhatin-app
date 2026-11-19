import '../models/discussion_model.dart';
import '../models/comment_model.dart';

class DummyForumData {
  static List<DiscussionModel> discussions = [
    DiscussionModel(
      id: 'd1',
      userId: 'u2',
      userName: 'Anya Putri',
      userAvatar: 'https://i.pravatar.cc/150?img=5',
      content:
          'Hai teman-teman, belakangan ini aku sering merasa cemas tanpa sebab yang jelas. Rasanya seperti ada beban berat di dada dan susah bernapas. Apakah ada yang pernah merasakan hal serupa? Bagaimana cara kalian mengatasinya? 🙏',
      category: 'Kecemasan',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      likeCount: 24,
      commentCount: 8,
      isLiked: false,
    ),
    DiscussionModel(
      id: 'd2',
      userId: 'u3',
      userName: 'Bima Santoso',
      userAvatar: 'https://i.pravatar.cc/150?img=12',
      content:
          'Akhir-akhir ini aku merasa sangat lelah meski sudah tidur cukup. Produktivitasku di tempat kerja juga menurun drastis. Ada yang bisa berbagi tips untuk mengatasi burnout? Sudah coba meditasi tapi belum berhasil 😔',
      category: 'Burnout',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likeCount: 41,
      commentCount: 15,
      isLiked: true,
    ),
    DiscussionModel(
      id: 'd3',
      userId: 'u4',
      userName: 'Citra Dewi',
      userAvatar: 'https://i.pravatar.cc/150?img=25',
      content:
          'Mau berbagi pengalaman positif nih! Setelah 3 bulan rutin journaling setiap malam, kondisi mentalku jauh lebih baik. Kalau ada yang tertarik mulai journaling, aku siap berbagi tipsnya. Semangat untuk kita semua! 💪✨',
      category: 'Self-Care',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      likeCount: 87,
      commentCount: 22,
      isLiked: false,
    ),
    DiscussionModel(
      id: 'd4',
      userId: 'u5',
      userName: 'Dani Firmansyah',
      userAvatar: 'https://i.pravatar.cc/150?img=33',
      content:
          'Overthinking itu melelahkan banget. Pikiran terus berputar-putar tentang hal-hal yang belum tentu terjadi. Ada yang punya cara jitu untuk berhenti overthinking? Sharing yuk! 🧠',
      category: 'Overthinking',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      likeCount: 56,
      commentCount: 19,
      isLiked: false,
    ),
    DiscussionModel(
      id: 'd5',
      userId: 'u6',
      userName: 'Ella Rahayu',
      userAvatar: 'https://i.pravatar.cc/150?img=47',
      content:
          'Hai semua! Aku baru saja selesai sesi konseling pertamaku dan rasanya lega banget bisa curhat ke profesional. Kalau ada yang ragu untuk mencoba, jangan takut ya! Itu langkah yang sangat berani dan tepat untuk merawat diri sendiri 💙',
      category: 'Konseling',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      likeCount: 134,
      commentCount: 31,
      isLiked: true,
    ),
    DiscussionModel(
      id: 'd6',
      userId: 'u7',
      userName: 'Fajar Nugroho',
      userAvatar: 'https://i.pravatar.cc/150?img=52',
      content:
          'Kesepian di tengah keramaian itu nyata adanya. Punya banyak teman tapi tetap merasa sendiri. Mungkin ada yang ingin berbagi pengalaman serupa? Aku senang mendengarkan dan saling bertukar cerita 🌙',
      category: 'Kesepian',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      likeCount: 73,
      commentCount: 27,
      isLiked: false,
    ),
  ];

  static List<CommentModel> getCommentsForDiscussion(String discussionId) {
    switch (discussionId) {
      case 'd1':
        return _commentsD1;
      case 'd2':
        return _commentsD2;
      case 'd3':
        return _commentsD3;
      default:
        return _commentsD4;
    }
  }

  static final List<CommentModel> _commentsD1 = [
    CommentModel(
      id: 'c1',
      discussionId: 'd1',
      userId: 'u8',
      userName: 'Hana Wijaya',
      userAvatar: 'https://i.pravatar.cc/150?img=9',
      content:
          'Pernah banget ngerasain ini! Yang paling membantu buatku adalah teknik pernapasan 4-7-8. Coba tarik napas 4 detik, tahan 7 detik, hembuskan 8 detik. Semoga membantu ya! 🌸',
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      likeCount: 12,
      isLiked: false,
      showReplies: false,
      replies: [
        ReplyModel(
          id: 'r1',
          commentId: 'c1',
          userId: 'u2',
          userName: 'Anya Putri',
          userAvatar: 'https://i.pravatar.cc/150?img=5',
          content: 'Makasih Hana! Aku akan coba teknik ini nanti malam 🙏',
          createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
          likeCount: 3,
          isLiked: false,
        ),
        ReplyModel(
          id: 'r2',
          commentId: 'c1',
          userId: 'u9',
          userName: 'Ivan Kusuma',
          userAvatar: 'https://i.pravatar.cc/150?img=15',
          content: 'Teknik ini juga sudah terbukti secara ilmiah lho! Sangat membantu untuk menenangkan sistem saraf.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
          likeCount: 7,
          isLiked: true,
        ),
      ],
    ),
    CommentModel(
      id: 'c2',
      discussionId: 'd1',
      userId: 'u10',
      userName: 'Joko Prasetyo',
      userAvatar: 'https://i.pravatar.cc/150?img=22',
      content:
          'Kecemasan tanpa sebab bisa jadi tanda anxiety disorder. Sebaiknya konsultasi ke psikolog ya, jangan dibiarkan terlalu lama. Kesehatan mental sama pentingnya dengan kesehatan fisik! 💙',
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      likeCount: 18,
      isLiked: true,
      showReplies: false,
      replies: [
        ReplyModel(
          id: 'r3',
          commentId: 'c2',
          userId: 'u11',
          userName: 'Kira Lestari',
          userAvatar: 'https://i.pravatar.cc/150?img=29',
          content: 'Setuju! Di Curhatin juga ada fitur konsultasi sama psikolog lho, bisa dicoba!',
          createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
          likeCount: 5,
          isLiked: false,
        ),
      ],
    ),
    CommentModel(
      id: 'c3',
      discussionId: 'd1',
      userId: 'u12',
      userName: 'Luna Arisanti',
      userAvatar: 'https://i.pravatar.cc/150?img=36',
      content:
          'Kalau aku, olahraga ringan setiap pagi sangat membantu mengurangi kecemasan. Jalan kaki 30 menit sambil dengerin podcast positif. Coba deh! 🏃‍♀️',
      createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
      likeCount: 9,
      isLiked: false,
      showReplies: false,
      replies: [],
    ),
  ];

  static final List<CommentModel> _commentsD2 = [
    CommentModel(
      id: 'c4',
      discussionId: 'd2',
      userId: 'u13',
      userName: 'Marco Halim',
      userAvatar: 'https://i.pravatar.cc/150?img=42',
      content:
          'Burnout itu tanda tubuh dan pikiranmu butuh istirahat. Coba ambil cuti beberapa hari dan lakukan hal yang kamu suka. Jangan paksa dirimu terus bekerja kalau kondisinya sudah seperti ini 🤗',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      likeCount: 23,
      isLiked: false,
      showReplies: false,
      replies: [
        ReplyModel(
          id: 'r4',
          commentId: 'c4',
          userId: 'u3',
          userName: 'Bima Santoso',
          userAvatar: 'https://i.pravatar.cc/150?img=12',
          content: 'Makasih Marco, sayang aku belum bisa ambil cuti sekarang karena ada deadline penting 😔',
          createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
          likeCount: 2,
          isLiked: false,
        ),
        ReplyModel(
          id: 'r5',
          commentId: 'c4',
          userId: 'u14',
          userName: 'Nadia Permata',
          userAvatar: 'https://i.pravatar.cc/150?img=49',
          content: 'Mini break di antara jam kerja juga bisa membantu Bima! Coba Pomodoro technique.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          likeCount: 8,
          isLiked: true,
        ),
      ],
    ),
  ];

  static final List<CommentModel> _commentsD3 = [
    CommentModel(
      id: 'c5',
      discussionId: 'd3',
      userId: 'u15',
      userName: 'Oki Ramadhan',
      userAvatar: 'https://i.pravatar.cc/150?img=56',
      content:
          'Wah inspiratif banget! Aku udah mau mulai journaling tapi bingung mulai dari mana. Sharing tipsnya dong Citra! 📔',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      likeCount: 15,
      isLiked: true,
      showReplies: false,
      replies: [
        ReplyModel(
          id: 'r6',
          commentId: 'c5',
          userId: 'u4',
          userName: 'Citra Dewi',
          userAvatar: 'https://i.pravatar.cc/150?img=25',
          content:
              'Mulai dari 3 hal yang kamu syukuri hari ini Oki! Simpel tapi efektif banget untuk shift mindset ke positif 🌟',
          createdAt: DateTime.now().subtract(const Duration(hours: 3, minutes: 30)),
          likeCount: 11,
          isLiked: false,
        ),
      ],
    ),
  ];

  static final List<CommentModel> _commentsD4 = [
    CommentModel(
      id: 'c6',
      discussionId: 'd4',
      userId: 'u16',
      userName: 'Putri Sari',
      userAvatar: 'https://i.pravatar.cc/150?img=61',
      content:
          'Overthinking itu memang melelahkan. Yang membantuku adalah menulis semua pikiran di kertas, terus tanya ke diri sendiri: "apakah ini nyata? apakah aku bisa kontrol?" Kalau jawabannya tidak, aku usahakan untuk lepaskan 🍃',
      createdAt: DateTime.now().subtract(const Duration(hours: 7)),
      likeCount: 31,
      isLiked: false,
      showReplies: false,
      replies: [],
    ),
  ];
}
