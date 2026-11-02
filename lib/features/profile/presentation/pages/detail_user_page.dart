import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:template_clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:template_clean_architecture/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:template_clean_architecture/injection.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;
  const UserDetailPage(this.userId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail $userId')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: appInjection<ProfileBloc>()
          ..add(ProfileEventGetDetaillUsers(userId: 1)),
        builder: (context, state) {
          if (state is ProfileStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileStateError) {
            return Center(child: Text(state.message));
          } else if (state is ProfileStateLoadedUser) {
            Profile profile = state.detail;
            return Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: Image.network(profile.avatar),
                    ),
                    Gap(20),
                    Text('ID : ${profile.id}'),
                    Text('Full Name : ${profile.fullName}'),
                    Text('Email : ${profile.email}'),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('EMPTY USER'));
          }
        },
      ),
    );
  }
}
