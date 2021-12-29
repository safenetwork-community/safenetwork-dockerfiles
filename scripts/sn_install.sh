#!/bin/bash

die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='oh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

_positionals=()

print_help()
{
	printf 'Usage: %s [-h|--help] <node-version> <api-version> <cli-version> \n' "$0"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done
}


handle_passed_args_count()
{
	local _required_args_string="'node-version' and 'api-version' and 'cli-version'"
	test "${_positionals_count}" -ge 3 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require exactly 3, but got only ${_positionals_count}." 1
	test "${_positionals_count}" -le 3 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect exactly 3, but got ${_positionals_count} (the last one was: '${_last_positional}')." 1
}


assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_node_version _arg_api_version _arg_cli_version"

	shift "$_shift_for"
	for _positional_name in ${_positional_names}
	do
		test $# -gt 0 || break
		eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
		shift
	done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

PLATFORM_ARCH=`uname -m`

case "$PLATFORM_ARCH" in
  "armv7l")
  PLATFORM_ARCH="armv7-unknown-linux-musleabihf"
  ;;
  "armv6l")
  PLATFORM_ARCH="arm-unknown-linux-musleabi"
  ;;
  *)
  PLATFORM_ARCH=$PLATFORM_ARCH"-unknown-linux-musl"
  ;;
esac

# Create safe folders
mkdir -p ~/.safe/{bin,cli,node}

# Install the safe network
curl -L https://github.com/maidsafe/safe_network/releases/download/$_arg_node_version-$_arg_api_version-$_arg_cli_version/sn_cli-$_arg_cli_version-$PLATFORM_ARCH.tar.gz | \
  tar xz -C ~/.safe/
curl -L https://github.com/maidsafe/safe_network/releases/download/$_arg_node_version-$_arg_api_version-$_arg_cli_version/sn_node-$_arg_node_version-$PLATFORM_ARCH.tar.gz | \
  tar xz -C ~/.safe/node/

chmod a+x ~/.safe/safe
chmod a+x ~/.safe/node/sn_node

# Add .bashrc and .bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/src/shared_files/.bash_profile -o ~/.bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/src/shared_files/.bashrc -o ~/.bashrc

# Add bin files
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/src/shared_files/.safe/bin/sn_nodebin.sh -o ~/.safe/bin/sn_nodebin.sh
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/src/shared_files/.safe/bin/sn_networkbin.sh -o ~/.safe/bin/sn_networkbin.sh



