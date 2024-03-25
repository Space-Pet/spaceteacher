#!/bin/bash

FLAVOR=""
PLATFORM=""

POSITIONAL=()

while [[ $# -gt 0 ]]; do
	key="$1"

	case $key in
	-f | --flavor)
		FLAVOR="$2"
		shift # past argument
		shift # past value
		;;
	-p | --platform)
		PLATFORM="$2"
		shift # past argument
		shift # past value
		;;
	*)                  # unknown option
		POSITIONAL+=("$1") # save it in an array for later
		shift              # past argument
		;;
	esac
done

if [ -z "$FLAVOR" ]; then
	echo "FLAVOR must be provided! Use -e arg!"
	exit 0
fi

if [ -z "$PLATFORM" ]; then
	echo "Platform must be provided! Use -p arg!"
	exit 0
fi

if [[ "iportalDev-teacherDev-iportalProd-teacherProd-dev-prod-all" != *"$FLAVOR"* ]]; then
	echo "Invalid FLAVOR : $FLAVOR"
	exit 0
fi

if [[ "ios-android-web-all" != *"$PLATFORM"* ]]; then
	echo "Invalid PLATFORM : $PLATFORM"
	exit 0
fi

clean_folder() {
	sh clean_all.sh
}

deploy_iportal_dev() {
	cd iportal2
	if [[ "android-all" == *"$PLATFORM"* ]]; then
		flutter build apk --flavor iportalDev --release -t lib/main_dev.dart
		cd android/
		fastlane android upload_firebase_iportal_dev

		cd ../
	fi
	if [[ "ios-all" == *"$PLATFORM"* ]]; then
		flutter build ipa --flavor iportalDev --release -t lib/main_dev.dart --export-options-plist=ios/ExportOptions.plist
		cd ios/
		fastlane ios upload_firebase_iportal_dev

		cd ../
	fi
	cd ../
}

deploy_teacher_dev() {
	cd teacher
	if [[ "android-all" == *"$PLATFORM"* ]]; then
		flutter build apk --flavor teacherDev --release -t lib/main_dev.dart
		cd android/
		fastlane android upload_firebase_teacher_dev

		cd ../
	fi
	if [[ "ios-all" == *"$PLATFORM"* ]]; then
		flutter build ipa --flavor teacherDev --release -t lib/main_dev.dart --export-options-plist=ios/ExportOptions.plist
		cd ios/
		fastlane ios upload_firebase_teacher_dev

		cd ../
	fi
	#    if [[ "web-all" == *"$PLATFORM"* ]];then
	#        flutter build web --release -t lib/main_teacher_dev.dart --web-renderer html
	#        firebase deploy --project teacher_dev --only hosting:teacher_dev
	#    fi
	cd ../
}

deploy_iportal_prod() {
	cd iportal2
	if [[ "android-all" == *"$PLATFORM"* ]]; then
		flutter build apk --flavor iportalProd --release -t lib/main.dart
		cd android/
		fastlane android upload_firebase_iportal_prod

		cd ../
	fi
	if [[ "ios-all" == *"$PLATFORM"* ]]; then
		flutter build ipa --flavor iportalProd --release -t lib/main.dart --export-options-plist=ios/ProdExportOptions.plist
		cd ios/
		fastlane ios upload_firebase_iportal_prod

		cd ../
	fi
	cd ../
}

deploy_teacher_prod() {
	cd teacher
	if [[ "android-all" == *"$PLATFORM"* ]]; then
		flutter build apk --flavor teacherProd --release -t lib/main.dart
		cd android/
		fastlane android upload_firebase_teacher_prod

		cd ../
	fi
	if [[ "ios-all" == *"$PLATFORM"* ]]; then
		flutter build ipa --flavor teacherProd --release -t lib/main.dart --export-options-plist=ios/ProdExportOptions.plist
		cd ios/
		fastlane ios upload_firebase_teacher_prod

		cd ../
	fi

	#    if [[ "web-all" == *"$PLATFORM"* ]];then
	#        flutter build web --release -t lib/main_teacher.dart --web-renderer html
	#        firebase deploy --project teacher_prod --only hosting:teacher_prod
	#    fi
	cd ../
}

if [[ "iportalDev" == *"$FLAVOR"* ]]; then

	clean_folder

	deploy_iportal_dev

elif [[ "teacherDev" == *"$FLAVOR"* ]]; then

	clean_folder

	deploy_teacher_dev

elif [[ "iportalProd" == *"$FLAVOR"* ]]; then

	clean_folder

	deploy_iportal_prod

elif [[ "teacherProd" == *"$FLAVOR"* ]]; then

	clean_folder

	deploy_teacher_prod

elif [[ "all" == *"$FLAVOR"* ]]; then

	clean_folder

	deploy_iportal_dev

	deploy_teacher_dev

	deploy_iportal_prod

	deploy_teacher_prod

elif [[ "dev" == *"$FLAVOR"* ]]; then

	clean_folder

	deploy_iportal_dev

	deploy_teacher_dev

elif [[ "prod" == *"$FLAVOR"* ]]; then

	clean_folder

	deploy_iportal_prod

	deploy_teacher_prod

fi

cd ..
echo "Deploy firebase done [flavor: $FLAVOR - platform: $PLATFORM] !!!"
