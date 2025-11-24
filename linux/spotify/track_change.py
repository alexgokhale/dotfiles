#!/usr/bin/env python3

import gi
gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl, GLib
from subprocess import Popen
import tempfile
import urllib.request
import os

player = Playerctl.Player()

def on_track_change(player, e):
    print("Track change: ", e)
    artist = player.get_artist()
    title = player.get_title()
    album_cover_url = e["mpris:artUrl"]

    icon_path = None
    if album_cover_url:
        try:
            print("Attempting to fetch album cover")
            fd, icon_path = tempfile.mkstemp(suffix=".jpg")
            os.close(fd)
            urllib.request.urlretrieve(album_cover_url, icon_path)
        except Exception as ex:
            print("Failed to fetch album cover: ", ex)
            icon_path = None
            pass

    common_args = ['dunstify', artist, title, "--replace=2594"]
    if icon_path:
        Popen([*common_args, "--icon", icon_path])
    else:
        Popen([*common_args, "--icon", "false"])

player.connect('metadata', on_track_change)

GLib.MainLoop().run()
