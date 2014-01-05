set -e

cd examples/activerecord
BUNDLE_GEMFILE=$PWD/Gemfile
bundle
bundle exec crspec
