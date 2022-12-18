FROM quay.io/centos/centos:stream9 AS build
WORKDIR /src
RUN yum -y install golang
COPY . .
RUN make

FROM quay.io/centos/centos:stream9
COPY --from=build /src/node-port-controller .
ENTRYPOINT ["/node-port-controller"]