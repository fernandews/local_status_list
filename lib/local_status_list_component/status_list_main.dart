import 'package:cozy/cozy.dart';
import 'package:local_status_list/local_status_list_component/status_list_item.dart';

import 'localizations/status_list_main_localization.dart';
import 'status_list_tile.dart';

enum LocalStatusListType {
  connected,
  none,
}

class LocalStatusList extends StatelessWidget {
  /// Items to show
  final List<LocalStatusListItem> items;

  /// Defines if the list will be [LocalStatusListType.separated]
  /// or [LocalStatusListType.connected]
  final LocalStatusListType type;

  const LocalStatusList({
    Key? key,
    required this.items,
    required this.type,
  }) : super(key: key);

  String _getSemanticItemLabel(
    List<LocalStatusListItem> items,
    int index,
    BuildContext context,
  ) {
    final l10n = LocalStatusListMainLocalization(context);

    final page = l10n.page(index + 1, items.length);
    final status = items[index].active ? l10n.complete : l10n.incomplete;
    final button = items[index].onTap != null ? l10n.button : '';
    final title = items[index].title;
    final description = items[index].description;
    final subButton = items[index].onMenuTap != null ? l10n.subButton : '';
    return '$status $button $title $description $subButton $page';
  }

  @override
  Widget build(BuildContext context) {
    final theme = CozyTheme.of(context);
    final l10n = LocalStatusListMainLocalization(context);

    if (items.length == 1) {
      return Semantics(
        label: _getSemanticItemLabel(items, 0, context),
        child: LocalStatusListTile(
          item: items.first,
          type: LocalStatusListTileType.single,
        ),
      );
    }

    switch (type) {
      case LocalStatusListType.none:
        return MergeSemantics(
          child: Semantics(
            label: l10n.label(items.length),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++)
                  Semantics(
                    label: _getSemanticItemLabel(items, i, context),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: i == items.length + 1
                            ? 0
                            : theme.alias.spacing.xsmall,
                      ),
                      child: LocalStatusListTile(
                        item: items[i],
                        type: i == 0
                            ? LocalStatusListTileType.head
                            : i + 1 == items.length
                                ? LocalStatusListTileType.tail
                                : LocalStatusListTileType.middle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );

      case LocalStatusListType.connected:
        return MergeSemantics(
          child: Semantics(
            value: l10n.value(items.length),
            container: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < items.length; i++)
                  Semantics(
                    label: _getSemanticItemLabel(items, i, context),
                    child: LocalStatusListTile(
                      item: items[i],
                      type: i == 0
                          ? LocalStatusListTileType.head
                          : i + 1 == items.length
                              ? LocalStatusListTileType.tail
                              : LocalStatusListTileType.middle,
                    ),
                  ),
              ],
            ),
          ),
        );
    }
  }
}
