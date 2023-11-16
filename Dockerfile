FROM registry.gitlab.com/devopsfaith/flutter-docker:0.1

WORKDIR /app

COPY . .

RUN flutter pub get

RUN flutter build apk --release
