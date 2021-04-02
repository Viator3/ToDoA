import 'package:flutter/material.dart';
import 'package:flutter_app_todoa/model/item_data.dart';
import 'package:flutter_app_todoa/widgets/tile_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTopBar(context),
          _buildBodyContent(),
          _buildBottomBar(context),
        ],
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
      ],
    );
  }

  Widget _buildBodyContent() {
    List<ItemData> items = [
      ItemData(
        isChecked: true,
        image: 'assets/avatar_holder.png',
        title: 'Item Text 0',
      ),
      ItemData(
        isChecked: false,
        image: 'assets/avatar_holder.png',
        title: 'Item Text 1',
      ),
      ItemData(
        isChecked: true,
        image: null,
        title: 'Item Text 2',
      ),
      ItemData(
        isChecked: true,
        image: 'assets/avatar_holder.png',
        title: 'Item Text 0',
      ),
      ItemData(
        isChecked: false,
        image: 'assets/avatar_holder.png',
        title: 'Item Text 1',
      ),
      ItemData(
        isChecked: true,
        image: null,
        title: 'Item Text 2',
      ),
      ItemData(
        isChecked: false,
        image: 'assets/avatar_holder.png',
        title: 'Item Text 3',
      )
    ];

    return Container(
      width: double.infinity,
      height: 560,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: TileItem(
              isChecked: items[index].isChecked,
              title: items[index].title,
              image: items[index].image,
            ),
          );
        },
      ),
    );
  }

  Container _buildBottomBar(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text(
          'Add items',
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          _navigateAndDisplaySelection(context);
        },
      ),
      color: Colors.yellow,
      width: double.infinity, // MediaQuery.of(context).size.width
      height: 70,
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final String result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => SecondPage(args: 'Add items')),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }

}


class SecondPage extends StatefulWidget {
  final String args;

  SecondPage({required this.args});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String _name = '';

  _changeName(String text) {
    setState(() {
      _name = text;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.args}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            style: TextStyle(fontSize: 22),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Hint text",
                fillColor: Colors.black12,
                filled: true),
            onSubmitted: _changeName,
            onChanged: _changeName,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _name);
            },
            child: Text('+'),
          ),
        ],
      ),
    );
  }
}