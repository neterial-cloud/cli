# Maintainer: Neterial <info@neterial.io>

pkgname=neterial-cli
pkgver=0.3.0
pkgrel=1
pkgdesc="CLI for Neterial services"
arch=('x86_64')
url="https://docs.neterial.io/#/CLI"
license=('custom:commercial')
provides=('neterial')
conflicts=('neterial')
options=(!strip !debug)

source_x86_64=("https://github.com/neterialio/cli/releases/download/v${pkgver}/neterial-v${pkgver}-linux-amd64.tar.gz")
sha256sums_x86_64=('68fe2bbdf18ff7cbd2b704719d3be20b70be5621c0d50f87cd3b9b11769203bc')

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
