FROM cirrusci/flutter:3.7.7 as build
WORKDIR /app
COPY . /app

RUN flutter build web --web-renderer html --release

FROM nginx:1.22
EXPOSE 80
COPY ./.nginx.conf /etc/nginx/conf.d/my.conf
COPY --from=build /app/build/web /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
