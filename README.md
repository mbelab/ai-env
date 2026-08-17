# ai-env

Environment for local AI usage.

**Maintainer:** [Michael Berghammer](mailto:info@mbelab.de)

- [usage](#usage)
- [backend](#backend)
- [frontend](#frontend)
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
    $ source .envrc

    # Prepare system and build llama.cpp (default backend)
    $ setup_system.sh
    $ build_llama_cpp.sh

    # Download model, open WebUI and run model
    $ model_mgr.sh download 'gpt-oss-20b-Q6_K'
    $ run_webui.sh
    $ run_server.sh 'gpt-oss-20b-Q6_K'

## backend

This environment is based on **llama.cpp**, a powerful implementation for LLM inference in C/C++ with different backend options.
It natively supports an optimized CPU backend, which is especially great for quantized models.

To use other backends e.g. with GPU support, one can add the corresponding flag to scripts:

- `setup_system.sh`
- `build_llama_cpp.sh`
- `build_llama_cpp_py.sh`

Currently supported backends by this environment:

- Native-CPU (default, generic CPU)
- OpenBLAS (`--openblas`, generic CPU)
- Vulkan (`--vulkan`, generic GPU)
- CUDA (`--cuda`, NVIDIA GPU)

> **Note:** **llama.cpp** implements many more backends, but not all are easy to use and supported by this environment.

## frontend

Since the backend provides a common API, most existing frontend implementations can be used.
There are several frontend supported by this environment.

**llama.cpp** native/included:

- llama-cli (cli chat): `run_cli.sh`
- llama-ui (web ui): `run_webui.sh`
- llama-bench (benchmark): `run_bench.sh`

Additional frontends:

- [Kilo Code](https://kilo.ai) (VS Code extension and CLI agent)
- [OpenCode](https://opencode.ai) (Standalone AI-Coding-Agent)

This environment suggests usage of a common alias for any running model, which is then used for e.g. Kilo Code.
Since it is mandatory to use the model alias, one can simply run any models and Kilo Code connects to it automatically due to the common alias `ai-env`.

## environment

This environment is shell based and provides command-line scripts and tools.

To prepare shell, e.g. bash, simply source the provided *.envrc* file:

    $ source .envrc

### bin

Scripts and tools for AI environment.

| Script / Tool | Description |
| ----- | ----- |
| `model_mgr.sh` | Tool for simple model management |
| `run_webui.sh` | Run WebUI |
| `run_server.sh` | Run server in router mode or with dedicated model |
| `run_cli.sh` | Run model in CLI |
| `run_bench.sh` | Run model in benchmark |
| `get_opencode.sh` | Download OpenCode AppImage |
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
