FROM nginx:alpine

WORKDIR /usr/share/nginx/html



RUN rm /usr/share/nginx/html/index.html
#COPY index_files /usr/share/nginx/html/
COPY index.html /usr/share/nginx/html/
RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/
EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]