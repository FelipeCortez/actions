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

echo $(pwd)
echo "trying to rewrite project.clj"
cat project.clj
clojure -Sdeps '{:deps {rewrite-clj {:mvn/version "0.6.1"}}}' /rewrite_projectclj.clj
echo "was it rewritten?"
cat project.clj
git checkout -- project.clj
_lint_and_fix_action cljfmt "${@}"
