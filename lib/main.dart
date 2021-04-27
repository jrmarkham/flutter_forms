import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_data/form_data_bloc.dart';
import 'screens/form_screen.dart';

void main()  {
  // This widget is the root of your application.

  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
      title: 'Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
          backgroundColor: Colors.white
      ),
      home: MultiBlocProvider(


          providers:[
              BlocProvider<FormDataBloc>(create: (BuildContext context)=>FormDataBloc())
          ],
      child:



      FormScreen(),
    )));
  }

  /*
  home: MultiBlocProvider(
                  providers: [
                    BlocProvider<UIBloc>(create: (BuildContext context) => UIBloc()),
                    BlocProvider<UserBloc>(create: (BuildContext context) => UserBloc()),
                    BlocProvider<DailiesBloc>(
                        create: (BuildContext context) => DailiesBloc()),
                    BlocProvider<AdsBloc>(create: (BuildContext context) => AdsBloc()),
                    BlocProvider<PurchasesBloc>(
                        create: (BuildContext context) => PurchasesBloc()),
                  ],child:App())));
   */

