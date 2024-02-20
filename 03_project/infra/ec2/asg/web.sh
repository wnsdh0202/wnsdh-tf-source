#!/bin/bash
cat > index.html <<EOF
<h1>Hello World</h1>
EOF

# echo "Hello World" > index.html
nohup busybox httpd -f -p ${web_port} &