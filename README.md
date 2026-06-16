# ai-env

Environment for local AI usage.

**Maintainer:** [Michael Berghammer](mailto:info@mbelab.de)

- [usage](#usage)
- [frontend](#frontend)
- [backend](#backend)
- [environment](#environment)
  - [bin](#bin)
  - [data](#data)
  - [llama.cpp](#llamacpp)

> **Note:** Files in subdirectories named *private* are not tracked by Git.

## usage

    # Prepare environment
    $ git clone ssh://git@codeberg.org/mbelab/ai-env.git
    $ cd ai-env
    $ git checkout main
    $ git submodule update --init --recursive

    # Prepare system and build llama.cpp (default backend)
    $ ./bin/setup_system.sh
    $ ./bin/build_llama_cpp.sh

    # Download model, open WebUI and run model
    $ ./bin/model_mgr.sh download 'gpt-oss-20b-Q6_K'
    $ ./bin/run_webui.sh
    $ ./bin/run_server.sh 'gpt-oss-20b-Q6_K'

## frontend

Since the backend provides a common API, most existing frontend implementations can be used.

Currently supported frontends by this environment:

- CLI: `run_cli.sh`
- WebUI: `run_webui.sh` / `run_server.sh`
- VS Code / Continue: `run_server.sh`
- Benchmark (only for test purpose): `run_bench.sh`

Continue is a VS Code IDE extension for agentic usage of LLMs via different backends.

A working config is provided in [config.yaml](./.continue/agents/config.yaml).

This environment suggests usage of a common alias for any running model, which is then used for Continue.
Since it is mandatory to use the model alias for Continue, one can simply run any models and Continue connects to it automatically due to the common alias `ai-env`.

## backend

This environment is based on *llama.cpp*, a powerful implementation for LLM inference in C/C++ with different backend options.

The suggested default backend by this environment is OpenBLAS (generic CPU).

To use other backends, one can add the corresponding flag to scripts:

- `setup_system.sh`
- `build_llama_cpp.sh`
- `build_llama_cpp_py.sh`

Currently supported backends by this environment:

- OpenBLAS (default, generic CPU)
- Vulkan (`--vulkan`, generic GPU)

> **Note:** *llama.cpp* implements many more backends, but not all are easy to use and supported by this environment.

## environment

### bin

Scripts and tools for AI environment.

| Script / Tool | Description |
| ----- | ----- |
| `model_mgr.sh` | Tool for simple model management |
| `run_webui.sh` | Run WebUI |
| `run_server.sh` | Run model as server |
| `run_cli.sh` | Run model on CLI |
| `run_bench.sh` | Run model in benchmark |
| `build_llama_cpp.sh` | Build llama.cpp for local usage |
| `clean_llama_cpp.sh` | Clean llama.cpp build |
| `setup_system.sh` | Setup script for system packages (apt) |
| `build_llama_cpp_py.sh` | Build llama-cpp-python for active virtual python env |
| `setup_python_venv.sh` | Setup virtual python env |
| `clean_python_venv.sh` | Clean virtual python env |

### data

Data for AI environment.

#### model_list.json

A curated list of models, usable with scripts in *bin*.

#### models

Directory for AI model files in e.g. `gguf` format.

> **Note:** Files in this directory except *.gitkeep* are ignored by Git.

### llama.cpp

See [README](./llama.cpp/README.md).

> **Note:** The submodule *llama.cpp* is hosted on GitHub (see URL). This may be changed later.
