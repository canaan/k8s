# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

all:

TAG = 1.0
PREFIX = bprashanth/nginxhttps
KEY = /tmp/nginx.key
CERT = /tmp/nginx.crt
SECRET = /tmp/secret.json

keys:
	# The CName used here is specific to the service specified in nginx-app.yaml.
	openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout $(KEY) -out $(CERT) -subj "/CN=nginxsvc/O=nginxsvc"

container:
	docker build --pull -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	rm $(KEY)
	rm $(CERT)
