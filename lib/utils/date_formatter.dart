String formatUpdatedAt(
  DateTime updatedAt,
) {

  final now = DateTime.now();

  final difference =
      now.difference(updatedAt);

  if (difference.inMinutes < 1) {
    return 'Updated just now';
  }

  if (difference.inHours < 1) {
    return 'Updated '
        '${difference.inMinutes}m ago';
  }

  if (difference.inDays < 1) {
    return 'Updated '
        '${difference.inHours}h ago';
  }

  if (difference.inDays == 1) {
    return 'Updated yesterday';
  }

  return 'Updated '
      '${updatedAt.day}/'
      '${updatedAt.month}/'
      '${updatedAt.year}';
}