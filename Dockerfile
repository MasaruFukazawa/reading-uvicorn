FROM python:3.11-slim

WORKDIR /docs

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    make \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p build

EXPOSE 9001

CMD ["sphinx-autobuild", "source", "build/html", "--host", "0.0.0.0", "--port", "9001"]
