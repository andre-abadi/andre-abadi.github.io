Force upgrade of all package lists, even if they appear up to date:
  https://wiki.archlinux.org/index.php/Pacman#Packages_cannot_be_retrieved_on_installation

  https://bbs.archlinux.org/viewtopic.php?pid=1403731#p1403731

  `pacman -Syy`

Manually update the keyring package:
  https://wiki.archlinux.org/index.php/pacman#Signature_from_.22User_.3Cemail.40gmail.com.3E.22_is_unknown_trust.2C_installation_failed

  `pacman -S archlinux-keyring`

Initialise the keyring:
  https://wiki.archlinux.org/index.php/Pacman/Package_signing#Initializing_the_keyring

  `pacman-key --init`

Verify the master keys:
  https://wiki.archlinux.org/index.php/Pacman/Package_signing#Verifying_the_five_master_keys

  `pacman-key --populate archlinux`

Update the known keys:
  https://wiki.archlinux.org/index.php/pacman#Signature_from_.22User_.3Cemail.40gmail.com.3E.22_is_unknown_trust.2C_installation_failed

  `pacman-key --refresh-keys`

Upgrade all packages:
  https://wiki.archlinux.org/index.php/Pacman#Upgrading_packages

  `pacman -Syu`

Upgrade Pacman database because pacman itself has been updated:

  `pacman-db-upgrade`

Enable pacman colours:

  https://wiki.archlinux.org/index.php/Color_Bash_Prompt

  vim /etc/pacman.conf

    #Color		-->		Color
