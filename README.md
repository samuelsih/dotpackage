# DotPackage

# Usage

```sh
curl -fsSL https://raw.githubusercontent.com/sxavity/dotpackage/main/setup.sh | bash
```

## Password Store (pass)

### Restore on a new machine

```sh
gpg --export-secret-keys --armor $(cat .gpg.id) > ~/gpg-backup.asc

gpg --import ~/gpg-backup.asc
gpg --edit-key $(cat .gpg.id) trust
```

The store is stowed: `stow -t ~ dothome` (done automatically by `setup.sh`) creates `~/.password-store` -> `dothome/.password-store`.
