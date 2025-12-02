# Используем Node.js 16, который совместим с вашим проектом
FROM node:16-alpine AS build

WORKDIR /app

COPY package*.json ./

# Устанавливаем зависимости с legacy-peer-deps
RUN npm install --legacy-peer-deps

COPY . .

# Собираем приложение
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
