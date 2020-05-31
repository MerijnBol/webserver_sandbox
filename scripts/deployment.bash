#!/bin/bash

#start virtual environment and cd to project folder.
cd /srv/django_app/app

#try to kill old process
pid=`cat gunicorn_pids`
echo "Killing old process with PID = $pid"
kill $pid

# run pre deploy maintenance tasks
pipenv run python manage.py migrate
pipenv run python manage.py collectstatic --noinput
# start the detached gunicorn process per gunicorn_cfg settings via pipenv.
pipenv run gunicorn -D -p gunicorn_pids -c gunicorn_cfg.py app.wsgi
