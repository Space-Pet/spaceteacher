#! /bin/bash

function run_pub_gen() {
	folder="$1"
	echo "================== Pub Gen $folder =================="
	cd "$folder"
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs
	cd ../
}

# Main script logic
if [[ $# -eq 0 ]]; then
	# Run on all folders if no argument is provided
	run_pub_gen core
	run_pub_gen iportal2
	run_pub_gen teacher
else
	# Check if the provided argument is a valid folder name
	folder=$1
	if [[ -d "$folder" ]]; then
		# Run the script on the specified folder
		run_pub_gen "$folder"
	else
		echo "Error: Invalid folder name."
		exit 1
	fi
fi
