# Codespaces Anchor(Solana) Starter

This project is a generic starter for developers to use in Codespaces that includes basic system tools and extensions.

## Usage

To use this codespace template simply create a new repository from this repository. In the new repository you have to wait until the codespace prebuild action is executed (takes around 15-20 minutes). Afterward you can access the prebuild codespace and optionally execute:

        chmod +x ./init-anchor-project.sh && ./init-anchor-project.sh
        
This will initialize a new anchor project in the root directory of the new repository.

## What's Included

This is a basic environment that should be ready to expand upon to build a day-to-day development envrionment for Solana. It comes with the following software choices:

### System Tools

- [curl/curl](https://github.com/curl/curl): the command line tool for transferring data over a metric boatload of protocols.
- git: the Git SCM tool.
- [gnupg2](https://gnupg.org/): a complete and free implementatiuon of the OpenPGP standard.
- [stedolan/jq](https://github.com/stedolan/jq) - a command line JSON parser.
- [sudo](https://www.sudo.ws/) - the superuser authority delegation tool.
- [zsh](https://www.zsh.org/) - interactive terminal (alternative to `bash`).
- [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) - a delightful community driven framework for managing zsh config.
- [vim](https://www.vim.org/) - a text editor
- build essentials - tools for compiling and linking code
- [openssl](https://www.openssl.org/) - tls and ssl toolkit

### Rust Tools

Besides Rust and Cargo, the image comes with the following Rust related tooling:

- [rustup](https://rustup.rs/): installer and toolchain manager
- [rustfmt](https://github.com/rust-lang/rustfmt): a tool for formatting Rust code according to style guidelines
- [clippy](https://github.com/rust-lang/rust-clippy): lints to catch common mistakes and improve your Rust code

### Solana Tools

Other than installing solana V1.8.2:

- [anchor](https://project-serum.github.io/anchor/getting-started/introduction.html): anchor

### VS Code Extensions

- [Rust Analyzer](https://marketplace.visualstudio.com/items?itemName=matklad.rust-analyzer): an alternative rust language server to the RLS.
- [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb): native debugger based on LLDB.
- [Crates](https://marketplace.visualstudio.com/items?itemName=serayuzgur.crates): helps Rust developers managing dependencies with Cargo.toml.
- [Live Share](https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare): collaborative, multi-user remote editing from directly within the editor.

### Operating System

- [Ubuntu 22.04](https://releases.ubuntu.com/22.04.1/): The 22.04 LTS version of Ubuntu.

