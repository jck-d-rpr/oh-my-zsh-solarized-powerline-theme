#Powerline theme for oh-my-zsh
The Powerline style prompt for oh-my-zsh.


###REQUIREMENTS
- Vim Powerline patched font: See [Powerline for vim](https://github.com/Lokaltog/vim-powerline.git) for more info.
- Z shell (zsh): See [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) for more info.

###INSTALLATION
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


###CONFIGURATION
You can set following options in your .zshrc.

- **Display username:** `SHOW_USER`
- options:
	- `true`
	- `false`
- default: `true`


- **Display IP address or host name:** `SHOW_IP`
- options:
	- `true`
	- `false`
- default: `true`

- **Display current time:** `SHOW_TIME`
- options:
	- `true`
	- `false`
- default: `false`

- **Use single line in prompt:** `SINGLE_LINE`
- options:
	- `true`
	- `false`
- default: `false`

- **Display git status of current repo. For a large git repo, the prompt will be very slow!** `SHOW_GIT_STATUS`
- options:
	- `true`
	- `false`
- default: `true`

- **Display branch name of current git repo. The priotity of this option is higher than `SHOW_GIT_STATUS`!** `SHOW_GIT_BRAHCH_ONLY`
- options:
	- `true`
	- `false`
- default: `false`

- **Display return code:** `SHOW_RETURN_CODE`
- options:
	- `true`
	- `false`
- default: `true`

- **Display symbol of current OS:** `SHOW_OS`
- options:
	- `true`
	- `false`
- default: `true`

- **The the depth of parant directories:** `DIRECTORY_DEPTH`
- options:
	- integer > 0
- default: `4`

###Other configuration
In addition to what to display and what not to you can also select the foreground and background color for each of the aformentioned elements.
