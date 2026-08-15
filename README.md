# DotPackage

# Usage

```sh
curl -fsSL https://raw.githubusercontent.com/sxavity/dotpackage/main/setup.sh | bash
```

## Password Store (pass)

### Restore on a new machine

```sh
gpg --export-secret-keys --armor D78AAE56FF0C46E7FAC0BABF4BC65064088C060C > ~/gpg-backup.asc

gpg --import ~/gpg-backup.asc
gpg --edit-key D78AAE56FF0C46E7FAC0BABF4BC65064088C060C trust
```

The store is stowed: `stow -t ~ dothome` (done automatically by `setup.sh`) creates `~/.password-store` -> `dothome/.password-store`.
