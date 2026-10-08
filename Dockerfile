# Build Stage
FROM python:3.9-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --target=/app/deps
COPY . .

# Final Distroless Runtime Stage
FROM gcr.io/distroless/python3-debian11
WORKDIR /app
COPY --from=builder /app/deps /app/deps
COPY --from=builder /app .
ENV PYTHONPATH="/app/deps"
EXPOSE 80
CMD ["run.py"]
