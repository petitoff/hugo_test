# Use the official extended Hugo base image
FROM klakegg/hugo:ext as builder

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the content of your repository into the container
COPY . .

# Build the site with Hugo
RUN hugo

# Use nginx to serve the site
FROM nginx:alpine

# Copy the built site from the Hugo builder stage
COPY --from=builder /usr/src/app/public /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
