from flask import current_app
from sqlalchemy import Column, Integer, String, Text, DateTime
from sqlalchemy.orm import (
    declarative_base,
    scoped_session,
    sessionmaker,
)
from sqlalchemy import create_engine
import os


if os.getenv("FLASK_ENV") == "dev":
    engine = create_engine(f"sqlite://{current_app.config['DATABASE']}")
    # engine = create_engine(f"sqlite://{g.get('DATABASE')}")
elif os.getenv("FLASK_ENV") == "prod":
    pg_user = os.environ.get("PG_USER").rstrip("\r\n")
    pg_pwd = os.environ.get("PG_PWD").rstrip("\r\n")
    pg_address = os.environ.get("PG_ADDRESS").rstrip("\r\n")
    pg_port = os.environ.get("PG_PORT")
    pg_db_name = os.environ.get("DB_NAME").rstrip("\r\n")

    pg_url = f"{pg_user}:{pg_pwd}@{pg_address}:{pg_port}/{pg_db_name}"
    print(pg_url)
    engine = create_engine(f"postgresql+pg8000://{pg_url}", echo=True)

db_session = scoped_session(
    sessionmaker(autocommit=False, autoflush=False, bind=engine)
)
Base = declarative_base()
Base.query = db_session.query_property()


class Images(Base):
    __tablename__ = "images_table"
    id = Column(Integer, unique=True, primary_key=True)
    title = Column(String(128), nullable=False)
    blob_url = Column(Text, nullable=False)
    blob_name = Column(Text, nullable=False)
    download_timestamp = Column(DateTime, nullable=False)
    expiration_timestamp = Column(DateTime, nullable=False)

    def __init__(
        self, title, blob_url, blob_name, download_timestamp, expiration_timestamp
    ):
        self.title = title
        self.blob_url = blob_url
        self.blob_name = blob_name
        self.download_timestamp = download_timestamp
        self.expiration_timestamp = expiration_timestamp


def init_db():
    Base.metadata.create_all(bind=engine)
