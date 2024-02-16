import 'package:cozy/cozy.dart';
import 'package:local_status_list/local_status_list_component/status_list_item.dart';
import './localizations/status_list_tile_localization.dart';

enum LocalStatusListTileType {
  head,
  tail,
  middle,
  single,
}

extension LocalStatusListTileTypeExtension on LocalStatusListTileType {
  bool get hasRadius {
    switch (this) {
      case LocalStatusListTileType.head:
      case LocalStatusListTileType.middle:
      case LocalStatusListTileType.tail:
        return true;
      case LocalStatusListTileType.single:
        return false;
    }
  }

  BorderRadius radius(CozyTheme theme) {
    switch (this) {
      case LocalStatusListTileType.single:
        return BorderRadius.zero;
      case LocalStatusListTileType.head:
        return BorderRadius.only(
          topLeft: Radius.circular(
            theme.component.statusList.shape.border.radius.defaultValue,
          ),
          topRight: Radius.circular(
            theme.component.statusList.shape.border.radius.defaultValue,
          ),
        );
      case LocalStatusListTileType.middle:
        return BorderRadius.zero;
      case LocalStatusListTileType.tail:
        return BorderRadius.only(
          bottomLeft: Radius.circular(
            theme.component.statusList.shape.border.radius.defaultValue,
          ),
          bottomRight: Radius.circular(
            theme.component.statusList.shape.border.radius.defaultValue,
          ),
        );
    }
  }

  Border border(CozyTheme theme) {
    final color = theme.alias.color.border.defaultValue;
    switch (this) {
      case LocalStatusListTileType.single:
        return Border.all(color: color);
      case LocalStatusListTileType.head:
        return Border(
          left: BorderSide(color: color),
          right: BorderSide(color: color),
          top: BorderSide(color: color),
          bottom: BorderSide(color: color),
        );
      case LocalStatusListTileType.middle:
      case LocalStatusListTileType.tail:
        return Border(
          left: BorderSide(color: color),
          bottom: BorderSide(color: color),
          right: BorderSide(color: color),
        );
    }
  }
}

class LocalStatusListTile extends StatefulWidget {
  final LocalStatusListItem item;
  final LocalStatusListTileType type;

  const LocalStatusListTile({
    Key? key,
    required this.item,
    required this.type,
  }) : super(key: key);

  @override
  State<LocalStatusListTile> createState() => _LocalStatusListTileState();
}

class _LocalStatusListTileState extends State<LocalStatusListTile> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = CozyTheme.of(context);
    final l10n = StatusListTileLocalization(context);
    final borderRadius = widget.type.radius(theme);
    return InkWell(
      excludeFromSemantics: true,
      onHighlightChanged: (param) {
        setState(() {
          isPressed = param;
        });
      },
      onTap: widget.item.onTap,
      highlightColor: theme.alias.color.surface.hovered,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: theme.alias.spacing.xsmall),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: isPressed
              ? theme.alias.color.surface.hovered
              : theme.alias.color.surface.defaultValue,
          boxShadow: widget.type.hasRadius
              ? [
                  BoxShadow(
                    color: theme.alias.color.border.defaultValue,
                    spreadRadius: 1,
                  )
                ]
              : [],
          border: widget.type.hasRadius ? null : widget.type.border(theme),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if (widget.type == LocalStatusListTileType.tail ||
                      widget.type == LocalStatusListTileType.middle)
                    Divider(
                      isVertical: true,
                      height: theme.alias.spacing.xsmall,
                      isDashed:
                          widget.item.status == LocalStatusListItemStatus.disabled,
                    ),
                  if (widget.type == LocalStatusListTileType.single ||
                      widget.type == LocalStatusListTileType.head)
                    SizedBox(height: theme.alias.spacing.xsmall),
                  Avatar(
                    active: widget.item.active,
                    variant: widget.item.status.avatarVariant,
                    size: AvatarSize.small,
                    cozyIconData: widget.item.iconData,
                  ),
                  if (widget.type == LocalStatusListTileType.head ||
                      widget.type == LocalStatusListTileType.middle)
                    Expanded(
                      child: Divider(
                        isVertical: true,
                        height: theme.alias.spacing.xsmall,
                        isDashed:
                            widget.item.status == LocalStatusListItemStatus.disabled,
                      ),
                    ),
                ],
              ),
              SizedBox(width: theme.alias.spacing.xxsmall),
              SizedBox(width: theme.alias.spacing.xxsmall),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: theme.alias.spacing.xsmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExcludeSemantics(
                        child: Text(
                          widget.item.title,
                          style: theme.cozyTypography.bodyStrong.copyWith(
                            color: widget.item.status ==
                                    LocalStatusListItemStatus.disabled
                                ? theme.alias.color.text.disabled
                                : theme.alias.color.text.defaultValue,
                          ),
                        ),
                      ),
                      SizedBox(height: theme.alias.spacing.hxxsmall),
                      ExcludeSemantics(
                        child: widget.item.content ?? Text(
                          widget.item.description,
                          style: theme.cozyTypography.bodyRegular.copyWith(
                            color: widget.item.status ==
                                LocalStatusListItemStatus.disabled
                                ? theme.alias.color.text.disabled
                                : theme.alias.color.text.lighter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: widget.item.tag == null,
                child: SizedBox(width: theme.alias.spacing.xxsmall),
              ),
              Offstage(
                offstage: widget.item.tag == null,
                child: Align(child: widget.item.tag),
              ),
              Offstage(
                offstage: widget.item.withMenu == false &&
                    widget.item.withChevron == false,
                child: SizedBox(width: theme.alias.spacing.xxsmall),
              ),
              Offstage(
                offstage: widget.item.withMenu == false &&
                    widget.item.withChevron == false,
                child: Align(
                  child: widget.item.withMenu
                      // TODO: Align with design if this still needed
                      // because the figma doesn't have this case
                      ? LegacyIconButton(
                          onPressed: widget.item.onMenuTap,
                          semanticsLabel: l10n.semanticsLabel,
                          iconData: CozyIcons.overflowMenu,
                        )
                      : CozyIcon(
                          CozyIcons.chevronForward,
                          color: theme.alias.color.icon.defaultValue,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
