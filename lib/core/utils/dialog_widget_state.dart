import 'package:notes_mvvm/core/styles/app_images.dart';
import 'package:notes_mvvm/core/utils/dialog_message_state.dart';

final Map<DialogWidgetState, dynamic> dialogMessageData = {
  DialogWidgetState.error: {"icon": AppImages.error},
  DialogWidgetState.noHeader: {"icon": AppImages.noHeader},
  DialogWidgetState.info: {"icon": AppImages.info},
  DialogWidgetState.infoReversed: {"icon": AppImages.infoReverse},
  DialogWidgetState.question: {"icon": AppImages.ask},
  DialogWidgetState.success: {"icon": AppImages.success},
  DialogWidgetState.warning: {"icon": AppImages.warning},
  DialogWidgetState.confirmation: {"icon": AppImages.confirmation},
  DialogWidgetState.location: {"icon": AppImages.location},
};
