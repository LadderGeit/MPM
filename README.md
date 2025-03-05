<!-- 
Writing on GitHub Guidance: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/quickstart-for-writing-on-github

- Styling text:
	- Bold:                			**Bold text**
	- Italic:              			*Italic text*
	- Strikethrough:				~~Strikethrough text~~
	- Bold and nested italic:		**Bold _Bold Italic_ text**
	- All bold and italic:			*** Bold Italic ***
	- Subscript:					<sub>Subscript text</sub>
	- Superscript:					<sup>Superscript text</super>
	- Underlined:					<ins>Underlined text</ins>

- Quoting text: >
 -->

> [!IMPORTANT]
> **Plugin compatibility**<br/>
> This plugin is only compatible with ***amxmodx 1.9 or higher.*** Support for older versions has been discontinued for ALL my plugins.<br/>
> - *Download [amxmodx 1.9](https://www.amxmodx.org/downloads-new.php) or [amxmodx 1.10](https://www.amxmodx.org/downloads-new.php?branch=master)*

# [MPM] MOTD Private Message

![GitHub Created At](https://img.shields.io/github/created-at/LadderGeit/MPM?style=plastic&color=blue)
![GitHub last commit](https://img.shields.io/github/last-commit/LadderGeit/MPM?style=plastic&color=darkorange)

A simple plugin allowing players to send MOTD private messages to one another by using the "mpm" console command. Messages can only be sent to DEAD players to prevent MOTD spamming.

## Usage
> Console command
> ```c
> mpm "player" "message"
> ```

## Cvars
```c
register_cvar("mpm_adminsonly", "1");
register_cvar("mpm_adminprefix", "ADMIN");
register_cvar("mpm_adminflags", "b");
register_cvar("mpm_chatprefix", "AMXX");
register_cvar("mpm_playerprefix", "PLAYER");
```

## Changelog
<details>
<summary>Version list</summary>

- [x] 1.0.0: Initial release

</details>
