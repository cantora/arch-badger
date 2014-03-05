KEYRING_FILES      = $(wildcard keyring/blackarch-keyring.pkg.tar.xz*)

.PHONY: all
all: Dockerfile

Dockerfile: system.dkr system.sh keyring.tar.gz
	cp system.dkr $@

keyring.tar.gz: $(KEYRING_FILES) .verify_keyring
	cd keyring && tar -cvzf ../keyring.tar.gz *

.verify_keyring: $(KEYRING_FILES)
	cd keyring && gpg --verify blackarch-keyring.pkg.tar.xz.sig
	touch $@

.PHONY: clean
clean:
	rm -f Dockerfile keyring.tar.gz .verify_keyring
