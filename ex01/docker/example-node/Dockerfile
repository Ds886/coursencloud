FROM node:18 AS build

COPY . /opt
WORKDIR /opt
RUN npm run clean && npm install && npm run build 

FROM node:18-alpine AS runtime
WORKDIR /app
COPY --from=build /opt/dist /app
RUN npm install -g serve
CMD ["serve" ]


