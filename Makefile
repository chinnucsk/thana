STAMPS := stamps
STAMP_COMPILE := $(STAMPS)/stamp-compile
STAMP_GENERATE := $(STAMPS)/stamp-generate

$(STAMP_COMPILE):
	rebar compile
	@mkdir -p $(@D)
	touch $@

compile: $(STAMP_COMPILE)

$(STAMP_GENERATE): $(STAMP_COMPILE)
	rebar generate
	@mkdir -p $(@D)
	touch $@

generate: $(STAMP_GENERATE)

run: $(STAMP_GENERATE)
	rel/thana/bin/thana console

clean:
	rebar clean
	rm -rf $(STAMPS)

.PHONY: clean compile generate run
