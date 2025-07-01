import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:snapverese/controller/user_controller.dart';
import 'package:snapverese/models/users_model.dart';
import 'package:snapverese/widgets/search_screen_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = TextEditingController();
  List<UsersModel> allUsers = [];
  List<UsersModel> filteredUsers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    final controller = Provider.of<UserController>(context);

    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customSearchBar("Search....",searchController , (){}),
            Gap(10),
            Expanded(
              child: controller.filteredUsers.isEmpty
            ? Center(child: Text("No user found"),)
            : ListView.builder(
              itemCount: controller.filteredUsers.length,
              itemBuilder: (context,index){
                final user = controller.filteredUsers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profileImage),
                  ),
                  title: Text(user.name),
                );
              }
              )
            )
          ],
        ),
      )),
    );
  }
}