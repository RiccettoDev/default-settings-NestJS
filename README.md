# Default Settings 

<div style="display: flex; gap: 5px; justify-content: center; align-items: center;">
  <img src="./img/nodejs.png" alt="nodeJs" width="120"/>
  <img src="./img/nestjs.png" alt="nestJs" width="180"/>
  <img src="./img/docker.png" alt="docker" width="100"/>
  <img src="./img/prisma.png" alt="prisma" width="250"/>
  <img src="./img/postgres.png" alt="postgres" width="120"/>
</div>

  <p> Initial configurations of a project with docker, nextJS, prism orm and postgres.</p>
    <p align="center">
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/v/@nestjs/core.svg" alt="NPM Version" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/l/@nestjs/core.svg" alt="Package License" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/dm/@nestjs/common.svg" alt="NPM Downloads" /></a>
<a href="https://circleci.com/gh/nestjs/nest" target="_blank"><img src="https://img.shields.io/circleci/build/github/nestjs/nest/master" alt="CircleCI" /></a>

# Description

## Start project

```bash
nest new 'name-project'
```

## Install Prisma

```bash
npm install @prisma/client
npm install prisma --save-dev
```

## Start Prisma

```bash
npx prisma init
```

## Config ```prisma/schema.prisma```

### -> example:

```bash

generator client {
  provider      = "prisma-client-js"
  binaryTargets = ["native", "linux-arm64-openssl-3.0.x"] // configuration to use docker. without docker you don't need this part
}

datasource db {
  provider = "postgresql" // or another bank
  url      = env("DATABASE_URL")
}

model User {
  id       Int          @id @default(autoincrement())
  name     String       @db.VarChar(100)
  surname  String       @db.VarChar(100)
  email    String       @unique @db.VarChar(100)
  password String       @db.VarChar(100)
  age      Int

  @@map("users")
}

```

## Config file .env

```bash
DATABASE_URL="postgresql://user:password@localhost:5432/mydatabase"
```

## Config file Dockerfile

```bash
# Usar a imagem base do Node.js
FROM node:18

# Criar diretório de trabalho
WORKDIR /usr/src/app

# Copiar o package.json e o package-lock.json
COPY package*.json ./

# Instalar as dependências
RUN npm install

# Copiar o restante da aplicação
COPY . .

# Rodar o Prisma
RUN npx prisma generate

# Expor a porta 3000
EXPOSE 3000

# Iniciar a aplicação
CMD ["npm", "run", "start:dev"]

```

## Config file docker-compose.yml

```bash
version: '3.8'
services:
  postgres:
    image: postgres:14
    container_name: postgres
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydatabase
    ports:
      - '5432:5432'
    volumes:
      - postgres_data:/var/lib/postgresql/data

  nestjs:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - '3000:3000'
    depends_on:
      - postgres
    environment:
      DATABASE_URL: postgres://user:password@postgres:5432/mydatabase
    volumes:
      - .:/usr/src/app

volumes:
  postgres_data:

```

## Generate DB in Prisma

```bash
npx prisma generate
```

## Start application and DB with docker

```bash
docker-compose up --build
```

## Create migrations with Prisma

```bash
npx prisma migrate dev
```

# Next continue development
😆