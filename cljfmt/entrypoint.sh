#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
source /lib.sh

cljfmt() {
  lein cljfmt "$@"
}

fix() {
  lein cljfmt fix
}

lint() {
	lein cljfmt check
}

clojure -Sdeps '{:deps {rewrite-clj {:mvn/version "0.6.1"}}}' -m fmt
git checkout -- project.clj
_lint_and_fix_action cljfmt "${@}"
