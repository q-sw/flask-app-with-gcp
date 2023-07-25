from flask import Blueprint, render_template, render_template_string, request
import google.auth
from google.auth.transport import requests
from google.cloud import storage
from . import db
import datetime as dt
import hashlib
import os
from sqlalchemy import select

GCS_BUCKET_NAME = os.getenv("GCS_BUCKET_NAME")


bp = Blueprint("home", __name__)


@bp.route("/")
def index():
    return render_template("index.html", slides=list_all_image_record())


@bp.route("/upload", methods=["GET", "POST"])
def upload():
    if request.method == "POST":
        new_file = request.files["file"]
        if new_file.filename:
            upload_file_to_gcs(new_file.filename, new_file.stream)
        else:
            return render_template("upload.html")
    return render_template("upload.html")


@bp.route("/img/<id>", methods=["GET", "POST"])
def img(id):
    return render_template("image.html", image=get_image(id))


def get_credentials():
    credentials, project = google.auth.default()
    r = requests.Request()
    credentials.refresh(r)

    return credentials


def upload_file_to_gcs(file_name, raw_file):
    gcs_client = storage.Client(credentials=get_credentials())
    bucket = gcs_client.bucket(GCS_BUCKET_NAME)

    unique_blob_name = str(hashlib.sha256(file_name.encode()).hexdigest()) + str(
        dt.datetime.timestamp(dt.datetime.now())
    )

    blob = bucket.blob(unique_blob_name)
    blob.upload_from_file(raw_file)
    sign_url = generate_sign_url(blob)

    download_time = dt.datetime.strftime(dt.datetime.now(), "%Y-%m-%d %H:%M:%S")
    expiration_time = dt.datetime.strftime(
        sign_url["expiration_time"], "%Y-%m-%d %H:%M:%S"
    )

    write_metadata(
        file_name, sign_url["url"], unique_blob_name, download_time, expiration_time
    )


def write_metadata(title, blob_url, blob_name, download_time, expiration_time):
    entry = db.Images(title, blob_url, blob_name, download_time, expiration_time)
    db.db_session.add(entry)
    db.db_session.commit()


def generate_sign_url(blob):
    expiration = dt.timedelta(hours=720)
    cred = get_credentials()
    sign_url = blob.generate_signed_url(
        expiration=expiration,
        method="GET",
        credentials=cred,
        service_account_email=cred.service_account_email,
        access_token=cred.token,
    )

    return {"url": sign_url, "expiration_time": dt.datetime.now() + expiration}


def get_image(id):
    image = db.Images.query.get(id)
    print(id)
    return image


def list_all_image_record():
    records = db.Images.query.all()
    result = []
    for r in records:
        print(r.id, r.blob_name)
        print(r.blob_url)
        result.append({"id": r.id, "blob_name": r.blob_name, "blob_url": r.blob_url})
    return result


def list_file_from_gcs():
    gcs_client = storage.Client()
    blobs = gcs_client.list_blobs(GCS_BUCKET_NAME)
    result = []
    for blob in blobs:
        sign_url = generate_sign_url(blob)
        result.append(sign_url["url"])
    return result
