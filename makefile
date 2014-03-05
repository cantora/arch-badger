.PHONY: all
all: image

.PHONY: image
image: Dockerfile
	@if [ -f .image ]; then \
		echo 'build arch-badger' \
		  && docker build -t 'arch-badger' .; \
	else \
		echo 're-build arch-badger' \
		  && docker build --no-cache -t 'arch-badger' .; \
	fi
	touch .image

Dockerfile: system/Dockerfile config/Dockerfile user/Dockerfile
	echo 'FROM cantora/arch' >> .dockerfile
	echo 'RUN mkdir /root/docker-build/' >> .dockerfile
	cat .dockerfile $+ > $@ && rm -f .dockerfile

system/Dockerfile:
	$(MAKE) -C system $(MFLAGS)

config/Dockerfile: system/Dockerfile
	$(MAKE) -C config $(MFLAGS)

user/Dockerfile: config/Dockerfile

.PHONY: clean
clean:
	$(MAKE) -C system $(MFLAGS) clean
	$(MAKE) -C config $(MFLAGS) clean
	rm -f .image Dockerfile .dockerfile
