import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:snapverese/widgets/common.dart';
import 'package:snapverese/widgets/login_screen_widget.dart';

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({super.key});

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.close)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(child: customText("Create New Post", 26,fontWeight: FontWeight.bold)),
              const Gap(20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: const TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Gap(1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.photo_size_select_actual_rounded),iconSize: 30,),
                  Gap(10),
                  IconButton(onPressed: (){}, icon: Icon(Icons.add),iconSize: 30,),
                ],
              ),
              Gap(20),
              loginButton("Save", (){}, null)
            ],
          ),
        ),
      ),
    );
  }
}
