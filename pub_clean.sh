function run_clean() {
	echo "================== Clean $1 =================="
	cd $1
	flutter clean
	flutter pub get
	cd ios
	rm -rf Pods
	rm -rf Podfile.lock
	pod install --repo-update
	cd ..
	dart run build_runner build -d
	cd ../
}

function run_clean_core() {
	echo "================== Clean core =================="
	cd core
	flutter clean
	flutter pub get
	dart run build_runner build -d
	cd ../
}

function pod_reset_cache() {
	echo "================== Reset pod cache =================="
	echo "Choose app need to reset pod cache:"
	select app in "iportal2" "teacher"; do
		case $app in
			iportal2)
				cd iportal2
				break
				;;
			teacher)
				cd teacher
				break
				;;
			*)
				echo "Invalid choice."
				;;
		esac
	done
	cd ios
	rm -rf ~/Library/Caches/CocoaPods
	rm -rf Pods
	rm -rf ~/Library/Developer/Xcode/DerivedData/*
	pod deintegrate
	pod setup
	pod install
}

function build_apk() {
	echo "================== Build APK =================="
	echo "Choose app need to build APK:"
	select app in "iportal2" "teacher"; do
		case $app in
			iportal2)
				cd iportal2
				break
				;;
			teacher)
				cd teacher
				break
				;;
			*)
				echo "Invalid choice."
				;;
		esac
	done
	flutter build apk
	echo "Enter app version:"
	read version
	cp build/app/outputs/flutter-apk/app-release.apk releases/$app-$version.apk
}

function menu() {
	echo "================== Menu =================="
	echo "1. Build iportal2"
	echo "2. Build teacher"
	echo "3. Build all"
	echo "4. Clean core"
	echo "5. Clean iportal2"
	echo "6. Clean teacher"
	echo "7. Clean all"
	echo "8. Reset pod cache"
	echo "0. Exit"
}

function main() {
	while true; do
		menu
		read -p "Enter your choice: " choice
		case $choice in
			1)
				build_apk
				;;
			2)
				build_apk
				;;
			3)
				build_apk
				;;
			4)
				run_clean_core
				;;
			5)
				run_clean iportal2
				;;
			6)
				run_clean teacher
				;;
			7)
				run_clean_core
				run_clean iportal2
				run_clean teacher
				;;
			8)
				pod_reset_cache
				;;
			0)
				break
				;;
			*)
				echo "Invalid choice."
				;;
		esac
	done
}
# execute main function
main
