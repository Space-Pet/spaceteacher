import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher/screens/observation_schedule/views/hourly_assessment/bloc/assessment_bloc.dart';

class MoetEvaluationQuestions extends StatefulWidget {
  const MoetEvaluationQuestions({
    super.key,
    required this.listMoetCriteria,
    required this.category,
    this.diemType = 'float',
    required this.lessonRegisterId,
    required this.listAnswer,
  });

  final List<Criteria> listMoetCriteria;
  final String category;
  final String diemType;
  final String lessonRegisterId;
  final List<Criteria> listAnswer;

  @override
  State<MoetEvaluationQuestions> createState() =>
      _MoetEvaluationQuestionsState();
}

class _MoetEvaluationQuestionsState extends State<MoetEvaluationQuestions> {
  late List<TextEditingController> scoreControllers;
  late List<TextEditingController> commmentControllers;
  late List<FocusNode> focusScores;
  late List<FocusNode> focusComments;

  final Map<int, String> levelMap = {
    4: 'Rất hài lòng',
    3: 'Hài lòng',
    2: 'Bình thường',
    1: 'Không hài lòng',
    0: 'Rất không hài lòng',
  };

  @override
  void initState() {
    super.initState();
    scoreControllers = List.generate(
        widget.listMoetCriteria.length, (index) => TextEditingController());

    commmentControllers = List.generate(
        widget.listMoetCriteria.length, (index) => TextEditingController());

    focusScores =
        List.generate(widget.listMoetCriteria.length, (index) => FocusNode());

    focusComments =
        List.generate(widget.listMoetCriteria.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var scoreController in scoreControllers) {
      scoreController.dispose();
    }
    for (var commentController in commmentControllers) {
      commentController.dispose();
    }
    for (var focusNode in focusScores) {
      focusNode.dispose();
    }
    for (var focusNode in focusComments) {
      focusNode.dispose();
    }

    super.dispose();
  }

  void onUpdateCriteria(Criteria criteria) {
    final indexAnswer = widget.listAnswer
        .indexWhere((element) => element.noteId == criteria.noteId);

    final indexController = widget.listMoetCriteria.indexWhere(
      (element) => element.noteId == criteria.noteId,
    );

    final newCriteria = criteria.copyWith(
      diemDat: scoreControllers[indexController].text,
      nhanXet: commmentControllers[indexController].text,
    );

    widget.listAnswer[indexAnswer] = newCriteria;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssessmentBloc, AssessmenState>(
      listener: (context, state) {
        if (state.status == AssessmentStatus.updateFailure) {
          Fluttertoast.showToast(
            msg: state.errorMsg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.black,
            textColor: AppColors.white,
          );

          for (var focusNode in focusComments) {
            focusNode.unfocus();
          }
        }
      },
      builder: (context, state) {
        final bloc = context.read<AssessmentBloc>();
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.category,
                  style: AppTextStyles.semiBold16(
                    color: AppColors.gray700,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.listMoetCriteria.length,
                  itemBuilder: (context, index) {
                    final criteria = widget.listMoetCriteria[index];
                    final TextEditingController scoreController =
                        scoreControllers[index];

                    scoreController.text = criteria.diemDat ?? '';
                    onUpdateCriteria(criteria);

                    final TextEditingController commentController =
                        commmentControllers[index];

                    if (criteria.nhanXet != null) {
                      commentController.text = criteria.nhanXet ?? '';
                      onUpdateCriteria(criteria);
                    }

                    final FocusNode focusScore = focusScores[index];
                    final FocusNode focusComment = focusComments[index];

                    KeyboardActionsConfig buildConfig(BuildContext context) {
                      return KeyboardActionsConfig(
                        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                        keyboardBarColor: AppColors.gray100,
                        nextFocus: true,
                        actions: [
                          KeyboardActionsItem(
                              focusNode: focusScore,
                              displayArrows: false,
                              toolbarAlignment: MainAxisAlignment.spaceBetween,
                              toolbarButtons: [
                                (node) {
                                  return InkWell(
                                    onTap: () => node.unfocus(),
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 4, 4, 4),
                                        child: Text('Đóng',
                                            style: AppTextStyles.semiBold14())),
                                  );
                                },
                                (node) {
                                  return InkWell(
                                    onTap: () {
                                      bloc.add(
                                        UpdateCriteria(
                                          lessonRegisterId:
                                              widget.lessonRegisterId,
                                          noteId: criteria.noteId,
                                          tieuChiDiem:
                                              criteria.tieuChiDiem.toString(),
                                          diemDat: scoreController.text,
                                          nhanXet: commentController.text,
                                        ),
                                      );

                                      focusComment.requestFocus();
                                      onUpdateCriteria(criteria);
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            4, 4, 16, 4),
                                        child: Text('Tiếp theo',
                                            style: AppTextStyles.semiBold14(
                                              color: AppColors.blue600,
                                            ))),
                                  );
                                },
                              ]),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Text(
                          criteria.tieuChiNoiDung ?? '',
                          style: AppTextStyles.semiBold16(
                            color: AppColors.brand600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6, bottom: 8),
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.gray100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Điểm chuẩn: ${criteria.tieuChiDiem}',
                                      style: AppTextStyles.semiBold14(
                                        color: AppColors.brand600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Điểm đạt:',
                                          style: AppTextStyles.normal14(),
                                        ),
                                        const SizedBox(width: 8),
                                        SizedBox(
                                          width: 50,
                                          height: 28,
                                          child: KeyboardActions(
                                            config: buildConfig(context),
                                            child: SizedBox(
                                              width: 50,
                                              height: 28,
                                              child: TextField(
                                                focusNode: focusScore,
                                                controller: scoreController,
                                                onChanged: (score) {
                                                  scoreController.text = score;
                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                  decimal: widget.diemType ==
                                                      'float',
                                                ),
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'[0-9]+[,.]{0,1}[0-9]*')),
                                                  TextInputFormatter
                                                      .withFunction(
                                                    (oldValue, newValue) =>
                                                        newValue.copyWith(
                                                      text: newValue.text
                                                          .replaceAll(',', '.'),
                                                    ),
                                                  ),
                                                ],
                                                style: AppTextStyles.normal14(),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: AppColors.gray400,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: AppColors.brand600,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: AppColors.gray400,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  width: 4,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.brand600,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.icons.features.report,
                                            width: 20,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Nhận xét',
                                            style: AppTextStyles.semiBold14(
                                                color: AppColors.brand600),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      TextField(
                                        onTapOutside: (event) {
                                          focusComment.unfocus();
                                        },
                                        focusNode: focusComment,
                                        controller: commentController,
                                        maxLines: 4,
                                        minLines: 2,
                                        onChanged: (newComment) {
                                          commentController.text = newComment;
                                        },
                                        onSubmitted: (nhanXet) {
                                          onUpdateCriteria(criteria);

                                          bloc.add(
                                            UpdateCriteria(
                                              lessonRegisterId:
                                                  widget.lessonRegisterId,
                                              noteId: criteria.noteId,
                                              tieuChiDiem: criteria.tieuChiDiem
                                                  .toString(),
                                              diemDat: scoreController.text,
                                              nhanXet: nhanXet,
                                            ),
                                          );

                                          if (index <
                                              widget.listMoetCriteria.length -
                                                  1) {
                                            focusScores[index + 1]
                                                .requestFocus();
                                          }
                                        },
                                        textInputAction: TextInputAction.next,
                                        style: AppTextStyles.normal14(),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 4),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.gray400,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.brand600,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: AppColors.gray400,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
