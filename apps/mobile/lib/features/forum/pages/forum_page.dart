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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.chat_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Curhat',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    letterSpacing: -0.3,
                  ),
                ),
                TextSpan(
                  text: 'in',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: AppColors.divider),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: _openCreateDiscussion,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: const Icon(Icons.add_rounded, size: 22),
      label: const Text(
        'Diskusi Baru',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
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
