# Dotfiles Template

This template is managed by the Velocity team and pulled into your personal workspace repository.

## Quick Start: Where to Put Your Customizations

**Use files ending in `-user-specific`** — these are safe from Velocity updates:
- `bootstrap-user-specific.sh` — commands to run at workspace startup
- `config-user-specific.yaml` — configure auto-clone repositories and base directory
- `.bash-rc-user-specific` - extend your .bashrc here

**Don't modify:** `.bashrc` or `bootstrap.sh` (managed by Velocity)

## Adding Your Own Files

Feel free to add any new dotfiles (`.bash_profile`, `.gitconfig`, etc.). Files not listed in `.homeignore` will be copied to your home directory.

## Migration & Updates

When Velocity releases template updates for workspace compatibility, you can safely replace old files with the new template. Your `-user-specific` files won't be touched, preserving your customizations.

---

## For Velocity Team: Maintenance

**Safe to modify:** `.bashrc`, `bootstrap.sh`, and any non-`-user-specific` files

**Never modify:** Files ending in `-user-specific` (reserved for user customizations, these must be called by relevant non -user-specific versions of the file)

**When adding new managed files:** Ensure they don't conflict with common user dotfiles. Add them to `.homeignore` if they shouldn't sync to home directory.

