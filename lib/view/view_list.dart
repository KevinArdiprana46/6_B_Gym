import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/data/data.dart';

class ListLayanan extends StatefulWidget {
  const ListLayanan({super.key});

  @override
  State<ListLayanan> createState() => _ListLayananState();
}

class _ListLayananState extends State<ListLayanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Layanan ATMA GYM"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if(constraints.maxWidth > 800) {
          return const wideLayout();
        } else {
          return const NarrowLayout();
        }
      }),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

@override
Widget build(BuildContext context) {
    return PeopleList(
      onPersonTap: (person) => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: PersonDetail(person),
        ),
      )),
    );
  }
}

class wideLayout extends StatefulWidget {
  const wideLayout({super.key});

  @override
  State<wideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<wideLayout> {
  dataLayanan? _data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: PeopleList(
              onPersonTap: (data) => setState(() => _data = data),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _data == null ? const Placeholder() : PersonDetail(_data!),
        ),
      ],
    );
  }
}

class PeopleList extends StatelessWidget {
  final void Function(dataLayanan) onPersonTap;
  const PeopleList({super.key, required this.onPersonTap});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for (var data in data)
        ListTile(
          title: Text(data.namaLayanan),
          onTap: () => onPersonTap(data),
        )
    ]);
  }
}

class PersonDetail extends StatelessWidget {
  final dataLayanan data;
  const PersonDetail(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, boxConstraints) {
        return Center(
          child: boxConstraints.maxHeight > 200 ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MouseRegion(
                      onHover: (_) => {print("Hello World")},
                      child: Text(data.namaLayanan),
                    ),
                    Text(data.jadwal),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Contact Us"),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MouseRegion(
                      onHover: (_) => {print("Hello World")},
                      child: Text(data.namaLayanan),
                    ),
                    Text(data.jadwal),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Contact Us"),
                    ),
                  ],
                ),);
      }
    );
  }
}
