FROM python:3.8.12-bullseye
RUN pip install dbt==0.19

ENTRYPOINT [ "bash" ]