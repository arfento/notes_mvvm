import 'package:notes_mvvm/config/router/navigation_service.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/utils/dialog_message_state.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/dialog_widget.dart';

class AppDialogs {
  static Future showDefaultErrorDialog() async {
    await DialogWidget.showCustomDialog(
      context: NavigationService.context,
      dialogWidgetState: DialogWidgetState.error,
      title: tr('oops'),
      description: '${tr('somethingWentWrong')}\n${tr('pleaseTryAgainLater')}',
      textButton: tr('OK'),
      onPressed: () {
        NavigationService.goBack();
      },
    );
  }
}
