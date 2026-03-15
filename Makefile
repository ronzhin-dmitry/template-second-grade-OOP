CMAKE ?= cmake
BUILD_DIR ?= build
BUILD_TYPE ?= Debug
GENERATOR ?= Unix Makefiles

.PHONY: help configure build test clean rebuild vs vs-build vs-test

help:
	@echo "Targets:"
	@echo "  make configure   - configure CMake in $(BUILD_DIR)"
	@echo "  make build       - build project"
	@echo "  make test        - run tests via CTest"
	@echo "  make clean       - remove build directory"
	@echo "  make rebuild     - clean, configure, build, test"
	@echo "  make vs          - generate Visual Studio 2022 solution in build-vs/"
	@echo "  make vs-build    - build Visual Studio solution"
	@echo "  make vs-test     - run tests from Visual Studio build"

configure:
	$(CMAKE) -S . -B $(BUILD_DIR) -G "$(GENERATOR)" -DCMAKE_BUILD_TYPE=$(BUILD_TYPE)

build: configure
	$(CMAKE) --build $(BUILD_DIR) --config $(BUILD_TYPE)

test: build
	cd $(BUILD_DIR) && ctest --output-on-failure -C $(BUILD_TYPE)

clean:
	$(CMAKE) -E rm -rf $(BUILD_DIR) build-vs

rebuild: clean build test

vs:
	$(CMAKE) -S . -B build-vs -G "Visual Studio 17 2022" -A x64

vs-build: vs
	$(CMAKE) --build build-vs --config $(BUILD_TYPE)

vs-test: vs-build
	cd build-vs && ctest --output-on-failure -C $(BUILD_TYPE)
