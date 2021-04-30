import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_app/components/bottom_button.dart';
import 'package:new_todo_app/constants.dart';
import 'package:new_todo_app/data/firestore_repository.dart';
import 'package:new_todo_app/screens/add_task_page.dart';
import 'package:new_todo_app/widgets/tile_item.dart';
import 'package:provider/provider.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _buildTopBar(context),
            _buildBodyContent(context),
            _buildBottomBar(context)
          ],
        ),
      ),
    );
  }

  Stack _buildTopBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity, // MediaQuery.of(context).size.width
          height: 140,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/bg_header.png'),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: 20.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 34,
          child: SizedBox(
            width: 250.0,
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'TODOa',
                  textStyle: kColorizeTextStyle,
                  colors: kColorizeColors,
                  speed: const Duration(seconds: 3),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream:
        Provider.of<FirestoreRepository>(context, listen: false).steam(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<TileItem> widgets = [];
          if (snapshot.hasData) {
            snapshot.data!.docs.forEach((QueryDocumentSnapshot query) {
              final id = query.id;
              Map<String, dynamic> data = query.data();

              final bool isSelected = data['isSelected'];
              final title = data['todo'];

              widgets.add(TileItem(
                isChecked: isSelected,
                title: title,
                image: null,
                onCheckedChanges: (bool isChecked) {
                  Provider.of<FirestoreRepository>(context, listen: false)
                      .update(id, isChecked);
                },
              ));
            });
          }

          return ListView(
            children: widgets,
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomButton(
        title: 'Add Item',
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                height: 220,
                color: Color(0xff757575),
                child: AddTaskPage(),
              );
            },
          );
        });
  }
}
