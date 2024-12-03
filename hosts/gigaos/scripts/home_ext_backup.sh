#!/bin/sh

    # Check if external drive is mounted

    if ! mountpoint -q /run/media/helmi/1EC677026F8DEC66/; then
        echo "External drive not mounted, aborting backup"
       exit 1
    fi

    # Setting this, so the credentials do not need to be given on the commandline:
    export BORG_REPO="/run/media/helmi/1EC677026F8DEC66/borg-repos/gig/"
    export BORG_PASSPHRASE="htz94__cborg"

    # Define a log file
    LOGFILE="/var/log/borg_back.log"

    # Redirect output to the log file
    exec > >(tee -a "$LOGFILE") 2>&1

    # some helpers and error handling:
    info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
    trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

    backup_exit=0
    prune_exit=0
    compact_exit=0
    global_exit=0

    info "Starting backup"

    # Backup the most important directories into an archive named after
    # the machine this script is currently running on:

    borg create                         \
        --verbose                       \
        --filter AME                    \
        --list                          \
        --stats                         \
        --show-rc                       \
        --compression zstd               \
        --exclude-caches                \
        --exclude 'home/*/.cache/*'     \
                                        \
        ::'{now}'          \
        /snapshots                 \
        /home/helmi/dotfiles        \
        /home/helmi/media           \
        /home/helmi/dev             \
        /home/helmi/dVault       \

    backup_exit=$?

    info "Pruning repository"

    # Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
    # archives of THIS machine. The '{hostname}-*' matching is very important to
    # limit prune's operation to this machine's archives and not apply to
    # other machines' archives also:

    borg prune                          \
        --list                          \
        --glob-archives '*'  \
        --show-rc                       \
        --keep-daily    7               \
        --keep-weekly   4               \
        --keep-monthly  6

    prune_exit=$?

    # actually free repo disk space by compacting segments

    info "Compacting repository"

    borg compact

    compact_exit=$?
    # use highest exit code as global exit code
    global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
    global_exit=$(( compact_exit > global_exit ? compact_exit : global_exit ))

    if [ ${global_exit} -eq 0 ]; then
        info "Backup, Prune, and Compact finished successfully"
    elif [ ${global_exit} -eq 1 ]; then
        info "Backup, Prune, and/or Compact finished with warnings"
    else
        info "Backup, Prune, and/or Compact finished with errors"
    fi

    exit ${global_exit}
