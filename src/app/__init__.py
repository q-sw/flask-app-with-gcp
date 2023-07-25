import os

from flask import Flask


def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    if os.getenv("FLASK_ENV") == "dev":
        app.config.from_mapping(
            SECRET_KEY="dev",
            DATABASE=os.path.join(app.instance_path, "test.db"),
        )
        with open(os.path.join(app.inject_url_defaults, "test.db"), "r") as db_file:
            print("DEV ENVIRONMENT CREATE DBFILE")

    elif os.getenv("FLASK_ENV") == "prod":
        pg_user = os.environ.get("PG_USER")
        pg_pwd = os.environ.get("PG_PWD")
        pg_address = os.environ.get("PG_ADDRESS")
        pg_port = os.environ.get("PG_PORT")
        pg_db_name = os.environ.get("DB_NAME")

        pg_url = f"{pg_user}:{pg_pwd}@{pg_address}:{pg_port}/{pg_db_name}"

        app.config.from_mapping(
            SECRET_KEY=os.getenv("DB_SECRET"),
            DATABASE=f"postgresql + pg8000://{pg_url}",
        )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile("config.py", silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # a simple page that says hello
    @app.route("/hello")
    def hello():
        return "Hello, World!"

    from . import db

    db.init_db()

    from . import main

    app.register_blueprint(main.bp)
    app.add_url_rule("/", endpoint="index")

    return app
