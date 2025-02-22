import 'package:example/web/router/web_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();

  static AppState of(BuildContext context) {
    return context.findAncestorStateOfType<AppState>()!;
  }
}

class AppState extends State<App> {
  late final authService = AuthService();
  late final _appRouter = WebAppRouter(authService);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _appRouter.routeInfoProvider(),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      // builder: (context, router) {
      //   return AutoRouteRedirector<bool>(
      //     router: _appRouter,
      //     state: loggedIn,
      //     child: router!,
      //     mapStateToRedirect: (loggedIn) {
      //       print(loggedIn);
      //       if (!loggedIn) {
      //         return RouteRedirect.replace(LoginRoute());
      //       } else {
      //         return RouteRedirect.replace(HomeRoute());
      //       }
      //
      //       return RouteRedirect.toNone();
      //     },
      //   );
      // },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login to continue'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              App.of(context).authService.isAuthenticated = true;
            },
            child: Text('Login'),
          ),
        ),
      ),
    );
  }
}

// mock auth state
class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}
