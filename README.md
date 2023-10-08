# SM-Re.LoadMap
(Re)loads the map

## Commands
`sm_reloadmap`
`sm_changelevel <mapname>` (Use exact map name);

### Notes
- The purpose of creating a custom changelevel command is to verify the map exists on the server. The built-in rcon command `changelevel` does not verify existance and will crash the server if file doesn't exist.
- Reloadmap exists to quickly reload current map without having to type out the name.
