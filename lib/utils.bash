#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/creativeprojects/resticprofile"
TOOL_NAME="resticprofile"
TOOL_TEST="--verbose version"

function fail() {
    echo -e "asdf-${TOOL_NAME}: ${*}"
    exit 1
}

# global vars
curl_opts=(-fsSL)

if [[ -n "${GITHUB_API_TOKEN:-}" ]]; then
    curl_opts+=(-H "Authorization: token ${GITHUB_API_TOKEN}")
fi

function sort_versions() {
    sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' \
        | LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

function list_github_tags() {
    git ls-remote --tags --refs "${GH_REPO}" \
        | grep -o 'refs/tags/.*' | cut -d/ -f3- \
        | sed 's/^v//'
}

function list_all_versions() {
    # currently all tags are valid releases, so this works
    list_github_tags
}

function get_platform() {
    local platform arch

    case "$(uname -s)" in
        "Linux")
            platform="unknown-linux-musl"
            ;;
        "*BSD")
            _platform="$(uname -s)"
            platform="${_platform,,}"
            ;;
        "Darwin")
            platform="darwin"
            ;;
    esac

    case "$(uname -m)" in
        "x86_64" | "amd64")
            arch="amd64"
            ;;
        "arm64" | "aarch64")
            arch="arm64"
            ;;
        "arm" | "armv7")
            arch="armv7"
            ;;
    esac

    echo -n "${platform}_${arch}"
}

function download_release() {
    local version download_path url platform release_tar

    version="${1}"
    download_path="${2}"
    platform="$(get_platform)"
    release_tar="${TOOL_NAME}_no_self_update_${version}_${platform}.tar.gz"

    url="${GH_REPO}/releases/download/${version}/${release_tar}"

    mkdir -p "${download_path}"

    echo "* Downloading ${TOOL_NAME} ${version} from ${url}"
    if ! curl "${curl_opts[@]}" -o "${download_path}/${release_tar}" -C - "${url}"; then
        fail "Could not download ${url}"
    fi

    if ! tar -xzf "${download_path}/${release_tar}" -C "${download_path}" "${TOOL_NAME}"; then
        fail "Could not extract ${release_tar}"
    fi
    rm -f "${download_path}/${release_tar}"
}

function install_version() {
    local version install_path download_path

    version="${1}"
    install_path="${2%/bin}/bin"
    download_path="${3}"

    mkdir -p "${install_path}"

    mv -f "${download_path}/${TOOL_NAME}" "${install_path}/${TOOL_NAME}"
    chmod +x "${install_path}/${TOOL_NAME}"

    if [[ ! -x "${install_path}/${TOOL_NAME}" ]]; then
        rm -rf "${install_path}"
        fail "Expected ${install_path}/${TOOL_NAME} to be executable"
    fi
    if ! "${install_path}/${TOOL_NAME}" "${TOOL_TEST}" > /dev/null; then
        rm -rf "${install_path}"
        fail "Error with command: '${TOOL_NAME} ${TOOL_TEST}'"
    fi

    echo "${TOOL_NAME} ${version} installation was successful!"
}
