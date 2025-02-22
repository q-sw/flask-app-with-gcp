FROM --platform=x86_64 python:3.10-alpine AS builder

COPY src/ /opt/app
WORKDIR /opt/app

RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

EXPOSE 5000

ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=app
ENV VERSION=1
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD ["gunicorn","-b", "0.0.0.0:5000", "demo-app:create_app()"]
