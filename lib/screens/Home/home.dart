import 'package:anywhere/core/navigation/keys.dart';
import 'package:anywhere/core/navigation/navigation_service.dart';
import 'package:anywhere/core/startup/app_startup.dart';
import 'package:anywhere/core/utils/colors.dart';
import 'package:anywhere/core/utils/response_message.dart';
import 'package:anywhere/core/utils/styles.dart';
import 'package:anywhere/screens/Home/cubit/home_cubit.dart';
import 'package:anywhere/screens/Home/models/character_list_model.dart';
import 'package:anywhere/screens/details/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<RelatedTopics> relatedTopics = [];
  List<RelatedTopics> filteredCharacterList = [];

  @override
  void initState() {
    //enable cache for the api result ;)
    // if (serviceLocator.isRegistered<CharacterList>()) {
    //   characterList = serviceLocator<CharacterList>();
    // }
    super.initState();
    serviceLocator<HomeCubit>().getCharacterList();
  }

  void filterCharacterList(String query) {
    // If the search query is empty, show all characters
    if (query.isEmpty) {
      setState(() {
        filteredCharacterList;
      });
    } else {
      // Filter the characters based on the search query
      setState(() {
        filteredCharacterList = relatedTopics.where((character) {
          final text = character.text!.toLowerCase();
          final result = character.result?.toLowerCase() ?? "";
          return text.contains(query.toLowerCase()) || result.contains(query.toLowerCase());
        }).toList();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Character Names'),
        ),
        body: BlocConsumer(
        bloc: serviceLocator<HomeCubit>(),
        listener: (_, state) {
          if (state is GetCharacterListError) {
            context.loaderOverlay.hide();
            ResponseMessage.showErrorSnack(
                context: context, message: state.message);
          }
          if (state is GetCharacterListSuccess) {
            context.loaderOverlay.hide();
            filteredCharacterList = state.characterList.relatedTopics!;
            relatedTopics = state.characterList.relatedTopics!;
          }
        },
        builder: (_, state) {
          if (state is GetCharacterListLoading) {
            context.loaderOverlay.show();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: filterCharacterList,
                  decoration: InputDecoration(
                    labelText: 'Search character names',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredCharacterList.length,
                  separatorBuilder: (context, index) => Divider(), // Add a divider between items
                  itemBuilder: (context, index) {
                    //to get exact character names
                    List<String> parts = filteredCharacterList[index].text!.split(" - ");
                    String characterName = parts.first;

                    return ListTile(
                      onTap: () {
                        if (Device.get().isTablet) {
                          showModal(context, DetailsScreen(relatedTopics: filteredCharacterList[index]));
                        } else {
                        serviceLocator<NavigationService>().toWithPameter(
                            routeName: RouteKeys.details,
                            data: {
                              "relatedTopic" : filteredCharacterList[index]
                            }
                        );
                      }},
                      trailing: Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 23,
                        color: AppColors.secondaryActive,
                      ),
                      title: Text(
                        characterName,
                        style: AppStyle.dark18Style.copyWith(
                          color: AppColors.secondaryActive
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        })
    );
  }

  var _roundedRectangleBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );

  void showModal(BuildContext? context, Widget widget) {
    showModalBottomSheet(
      context: context!,
      barrierColor: Colors.black.withOpacity(0.6),
      shape: _roundedRectangleBorder,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
            heightFactor: 0.85,
            child: widget
        );
      },
    );
  }
}
