#!/bin/bash

# Wisecow - A web server that serves fortune cookies with cowsay
# Default port
PORT=${PORT:-4499}

# Function to generate response
generate_response() {
    # Generate fortune and pipe it through cowsay
    fortune | cowsay
}

# Function to handle HTTP request
handle_request() {
    # Read the request (we don't really parse it, just consume it)
    while read -r line; do
        # Break on empty line (end of HTTP headers)
        [ -z "$line" ] && break
    done
    
    # Generate the cow wisdom
    cow_output=$(generate_response)
    
    # Send HTTP response
    echo -e "HTTP/1.1 200 OK\r"
    echo -e "Content-Type: text/html\r"
    echo -e "Connection: close\r"
    echo -e "\r"
    echo "<html>"
    echo "<head><title>Wisecow</title></head>"
    echo "<body>"
    echo "<h1>Cow Wisdom</h1>"
    echo "<pre>$cow_output</pre>"
    echo "</body>"
    echo "</html>"
}

# Main server loop
echo "Starting Wisecow server on port $PORT..."

# Start the server using netcat
while true; do
    # Use netcat to listen and pipe to our handler
    handle_request | nc -l -p $PORT -q 1
done

