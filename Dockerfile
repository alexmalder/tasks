FROM cirrusci/flutter:3.7.5

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build apk
