#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/pulumi/crd2pulumi"
TOOL_NAME="crd2pulumi"
TOOL_TEST="crd2pulumi version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if crd2pulumi is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

get_arch() {
  local arch=$(uname -m)
  case $arch in
  amd64 | x86_64)
    echo "amd64"
    ;;
  arm64)
    echo "arm64"
    ;;
  *)
    echo ""
    ;;
  esac
}

get_platform() {
  [ "Linux" = "$(uname)" ] && echo "linux" || echo "darwin"
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  arch=$(get_arch)
  if [ -z "$arch" ]; then
    fail "Unsupported architecture: $arch"
  fi
  echo "Detected architecture: $arch"

  platform=$(get_platform)
  if [ -z "$platform" ]; then
    fail "Unsupported platform: $platform"
  fi
  echo "Detected platform: $platform"

  archive="crd2pulumi-v${version}-${platform}-${arch}.tar.gz"
  url="$GH_REPO/releases/download/v${version}/${archive}"

  echo "* Downloading $TOOL_NAME release $version..."
  echo "* Fetching release asset ${archive} on GitHub..."

  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp "$ASDF_DOWNLOAD_PATH"/crd2pulumi "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
