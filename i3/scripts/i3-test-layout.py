from i3ipc import Connection

i3 = Connection()

i3.command('workspace 1')
i3.command('exec alacritty')
i3.command('split horizontal')
i3.command('exec telegram-desktop')
