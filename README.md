# Exercise App

This app is now set up to run in Docker, including on a UGREEN NAS.

## Run with Docker Compose

1. Install Docker and Docker Compose on the NAS.
2. From the project root, build and start the app:

   docker compose up --build -d

3. Open the app at http://<nas-ip>:3000.
4. To stop it:

   docker compose down

## Persistent data

The container uses a Docker volume for the SQLite database and temporary files, so your data will persist across container restarts.

## Environment variables

You can override defaults with:

- SECRET_KEY_BASE
- DATABASE_PATH
- CACHE_DATABASE_PATH
- CABLE_DATABASE_PATH
- RAILS_FORCE_SSL
- RAILS_ASSUME_SSL
