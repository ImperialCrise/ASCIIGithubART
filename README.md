<p align="center">
  <img src="https://img.shields.io/badge/version-2.0.0-blue?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/badge/bash-5.0+-green?style=for-the-badge&logo=gnu-bash" alt="Bash">
  <img src="https://img.shields.io/badge/license-MIT-purple?style=for-the-badge" alt="License">
</p>

<h1 align="center">🎨 GitHub Pixel Art Generator</h1>

<p align="center">
  <strong>Transform your GitHub contribution graph into pixel art!</strong><br>
  Write text, display logos, or create custom designs on your contribution history.
</p>

<p align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=ImperialCrise&show_icons=true&theme=radical" alt="Stats">
</p>

---

> [!WARNING]
> ## ⚠️ Before You Start
> 
> **1. Fork this repository first!**
> This script modifies git history. You need your own copy to use it.
> 
> **2. GitHub takes 24-48 hours to update!**
> After pushing your commits, the contribution graph won't update immediately.
> Be patient – it can take up to 24-48 hours for changes to appear.
> 
> **3. Use a dedicated repository!**
> Don't run this on important projects. Create a new repo or fork this one.

---

## ✨ Features

- 📝 **Custom Text** - Write any text on your contribution graph
- 🎮 **Templates** - Pre-built designs (Bitcoin, Minecraft)
- 🎨 **Gradient Support** - Multiple intensity levels for depth
- 📅 **Any Year** - Target any year from 2008 to present
- 🔄 **Reset Function** - Easily remove pixel art commits
- 🖥️ **User-Friendly CLI** - Modern command-line interface with colors

---

## 📦 Installation

```bash
git clone git@github.com:ImperialCrise/ASCIIGithubART.git
cd ASCIIGithubART
chmod +x github_pixel_art.sh
```

---

## 🚀 Quick Start

### Preview a design

```bash
./github_pixel_art.sh preview --text "HELLO" --year 2020
```

### Generate commits

```bash
./github_pixel_art.sh generate --text "HELLO" --year 2020
git push origin main --force
```

---

## 📖 Usage

```
./github_pixel_art.sh <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `generate` | Generate pixel art commits |
| `preview` | Preview the design without generating |
| `reset` | Remove pixel art commits for a specific year |
| `reset-all` | Clear all git history |
| `list` | List available templates |
| `help` | Show help message |

### Options

| Option | Description |
|--------|-------------|
| `-t, --text <TEXT>` | Text to display |
| `-y, --year <YEAR>` | Target year (e.g., 2016) |
| `-T, --template <NAME>` | Use a template (bitcoin, minecraft) |
| `-p, --preview` | Preview only, don't generate |
| `-f, --force` | Skip confirmation prompts |
| `-h, --help` | Show help message |
| `-v, --version` | Show version |

---

## 🎨 Templates

### 🪙 Bitcoin (2009)

Perfect for celebrating Bitcoin's birth year!

```bash
./github_pixel_art.sh generate --template bitcoin --year 2009
```

```
 ░   ░   ░███  ███ ███  ███  ██  ███ █  █ ░   ░   ░ 
░░░ ░░░ ░░█  █  █   █  █    █  █  █  ██ █░░░ ░░░ ░░░
░ ░ ░ ░ ░ █  █  █   █  █    █  █  █  █ ██░ ░ ░ ░ ░ ░
░░░ ░░░ ░░███   █   █  █    █  █  █  █  █░░░ ░░░ ░░░
░ ░ ░ ░ ░ █  █  █   █  █    █  █  █  █  █░ ░ ░ ░ ░ ░
░░░ ░░░ ░░█  █  █   █  █    █  █  █  █  █░░░ ░░░ ░░░
 ░   ░   ░███  ███  █   ███  ██  ███ █  █ ░   ░   ░ 
```

### 🌲 Minecraft Scene

Add a tree and terrain next to your text!

```bash
./github_pixel_art.sh generate --text "iCrise" --template minecraft --year 2016
```

```
 █  ███     █                            ░░       
   █                                    ░░░░░     
 █ █     ██ █  ██  ██                  ░░░░░░░    
 █ █    █   █ █   █ █                   ░░░░░     
 █ █    █   █  █  ███           ░         ▒▒      
 █ █    █   █   █ █             ▒   ▒▒    ▒▒      
 █  ███ █   █ ██   ██         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
```

---

## 📊 Intensity Levels

The script supports 4 intensity levels for gradient effects:

| Symbol | Commits | Color |
|--------|---------|-------|
| █ | 25 | Dark green |
| ▓ | 15 | Medium-dark green |
| ▒ | 8 | Medium green |
| ░ | 3 | Light green |

---

## 🔧 Examples

### Simple text

```bash
./github_pixel_art.sh generate --text "CODE" --year 2018
```

### Preview before generating

```bash
./github_pixel_art.sh preview --text "PIXEL" --year 2015
```

### Force mode (no prompts)

```bash
./github_pixel_art.sh generate --template bitcoin --year 2009 --force
```

### Reset a specific year

```bash
./github_pixel_art.sh reset --year 2016
git push origin main --force
```

### Full reset

```bash
./github_pixel_art.sh reset-all --force
git push origin main --force
```

---

## ⚠️ Important Notes

1. **Force Push Required**: After generating commits, you need to force push:
   ```bash
   git push origin main --force
   ```

2. **Private Contributions**: Make sure "Private contributions" is enabled in your GitHub settings to see the graph.

3. **Email Matching**: Your git email must match your GitHub account email:
   ```bash
   git config user.email "your-github-email@example.com"
   ```

4. **Year Calculation**: The contribution graph for a year starts on the Sunday before January 1st, so some commits may have dates from the previous year.

---

## 🛠️ Supported Characters

```
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
a (lowercase i, r, s, e available)
0-9 (coming soon)
```

---

## 📋 Requirements

- Bash 4.0+
- Git
- `date` command (GNU coreutils)

---

## 🤝 Contributing

Feel free to open issues or submit pull requests!

---

## 📄 License

MIT License - feel free to use this for your own contribution graphs!

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/ImperialCrise">ImperialCrise</a>
</p>

