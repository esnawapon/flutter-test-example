# Flutter test example

## Setup
to be able to run app and test this project required
- flutter [https://docs.flutter.dev/get-started/install]
- nodejs [https://nodejs.org/en/download/]
---

## Getting start
install flutter dependencies
```
flutter pub get
```
install other dependencies
```
apt-get install lcov

# or for macos
brew install lcov
```
```
npm install
```

start emulator (optional)
```
flutter emulators --launch apple_ios_simulator
```
---

### Integration test
```
flutter test integration_test --coverage --coverage-path=integration_test/lcov.info

genhtml integration_test/lcov.info -o integration_test/coverage/
```
  html generated file locate at `integration_test/coverage/index.html`

**pros**
- can see result on device during test
- faster than test driver
- code coverage report
- currently it is the most stable for automate testing method in term of widget finding
- can test MethodChannel
- can access Widget's properties during test

**cons**
- still slow if compare with widget test
---

### Test driver

```
dart test/driver/driver_main.dart

node cucumber-html-reporter.js
```
  html generate file locate at `test/driver/report.html`

**pros**
- can see result on device during test
- can do BDD by implement gherkin
- can test MethodChannel

**cons**
- the slowest test among integration test and widget test
- unstable widget finding
- cannot access Widget's properties without create Command class
---

**Widget Test and Golden test are currently on WIP!!**  
With the same code as `integration_test` (except `ensureInitialized()` step), this test suppose to have the same result. But it fail ant many steps. Need to investigate more


### [WIP] Widget test
```
flutter test test/widget_test --coverage --coverage-path=test/widget_test/lcov.info

genhtml test/widget_test/lcov.info -o test/widget_test/coverage/
```
  html generate file locate at `test/widget_test/coverage/index.html`

**pros**
- the fastest test
- code coverage report
- can access Widget's properties during test

**cons**
- can not see result on device during test
- can test MethodChannel
---

### [WIP] Golden test
```
flutter test test/golden --coverage --coverage-path=test/golden/lcov.info

genhtml test/golden/lcov.info -o test/golden/coverage/
```

run with `--update-goldens` instead, if you want to update golden files
```
flutter test test/golden --update-goldens --coverage --coverage-path=test/golden/lcov.info
```
  html generate file locate at `test/golden_test/coverage/index.html`

**pros/cons**  
basically it is Widget test but use snapshot impage comparison instead, so it have the same pros and cons but easier to write expecting step don't need to get data from widget just do a snapshot
