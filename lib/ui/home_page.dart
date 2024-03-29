import 'package:bloc_bases/bloc/bloc.dart';
import 'package:bloc_bases/bloc/home/home_bloc.dart';
import 'package:bloc_bases/bloc/home/home_state.dart';
import 'package:bloc_bases/data/fillm_data_repostory.dart';
import 'package:bloc_bases/data/model/film_model.dart';
import 'package:bloc_bases/widget/item_book_thumb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final FilmDataRepository filmDataRepository = FilmDataRepository();

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: BlocProvider(
          builder: (context) => HomeBloc(filmDataRepository),
          child: _HomePageWidgete()),
    );
  }
}

class _HomePageWidgete extends StatefulWidget {
  __HomePageWidgeteState createState() => __HomePageWidgeteState();
}

class __HomePageWidgeteState extends State<_HomePageWidgete> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is InitialHomeState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is EmptyHomeState) {
        return Center(child: Text("No data"));
      } else if (state is SuccessHomeState) {
        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 12.0),
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) => ItemBookThumb(
                  data: state.result[index],
                  onClick: (data) => _actionClick(data)),
              itemCount: state.result.length,
              separatorBuilder: (BuildContext context, int index) => Divider()),
        );
      } else {
        return Container();
      }
    });
  }

  _actionClick(FilmModel data) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(film: data)),
    );

    // final snackBar = SnackBar(content: Text('You click on ${data.name}'));
    // Scaffold.of(context).showSnackBar(snackBar);
  }
}
