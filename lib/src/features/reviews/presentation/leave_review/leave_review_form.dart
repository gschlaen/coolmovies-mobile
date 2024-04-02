import 'package:coolmovies/src/features/reviews/presentation/leave_review/leave_review_controller.dart';
import 'package:coolmovies/src/features/reviews/presentation/movie_review/movie_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaveReviewForm extends ConsumerStatefulWidget {
  const LeaveReviewForm({required this.movietId, super.key});

  final String movietId;

  @override
  ConsumerState<LeaveReviewForm> createState() => _LeaveReviewFormState();
}

class _LeaveReviewFormState extends ConsumerState<LeaveReviewForm> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(leaveReviewControllerProvider);
    // TODO: listen to state.hasError to show an error message
    ref.listen<AsyncValue>(leaveReviewControllerProvider, (_, state) {
      if (state is AsyncData) {
        _titleController.clear();
        _bodyController.clear();
        _rating = 0;
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _titleController,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 1,
          decoration: const InputDecoration(
            labelText: 'Your title',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _bodyController,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: 'Your review',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: MovieRatingBar(
            initialRating: _rating,
            onRatingUpdate: (rating) => setState(() => _rating = rating),
          ),
        ),
        TextButton(
          onPressed: state.isLoading ||
                  _rating == 0 ||
                  _titleController.text.trim().isEmpty ||
                  _bodyController.text.trim().isEmpty
              ? null
              : () =>
                  ref.read(leaveReviewControllerProvider.notifier).submitReview(
                        title: _titleController.text,
                        body: _bodyController.text,
                        rating: _rating.toInt(),
                        movieId: widget.movietId,
                      ),
          child: const Text('Submit'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
