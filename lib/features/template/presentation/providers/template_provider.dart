// import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';

import '../../../../../core/errors/failure.dart';
import '../../business/entities/template_entity.dart';

class TemplateProvider extends ChangeNotifier {
  TemplateEntity? template;
  Failure? failure;

  TemplateProvider({
    this.template,
    this.failure,
  });

  void eitherFailureOrTemplate() async {
    // TemplateRepositoryImpl repository = TemplateRepositoryImpl(
    //   remoteDataSource: TemplateRemoteDataSourceImpl(
    //     dio: Dio(),
    //   ),
    //   localDataSource: TemplateLocalDataSourceImpl(
    //     sharedPreferences: await SharedPreferences.getInstance(),
    //   ),
    //   // networkInfo: NetworkInfoImpl(
    //   //   DataConnectionChecker(),
    //   // ),
    // );

    // final failureOrTemplate =
    //     await GetTemplate(templateRepository: repository).call(
    //   templateParams: TemplateParams(),
    // );

    // failureOrTemplate.fold(
    //   (Failure newFailure) {
    //     template = null;
    //     failure = newFailure;
    //     notifyListeners();
    //   },
    //   (TemplateEntity newTemplate) {
    //     template = newTemplate;
    //     failure = null;
    //     notifyListeners();
    //   },
    // );
    notifyListeners();
  }
}
