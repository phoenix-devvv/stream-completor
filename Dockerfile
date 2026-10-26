FROM node:22-bookworm-slim

WORKDIR /app

# Build tools + FFmpeg (glibc-based, so node-av's prebuilt binary loads fine)
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3 make g++ ffmpeg ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

# Generate dummy video if not already present
RUN node -e "import('./src/media.js').then(m => m.ensureDummyMedia())"

CMD ["npm", "start"]
