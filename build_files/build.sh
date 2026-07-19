#!/bin/bash

set -ouex pipefail

cp -avf "/ctx/system"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y \
  tmux \
  yq

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# Can't use zen-browser from Flathub, since it wouldn't work well with KeepassXC
dnf5 -y copr enable sneexy/zen-browser
dnf5 -y install zen-browser
dnf5 -y copr disable sneexy/zen-browser

. /ctx/patch-zdots.sh

systemctl preset-all
systemctl preset-all --global

# terra repos break bib's depsolver regardless (releasever mismatch inside
# the builder container) — disable them outright.
# Source: https://github.com/chulsaheng/techoos/blob/main/build_files/build.sh#L245
# See also: https://github.com/ublue-os/image-template/issues/196
for repo in /etc/yum.repos.d/terra*.repo; do
  [ -e "$repo" ] || continue
  echo "Disabling $repo (terra repos break ISO depsolve)"
  sed -i 's/^enabled[[:space:]]*=[[:space:]]*1/enabled=0/' "$repo"
done
