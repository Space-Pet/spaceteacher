# NHG apps

## Getting Started

**Build commands**

- iportal Dev
  sh distribution.sh -f iportalDev -p all

- teacher Dev  
  sh distribution.sh -f teacherDev -p all

- iportal Prod  
  sh distribution.sh -f iportalProd -p all

- teacher Prod  
  sh distribution.sh -f teacherProd -p all

- All Dev
  sh distribution.sh -f dev -p all

- All Prod
  sh distribution.sh -f prod -p all

- All flavor, platform  
  sh distribution.sh -f all -p all

# Tools:

```
- module_generator: cd [iportal, teacher] flutter pub run module_generator
    -- Module name: refer under-scrore (test_module)
```

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
- Go to child apps to gen code directly

# Run project

```bash
step 1:
$ bash pub_gen.sh
step 2:
$ bash pub_gen.sh 1
step 3:
In visual studio code, run and debug chosse name env you want to run
```

### Build app env dev

# Android

app iportal: $ flutter build apk --flavor iportalDev --release -t lib/main_dev.dart
app partner: $ flutter build apk --flavor teacherDev --release -t lib/main_dev.dart

# IOS

app iportal: $ flutter build ipa --flavor iportalDev --release -t lib/main_dev.dart
app partner: $ flutter build ipa --flavor teacherDev --release -t lib/main_dev.dart

# structure of source code

- core (this module is define as an app)
  - It has create, config for teacher, AppConfig ...
  - It has bloc base, component , service call api, share modules for iportal and teacher ...
  - It has information config environment. (core/lib/envs.dart)
  - Currently image only gen in iportal app, teacher app => if any picture is used in common, it will be added to core app

- iportal: Source code app iportal
  - AppID:
    [dev]: com.aegona.iportal2
    [prod]: com.nhgvn.iportal2
- teacher: Source code app partner
  - AppID:
    [dev]: com.aegona.teacher
    [prod]: com.nhgvn.teacher

## Change environment
``` bash
$ flutter pub run environment_config:generate --config=environment_config.yaml --config-extension=$environment_name
```
```
$ flutter build apk --release --flavor uat
```
