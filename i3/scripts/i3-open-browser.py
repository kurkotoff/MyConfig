from i3ipc import Connection, Event

# Create the Connection object that can be used to send commands and subscribe
# to events.
i3 = Connection()

# Print the name of the focused window
#focused = i3.get_tree().find_focused()
#print('Focused window %s is on workspace %s' %
#      (focused.name, focused.workspace().name))

# Query the ipc for outputs. The result is a list that represents the parsed
# reply of a command like `i3-msg -t get_outputs`.

i3.command('workspace 5')
i3.command('exec qutebrowser')
