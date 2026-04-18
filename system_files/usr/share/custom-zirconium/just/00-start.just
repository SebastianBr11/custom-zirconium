default:
    @czjust --choose

install-kitty:
    #!/usr/bin/env bash
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

uninstall-kitty:
    #!/usr/bin/env bash
    rm -rf ~/.local/kitty.app/
