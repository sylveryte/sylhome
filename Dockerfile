FROM docker.io/library/archlinux:latest

RUN pacman -Syu --noconfirm \
    neovim \
    zsh \
    fzf \
    prettier \
    go \
    zoxide \
    less \
    imagemagick \
    openssh \
    yazi \
    wl-clipboard \
    fd \
    git \
    base-devel \
    pnpm \
    npm \
    nodejs \
    ripgrep \
    gopls \
    tree-sitter-cli \
    hurl \
    zip \
    curl \
    && pacman -Scc --noconfirm


# Configure Go binaries path
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Install Go-based development tools
# Example:
RUN go install github.com/air-verse/air@latest
RUN go install github.com/pressly/goose/v3/cmd/goose@latest

# Install sylmark
RUN git clone https://codeberg.org/sylveryte/sylmark.git /tmp/sylmark && \
    cd /tmp/sylmark && \
    make install && \
    # Cleanup Go caches
    go clean -modcache && \
    go clean -cache && \
    \
    # Cleanup pnpm/npm caches
    pnpm store prune && \
    rm -rf /root/.npm && \
    rm -rf /root/.local/share/pnpm && \
    \
    # Remove source
    rm -rf /tmp/sylmark

RUN curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
