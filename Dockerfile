FROM ubuntu:24.04

# Set environment variables
ENV PYTHONUNBUFFERED=1 

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    tar \
    python3-pip \
    python3-venv \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

RUN python3 -m venv /app/venv \
    && . /app/venv/bin/activate \
    && pip install --upgrade pip

RUN . /app/venv/bin/activate && pip install setuptools

# Clone and install vrs-python with extras
RUN git clone --depth=1 https://github.com/ga4gh/vrs-python.git /app/vrs-python \
    && cd /app/vrs-python \
    && . /app/venv/bin/activate && pip install .[extras]

# Download and extract seqrepo data
RUN wget -O /app/seqrepo.tar.gz https://storage.googleapis.com/clingen-public/seqrepo_2024-12-20.tar.gz \
    && tar -xzf /app/seqrepo.tar.gz -C /app \
    && rm /app/seqrepo.tar.gz

# Verify installation
RUN . /app/venv/bin/activate && python3 -c "import ga4gh.vrs; print('VRS installed successfully:', ga4gh.vrs.__version__)"

ENV VIRTUAL_ENV=/app/venv
ENV PATH=/app/venv:$PATH
# Set default command
#ENTRYPOINT vrs-annotate vcf --dataproxy-uri seqrepo+file:///app/2024-12-20 --vcf-out 

ENTRYPOINT ["/app/venv/bin/vrs-annotate", "vcf", "--dataproxy-uri", "seqrepo+file:///app/2024-12-20", "--vcf-out"]
