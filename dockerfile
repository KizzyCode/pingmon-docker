FROM alpine:latest
COPY ./pingmon.sh /usr/bin/pingmon.sh
CMD [ "/usr/bin/pingmon.sh" ]
