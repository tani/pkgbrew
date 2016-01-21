TARGETS = pkgbrew installer

all: $(TARGETS)

$(TARGETS): %: src/%.sh
	perl bin/compile.pl $^ > $@
	chmod +x $@
	mv $@ bin/

.PHONY: clean

clean:
	rm -rf bin/installer bin/pkgbrew *~ */*~

test: $(TARGETS)
	sh bin/test.sh
