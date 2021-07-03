all: deploy

version:
	$(eval VERSION = $(shell git log -1 --pretty=format:"%h"))
build: clean
	hugo -D
clean:
	rm -rf public/
image: build version
	docker build . -t i.rocm.in/tivizi:${VERSION}
	docker push i.rocm.in/tivizi:${VERSION}
deploy: image
	kubectl set image -n tivizi deployment/tivizi tivizi-cn=i.rocm.in/tivizi:${VERSION}

