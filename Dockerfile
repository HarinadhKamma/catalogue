FROM node:24.12.0-alpine3.22 AS build
WORKDIR /opt/server
COPY *.json .
COPY *.js .
RUN npm install



FROM node:24.12.0-alpine3.22
WORKDIR /opt/server
EXPOSE 8080
# Create a group and user
RUN addgroup -S robosho && adduser -S roboshop -G roboshop 
LABEL com.project="roboshop" \
    component="catalogue" \
    craetedby="hari"
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue" 
COPY --from=build -chown=roboshop:roboshop /opt/server /opt/server/
USER roboshop
CMD ["server.js"]
ENTRYPOINT [ "node" ]