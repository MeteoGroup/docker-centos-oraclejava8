push: javaimage
	docker push meteogroup/centos-oraclejava8
	touch push

javaimage: Dockerfile
	docker pull meteogroup/centos:7
	cat Dockerfile | docker build --rm -t meteogroup/centos-oraclejava8 -
	touch javaimage
