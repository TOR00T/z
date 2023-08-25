#!/usr/bin/env bash

print_ascii() {
    set_colors 4 8
    read -rd '' ascii_data <<'EOF'
${c1}..............
            ..,;:ccc,.
          ......''';lxO.
.....''''..........,:ld;
           .';;;:::;,,.x,
      ..'''.            0Xxoc:,.  ...
  ....                ,ONkc;,;cokOdc',.
 .                   OMo           ':${c2}dd${c1}o.
                    dMc               :OO;
                    0M.                 .:o.
                    ;Wd
                     ;XO,
                       ,d0Odlc;,..
                           ..',;:cdOOd::,.
                                    .:d;.':;.
                                       'd,  .'
                                         ;l   ..
                                          .o
                                            c
                                            .'
                                             .
EOF

    while IFS=$'\n' read -r line; do
        line=${line//\\\\/\\}
        line=${line//█/ }
        ((++lines,${#line}>ascii_len)) && ascii_len="${#line}"
    done <<< "${ascii_data//\$\{??\}}"
    
    ascii_data="${ascii_data//\$\{c1\}/$c1}"
    ascii_data="${ascii_data//\$\{c2\}/$c2}"
    ascii_data="${ascii_data//\$\{c3\}/$c3}"
    ascii_data="${ascii_data//\$\{c4\}/$c4}"
    ascii_data="${ascii_data//\$\{c5\}/$c5}"
    ascii_data="${ascii_data//\$\{c6\}/$c6}"

    ((text_padding=ascii_len+gap))
    printf '%b\n' "$ascii_data"
    printf '\e[%sA' "${lines:-0}"
}

set_colors() {
    c1="$(color "$1")\e[1m"
    c2="$(color "$2")\e[1m"
    c3="$(color "$3")\e[1m"
    c4="$(color "$4")\e[1m"
    c5="$(color "$5")\e[1m"
    c6="$(color "$6")\e[1m"
}

color() {
    case $1 in
        [0-6]) printf '\e[0m\e[3%sm' "$1" ;;
        #7) printf '\e[37m\e[0m' "" ;;
        *) printf '\e[38;5;%sm' "$1" ;;
    esac
}

print_info() {
    info title
    info underline

    info "Datetime" datetime
    info "Uptime" uptime
    info "OS" distro
    info "Release" release
    info "Kernel" kernel
    info "Shell" shell
    info "Resolution" resolution
    info "DE" de
    info "Theme" theme
    info "Icons" icons
    info "Terminal" term
    info "CPU" cpu
    info "Local IP" local_ip
    info "Public IP" public_ip
    info cols
}

info() {
    [[ "$2" ]] && subtitle="$1"
    unset -v prin
    "get_${2:-$1}"
    [[ "$prin" ]] && return

    if [[ "$2" ]]; then
        output="$(trim "${!2}")"
    else
        output="$(trim "${!1}")"
    fi

    if [[ "$2" && "${output// }" ]]; then
        prin "$1" "$output"

    elif [[ "${output// }" ]]; then
        prin "$output"
    fi

    unset -v subtitle
}

prin() {
    if [[ "$(trim "$1")" && "$2" ]]; then
        [[ "$json" ]] && { printf '    %s\n' "\"${1}\": \"${2}\","; return; }

        string="${1}${2:+: $2}"
    else
        string="${2:-$1}"
    fi

    string="$(trim "${string//$'\e[0m'}")"
    length="$(strip_sequences "$string")"
    length="${#length}"

    string="${string/:/'\e[0m'${separator:=:}}"
    string="\e[1m${string}"
    printf '%b\n' "${text_padding:+\e[${text_padding}C}${string//\\n}"
    ((++info_height))
}

trim() {
    set -f
    set -- $*
    printf '%s\n' "${*//[[:space:]]/}"
    set +f
}

strip_sequences() {
    strip="${1//$'\e['3[0-9]m}"
    strip="${strip//$'\e['[0-9]m}"
    strip="${strip//\\e\[[0-9]m}"
    strip="${strip//$'\e['38\;5\;[0-9]m}"
    strip="${strip//$'\e['38\;5\;[0-9][0-9]m}"
    strip="${strip//$'\e['38\;5\;[0-9][0-9][0-9]m}"

    printf '%s\n' "$strip"
}

get_title() {
    user=${USER:-$(id -un || printf %s "${HOME/*\/}")}

    hostname=$(hostname -f)
    hostname=${HOSTNAME:-$(hostname)}

    title="$(color "4")\e[1m${user}\e[0m@$(color "4")\e[1m${hostname}"
}

get_underline() {
    printf -v underline "%${length}s"
    printf '%b%b\n' "${text_padding:+\e[${text_padding}C}\e[0m" \
            "${underline// /$underline_char}\e[0m"
}

get_datetime() {
    datetime=$(date +"%F %T %p %Z %z")
}

get_uptime() {
    if [[ -r /proc/uptime ]]; then
        s=$(< /proc/uptime)
        s=${s/.*}
    else
        boot=$(date -d"$(uptime -s)" +%s)
        now=$(date +%s)
        s=$((now - boot))
    fi

    d="$((s / 60 / 60 / 24)) days"
    h="$((s / 60 / 60 % 24)) hours"
    m="$((s / 60 % 60)) minutes"

    uptime=${d:+$d, }${h:+$h, }$m

    uptime=${uptime/ days/d}
    uptime=${uptime/ day/d}
    uptime=${uptime/ hours/h}
    uptime=${uptime/ hour/h}
    uptime=${uptime/ minutes/m}
    uptime=${uptime/ minute/m}
    uptime=${uptime/ seconds/s}
    uptime=${uptime//,}
}

get_distro() {
    if [[ -f /etc/os-release ]]; then
        for file in /etc/os-release; do
        source "$file" && break
        done
        distro="${PRETTY_NAME:-${DISTRIB_DESCRIPTION}} $kernel_machine"
    else
        distro="Unknown"
    fi
}

get_release() {
    release=$(lsb_release -r)
    release=${release##*:}
}

get_kernel() {
    kernel=$kernel_version
}

get_shell() {
    shell+=$("$SHELL" --version 2>&1)
    shell=${shell/\(*\)}
}

get_resolution() {
    resolution="$(xrandr --nograb --current |\
        awk 'match($0,/[0-9]*\.[0-9]*\*/) {printf $1 " @ " substr($0,RSTART,RLENGTH) "Hz, "}')"
    resolution="${resolution//\*/}"
    resolution="${resolution%%, }"
}

get_de() {
    de_ver=$(xfce4-session --version)
    de_ver=${de_ver#*\(}
    de=${de_ver/)*/}
}

get_theme() {
    theme="$(xfconf-query -c xsettings -p "/Net/ThemeName")"
}

get_icons() {
    icons="$(xfconf-query -c xsettings -p "/Net/IconThemeName")"
}

get_ppid() {
    
    ppid="$(grep -i -F "PPid:" "/proc/${1:-$PPID}/status")"
    ppid="$(trim "${ppid/PPid:}")"

    printf "%s" "$ppid"
}

get_process_name() {
    name="$(< "/proc/${1:-$PPID}/comm")"

    printf "%s" "$name"
}

get_term() {
    while [[ -z "$term" ]]; do
        parent="$(get_ppid "$parent")"
        [[ -z "$parent" ]] && break
        name="$(get_process_name "$parent")"
        case ${name// } in
            "${SHELL/*\/}"|*"sh"|"screen"|"su"*|"newgrp") ;;

            *)
                [[ $os == Linux ]] && term=$(realpath "/proc/$parent/exe")
                term="${name##*/}"
            ;;
        esac
    done
}

get_cpu() {
    if [[ -f /proc/cpuinfo ]]; then
        cpu=$(cat /proc/cpuinfo | grep "model name" | uniq)
        cpu=${cpu##*:}
    else
        cpu="Unknown"
    fi
}

get_local_ip() {
    local_ip="$(ifconfig -a | awk '/broadcast/ {print $2; exit}')"
}

get_public_ip() {
    ping -c 1 ipv4.ip.sb > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            public_ip="NOT internet"
        else
            public_ip=$(curl -s ipv4.ip.sb)
        fi
}

get_cols() {
    local blocks blocks2 cols

    printf -v block_width "%${block_width}s"

        for ((block_range[0]; block_range[0]<=block_range[1]; block_range[0]++)); do
            case ${block_range[0]} in
                [0-7])
                    printf -v blocks  '%b\e[3%bm\e[4%bm%b' \
                        "$blocks" "${block_range[0]}" "${block_range[0]}" "$block_width"
                ;;

                *)
                    printf -v blocks2 '%b\e[38;5;%bm\e[48;5;%bm%b' \
                        "$blocks2" "${block_range[0]}" "${block_range[0]}" "$block_width"
                ;;
            esac
        done

        printf -v block_spaces "%${block_height}s"

        [[ "$blocks"  ]] && cols+="${block_spaces// /${blocks}[mnl}"
        [[ "$blocks2" ]] && cols+="${block_spaces// /${blocks2}[mnl}"

        cols=${cols%%nl}
        cols=${cols//nl/
[${text_padding}C}

        ((info_height+=block_range[1]>7?block_height+2:block_height+1))

        printf '\n\e[%bC%b\n' "$text_padding" "${cols}"

    unset -v blocks blocks2 cols
}

dynamic_prompt() {
    ((lines=lines>info_height?lines-info_height-1:1))
    printf -v nlines "%${lines}s"
    printf "%b" "${nlines// /\\n}"
}

Check() {
    if [[ $UID -ne 0 ]]; then
        Echo_ERROR "Please run with sudo or root privileged account!"
        exit 1
    else
        printf "$(color "3")\e[1m>> k1t_Initializing\n"
        ping -c 1 223.5.5.5 > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            Echo_ERROR "NOT internet!"
            exit 1
        fi
    fi
}

mk_dir() {
    dir="./tool/"
    dir1=$dir"scan/"
    dir2=$dir"vuln/"
    dir3=$dir"webshell/"
    dir4=$dir"subdomain/"
    dir5=$dir"dev/"
    dir6=$dir"dict/"
    dir7=$dir"privacy/"
    dir8=$dir"other/"

    if [ ! -d $dir ];then
        mkdir $dir
        mkdir -p $dir1
        mkdir -p $dir2
        mkdir -p $dir3
        mkdir -p $dir4
        mkdir -p $dir5
        mkdir -p $dir6
        mkdir -p $dir7
        mkdir -p $dir8
        chmod 777 -R $dir
        Echo_INFOR "$dir folder created.\n"
    else
        chmod 777 -R $dir
        Echo_INFOR "$dir folder already exists.\n"
    fi
}

usage() {
    set_colors 3 7 4 2 1
    printf "%b" "\
$c1>> Usage: bash k1t.sh [optiones]$c2

${c3}k1t$c2 is a ${c5}Red Team$c2 Weaponization Tool Rapid Deployment BASH Script. 
${c3}k$c2=$c4{${c3}k$c4}${c2}ali
${c3}1$c2=ka$c4{${c3}l$c4}${c2}i
${c3}t$c2=$c4{${c3}t$c4}${c2}ool

Options:
    -h, --help            Show basic help message and exit
    --pull-list           Show list
    --pull-all            Pull all
    --pull-dev            Pull dev
    --up-sources          Update-sources.list

Privacy:
    --pull-kali-whoami    Pull kali-whoami

Vuln:
    --pull-goby           Pull goby
    --pull-xray           Pull xray
    --pull-pocassist      Pull pocassist
    --pull-yakit          Pull yakit
    --pull-nuclei         Pull nuclei

Webpath_bruteforce:
    --pull-dirsearch      Pull dirsearch
    --pull-feroxbuster    Pull feroxbuster
    --pull-sublist3r      Pull sublist3r

Subdomain:
    --pull-ksubdomain     Pull ksubdomain
    --pull-subfinder      Pull subfinder
    --pull-wanli          Pull WanLi

Webshell:
    --pull-godzilla       Pull Godzilla
    --pull-behinder       Pull Behinder

Scan:
    --pull-fscan          Pull fscan
    --pull-gogo           Pull gogo
    --pull-ffuf           Pull ffuf
    --pull-yasso          Pull Yasso
    --pull-ServerScan     Pull ServerScan
    --pull-darkeye        Pull DarkEye
    --pull-netspy         Pull netspy
    --pull-rustscan       Pull RustScan
    --pull-httpx          Pull httpx
    --pull-amass          Pull Amass
    --pull-gobuster       Pull Gobuster
    --pull-zscan          PUll Zscan
    --pull-dismap         Pull dismap
    --pull-ladon          Pull LadonGo

Dict:
    --pull-fuzzdicts      Pull fuzzDicts
    --pull-bdict          Pull Blasting_dictionary
    --pull-superwordlist  Pull SuperWordlist
    --pull-dof            Pull Dictionary-Of-Pentesting

Dev_Tools:
    --pull-pip2           Pull pip2
    --pull-pip3           Pull pip3
    --pull-golang         Pull Golang
"
}

get_args() {
    pull_info
    while [[ "$1" ]]; do
        case $1 in
            # Options
            "-h" | "--help") usage ;;
            "--pull-list") pull_list ;;
            "--pull-all") usage ;;
            "--pull-dev") pull_dev ;;
            "--up-sources") up-sources ;;
            # Privacy
            "--pull-kali-whoami") pull_kali_whoami ;;
            # Vuln
            "--pull-goby") pull_goby ;;
            "--pull-xray") pull_xray ;;
            "--pull-pocassist") pull_pocassist ;;
            "--pull-yakit") pull_yakit ;;
            "--pull-nuclei") pull_nuclei ;;
            # Webpath_bruteforce
            "--pull-dirsearch") pull_dirsearch ;;
            "--pull-feroxbuster") pull_feroxbuster ;;
            "--pull-sublist3r") pull_sublist3r ;;
            # Subdomain
            "--pull-ksubdomain") pull_ksubdomain ;;
            "--pull-subfinder") pull_subfinder ;;
            "--pull-wanli") pull_wanli ;;
            # Webshell
            "--pull-godzilla") pull_godzilla ;;
            "--pull-behinder") pull_behinder ;;
            # Scan
            "--pull-fscan") pull_fscan ;;
            "--pull-gogo") pull_gogo ;;
            "--pull-ffuf") pull_ffuf ;;
            "--pull-yasso") pull_yasso ;;
            "--pull-serverscan") pull_serverscan ;;
            "--pull-darkeye") pull_darkeye ;;
            "--pull-netspy") pull_netspy ;;
            "--pull-rustscan") pull_rustscan ;;
            "--pull-httpx") pull_httpx ;;
            "--pull-amass") pull_amass ;;
            "--pull-gobuster") pull_gobuster ;;
            "--pull-zscan") pull_zscan ;;
            "--pull-dismap") pull_dismap ;;
            "--pull-ladon") pull_ladon ;;
            # Dict
            "--pull-fuzzdicts") pull_fuzzdicts ;;
            "--pull-bdict") pull_bdict ;;
            "--pull-superwordlist") pull_superwordlist ;;
            "--pull-dof") pull_dof ;;
            # Dev_Tools
            "--pull-pip2") pull_pip2 ;;
            "--pull-pip3") pull_pip3 ;;
            "--pull-golang") pull_golang ;;
            *) printf "$(color "3")\e[1m>> Usage: bash k1t.sh [optiones] (-h/--help) \n";;
        esac
        shift
    done
}

pull_list() {
    set_colors 4 7 2
    printf "$c1[ALL_LIST]\n"
    # Privacy
    printf "${c1}[Privacy]\n"
    printf "$c1[kali-whoami]$c2: $c3$kali_whoami_version $c2$kali_whoami_update\n\n"
    # Vuln
    printf "${c1}[Vuln]\n"
    printf "$c1[Goby]$c2: $c3$goby_version $c2$goby_update\n"
    printf "$c1[xray]$c2: $c3$xray_version $c2$xray_update\n"
    printf "$c1[pocassist]$c2: $c3$pocassist_version $c2$pocassist_update\n"
    printf "$c1[yakit]$c2: $c3$yakit_version $c2$yakit_update\n"
    printf "$c1[nuclei]$c2: $c3$nuclei_version $c2$nuclei_update\n\n"
    # Webpath_bruteforce
    printf "$c1[Webpath_bruteforce]\n"
    printf "$c3[dirsearch]\n"
    printf "$c3[feroxbuster]\n"
    printf "$c3[sublist3r]\n\n"
    # Subdomain
    printf "${c1}[Subdomain]\n"
    printf "$c1[ksubdomain]$c2: $c3$ksubdomain_version $c2$ksubdomain_update\n"
    printf "$c1[subfinder]$c2: $c3$subfinder_version $c2$subfinder_update\n"
    printf "$c1[wanli]$c2: $c3$wanli_version $c2$wanli_update\n\n"
    # Webshell
    printf "${c1}[Webshell]\n"
    printf "$c1[Godzilla]$c2: $c3$godzilla_version $c2$godzilla_update\n"
    printf "$c1[Behinder]$c2: $c3$behinder_version $c2$behinder_update\n\n"
    # Scan
    printf "${c1}[Scan]\n"
    printf "$c1[fscan]$c2: $c3$fscan_version $c2$fscan_update\n"
    printf "$c1[gogo]$c2: $c3$gogo_version $c2$gogo_update\n"
    printf "$c1[ffuf]$c2: $c3$ffuf_version $c2$ffuf_update\n"
    printf "$c1[yasso]$c2: $c3$yasso_version $c2$yasso_update\n"
    printf "$c1[serverscan]$c2: $c3$serverscan_version $c2$serverscan_update\n"
    printf "$c1[darkeye]$c2: $c3$darkeye_version $c2$darkeye_update\n"
    printf "$c1[netspy]$c2: $c3$netspy_version $c2$netspy_update\n"
    printf "$c1[RustScan]$c2: $c3$rustscan_version $c2$rustscan_update\n"
    printf "$c1[httpx]$c2: $c3$httpx_version $c2$httpx_update\n"
    printf "$c1[Amass]$c2: $c3$amass_version $c2$amass_update\n"
    printf "$c1[Gobuster]$c2: $c3$gobuster_version $c2$gobuster_update\n"
    printf "$c1[Zscan]$c2: $c3$zscan_version $c2$zscan_update\n"
    printf "$c1[dismap]$c2: $c3$dismap_version $c2$dismap_update\n"
    printf "$c1[LadonGo]$c2: $c3$ladon_version $c2$ladon_update\n\n"
    # Dict
    printf "${c1}[Dict]\n"
    printf "$c1[fuzzDicts]$c2: $c3$fuzzdicts_version $c2$fuzzdicts_update\n"
    printf "$c1[Blasting_dictionary]$c2: $c3$bdict_version $c2$bdict_update\n"
    printf "$c1[SuperWordlist]$c2: $c3$superwordlist_version $c2$superwordlist_update\n"
    printf "$c1[Dictionary-Of-Pentesting]$c2: $c3$dof_version $c2$dof_update\n\n"
    # Dev_Tools
    printf "$c1[DEV_LIST]\n"
    printf "$c3[pip2]\n"
    printf "$c3[pip3]\n"
    printf "$c3[golang]\n\n"

    printf "$c1[USER_LIST]\n"
    for file in $dir*; do
        printf "$c2$file\n"
    done
}

use_proxy() {
    while read -p $'\033[1;33m\n>> Does the runtime need to use a proxy? [y/N]: \033[0m' input;do
        case $input in
            [yY])
                if [ "$state" == "git" ];then
                    Git_Proxy="https://cdn.ffffffff0x.com/?durl="
                else
                    pcs="/etc/proxychains.conf"
                    pcs4="/etc/proxychains4.conf"
                    if [ -e $pcs ]; then
                        mousepad $pcs
                        proxy="proxychains"
                    elif [ -e $pcs4 ]; then
                        mousepad $pcs4
                        proxy="proxychains"
                    else
                        Echo_ERROR "proxychains does not exist!"
                    fi
                fi
                break
                ;;
            [nN])
                proxy=
                Git_Proxy=
                break
                ;;
            "")
                Echo_INFOR "exit done."
                exit 1
            ;;
            *)
                Echo_ERROR "You can exit with Ctrl + C or empty input!"
            ;;
        esac
    done
}

pull_info() {
# Privacy
    kali_whoami="https://github.com/Ra7mo0on/kali-whoami"
    kali_whoami_version=${kali_whoami##*/}
    kali_whoami_update="https://github.com/Ra7mo0on/kali-whoami"

# Vuln
    goby="https://goby-storage-public.oss-cn-beijing.aliyuncs.com/2.4.8/goby-linux-x64-2.4.8-Community.zip"
    goby_version=${goby##*/}
    goby_update="https://gobies.org/updates.html"

    xray="https://github.com/chaitin/xray/releases/download/1.9.11/xray_linux_amd64.zip"
    xray_version=${xray##*/}
    xray_update="https://github.com/chaitin/xray/releases"

    pocassist="https://github.com/jweny/pocassist/releases/download/1.0.5/pocassist_linux_amd64.zip"
    pocassist_version=${pocassist##*/}
    pocassist_update="https://github.com/jweny/pocassist/releases"

    yakit="https://github.com/yaklang/yakit/releases/download/v1.0.12-sp10/Yakit-1.0.12-sp10-linux-amd64.AppImage"
    yakit_version=${yakit##*/}
    yakit_update="https://github.com/yaklang/yakit/releases"

    nuclei="https://github.com/projectdiscovery/nuclei/releases/download/v2.6.0/nuclei_2.6.0_linux_amd64.zip"
    nuclei_version=${nuclei##*/}
    nuclei_update="https://github.com/projectdiscovery/nuclei/releases"

    nuclei_templates="https://github.com/projectdiscovery/nuclei-templates/archive/refs/tags/v8.8.4.zip"
    nuclei_templates_version=${nuclei_templates##*/}
    nuclei_templates_update="https://github.com/projectdiscovery/nuclei-templates/releases"
# Subdomain
    ksubdomain="https://github.com/knownsec/ksubdomain/releases/download/v0.7/ksubdomain_linux.zip"
    ksubdomain_version=${ksubdomain##*/}
    ksubdomain_update="https://github.com/knownsec/ksubdomain/releases"

    subfinder="https://github.com/projectdiscovery/subfinder/releases/download/v2.4.9/subfinder_2.4.9_linux_amd64.zip"
    subfinder_version=${subfinder##*/}
    subfinder_update="https://github.com/projectdiscovery/subfinder/releases"

    wanli="https://github.com/ExpLangcn/WanLi/releases/download/1.2/Linux.zip"
    wanli_version=${wanli##*/}
    wanli_update="https://github.com/ExpLangcn/WanLi/releases"
# Webshell
    godzilla="https://github.com/BeichenDream/Godzilla/releases/download/v4.0.1-godzilla/godzilla.jar"
    godzilla_version=${godzilla##*/}
    godzilla_update="https://github.com/BeichenDream/Godzilla/releases"

    behinder="https://github.com/rebeyond/Behinder/releases/download/Behinder_v4.0.6/Behinder_v4.0.6.zip"
    behinder_version=${behinder##*/}
    behinder_update="https://github.com/rebeyond/Behinder/releases"
# Scan
    fscan="https://github.com/shadow1ng/fscan/releases/download/1.8.2/fscan_amd64"
    fscan_version=${fscan##*/}
    fscan_update="https://github.com/shadow1ng/fscan/releases"

    gogo="https://github.com/chainreactors/gogo/releases/download/v2.11.2/gogo_linux_amd64"
    gogo_version=${gogo##*/}
    gogo_update="https://github.com/chainreactors/gogo/releases"

    ffuf="https://github.com/ffuf/ffuf/releases/download/v2.0.0/ffuf_2.0.0_linux_amd64.tar.gz"
    ffuf_version=${ffuf##*/}
    ffuf_update="https://github.com/ffuf/ffuf/releases"

    yasso="https://github.com/sairson/Yasso/releases/download/v0.06-main/Yasso_linux_x64"
    yasso_version=${yasso##*/}
    yasso_update="https://github.com/sairson/Yasso/releases"

    serverscan_air="https://github.com/Adminisme/ServerScan/releases/download/v1.0.2/ServerScan_Air_v1.0.2_linux_adm64"
    serverscan_air_version=${serverscan_air##*/}
    serverscan_pro="https://github.com/Adminisme/ServerScan/releases/download/v1.0.2/ServerScan_Pro_v1.0.2_linux_adm64"
    serverscan_pro_version=${serverscan_pro##*/}
    serverscan_update="https://github.com/Adminisme/ServerScan/releases"

    darkeye="https://github.com/b1gcat/DarkEye/releases/download/v5.0.1/superscan_linux_amd64"
    darkeye_version=${darkeye##*/}
    darkeye_update="https://github.com/b1gcat/DarkEye/releases"

    netspy="https://github.com/shmilylty/netspy/releases/download/v0.0.4/netspy_linux_amd64.zip"
    netspy_version=${netspy##*/}
    netspy_update="https://github.com/shmilylty/netspy/releases"

    rustscan="https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb"
    rustscan_version=${rustscan##*/}
    rustscan_update="https://github.com/RustScan/RustScan/releases"

    httpx="https://github.com/projectdiscovery/httpx/releases/download/v1.1.5/httpx_1.1.5_linux_amd64.zip"
    httpx_version=${httpx##*/}
    httpx_update="https://github.com/projectdiscovery/httpx/releases"

    amass="https://github.com/OWASP/Amass/releases/download/v3.16.0/amass_linux_amd64.zip"
    amass_version=${amass##*/}
    amass_update="https://github.com/OWASP/Amass/releases"

    gobuster="https://github.com/OJ/gobuster/releases/download/v3.1.0/gobuster-linux-amd64.7z"
    gobuster_version=${gobuster##*/}
    gobuster_update="https://github.com/OJ/gobuster/releases"

    zscan="https://github.com/zyylhn/zscan/archive/refs/tags/1.4.4.zip"
    zscan_version=${zscan##*/}
    zscan_update="https://github.com/zyylhn/zscan/releases"

    dismap="https://github.com/zhzyker/dismap/releases/download/v0.2/dismap-linux-amd64"
    dismap_version=${dismap##*/}
    dismap_update="https://github.com/zhzyker/dismap/releases"

    ladon="https://github.com/k8gege/LadonGo/releases/download/v3.8/Ladon64.lnx"
    ladon_version=${ladon##*/}
    ladon_update="https://github.com/k8gege/LadonGo/releases"
# Dict
    fuzzdicts="https://github.com/TheKingOfDuck/fuzzDicts"
    fuzzdicts_version=${fuzzdicts##*/}
    fuzzdicts_update="https://github.com/TheKingOfDuck/fuzzDicts"

    bdict="https://github.com/rootphantomer/Blasting_dictionary"
    bdict_version=${bdict##*/}
    bdict_update="https://github.com/rootphantomer/Blasting_dictionary"

    superwordlist="https://github.com/fuzz-security/SuperWordlist"
    superwordlist_version=${superwordlist##*/}
    superwordlist_update="https://github.com/fuzz-security/SuperWordlist"

    dof="https://github.com/insightglacier/Dictionary-Of-Pentesting"
    dof_version=${dof##*/}
    dof_update="https://github.com/insightglacier/Dictionary-Of-Pentesting"
}

pull_dev() {
    pull_pip2
    pull_pip3
    pull_golang
}

up-sources() {
    sudo mv /etc/apt/sources.list /etc/apt/sources.list_bak
    contents="deb https://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
deb-src https://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib"
    echo "$contents" | sudo tee /etc/apt/sources.list > /dev/null &&
    sudo chmod 644 /etc/apt/sources.list &&
    sudo apt update &&
    sudo du -sh /var/cache/apt/archives &&
    sudo apt-get clean
}

# Privacy
pull_kali_whoami() {
    if [ ! -f "$dir7$kali_whoami_version" ]; then
        use_proxy
        $proxy git clone $kali_whoami $dir7$kali_whoami_version
    else
        Echo_INFOR "kali-whoami is already installed in: $dir7$kali_whoami_version"
        Echo_INFOR "Update URL: $kali_whoami_update"
    fi
}

# Vuln
pull_goby() {
    if [ ! -f "$dir2/$goby_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$goby -O $dir2/$goby_version
    else
        Echo_INFOR "Goby is already installed in: $dir2$goby_version"
        Echo_INFOR "Update URL: $goby_update"
    fi
}

pull_xray() {
    if [ ! -f "$dir2$xray_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$xray -O $dir2$xray_version
    else
        Echo_INFOR "xray is already installed in: $dir2$xray_version"
        Echo_INFOR "Update URL: $xray_update"
    fi
}

pull_pocassist() {
    if [ ! -f "$dir2$pocassist_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$pocassist -O $dir2$pocassist_version
    else
        Echo_INFOR "pocassist is already installed in: $dir2$pocassist_version"
        Echo_INFOR "Update URL: $pocassist_update"
    fi
}

pull_yakit() {
    if [ ! -f "$dir2$yakit_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$yakit -O $dir2$yakit_version
    else
        Echo_INFOR "yakit is already installed in: $dir2$yakit_version"
        Echo_INFOR "Update URL: $yakit_update"
    fi
}

pull_nuclei() {
    if [ ! -f "$dir2$nuclei_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$nuclei -O $dir2$nuclei_version
    else
        Echo_INFOR "nuclei is already installed in: $dir2$nuclei_version"
        Echo_INFOR "Update URL: $nuclei_update"
    fi

    if [ ! -f "$dir2$nuclei_templates_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$nuclei_templates -O $dir2$nuclei_templates_version
    else
        Echo_INFOR "nuclei-templates is already installed in: $dir2$nuclei_templates_version"
        Echo_INFOR "Update URL: $nuclei_templates_update"
    fi
}

# Webpath_bruteforce
pull_dirsearch() {
    sudo apt install dirsearch -y
}

pull_feroxbuster() {
    sudo apt install feroxbuster -y
}

pull_sublist3r() {
    sudo apt install sublist3r -y
}

# Subdomain
pull_ksubdomain() {
    if [ ! -f "$dir4$ksubdomain_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$ksubdomain -O $dir4$ksubdomain_version
    else
        Echo_INFOR "ksubdomain is already installed in: $dir4$ksubdomain_version"
        Echo_INFOR "Update URL: $ksubdomain_update"
    fi
}

pull_subfinder() {
    if [ ! -f "$dir4$subfinder_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$subfinder -O $dir4$subfinder_version
    else
        Echo_INFOR "subfinder is already installed in: $dir4$subfinder_version"
        Echo_INFOR "Update URL: $subfinder_update"
    fi
}

pull_wanli() {
    if [ ! -f "$dir4$wanli_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$wanli -O $dir4$wanli_version
    else
        Echo_INFOR "WanLi is already installed in: $dir4$wanli_version"
        Echo_INFOR "Update URL: $wanli_update"
    fi
}

# Webshell
pull_godzilla() {
    dir=$dir3"godzilla"
    if [ ! -f "$dir$godzilla_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$godzilla -O $dir$godzilla_version
    else
        Echo_INFOR "Godzilla is already installed in: $dir$godzilla_version"
        Echo_INFOR "Update URL: $godzilla_update"
    fi
}

pull_behinder() {
    if [ ! -f "$dir3$behinder_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$behinder -O $dir3$behinder_version
    else
        Echo_INFOR "Behinder is already installed in: $dir3$behinder_version"
        Echo_INFOR "Update URL: $behinder_update"
    fi
}

# Scan
pull_fscan() {
    if [ ! -f "$dir1$fscan_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$fscan -O $dir1$fscan_version
    else
        Echo_INFOR "fscan is already installed in: $dir1$fscan_version"
        Echo_INFOR "Update URL: $fscan_update"
    fi
}

pull_gogo() {
    if [ ! -f "$dir1$gogo_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$gogo -O $dir1$gogo_version
    else
        Echo_INFOR "gogo is already installed in: $dir1$gogo_version"
        Echo_INFOR "Update URL: $gogo_update"
    fi
}

pull_ffuf() {
    if [ ! -f "$dir1$ffuf_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$ffuf -O $dir1$ffuf_version
    else
        Echo_INFOR "ffuf is already installed in: $dir1$ffuf_version"
        Echo_INFOR "Update URL: $ffuf_update"
    fi
}

pull_yasso() {
    if [ ! -f "$dir1$yasso_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$yasso -O $dir1$yasso_version
    else
        Echo_INFOR "Yasso is already installed in: $dir1$yasso_version"
        Echo_INFOR "Update URL: $yasso_update"
    fi
}

pull_serverscan() {
    if [[ ! -f "$dir1$serverscan_air_version" && ! -f "$dir1$serverscan_pro_version" ]]; then
        state="git"
        use_proxy
        wget $Git_Proxy$serverscan_air -O $dir1$serverscan_air_version
        wget $Git_Proxy$serverscan_pro -O $dir1$serverscan_pro_version
    else
        Echo_INFOR "serverscan_air is already installed in: $dir1$serverscan_air_version"
        Echo_INFOR "serverscan_pro is already installed in: $dir1$serverscan_pro_version"
        Echo_INFOR "Update URL: $serverscan_update"
    fi
}

pull_darkeye() {
    if [ ! -f "$dir1$darkeye_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$darkeye -O $dir1$darkeye_version
    else
        Echo_INFOR "darkeye is already installed in: $dir1$darkeye_version"
        Echo_INFOR "Update URL: $darkeye_update"
    fi
}

pull_netspy() {
    if [ ! -f "$dir1$netspy_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$netspy -O $dir1$netspy_version
    else
        Echo_INFOR "netspy is already installed in: $dir1$netspy_version"
        Echo_INFOR "Update URL: $netspy_update"
    fi
}

pull_rustscan() {
    if [ ! -f "$dir1$rustscan_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$rustscan -O $dir1$rustscan_version
    else
        Echo_INFOR "RustScan is already installed in: $dir1$rustscan_version"
        Echo_INFOR "Update URL: $rustscan_update"
    fi
}

pull_httpx() {
    if [ ! -f "$dir1$httpx_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$httpx -O $dir1$httpx_version
    else
        Echo_INFOR "httpx is already installed in: $dir1$httpx_version"
        Echo_INFOR "Update URL: $httpx_update"
    fi
}

pull_amass() {
    if [ ! -f "$dir1$amass_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$amass -O $dir1$amass_version
    else
        Echo_INFOR "Amass is already installed in: $dir1$amass_version"
        Echo_INFOR "Update URL: $amass_update"
    fi
}

pull_gobuster() {
    if [ ! -f "$dir1$gobuster_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$gobuster -O $dir1$gobuster_version
    else
        Echo_INFOR "Gobuster is already installed in: $dir1$gobuster_version"
        Echo_INFOR "Update URL: $gobuster_update"
    fi
}

pull_zscan() {
    if [ ! -f "$dir1$zscan_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$zscan -O $dir1$zscan_version
    else
        Echo_INFOR "Zscan is already installed in: $dir1$zscan_version"
        Echo_INFOR "Update URL: $zscan_update"
    fi
}

pull_dismap() {
    if [ ! -f "$dir1$dismap_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$dismap -O $dir1$dismap_version
    else
        Echo_INFOR "dismap is already installed in: $dir1$dismap_version"
        Echo_INFOR "Update URL: $dismap_update"
    fi
}

pull_ladon() {
    if [ ! -f "$dir1$ladon_version" ]; then
        state="git"
        use_proxy
        wget $Git_Proxy$ladon -O $dir1$ladon_version
    else
        Echo_INFOR "LadonGo is already installed in: $dir1$ladon_version"
        Echo_INFOR "Update URL: $ladon_update"
    fi
}

# Dict
pull_fuzzdicts() {
    if [ ! -f "$dir6$fuzzdicts_version" ]; then
        use_proxy
        $proxy git clone $fuzzdicts $dir6$fuzzdicts_version
    else
        Echo_INFOR "fuzzDicts is already installed in: $dir6$fuzzdicts_version"
        Echo_INFOR "Update URL: $fuzzdicts_update"
    fi
}

pull_bdict() {
    if [ ! -f "$dir6$bdict_version" ]; then
        use_proxy
        $proxy git clone $bdict $dir6$bdict_version
    else
        Echo_INFOR "Blasting_dictionary is already installed in: $dir6$bdict_version"
        Echo_INFOR "Update URL: $bdict_update"
    fi
}

pull_superwordlist() {
    if [ ! -f "$dir6$superwordlist_version" ]; then
        use_proxy
        $proxy git clone $superwordlist $dir6$superwordlist_version
    else
        Echo_INFOR "SuperWordlist is already installed in: $dir6$superwordlist_version"
        Echo_INFOR "Update URL: $superwordlist_update"
    fi
}

pull_dof() {
    if [ ! -f "$dir6$dof_version" ]; then
        use_proxy
        $proxy git clone $dof $dir6$dof_version
    else
        Echo_INFOR "Dictionary-Of-Pentesting is already installed in: $dir6$dof_version"
        Echo_INFOR "Update URL: $dof_update"
    fi
}

# Dev_Tools
pull_pip2() {
    if ! type pip2 >/dev/null 2>&1; then
        use_proxy
        $proxy wget -nc https://bootstrap.pypa.io/pip/2.7/get-pip.py -C $dir5
        python2 $dir5"get-pip.py"
    else
        Echo_INFOR "pip2 is already installed in: $(which pip2)"
        Echo_INFOR "version: $(pip2 --version)"
        Echo_INFOR "update: python2 -m pip install --upgrade pip"
        Echo_INFOR "uninstall: python2 -m pip uninstall pip"
    fi
}

pull_pip3() {
    if ! type pip3 >/dev/null 2>&1; then
        use_proxy
        $proxy apt-get install python3-pip -y
    else
        Echo_INFOR "pip3 is already installed in: $(which pip3)"
        Echo_INFOR "version: $(pip3 --version)"
        Echo_INFOR "update: python3 -m pip install --upgrade pip"
        Echo_INFOR "uninstall: apt autoremove python3-pip"
    fi
}

pull_golang() {
    if ! type go >/dev/null 2>&1; then
        use_proxy
        $proxy apt-get install golang -y
    else
        Echo_INFOR "golang is already installed in: $(which go)"
        Echo_INFOR "version: $(go version)"
        Echo_INFOR "uninstall: apt autoremove golang"
    fi
}

Echo_ERROR() {
    set_colors 4 1 7
    printf "$c1$(date +"%H:%M:%S") $c2$2[ERROR] $c3- $c2$1\n"
}

Echo_INFOR() {
    set_colors 4 2 7
    printf "$c1$(date +"%H:%M:%S") $c2$2[INFO] $c3- $c2$1\n$c3"
}

ini() {
    if [[ $(hostname) != "kali" ]]; then
        Echo_ERROR "Please run in KALI!"
        exit 1
    fi

    printf '\e[?25l\e[?7l'

    underline_char="-"
    block_range=(0 15)
    block_width=3
    block_height=1
    gap=3

    read -ra uname <<< "$(uname -srm)"
    kernel_name="${uname[0]}"
    kernel_version="${uname[1]}"
    kernel_machine="${uname[2]}"
}

main() {
    if [ $# -eq 0 ]; then
        ini
        print_ascii
        print_info
        dynamic_prompt
    else
        Check
        mk_dir
        get_args "$@"
    fi
    return 0
}

main "$@"