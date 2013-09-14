STAMPS := stamps
STAMP_DEPS := $(STAMPS)/stamp-deps
STAMP_COMPILE := $(STAMPS)/stamp-compile
STAMP_GENERATE := $(STAMPS)/stamp-generate

$(STAMP_DEPS):
	rebar get-deps
	@mkdir -p $(@D)
	touch $@

deps: $(STAMP_DEPS)

$(STAMP_COMPILE): $(STAMP_DEPS)
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
	rm -rf $(STAMPS) deps

.PHONY: clean compile generate run deps
