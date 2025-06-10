# Kanata

```bash
cp kanata.kbd ~/.config/kanata/
cp kanata.service ~/.config/systemd/user/
```

```bash
systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user start kanata.service
systemctl --user status kanata.service
```
