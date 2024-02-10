FROM golang:latest as go-builder
MAINTAINER Valentin Kuznetsov vkuznet@gmail.com

# build procedure
ENV PROJECT=DataBookkeeping
ENV WDIR=/data
WORKDIR $WDIR
RUN mkdir /build
RUN git clone https://github.com/CHESSComputing/$PROJECT
ARG CGO_ENABLED=0
RUN cd $PROJECT && make && cp srv /build

# build final image for given image
# FROM alpine as final
# RUN mkdir -p /data
FROM gcr.io/distroless/static as final
COPY --from=go-builder /build/srv /data
LABEL org.opencontainers.image.description="FOXDEN DataBookkeeping service"
LABEL org.opencontainers.image.source=https://github.com/chesscomputing/databookkeeping
LABEL org.opencontainers.image.licenses=MIT