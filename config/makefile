.PHONY: all
all: Dockerfile

Dockerfile: config.dkr config.sh pass.txt
	cp config.dkr $@

pass.txt:
	shadowpass 6 > $@

.PHONY: clean
clean:
	rm -f pass.txt Dockerfile
