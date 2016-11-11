FROM valum/valum:latest

RUN apt-get update && apt-get install -y \
    libvaladoc-dev                       \
    unzip                                \
    valadoc

WORKDIR /valadoc-org
ADD . .

RUN make app

ENTRYPOINT ./app --port=7777 --any
