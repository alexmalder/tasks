prepare:
	flutter pub get
	flutter pub run build_runner build

lint:
	flutter analyze .

push:
	flutter build apk
	git push -u origin $(git rev-parse --abbrev-ref HEAD)
