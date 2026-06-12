# ai-env

Environment for local AI usage.

**Maintainer:** [Michael Berghammer](mailto:info@mbelab.de)

> **Note:** Files in subdirectories named *private* are not tracked by Git.

## usage

    # Prepare environment
    $ git clone ssh://git@codeberg.org/mbelab/ai-env.git
    $ cd ai-env
    $ git checkout main
    $ git submodule update --init --recursive

    # Prepare system and build llama.cpp (OpenBLAS backend)
    $ ./bin/setup_system.sh
    $ ./bin/build_llama_cpp.sh

    # Download model, run model and open WebUI (Gemma 4 E2B)
    $ ./bin/model_mgr.sh download --model='gemma-4-E2B-it-Q6_K'
    $ ./bin/run_webui.sh 'gemma-4-E2B-it-Q6_K'

## bin

Scripts and tools for AI environment.

| Script / Tool | Description |
| ----- | ----- |
| model_mgr.sh | Tool for simple model management. |
| | |
| run_cli.sh | Run model on CLI. |
| run_webui.sh | Run model as server with WebUI. |
| run_server.sh | Run model as server. |
| run_bench.sh | Run model in benchmark. |
| | |
| build_llama_cpp.sh | Build llama.cpp for local usage. |
| clean_llama_cpp.sh | Clean llama.cpp build. |
| setup_system.sh | Setup script for system packages (apt). |
| | |
| build_llama_cpp_py.sh | Build llama-cpp-python for active virtual python env. |
| setup_python_venv.sh | Setup virtual python env. |
| clean_python_venv.sh | Clean virtual python env. |

## data

Data for AI environment.

### model_list.json

A curated list of models, usable with scripts in *bin*.

### models

Directory for AI model files in e.g. `gguf` format.

> **Note:** Files in this directory except *.gitkeep* are ignored by Git.

## llama.cpp

See [README](./llama.cpp/README.md).

> **Note:** The submodule *llama.cpp* is hosted on GitHub (see URL). This may be changed later.
