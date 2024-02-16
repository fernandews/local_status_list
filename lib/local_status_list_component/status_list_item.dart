import 'package:cozy/cozy.dart';

enum LocalStatusListItemStatus { pending, success, attention, error, disabled }

extension StatusListItemStatusExtension on LocalStatusListItemStatus {
  AvatarVariant get avatarVariant {
    switch (this) {
      case LocalStatusListItemStatus.pending:
        return AvatarVariant.base;
      case LocalStatusListItemStatus.success:
        return AvatarVariant.success;
      case LocalStatusListItemStatus.attention:
        return AvatarVariant.warning;
      case LocalStatusListItemStatus.error:
        return AvatarVariant.error;
      case LocalStatusListItemStatus.disabled:
        return AvatarVariant.disabled;
    }
  }
}

class LocalStatusListItem {
  /// Sets the title text of the [LocalStatusListItem].
  final String title;

  /// Sets the description of the [LocalStatusListItem].
  final String description;
  final Widget? content;

  /// Sets the icon of the avatar.
  final CozyIconData iconData;

  /// Sets the status of the avatar.
  final bool active;

  /// Sets use of chevron at right of the [LocalStatusListItem].
  final bool withChevron;

  /// Sets use of menu at right of the [LocalStatusListItem]
  /// and ignore [withChevron].
  final bool withMenu;

  /// Sets the status of the [LocalStatusListItem].
  final LocalStatusListItemStatus status;

  /// Sets the callback for tap event on [withMenu].
  final VoidCallback? onMenuTap;

  /// Sets the callback for the [LocalStatusListItem].
  final VoidCallback? onTap;

  /// Sets the tag of the [LocalStatusListItem].
  final Tag? tag;

  LocalStatusListItem({
    required this.title,
    required this.description,
    required this.iconData,
    required this.status,
    this.active = false,
    this.withChevron = false,
    this.withMenu = false,
    this.onMenuTap,
    this.onTap,
    this.tag,
    this.content,
  }) : assert(
          onMenuTap != null ? withMenu != false : onMenuTap == null,
          "actionIcon shouldn't be null when onActionIconTap is given",
        );
}
