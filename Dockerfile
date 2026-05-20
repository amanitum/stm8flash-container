# === Build stage: compile stm8flash ===
FROM ubuntu:24.04 AS builder

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        libusb-1.0-0-dev \
        git \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Clone the official repository
WORKDIR /opt/stm8flash
RUN git clone https://github.com/vdudouyt/stm8flash.git . && \
    # Optional: pin to a specific commit for reproducibility (latest as of 2026‑05‑19)
    git checkout 519d8d23d0b79bd9bd1ca48d8fcf3b27bf079444

# Build the executable
RUN make

# === Runtime stage: minimal final image ===
FROM ubuntu:24.04

# Install only the runtime dependency (libusb)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libusb-1.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy the pre‑built binary from the builder stage
COPY --from=builder /opt/stm8flash/stm8flash /usr/local/bin/

# Create a non‑root user for better security
RUN groupadd -r stm8flash && useradd -r -g stm8flash stm8flash
USER stm8flash

# Set the default command
ENTRYPOINT ["stm8flash"]
CMD ["--help"]
