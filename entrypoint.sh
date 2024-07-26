#!/bin/bash
python3 manage.py migrate

python3 manage.py migrate catalog --database=catalog

python manage.py collectstatic --clear --noinput --verbosity 0

celery -A onrequestlab.celery_config worker -l info -f celery_worker.log --detach

celery -A onrequestlab.celery_config beat -l INFO --scheduler django_celery_beat.schedulers:DatabaseScheduler -f celery_beat.log & --detach

python3 manage.py runserver 0.0.0.0:8000

tail -f /dev/null
