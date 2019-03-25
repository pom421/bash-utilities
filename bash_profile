##
# Bash utilities : rename it as .bash_profile on your user's root folder
##


# fonction md : mkdir + cd
md()
{
    mkdir -p -- "$1" && cd -P -- "$1"
}

# Set Proxy
function setproxy() {
    export PROXY=http://10.154.61.3:3128
    export {http,https,ftp}_proxy=$PROXY
    export {HTTP,HTTPS,FTP}_PROXY=$PROXY

    # git
    git config --global http.proxy $PROXY
    git config --global https.proxy $PROXY

    # npm
    npm config set proxy $PROXY

    # gradle
    if [ -f ~/.gradle/gradle.archive.properties ]; then
        mv  ~/.gradle/gradle.archive.properties ~/.gradle/gradle.properties
    fi
}

# Set Proxy (configuration à l'identique des smartphones)
function setproxysmart() {
    export PROXY=http://10.156.242.218:8080
    export {http,https,ftp}_proxy=$PROXY
    export {HTTP,HTTPS,FTP}_PROXY=$PROXY

    # git
    git config --global http.proxy $PROXY
    git config --global https.proxy $PROXY

    # npm
    npm config set proxy $PROXY

    # utile éventuellement quand on est en mode setproxysmart pour ne pas toujours passer par le proxy d'IA
    export no_proxy="localhost,127.0.0.1,10.75.204.14"
}

# Unset Proxy
function unsetproxy() {
    unset {http,https,ftp}_proxy
    unset {HTTP,HTTPS,FTP}_PROXY
    unset {ALL,_}PROXY
    unset PROXY
    unset no_proxy

    # git
    git config --global --unset http.proxy
    git config --global --unset https.proxy

    # npm
    npm config delete proxy

    # gradle
    if [ -f ~/.gradle/gradle.properties ]; then
        mv ~/.gradle/gradle.properties ~/.gradle/gradle.archive.properties
    fi

}

function showproxy() {
  echo "Affichage des paramètres proxy du poste de développement"
  echo "--------------------------------------------------------"

  env | grep PROXY
  env | grep proxy

  echo "git http.proxy :" $(git config --global --get http.proxy)
  echo "git https.proxy :" $(git config --global --get https.proxy)

  echo "npm proxy :" $(npm config get proxy)

  if [ -f  ~/.gradle/gradle.properties ]; then
    echo "gradle proxy"
    echo "------------"
    cat  ~/.gradle/gradle.properties
  else 
    echo "gradle proxy (pas de fichier gradle.properties trouvé)"
  fi

}

# Ouvrir dans XCode le fichier avec l'extension xcworkspace
function openxcw() {
    FILE=$(find ./platforms/ios -name "*.xcworkspace")
    echo "Ouverture de $FILE"
    open $FILE
}

export JAVA_HOME=$(/usr/libexec/java_home)
export ANDROID_HOME="/Users/pomauguet/Library/Android/sdk"
export ANDROID_SDK_ROOT=$ANDROID_HOME

export PATH=${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
export PATH=${PATH}:/Users/pomauguet/scripts

# ajout couleurs au shell
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export LAB="/Users/pomauguet/lab"

# alias
alias ls='ls -GFh'
alias ll="ls -al"
alias ..="cd .."
alias ...=".. && .."