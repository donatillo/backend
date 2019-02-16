FROM alpine

RUN apk add nginx python3 gcc musl-dev linux-headers python3-dev && \
    pip3 install --upgrade pip && \
    pip3 install flask flask-restful uwsgi && \
    apk del gcc musl-dev linux-headers python3-dev

WORKDIR /usr/src/app

COPY backend .

ENV FLASK_APP=hello.py

#CMD ["flask", "run", "--host=0.0.0.0"]
CMD ["uwsgi", "--socket", "0.0.0.0:8000", "--protocol=http", "-w", "wsgi"]

EXPOSE 8000

# TODO - install nginx
# TODO - add https
