import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_mvvm/core/localization/app_localization.dart';
import 'package:notes_mvvm/core/styles/app_colors.dart';
import 'package:notes_mvvm/core/styles/font_styles.dart';
import 'package:notes_mvvm/core/styles/sizes.dart';
import 'package:notes_mvvm/popup_page.dart';
import 'package:notes_mvvm/presentation/viewmodels/home/home_viewmodel.dart';
import 'package:notes_mvvm/presentation/widgets/components/main_drawer.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/custom_text.dart';
import 'package:notes_mvvm/presentation/widgets/custom_widgets/loading_indicators.dart';
import 'package:notes_mvvm/presentation/widgets/home/home_dismiss_background_component.dart';
import 'package:notes_mvvm/presentation/widgets/home/home_list_item_component.dart';
import 'package:notes_mvvm/presentation/widgets/home/multi_selection_header_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopUpPage(
      scaffoldKey: scaffoldKey,
      appBarWithMenu: true,
      appbarItems: [
        CustomText.h6(
          context,
          tr('appName'),
          color: AppColors.primaryColor,
          weight: FontStyles.fontWeightBlack,
          overflow: TextOverflow.ellipsis,
        ),
      ],
      drawer: MainDrawer(
        scaffoldKey: scaffoldKey,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final homeVm = ref.watch(homeViewModel);
          return homeVm.isLoading
              ? LoadingIndicators.instance.smallLoadingAnimation(context)
              : homeVm.notesList.isEmpty
                  ? CustomText.h4(
                      context,
                      tr('thereAreNoVisualNotes'),
                      color: AppColors.grey,
                      alignment: Alignment.center,
                      key: const Key('noVisualNotes'),
                    )
                  : Column(
                      children: <Widget>[
                        if (homeVm.selectedNotesIds.isNotEmpty)
                          MultiSelectionHeaderComponent(
                            homeVm: homeVm,
                          ),
                        Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizes.screenVPaddingDefault,
                                horizontal: Sizes.screenHPaddingDefault,
                              ),
                              itemBuilder: (context, index) {
                                return Dismissible(
                                    key: Key(homeVm.notesList[index].noteId),
                                    direction:
                                        homeVm.selectedNotesIds.isNotEmpty
                                            ? DismissDirection.none
                                            : DismissDirection.horizontal,
                                    onDismissed: (direction) =>
                                        homeVm.deleteNote(
                                            visualNoteModel:
                                                homeVm.notesList[index]),
                                    background:
                                        const HomeDismissBackgroundComponent(),
                                    child: GestureDetector(
                                      onTap: homeVm.selectedNotesIds.isNotEmpty
                                          ? () {
                                              homeVm.toggleNoteSelection(
                                                  noteId: homeVm
                                                      .notesList[index].noteId);
                                            }
                                          : null,
                                      onLongPress: () {
                                        homeVm.toggleNoteSelection(
                                          noteId:
                                              homeVm.notesList[index].noteId,
                                        );
                                      },
                                      child: HomeListItemComponent(
                                        visualNoteModel:
                                            homeVm.notesList[index],
                                        isSelectedNote: homeVm.isSelectedNote(
                                            noteId:
                                                homeVm.notesList[index].noteId),
                                      ),
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: Sizes.vMarginMedium,
                                );
                              },
                              itemCount: homeVm.notesList.length),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}
