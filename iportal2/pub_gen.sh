#! /bin/bash

function run_pub_gen() {
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs
}
