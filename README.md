syncback-hard-links
===================

This batch file created hard links for incremental backups.
Its intended to use with SyncBack.

I was searching a lot to find a possibility to create backups with hard links (so every daily backup folder seems to contain the whole backup content from that date).

Finally I wrote a batch script using rsync to create hard links from the last backup folder in the actual backup folder.

You can find it on github:
https://github.com/DorianVasco/syncback-hard-links

The script is working like this:
- Find the last backup folder (by date)
- Create actual backup folder
- Copy hard links to actual backup folder
- Script is done.
- SyncBack starts to backup/delete new files
- Enjoy incremental folders with full content :-)

As the script searches for the last backup folder just by checking for modified date, please be careful if some programmes can mess up these dates.

Please, tell my what you think about it. I copied the rsync files directly into the SyncBack installation folder to make it work.

Go to the profile settings and choose the .bat as programme to run before the profile start:

  syncback-hard-links.bat "%_SOURCE%" "%_DESTINATION%"
  
Check "Wait till program is finished".


