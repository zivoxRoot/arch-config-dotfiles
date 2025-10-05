# Next Steps

## These are the manual configurations required to have a completely themed system. You can apply or ignore them...

1. Apply pywal theme to Zen browser: install the pywalfox extension
1. Apply pywal theme to Telegram: go to telegram > settings > chat settings > chat wallpaper > choose from file > choose **~/.cache/walogram/wal.tdesktop-theme**

## These are recommended next steps to make this system truly yours... Do as you wish!

1. Connect to your accounts on Zen browser or install your preferred web browser
2. Install some extensions on Zen browser: uBlock Origin, pywalfox (already recommended in the manual config steps), dark reader...
3. Set your ~/.gitconfig file (it already has some config in it)
4. Create a new SSH key to access your github account
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   bat ~/.ssh/id_ed25519
   ```
5. Delete this file and the repository folder

**Enjoy your new system! :)**
