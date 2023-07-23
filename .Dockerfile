FROM cirrusci/flutter:3.7.7

WORKDIR /app

COPY . .

RUN flutter pub get

RUN flutter build apk --release
