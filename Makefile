test_and_push:
	flutter analyze .
	flutter build apk
	git push -u origin $(git rev-parse --abbrev-ref HEAD)
