FROM python:3-alpine

RUN pip install flask

WORKDIR /usr/src/app

COPY backend .

ENV FLASK_APP=hello.py

CMD ["flask", "run", "--host=0.0.0.0"]

EXPOSE 5000

# TODO - install nginx
# TODO - add https
