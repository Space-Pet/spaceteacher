# iPortal2

App for student and parents - Flutter version

## Generate Image file

Note: make sure you setup fluttergen path to your environment

- Refereance link:
  [.] https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path
  [.] https://pub.dev/packages/flutter_gen

- Using flutter_gen for auto-generate dart code, run:

```bash
$ dart pub global activate flutter_gen
$ fluttergen -c pubspec.yaml
```

## Get current account training level

- To get current logged in account's training level
  use isKinderGarten() method defined in ProfileInfo

- Wrap your widget with BlocBuilder and use CurrentUserBloc to get the current logged in account info and use the isKinderGarten() method.

```dart
...
class YourWidget extends StatelessWidget {
  ...
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
          if (state.activeChild.isMN) {
            return Widget();
          }
        }
    )
  }
}
```
