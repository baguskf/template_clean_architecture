import '../../injection.dart';
import 'data/datasources/local_data.dart';
import 'data/datasources/remote_data.dart';
import 'data/repositories/profile_repository_implementation.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_all_user.dart';
import 'domain/usecases/get_user.dart';
import 'presentation/bloc/profile_bloc.dart';

void initProfileInjection() {
  //Bloc
  appInjection.registerFactory(
    () => ProfileBloc(getAllUsers: appInjection(), getUserById: appInjection()),
  );

  //UseCase
  appInjection.registerLazySingleton(() => GetAllUsers(appInjection()));
  appInjection.registerLazySingleton(() => GetUser(appInjection()));

  //Repository
  appInjection.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImplementation(
      profileRemoteData: appInjection(),
      profileLocalData: appInjection(),
      box: appInjection(),
    ),
  );

  //Datasource
  appInjection.registerLazySingleton<ProfileLocalData>(
    () => ProfileLocalDataImplementation(box: appInjection()),
  );
  appInjection.registerLazySingleton<ProfileRemoteData>(
    () => ProfileRemoteDataImplementation(client: appInjection()),
  );
}
