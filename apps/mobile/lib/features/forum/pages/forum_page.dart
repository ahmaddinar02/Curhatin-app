import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/forum_theme.dart';
import '../models/discussion_model.dart';
import '../models/comment_model.dart';
import '../data/dummy_forum_data.dart';
import '../widgets/discussion_card.dart';
import '../widgets/comment_bottom_sheet.dart';
import 'create_discussion_page.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  late List<DiscussionModel> _discussions;
  late Map<String, List<CommentModel>> _commentsCache;

  @override
  void initState() {
    super.initState();
    _discussions = List<DiscussionModel>.from(DummyForumData.discussions);
    _commentsCache = {};
  }

  List<CommentModel> _getComments(String discussionId) {
    if (!_commentsCache.containsKey(discussionId)) {
      _commentsCache[discussionId] =
          DummyForumData.getCommentsForDiscussion(discussionId);
    }
    return _commentsCache[discussionId]!;
  }

  void _toggleLike(String discussionId) {
    setState(() {
      final idx = _discussions.indexWhere((d) => d.id == discussionId);
      if (idx != -1) {
        final d = _discussions[idx];
        d.isLiked = !d.isLiked;
        d.likeCount += d.isLiked ? 1 : -1;
      }
    });
  }

  Future<void> _openComments(DiscussionModel discussion) async {
    final comments = _getComments(discussion.id);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentBottomSheet(
        discussionId: discussion.id,
        initialComments: comments,
        onCommentCountChanged: (newCount) {
          setState(() {
            final idx = _discussions.indexWhere((d) => d.id == discussion.id);
            if (idx != -1) {
              _discussions[idx].commentCount = newCount;
            }
          });
        },
      ),
    );
  }

  Future<void> _openCreateDiscussion() async {
    final result = await Navigator.of(context).push<DiscussionModel>(
      MaterialPageRoute(
        builder: (context) => const CreateDiscussionPage(),
      ),
    );

    if (result != null) {
      setState(() {
        _discussions.insert(0, result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _discussions.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 100),
              itemCount: _discussions.length,
              itemBuilder: (context, index) {
                final discussion = _discussions[index];
                return DiscussionCard(
                  discussion: discussion,
                  onLike: () => _toggleLike(discussion.id),
                  onComment: () => _openComments(discussion),
                );
              },
            ),
      floatingActionButton: _buildFAB(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surfaceWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      // Back button: lingkaran putih dengan arrow biru
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
              size: 18,
            ),
          ),
        ),
      ),
      // Logo gambar di tengah
      title: _buildLogoTitle(),
      centerTitle: true,
      // Tidak ada actions (search dihapus)
      actions: const [SizedBox(width: 52)], // balancing spacer agar logo benar-benar di tengah
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: AppColors.divider),
      ),
    );
  }

  /// Logo di AppBar: gunakan Image.asset jika file tersedia,
  /// fallback ke widget teks bergaya logo.
  Widget _buildLogoTitle() {
    // Ganti baris ini dengan Image.asset('assets/images/logo_curhatin.png', height: 32)
    // setelah file logo diletakkan di assets/images/
    return Image.asset(
      'assets/image/curhtinlogo2.png',
        height: 32,
        fit: BoxFit.contain,
      );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _openCreateDiscussion,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: const CircleBorder(),
      child: const Icon(Icons.add_rounded, size: 28),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.forum_outlined,
            size: 72,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada diskusi',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Jadilah yang pertama memulai diskusi!',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _openCreateDiscussion,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Mulai Diskusi'),
          ),
        ],
      ),
    );
  }
}
