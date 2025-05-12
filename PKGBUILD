# Maintainer: Neterial <info@neterial.io>

pkgname=neterial-cli
pkgver=0.1.0
pkgrel=1
pkgdesc="CLI for Neterial services"
arch=('x86_64')
url="https://docs.neterial.io/#/CLI"
license=('custom:commercial')
provides=('neterial')
conflicts=('neterial')
options=(!strip !debug)

source_x86_64=("https://github.com/neterialio/cli/releases/download/v${pkgver}/neterial-v${pkgver}-linux-amd64.tar.gz")
sha256sums_x86_64=('f19fee64ea24b769d4997d470c025072346da269dbeec57ffcb8c8c449cfe990')

package() {
  cd "${srcdir}"
  install -Dm755 neterial "${pkgdir}/usr/bin/neterial"

  # Generate shell completions
  mkdir -p "${pkgdir}/usr/share/bash-completion/completions"
  mkdir -p "${pkgdir}/usr/share/zsh/site-functions"
  mkdir -p "${pkgdir}/usr/share/fish/vendor_completions.d"

  "${pkgdir}/usr/bin/neterial" completion bash > "${pkgdir}/usr/share/bash-completion/completions/neterial"
  "${pkgdir}/usr/bin/neterial" completion zsh > "${pkgdir}/usr/share/zsh/site-functions/_neterial"
  "${pkgdir}/usr/bin/neterial" completion fish > "${pkgdir}/usr/share/fish/vendor_completions.d/neterial.fish"
}
