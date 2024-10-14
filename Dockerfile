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