@update-contributors:
	echo 'Removing old CONTRIBUTORS.md'
	mv CONTRIBUTORS.md CONTRIBUTORS.md.bak
	echo 'Downloading a list of new contributors'
	echo "The following is a list of contributors in alphabetical order:" > CONTRIBUTORS.md
	echo "" >> CONTRIBUTORS.md
	echo "" >> CONTRIBUTORS.md
	githubcontrib --owner kbknapp --repo cargo-outdated --sha master --cols 6 --format md --showlogin true --sortBy login >> CONTRIBUTORS.md
	rm CONTRIBUTORS.md.bak

run-test TEST:
	cargo test --test {{TEST}}

debug TEST:
	cargo test --test {{TEST}} --features debug

run-tests:
	cargo test --features "yaml unstable"

nightly:
	rustup override add nightly

rm-nightly:
	rustup override remove

@lint: nightly
	cargo build --features lints && just rm-nightly

clean:
	cargo clean
	find . -type f -name "*.orig" -exec rm {} \;
	find . -type f -name "*.bk" -exec rm {} \;
	find . -type f -name ".*~" -exec rm {} \;
