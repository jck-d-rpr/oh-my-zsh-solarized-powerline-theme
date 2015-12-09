#Powerline theme for oh-my-zsh
The Powerline style prompt for oh-my-zsh.

##Preview
The one with the apple logo
![powerline prompt apple](https://raw.github.com/jck-d-rpr/powerline-train/master/previews/preview-apple-logo.png)

The one with with the linux logo
![powerline prompt](https://raw.github.com/jck-d-rpr/powerline-train/master/previews/preview.png)

#####Some more

![2](https://raw.github.com/jck-d-rpr/powerline-train/master/previews/preview-2.png)
![3](https://raw.github.com/jck-d-rpr/powerline-train/master/previews/preview-3.png)
![4](https://raw.github.com/jck-d-rpr/powerline-train/master/previews/preview-4.png)
![8](https://raw.github.com/jck-d-rpr/powerline-train/master/previews/preview-8.png)

###Requirements
- Vim Powerline patched font: See [Powerline for vim](https://github.com/Lokaltog/vim-powerline.git) for more info.
- Z shell (zsh): See [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) for more info.

###Installation
**Manual / oh-my-zsh**

1. Clone the repository.

	```
	$ git clone https://github.com/KuoE0/oh-my-zsh-solarized-powerline-theme.git
	```

2. Create a symbolic link of solarized-powerline.zsh-theme in .oh-my-zsh/themes/.
	
	```
	$ ln -s $PWD/jckdrpr.zsh-theme ~/.oh-my-zsh/themes
	```

3. Configure the theme in your **.zshrc** file :

	```
	ZSH_THEME="jckdrpr"
	```

**Antigen**

```
antigen theme jck-d-rpr/oh-my-zsh-solarized-powerline-theme jckdrpr
```

See [Antigen](https://github.com/zsh-users/antigen) for more info.


###Configuration
You can set following options in your .zshrc.

**Display username:** `SHOW_USER`
- default: `true`


**Display IP address or host name:** `SHOW_IP`
- default: `true`

**Display current time:** `SHOW_TIME`
- default: `false`

**Use single line in prompt:** `SINGLE_LINE`
- default: `false`

**Display git status of current repo. For a large git repo, the prompt will be very slow!** `SHOW_GIT_STATUS`
- default: `true`

**Display branch name of current git repo. The priotity of this option is higher than `SHOW_GIT_STATUS`!** `SHOW_GIT_BRAHCH_ONLY`
- default: `false`

**Display return code:** `SHOW_RETURN_CODE`
- default: `true`

**Display symbol of current OS:** `SHOW_OS`
- default: `true`

**The the depth of parant directories:** `DIRECTORY_DEPTH`
- options:
	- integer > 0
- default: `4`

###Other configuration
In addition to what to display and what not to you can also select the foreground and background color for each of the aformentioned elements.

###Thanks to
Original project page [Powerline theme for oh-my-zsh](https://github.com/KuoE0/oh-my-zsh-solarized-powerline-theme).

[The color generating script](http://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt) answer by krwoe.

Random symbols in the prompt I first encountered in [here](https://github.com/narendraj9/dotfiles).
