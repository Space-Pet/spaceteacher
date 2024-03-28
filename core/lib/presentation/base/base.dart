import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/constants.dart';
import '../../common/services/auth_service.dart';
import '../../common/utils.dart';
import '../../data/data_source/local/local_data_manager.dart';
// import '../../data/models/graphql_error.dart';
import '../../di/di.dart';
import '../common_widget/export.dart';
import '../extentions/extention.dart';

part 'state_base/bloc_status_state.dart';
part 'bloc_base.dart';
part 'state_base/state_base.dart';
part 'state_base/state_base.error_handler.dart';
part 'state_base/state_base.ext.dart';
