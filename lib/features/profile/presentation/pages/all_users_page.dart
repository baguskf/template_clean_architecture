import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template_clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:template_clean_architecture/features/profile/presentation/bloc/profile_bloc.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Users')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: context.read<ProfileBloc>()
          ..add(ProfileEventGetAllUsers(page: 1)),
        builder: (context, state) {
          if (state is ProfileStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileStateError) {
            return Center(child: Text(state.message));
          } else if (state is ProfileStateLoadedAllUsers) {
            List<Profile> allUsers = state.allUsers;
            return ListView.builder(
              itemCount: allUsers.length,
              itemBuilder: (context, index) {
                Profile profile = allUsers[index];
                return ListTile(
                  leading: CircleAvatar(child: Image.network(profile.avatar)),
                  title: Text(profile.fullName),
                  onTap: () {
                    context.pushNamed('detail_user', extra: profile.id);
                  },
                );
              },
            );
          } else {
            return Center(child: Text('EMPTY USER'));
          }
        },
      ),
    );
  }
}
