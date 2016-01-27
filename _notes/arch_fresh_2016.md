Force upgrade of all package lists, even if they appear up to date:
  https://wiki.archlinux.org/index.php/Pacman#Packages_cannot_be_retrieved_on_installation

  https://bbs.archlinux.org/viewtopic.php?pid=1403731#p1403731

  `pacman -Syy`
  Initialise the keyring:
    https://wiki.archlinux.org/index.php/Pacman/Package_signing#Initializing_the_keyring

    `pacman-key --init`
Manually update the keyring package:
  https://wiki.archlinux.org/index.php/pacman#Signature_from_.22User_.3Cemail.40gmail.com.3E.22_is_unknown_trust.2C_installation_failed

  `pacman -S archlinux-keyring`



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

Disable deprecated "Diffie-Hellman group exchange" key exchange on PuTTY to allow SSH connection now that OpenSSH package has been updated to disallow this type of key exchange. Otherwise SSH attempts just have no result.

  Check the SSH daemon logs for error:

  `journalctl -u sshd -n 100`

  https://blog.nytsoi.net/2015/07/13/putty-kex-error

  `Putty
  -->Connection
    -->SSH
      -->Kex
        -->"Diffie-Hellman group exchange" to bottom of list`

Create user and add a password for them:

  `useradd -m -g wheel dancingborg`
  `passwd dancingborg`

Install sudo to allow root commands by new user:

  `pacman -S sudo`

  `visudo`

  Remove # from wheel entry to allow wheel users to sudo:

  `#%wheel ALL=(ALL) ALL`
  TO
  `%wheel ALL=(ALL) ALL`

Disable root login via SSH:

  `vim /etc/ssh/sshd_config`

  add: `PermitRootLogin no`

  `reboot`

  Login as user.

Remove MOTD:

  `sudo rm /etc/motd`

Enable pacman colours:

  https://wiki.archlinux.org/index.php/Color_Bash_Prompt

  `vim /etc/pacman.conf

    #Color		-->		Color`

Install package-query to install Yaourt:

  https://astrofloyd.wordpress.com/2015/01/17/installing-yaourt-on-arch-linux/

  `pacman -S base-devel yajl
  pacman -S wget
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
  tar xfz package-query.tar.gz
  cd package-query
  makepkg
  sudo pacman -U package-query*.pkg.tar.xz
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
  tar xzf yaourt.tar.gz
  cd yaourt
  makepkg
  sudo pacman -U yaourt*.pkg.tar.xz
  rm -r ~/package-query
  rm -r ~/yaourt
  rm -r *.tar.gz`

Liquid Prompt:

  https://github.com/nojhan/liquidprompt
  https://www.liquidstate.net/liquid-prompt/
  Use the following instructions:
  http://www.webupd8.org/2013/04/liquid-prompt-adaptive-prompt-for-bash.html

  `sudo pacman -S git
  git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt
  mkdir .config
  cp ~/.liquidprompt/liquidpromptrc-dist ~/.config/liquidpromptrc
  vim .bashrc`
    Add to end of file: `. ~/.liquidprompt/liquidprompt`
  Log out and back in!

Measure CPU temperature and create Bash alias:

  https://www.raspberrypi.org/forums/viewtopic.php?f=91&t=34994

  `/opt/vc/bin/vcgencmd measure_temp
  vim ~/.bashrc`
  Add before liquidprompt lines:
    `alias temp='/opt/vc/bin/vcgencmd measure_temp'`
  `temp`

Tmux:

  https://wiki.archlinux.org/index.php/tmux#Installation
  `sudo pacman -S tmux`

  https://wiki.archlinux.org/index.php/tmux#Start_tmux_on_every_shell_login
  `vim ~/.bashrc`
  Add before aliases:
    `# Start Tmux on every shell login
    # https://coderwall.com/p/tgm2la/auto-attach-or-start-tmux-at-login
    # If not running interactively, do not do anything

    if [[ "$TERM" != "screen" ]] &&
          ; then
      # Attempt to discover a detached session and attach
      # it, else create a new session

      WHOAMI=$(whoami)
      if tmux has-session -t $WHOAMI 2>/dev/null; then
          tmux -2 attach-session -t $WHOAMI
      else
          tmux -2 new-session -s $WHOAMI
      fi
    else`

  Use the cheat sheet in case you lose a session:
    http://www.dayid.org/comp/tm.html

Zsh:

  https://wiki.archlinux.org/index.php/zsh#Installation
  `echo $SHELL
  sudo pacman -S zsh zsh-completions`
  Append custom `~/.bashrc` to `~/.zshrc`

  https://wiki.archlinux.org/index.php/Command-line_shell#Changing_your_default_shell
  `chsh -l`
  http://unix.stackexchange.com/questions/71236/zsh-is-in-usr-bin-but-also-in-bin-what-is-the-difference
  `chsh -s /bin/zsh` per `chsh -l` path to zsh
  Log out and back in.
