# My personal .dotfiles
These are my personal configuration files I use to setup my development workflow. This avery minimilistic setup for:
* **neovim** (Code Editor)
* **tmux** (Session Multiplexir)
* **zsh** (Shell, and `Oh My Zsh` on top of it)

*I belive in, making things more productive rather spending bunch of hours to make it beautiful.*



I case you want to use this setup, Use the below guide to properly place and link the cofiguration as it should be.


### How to setup these set of configuration files for you self
Clone this repo in the $HOME. A new hidden folder `.dotfiles` directory will be created in your $HOME directory.

**Clone this repo in your $HOME**
```
git clone 

```
*Note: This will be a hidden directory, you should use `ls -a` flag to view it.*

```
cd .dotfiles
``` 
**Linking**

Now link the configuration files to the right place. There are plenty of other methods like `GNU Stow`, some uses automated script to link. But I have a very minimilistic setup. So, I am using symlinking for it.

```

cd $HOME    // or type 'pwd' to check your current directory

ln -s $HOME/.dotfiles/zsh/.zshrc $HOME/
ln -s $HOME/.dotfiles/nvim $HOME/.config/
ln -s $HOME/.dotfiles/tmux/.tmux.conf $HOME/


```
* *NOTE:  Now run `ls -a` or `ls -al` to check wheter your setups are linked or not.*
* *NOTE: Any changes made here will directly be reflected in there.*
* *NOTE: You can use `-v` flag to print info in the terminal when linking*

```
// For unlinking use
unlink $HOME/the-linked-file-name
```


**Backup installed packages**

Incase if your are moving your installation to a new system. Then with following command a backup list of installed packages can be made, and can be reinstalled in one go.

```
pacman -Qqen > pkglist.txt
pacman -Qqem > pkglist_aur.txt

```
**Reinstall those packages**

```
pacman -S --needed - < pkglist.txt
yay -S --needed - < pkglist_aur.txt

```

---
*Note: In future I might convert this to a `git --bare` repo and add further more configuration.*

*Note: The setup files are well documented. Read it carefully to get going with the setup.*

**See:** For more exploration of setting .dotfiles configuration.
* [Best way to reproduce install + dotfiles]("https://www.reddit.com/r/archlinux/comments/15adjk2/best_way_to_reproduce_install_dotfiles/")
* [Migrate installation to new hardware]("https://wiki.archlinux.org/title/Migrate_installation_to_new_hardware")
* [how do you manage your dotfiles?]("https://www.reddit.com/r/linux4noobs/comments/sk5fm5/how_do_you_manage_your_dotfiles/")
