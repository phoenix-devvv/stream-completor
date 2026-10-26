FROM node:22-trixie-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
      python3 make g++ ffmpeg ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

RUN node -e "import('./src/media.js').then(m => m.ensureDummyMedia())"

CMD ["npm", "start"]
