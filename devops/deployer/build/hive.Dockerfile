FROM <% docker.base %>
MAINTAINER <% maintainer %>

ENV GOPATH /go

COPY go_setup /root/
RUN /root/go_setup
COPY deployer /go/src/deployer
WORKDIR /go/src/deployer
RUN go build -v
RUN go install -v
RUN go test
ENV DEPLOYER_VERSION "<% version.major %>.<% version.minor %>.<% cli.build %>"

ENTRYPOINT ["deployer"]
