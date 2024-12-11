import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/data/data.dart';
import 'package:tubes_pbp_6/view/reviewPage.dart';

class ListReview extends StatefulWidget {
  const ListReview({Key? key}) : super(key: key);

  @override
  State<ListReview> createState() => _ListReviewState();
}

class _ListReviewState extends State<ListReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color(0xFF5565E8),
        title: const Text('Review', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return const WideLayout();
        } else {
          return const NarrowLayout();
        }
      }),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeopleList(
      onPersonTap: (person) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReviewPage(
              selectedService: person,
            ),
          ),
        );
      },
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({Key? key}) : super(key: key);

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
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
              onPersonTap: (data) {
                setState(() => _data = data);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewPage(
                      selectedService: data,
                    ),
                  ),
                );
              },
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
  const PeopleList({Key? key, required this.onPersonTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var data in data)
          ListTile(
            title: Text(data.namaLayanan),
            onTap: () => onPersonTap(data),
          ),
      ],
    );
  }
}

class PersonDetail extends StatelessWidget {
  final dataLayanan data;
  const PersonDetail(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, boxConstraints) {
        return Center(
          child: boxConstraints.maxHeight > 200
              ? Column(
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
                ),
        );
      },
    );
  }
}
