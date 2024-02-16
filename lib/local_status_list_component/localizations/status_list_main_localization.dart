import 'package:cozy/cozy.dart';
import 'package:cozy/cozy_localization.dart';

class LocalStatusListMainLocalization extends CozyLocalization {
  LocalStatusListMainLocalization(BuildContext context) : super(context);

  String page(int index, int length) => appLocalizations
      .srcWidgetsMoleculesStatusListStatusListMainPage(index, length);

  String get complete =>
      appLocalizations.srcWidgetsMoleculesStatusListStatusListMainComplete;

  String get incomplete =>
      appLocalizations.srcWidgetsMoleculesStatusListStatusListMainIncomplete;

  String get button =>
      appLocalizations.srcWidgetsMoleculesStatusListStatusListMainButton;

  String get subButton =>
      appLocalizations.srcWidgetsMoleculesStatusListStatusListMainSubButton;

  String label(int length) =>
      appLocalizations.srcWidgetsMoleculesStatusListStatusListMainLabel(length);

  String value(int length) =>
      appLocalizations.srcWidgetsMoleculesStatusListStatusListMainValue(length);
}
