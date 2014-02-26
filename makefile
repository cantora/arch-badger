SETUP_FILES        = $(wildcard setup/*)
KEYRING_FILES      = $(wildcard setup/blackarch-keyring.pkg.tar.xz*)

.PHONY: all
all: image

.PHONY: image
image: setup.tar.gz Dockerfile
	docker build --rm -t 'arch-badger' .

setup.tar.gz: $(SETUP_FILES) verify_keyring
	cd setup && tar -cvzf ../setup.tar.gz *

.PHONY: verify_keyring
verify_keyring: $(KEYRING_FILES)
	cd setup && gpg --verify blackarch-keyring.pkg.tar.xz.sig

.PHONY: clean
clean:
	rm -f setup.tar.gz
