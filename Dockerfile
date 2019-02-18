FROM alpine

RUN apk --no-cache add nginx python3 \
    && apk --no-cache add --virtual deps gcc musl-dev linux-headers python3-dev shadow \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && pip3 install --upgrade pip \
    && pip3 install flask flask-restful uwsgi boto3 \
    && apk del deps

WORKDIR /usr/src/app

COPY backend .
COPY etc/default.conf /etc/nginx/conf.d/
COPY etc/aws.crt /etc/
#COPY etc/selfsigned.key /etc/
#COPY etc/dhparam.pem /etc/

CMD ./start.sh

EXPOSE 80
EXPOSE 443

# TODO - install nginx
# TODO - add https
