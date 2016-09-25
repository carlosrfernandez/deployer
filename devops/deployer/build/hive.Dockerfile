FROM <% docker.base %>
MAINTAINER <% maintainer %>

ENV GOPATH /go

# Library to manage AWS
RUN go get github.com/aws/aws-sdk-go/...

# Library to manage YAML
RUN go get gopkg.in/yaml.v2

COPY deployer /go/src/deployer
WORKDIR /go/src/deployer
RUN go build -v
RUN go install -v
ENV DEPLOYER_VERSION "<% version.major %>.<% version.minor %>.<% cli.build %>"

ENTRYPOINT ["deployer"]
