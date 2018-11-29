TAG=heycar/pghero:0.3.0

build:
	rm -Rf pghero/
	git clone git@github.com:hey-car/pghero.git ./pghero
	docker build -f Dockerfile -t ${TAG} .
	docker push ${TAG}

