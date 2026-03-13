# OpenCode Configuration Backup

Backup of OpenCode configuration files and settings.

## Contents

- **Configuration Files**: `opencode.json`, `oh-my-opencode.json`
- **Agents**: Custom agent configurations
- **Commands**: Custom command definitions
- **Plugins**: Plugin configurations
- **Superpowers**: Complete superpowers skill system

## Structure

```
.
├── agent/              # Agent definitions
├── agents/             # Additional agent configs
├── command/            # Custom commands
├── plugin/             # Plugin source files
├── plugins/            # Plugin configurations
├── skill/              # Skill directory (empty - symlinks removed)
├── skills/             # Skills directory
├── superpowers/        # Superpowers skill system
├── opencode.json       # Main OpenCode configuration
├── oh-my-opencode.json # Oh My OpenCode configuration
└── package.json        # Node dependencies
```

## Notes

- Sensitive files excluded: API keys and credentials
- Build artifacts excluded: `node_modules/`, lock files
- Antigravitys project symlinks removed for portability

## Restore

To restore this configuration:

1. Copy contents to `~/.config/opencode/`
2. Run `npm install` to restore dependencies
3. Restart OpenCode

## Backup Date

Created: 2026-03-13
