FROM debian:bullseye-slim

# Install dependencies
RUN apt update && apt install software-properties-common wget curl git openssh-client tmate python3 sudo neofetch -y && apt clean
# Create a dummy index page to keep the service alive
RUN mkdir -p /app && echo "Tmate Session Running..." > /app/index.html
WORKDIR /app

# Expose a fake web port to trick Railway into keeping container alive
EXPOSE 6080
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh
# Start a dummy Python web server to keep Railway service active
# and start tmate session
CMD python3 -m http.server 6080 & \
    tmate -F
