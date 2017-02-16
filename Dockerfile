FROM golang

ENV HOME /root
ADD . /root
WORKDIR /root
CMD ["go","test"]