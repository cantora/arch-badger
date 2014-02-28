SETUP_FILES        = $(wildcard setup/*)
KEYRING_FILES      = $(wildcard setup/blackarch-keyring.pkg.tar.xz*)

.PHONY: all
all: image

.PHONY: image
image: setup.tar.gz Dockerfile
	docker build --no-cache --rm -t 'arch-badger' .

Dockerfile: Dockerfile.in
	cryptpass=$$(shadowpass 6) && \
	test -n "$$cryptpass" && \
	cog.py -ed \
		-D cryptpass="$$cryptpass" \
		-o $@ $<

setup.tar.gz: $(SETUP_FILES) verify_keyring
	cd setup && tar -cvzf ../setup.tar.gz *

.PHONY: verify_keyring
verify_keyring: $(KEYRING_FILES)
	cd setup && gpg --verify blackarch-keyring.pkg.tar.xz.sig

.PHONY: clean
clean:
	rm -f setup.tar.gz Dockerfile
