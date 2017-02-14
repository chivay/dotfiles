# Usage: extract <file>
# Description: extracts archived files / mounts disk images
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1        ;;
            *.tar.gz)   tar -zxvf $1        ;;
            *.bz2)      bunzip2 $1          ;;
            *.gz)       gunzip $1           ;;
            *.tar)      tar -xvf $1         ;;
            *.tbz2)     tar -jxvf $1        ;;
            *.tgz)      tar -zxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create directory and enter it
function mcd() {
  mkdir -p "$1" && cd "$1";
}
