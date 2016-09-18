FROM <% deployer.base %>
MAINTAINER <% maintainer %>

COPY deployer /go/src/deployer
WORKDIR /go/src/deployer
RUN go get -v ...
RUN go build -v

ENTRYPOINT ["deployer"]
