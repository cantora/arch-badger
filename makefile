SETUP_FILES        = $(wildcard setup/*)
KEYRING_FILES      = $(wildcard setup/blackarch-keyring.pkg.tar.xz*)

.PHONY: all
all: image

.PHONY: image
image: setup.tar.gz Dockerfile
	if [ -f .image ]; then \
		docker build -t 'arch-badger' .; \
	else \
		docker build --no-cache -t 'arch-badger' .; \
	fi
	touch .image

setup/pass.txt:
	shadowpass 6 > $@

setup.tar.gz: setup/pass.txt $(SETUP_FILES) .verify_keyring
	cd setup && tar -cvzf ../setup.tar.gz *

.verify_keyring: $(KEYRING_FILES)
	cd setup && gpg --verify blackarch-keyring.pkg.tar.xz.sig
	touch $@

.PHONY: clean
clean:
	rm -f setup.tar.gz .image .verify_keyring setup/pass.txt
