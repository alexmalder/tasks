FROM mobiledevops/flutter-sdk-image:3.10.3

WORKDIR /app

COPY . .

RUN flutter pub get

RUN flutter build apk --release
