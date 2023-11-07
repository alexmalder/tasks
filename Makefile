prepare:
	flutter pub run build_runner build
	flutter analyze .

push:
	flutter build apk
	git push -u origin $(git rev-parse --abbrev-ref HEAD)
