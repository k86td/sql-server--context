FROM mcr.microsoft.com/mssql/server:2019-CU15-ubuntu-20.04

USER root

RUN mkdir -p /usr/local/src
WORKDIR /usr/local/src
COPY . /usr/local/src

RUN chmod +x /usr/local/src/context-builder.sh
RUN chmod +x /usr/local/src/entrypoint.sh

ENV ACCEPT_EULA "Y"
ENV SA_PASSWORD "\$RandomSAPass123"
ENV ADMIN_PASSWORD "\$AdminRandomPass123"
ENV MSSQL_PID "Express"

EXPOSE 1433

CMD ./entrypoint.sh "sa" $SA_PASSWORD "admin" $ADMIN_PASSWORD

