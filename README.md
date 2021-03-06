# Vulkan SDK with Bazel

## Installation

rules_vulkan relies on [rules_7zip](https://github.com/zaucy/rules_7zip) for extracting the vulkan sdk on windows

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_zaucy_rules_7zip",
    strip_prefix = "rules_7zip-e95ba876db445cf2c925c02c4bc18ed37a503fd8",
    url = "https://github.com/zaucy/rules_7zip/archive/e95ba876db445cf2c925c02c4bc18ed37a503fd8.zip",
    sha256 = "b66e1c712577b0c029d4c94228dba9c8aacdcdeb88c3b1eeeffd00247ba5a856",
)

load("@com_github_zaucy_rules_7zip//:setup.bzl", "setup_7zip")
setup_7zip()

http_archive(
    name = "com_github_zaucy_rules_vulkan",
    strip_prefix = "rules_vulkan-56fcc35f4def06de53ba36b2c5bd3ff20fcb43cf",
    url = "https://github.com/zaucy/rules_vulkan/archive/56fcc35f4def06de53ba36b2c5bd3ff20fcb43cf.zip",
    sha256 = "bc4b3aa29e30f11144fbc3254b86bb1fb735e01fbe6dfce5857fcb6fdf5b6952",
)

load("@com_github_zaucy_rules_vulkan//:repo.bzl", "vulkan_repos")
vulkan_repos()

```

## License

This repository is licensed under MIT. Please note that rules_vulkan downloads the Vulkan SDK from [LunarG](https://www.lunarg.com/) which has it's own licenses and agreements you must adhere to.
