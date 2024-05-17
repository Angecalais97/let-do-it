FROM httpd:latest
RUN apt update -y
VOLUME /saves
COPY . /saves
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf /usr/local/apache2/htdocs/*
ADD https://linux-devops-course.s3.amazonaws.com/halloween.zip .
RUN apt install unzip -y
RUN unzip halloween.zip
RUN cp -r halloween/* /usr/local/apache2/htdocs/
RUN rm -rf halloween.zip halloween
EXPOSE 80
