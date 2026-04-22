rclone_mount() {
  /usr/bin/rclone mount --vfs-cache-mode=minimal --dir-cache-time=10h --poll-interval=1m --vfs-read-ahead=0 --no-modtime --vfs-cache-max-size=0 --buffer-size=0 --tpslimit=10 --tpslimit-burst=10 --log-level=DEBUG $1: ~/$1
}
