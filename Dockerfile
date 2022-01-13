FROM python:3

ARG org_label_schema_schema_version=1.0
ARG org_label_schema_name=tensorflow-hub-make_image_classifier
ARG org_label_schema_description=This container will setup an environment that allows you to run the tensorflow-hub make_image_classifier python scripts and tools to retrain image classification using your own datasets.
ARG org_label_schema_version
ARG org_label_schema_vcs_url=https://github.com/xitation/tensorflow-hub-make_image_classifier
ARG org_label_schema_build_date
ARG org_label_schema_maintainer=xitation@gmail.com
ARG org_lable_schema_url="https://github.com/tensorflow/hub/tree/master/tensorflow_hub/tools/make_image_classifier"

LABEL org.label-schema.schema-version=$org_label_schema_schema_version \
      org.label-schema.name=$org_label_schema_name \
      org.label-schema.description=$org_label_schema_description \
      org.label-schema.version=$org_label_schema_version \
      org.label-schema.vcs-url=$org_label_schema_vcs_url \
      org.label-schema.build-date=$org_label_schema_build_date \
      org.label-schema.maintainer=$org_label_schema_maintainer \
      org.label-schema.url=$org_lable_schema_url

WORKDIR .

COPY build_files/requirements.txt build_files/entrypoint.sh ./

RUN chmod 755 entrypoint.sh
RUN /usr/local/bin/python -m pip install --upgrade pip \
    pip install --no-cache-dir -r requirements.txt

CMD [ "./entrypoint.sh" ]
