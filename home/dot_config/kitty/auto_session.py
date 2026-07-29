def on_quit(boss, window, data):
    if data.get("confirmed"):
        boss.call_remote_control(
            window,
            ("action", "save_as_session --save-only ~/.config/kitty/last-session.kitty-session"),
        )
