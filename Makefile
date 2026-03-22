.PHONY: test-install-tart

test-install-tart:
	brew install cirruslabs/cli/tart
	tart clone ghcr.io/cirruslabs/macos-tahoe-base:latest tahoe-base
	tart run tahoe-base
