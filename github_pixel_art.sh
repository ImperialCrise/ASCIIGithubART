#!/bin/bash
set -e

VERSION="2.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="${SCRIPT_DIR}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

TEXT=""
YEAR=""
ACTION=""
PREVIEW_ONLY=false
FORCE=false

declare -A INTENSITY
INTENSITY[4]=25
INTENSITY[3]=15
INTENSITY[2]=8
INTENSITY[1]=3

declare -A FONT

FONT[A]="0110 1001 1001 1111 1001 1001 1001"
FONT[B]="1110 1001 1001 1110 1001 1001 1110"
FONT[C]="0111 1000 1000 1000 1000 1000 0111"
FONT[D]="1110 1001 1001 1001 1001 1001 1110"
FONT[E]="1111 1000 1111 1000 1000 1000 1111"
FONT[F]="1111 1000 1000 1110 1000 1000 1000"
FONT[G]="0110 1001 1000 1011 1001 1001 0110"
FONT[H]="1001 1001 1001 1111 1001 1001 1001"
FONT[I]="111 010 010 010 010 010 111"
FONT[J]="0011 0010 0010 0010 0010 1010 0100"
FONT[K]="1001 1010 1100 1000 1100 1010 1001"
FONT[L]="1000 1000 1000 1000 1000 1000 1111"
FONT[M]="10001 11011 10101 10001 10001 10001 10001"
FONT[N]="1001 1101 1011 1001 1001 1001 1001"
FONT[O]="0110 1001 1001 1001 1001 1001 0110"
FONT[P]="1111 1001 1111 1000 1000 1000 1000"
FONT[Q]="0110 1001 1001 1001 1011 0110 0001"
FONT[R]="1110 1001 1001 1110 1010 1001 1001"
FONT[S]="0111 1000 1000 0110 0001 0001 1110"
FONT[T]="111 010 010 010 010 010 010"
FONT[U]="1001 1001 1001 1001 1001 1001 0110"
FONT[V]="1001 1001 1001 1001 1001 0110 0110"
FONT[W]="10001 10001 10001 10101 10101 11011 10001"
FONT[X]="1001 1001 0110 0110 0110 1001 1001"
FONT[Y]="101 101 101 010 010 010 010"
FONT[Z]="1111 0001 0010 0100 1000 1000 1111"

FONT[a]="0000 0000 0110 0001 0111 1001 0111"
FONT[b]="1000 1000 1110 1001 1001 1001 1110"
FONT[c]="0000 0000 0110 1000 1000 1000 0110"
FONT[d]="0001 0001 0111 1001 1001 1001 0111"
FONT[e]="0000 0000 0110 1001 1111 1000 0110"
FONT[f]="0010 0100 0100 1110 0100 0100 0100"
FONT[g]="0000 0000 0111 1001 0111 0001 0110"
FONT[h]="1000 1000 1110 1001 1001 1001 1001"
FONT[i]="010 000 010 010 010 010 010"
FONT[j]="001 000 001 001 001 101 010"
FONT[k]="1000 1000 1001 1010 1100 1010 1001"
FONT[l]="110 010 010 010 010 010 111"
FONT[m]="00000 00000 11010 10101 10101 10101 10101"
FONT[n]="0000 0000 1110 1001 1001 1001 1001"
FONT[o]="0000 0000 0110 1001 1001 1001 0110"
FONT[p]="0000 0000 1110 1001 1110 1000 1000"
FONT[q]="0000 0000 0111 1001 0111 0001 0001"
FONT[r]="000 000 011 100 100 100 100"
FONT[s]="000 000 011 100 010 001 110"
FONT[t]="010 010 111 010 010 010 001"
FONT[u]="0000 0000 1001 1001 1001 1001 0111"
FONT[v]="0000 0000 1001 1001 1001 0110 0110"
FONT[w]="00000 00000 10001 10001 10101 10101 01010"
FONT[x]="0000 0000 1001 0110 0110 0110 1001"
FONT[y]="0000 0000 1001 1001 0111 0001 0110"
FONT[z]="0000 0000 1111 0010 0100 1000 1111"

FONT[0]="0110 1001 1011 1101 1001 1001 0110"
FONT[1]="010 110 010 010 010 010 111"
FONT[2]="0110 1001 0001 0010 0100 1000 1111"
FONT[3]="1110 0001 0001 0110 0001 0001 1110"
FONT[4]="0010 0110 1010 1111 0010 0010 0010"
FONT[5]="1111 1000 1110 0001 0001 0001 1110"
FONT[6]="0110 1000 1000 1110 1001 1001 0110"
FONT[7]="1111 0001 0010 0010 0100 0100 0100"
FONT[8]="0110 1001 1001 0110 1001 1001 0110"
FONT[9]="0110 1001 1001 0111 0001 0001 0110"

FONT[" "]="00 00 00 00 00 00 00"
FONT[!]="1 1 1 1 1 0 1"
FONT[.]="0 0 0 0 0 0 1"
FONT[,]="00 00 00 00 00 01 10"
FONT[-]="000 000 000 111 000 000 000"
FONT[_]="0000 0000 0000 0000 0000 0000 1111"
FONT[:]="0 0 1 0 0 1 0"
FONT[/]="0001 0001 0010 0100 0100 1000 1000"
FONT["'"]="1 1 0 0 0 0 0"
FONT['"']="101 101 000 000 000 000 000"

MINECRAFT_SCENE=(
"00000000000110000000"
"00000000001111100000"
"00000000011111110000"
"00000000001111100000"
"00300000000022000000"
"00300033000022000000"
"22222222222222222222"
)

BTC_ICON=(
"010"
"111"
"101"
"110"
"101"
"111"
"010"
)

show_banner() {
    echo -e "${PURPLE}"
    echo '  ╔═══════════════════════════════════════════════╗'
    echo '  ║     🎨 GitHub Pixel Art Generator 🎨          ║'
    echo '  ║         Make your contribution graph          ║'
    echo '  ║              look awesome!                    ║'
    echo '  ╚═══════════════════════════════════════════════╝'
    echo -e "${NC}"
}

show_help() {
    show_banner
    echo -e "${BOLD}USAGE${NC}"
    echo "    ./github_pixel_art.sh <command> [options]"
    echo ""
    echo -e "${BOLD}COMMANDS${NC}"
    echo -e "    ${GREEN}generate${NC}     Generate pixel art commits"
    echo -e "    ${GREEN}preview${NC}      Preview the design without generating"
    echo -e "    ${GREEN}reset${NC}        Remove pixel art commits for a year"
    echo -e "    ${GREEN}reset-all${NC}    Clear all git history"
    echo -e "    ${GREEN}list${NC}         List available templates"
    echo ""
    echo -e "${BOLD}OPTIONS${NC}"
    echo -e "    ${CYAN}-t, --text${NC} <TEXT>      Text to display (e.g., 'HELLO')"
    echo -e "    ${CYAN}-y, --year${NC} <YEAR>      Target year (e.g., 2016)"
    echo -e "    ${CYAN}-T, --template${NC} <NAME>  Use a template (bitcoin, minecraft)"
    echo -e "    ${CYAN}-p, --preview${NC}          Preview only, don't generate"
    echo -e "    ${CYAN}-f, --force${NC}            Skip confirmation prompts"
    echo -e "    ${CYAN}-h, --help${NC}             Show this help message"
    echo -e "    ${CYAN}-v, --version${NC}          Show version"
    echo ""
    echo -e "${BOLD}EXAMPLES${NC}"
    echo -e "    ${DIM}# Preview text for 2020${NC}"
    echo "    ./github_pixel_art.sh preview --text 'HELLO' --year 2020"
    echo ""
    echo -e "    ${DIM}# Generate Bitcoin design for 2009${NC}"
    echo "    ./github_pixel_art.sh generate --template bitcoin --year 2009"
    echo ""
    echo -e "    ${DIM}# Generate text with Minecraft scene${NC}"
    echo "    ./github_pixel_art.sh generate --text 'iCrise' --template minecraft --year 2016"
    echo ""
    echo -e "    ${DIM}# Reset commits for 2016${NC}"
    echo "    ./github_pixel_art.sh reset --year 2016"
    echo ""
    echo -e "    ${DIM}# Clear everything${NC}"
    echo "    ./github_pixel_art.sh reset-all --force"
    echo ""
    echo -e "${BOLD}TEMPLATES${NC}"
    echo -e "    ${YELLOW}bitcoin${NC}      Bitcoin logo with ₿ icons (best for 2009)"
    echo -e "    ${YELLOW}minecraft${NC}    Adds tree and terrain to the right"
    echo ""
}

show_version() {
    echo -e "${BOLD}GitHub Pixel Art Generator${NC} v${VERSION}"
}

log_info() {
    echo -e "${BLUE}ℹ${NC}  $1"
}

log_success() {
    echo -e "${GREEN}✓${NC}  $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC}  $1"
}

log_error() {
    echo -e "${RED}✗${NC}  $1"
}

get_start_date() {
    local year=$1
    local first_day_of_year=$(date -d "$year-01-01" +%u)
    
    if [ "$first_day_of_year" -eq 7 ]; then
        echo "$year-01-01"
    else
        local days_to_subtract=$first_day_of_year
        date -d "$year-01-01 - $days_to_subtract days" +%Y-%m-%d
    fi
}

text_to_grid() {
    local text="$1"
    local grid=()
    
    for row in {0..6}; do
        grid[$row]=""
    done
    
    for (( i=0; i<${#text}; i++ )); do
        local char="${text:$i:1}"
        local pattern="${FONT[$char]}"
        
        if [ -z "$pattern" ]; then
            pattern="${FONT[ ]}"
        fi
        
        local rows=($pattern)
        
        for row in {0..6}; do
            grid[$row]+="${rows[$row]}"
            if [ $i -lt $((${#text}-1)) ]; then
                grid[$row]+="0"
            fi
        done
    done
    
    for row in {0..6}; do
        echo "${grid[$row]}" | sed 's/1/4/g'
    done
}

build_minecraft_scene() {
    local text="$1"
    local start_offset="$2"
    local total_width=52
    
    local text_grid=()
    while IFS= read -r line; do
        text_grid+=("$line")
    done <<< "$(text_to_grid "$text")"
    
    local text_width=${#text_grid[0]}
    local scene_width=${#MINECRAFT_SCENE[0]}
    local gap=$((total_width - start_offset - text_width - scene_width - 2))
    
    if [ $gap -lt 2 ]; then
        gap=2
    fi
    
    local full_grid=()
    for row in {0..6}; do
        local line=""
        for ((c=0; c<start_offset; c++)); do
            line+="0"
        done
        line+="${text_grid[$row]}"
        for ((c=0; c<gap; c++)); do
            line+="0"
        done
        line+="${MINECRAFT_SCENE[$row]}"
        full_grid+=("$line")
    done
    
    for row in {0..6}; do
        echo "${full_grid[$row]}"
    done
}

build_bitcoin_scene() {
    local total_width=52
    
    local text_grid=()
    while IFS= read -r line; do
        text_grid+=("$line")
    done <<< "$(text_to_grid "BITCOIN")"
    
    local text_width=${#text_grid[0]}
    local left_margin=$(( (total_width - text_width) / 2 ))
    local right_margin=$((total_width - left_margin - text_width))
    
    local full_grid=()
    for row in {0..6}; do
        local line=""
        for ((c=0; c<left_margin; c++)); do
            local pos_in_icon=$((c % 4))
            if [ $pos_in_icon -lt 3 ]; then
                local icon_pixel="${BTC_ICON[$row]:$pos_in_icon:1}"
                if [ "$icon_pixel" == "1" ]; then
                    line+="1"
                else
                    line+="0"
                fi
            else
                line+="0"
            fi
        done
        line+="${text_grid[$row]}"
        for ((c=0; c<right_margin; c++)); do
            local pos_in_icon=$((c % 4))
            if [ $pos_in_icon -lt 3 ]; then
                local icon_pixel="${BTC_ICON[$row]:$pos_in_icon:1}"
                if [ "$icon_pixel" == "1" ]; then
                    line+="1"
                else
                    line+="0"
                fi
            else
                line+="0"
            fi
        done
        full_grid+=("$line")
    done
    
    for row in {0..6}; do
        echo "${full_grid[$row]}"
    done
}

preview_grid() {
    local grid_data="$1"
    local title="$2"
    
    echo ""
    echo -e "${BOLD}${title}${NC}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "$grid_data" | while read -r line; do
        echo "$line" | sed "s/4/█/g; s/3/▓/g; s/2/▒/g; s/1/░/g; s/0/ /g"
    done
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    local width=$(echo "$grid_data" | head -1 | tr -d '\n' | wc -c)
    echo -e "${DIM}Width: ${width} columns (max 52)${NC}"
    echo ""
    echo -e "${CYAN}Legend:${NC} █ = 25 commits  ▓ = 15  ▒ = 8  ░ = 3"
    echo ""
}

generate_commits_from_grid() {
    local grid_data="$1"
    local year="$2"
    local prefix="$3"
    
    cd "$REPO_DIR" || exit 1
    
    local start_date=$(get_start_date $year)
    log_info "Start date for $year: $start_date"
    
    local grid=()
    while IFS= read -r line; do
        grid+=("$line")
    done <<< "$grid_data"
    
    local width=${#grid[0]}
    local total_commits=0
    local total_pixels=0
    
    for row in {0..6}; do
        for col in $(seq 0 $((width-1))); do
            local pixel="${grid[$row]:$col:1}"
            if [ "$pixel" != "0" ]; then
                ((total_pixels++))
            fi
        done
    done
    
    log_info "Generating commits for $total_pixels pixels..."
    echo ""
    
    local current_pixel=0
    
    for col in $(seq 0 $((width-1))); do
        for row in {0..6}; do
            local pixel="${grid[$row]:$col:1}"
            
            if [ "$pixel" != "0" ]; then
                local commits_count=${INTENSITY[$pixel]:-5}
                local days_offset=$((col * 7 + row))
                local commit_date=$(date -d "$start_date + $days_offset days" +%Y-%m-%d)
                
                for c in $(seq 1 $commits_count); do
                    local commit_time=$(printf "%02d:%02d:%02d" $((RANDOM % 24)) $((RANDOM % 60)) $((RANDOM % 60)))
                    local full_date="$commit_date $commit_time"
                    
                    GIT_AUTHOR_DATE="$full_date" GIT_COMMITTER_DATE="$full_date" \
                        git commit --allow-empty -m "${prefix}[$year]: $commit_date #$c" --quiet
                    
                    ((total_commits++))
                done
                
                ((current_pixel++))
                local percent=$((current_pixel * 100 / total_pixels))
                printf "\r${GREEN}Progress:${NC} [%-50s] %d%%" $(printf '#%.0s' $(seq 1 $((percent / 2)))) $percent
            fi
        done
    done
    
    echo ""
    echo ""
    log_success "Generated $total_commits commits!"
}

cmd_generate() {
    if [ -z "$YEAR" ]; then
        log_error "Year is required. Use --year <YEAR>"
        exit 1
    fi
    
    local grid_data=""
    local prefix="Art"
    local title=""
    
    if [ "$TEMPLATE" = "bitcoin" ]; then
        grid_data=$(build_bitcoin_scene)
        prefix="BTC"
        title="BITCOIN for $YEAR"
    elif [ "$TEMPLATE" = "minecraft" ]; then
        if [ -z "$TEXT" ]; then
            log_error "Text is required for minecraft template. Use --text <TEXT>"
            exit 1
        fi
        grid_data=$(build_minecraft_scene "$TEXT" 1)
        title="$TEXT + Minecraft for $YEAR"
    elif [ -n "$TEXT" ]; then
        grid_data=$(text_to_grid "$TEXT")
        title="$TEXT for $YEAR"
    else
        log_error "Either --text or --template is required"
        exit 1
    fi
    
    preview_grid "$grid_data" "$title"
    
    if [ "$PREVIEW_ONLY" = true ]; then
        return 0
    fi
    
    if [ "$FORCE" != true ]; then
        echo -e "${YELLOW}This will generate commits for year $YEAR${NC}"
        read -p "Continue? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_warning "Aborted."
            exit 0
        fi
    fi
    
    echo ""
    generate_commits_from_grid "$grid_data" "$YEAR" "$prefix"
    
    echo ""
    log_success "Done! Now run:"
    echo -e "    ${CYAN}git push origin main --force${NC}"
}

cmd_preview() {
    PREVIEW_ONLY=true
    cmd_generate
}

cmd_reset() {
    if [ -z "$YEAR" ]; then
        log_error "Year is required. Use --year <YEAR>"
        exit 1
    fi
    
    cd "$REPO_DIR" || exit 1
    
    log_info "Searching for pixel art commits in $YEAR..."
    
    local art_count=$(git log --oneline --grep="Art\[$YEAR\]" 2>/dev/null | wc -l)
    local btc_count=$(git log --oneline --grep="BTC\[$YEAR\]" 2>/dev/null | wc -l)
    local commit_count=$((art_count + btc_count))
    
    if [ "$commit_count" -eq 0 ]; then
        log_warning "No pixel art commits found for $YEAR"
        return 0
    fi
    
    echo ""
    echo -e "Found ${BOLD}$commit_count${NC} pixel art commits:"
    echo -e "  • Art commits: $art_count"
    echo -e "  • BTC commits: $btc_count"
    echo ""
    
    if [ "$FORCE" != true ]; then
        log_warning "This will rewrite git history!"
        read -p "Remove these commits? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_warning "Aborted."
            exit 0
        fi
    fi
    
    log_info "Removing commits..."
    
    local pattern1="Art\[$YEAR\]"
    local pattern2="BTC\[$YEAR\]"
    
    GIT_SEQUENCE_EDITOR="sed -i '/$pattern1/d; /$pattern2/d'" git rebase -i --root 2>/dev/null || {
        log_warning "Rebase method failed, using alternative..."
        git rebase --abort 2>/dev/null || true
        
        local commits_to_keep=$(mktemp)
        git log --oneline --reverse | grep -v "Art\[$YEAR\]" | grep -v "BTC\[$YEAR\]" | cut -d' ' -f1 > "$commits_to_keep"
        
        if [ ! -s "$commits_to_keep" ]; then
            log_warning "All commits would be removed. Use reset-all instead."
            rm "$commits_to_keep"
            exit 1
        fi
        
        rm "$commits_to_keep"
    }
    
    git reflog expire --expire=now --all 2>/dev/null
    git gc --prune=now 2>/dev/null
    
    log_success "Removed $commit_count commits!"
    echo ""
    echo -e "Now run: ${CYAN}git push origin main --force${NC}"
}

cmd_reset_all() {
    echo ""
    log_warning "This will DELETE ALL git history!"
    echo ""
    
    if [ "$FORCE" != true ]; then
        read -p "Type 'yes' to confirm: " confirm
        if [ "$confirm" != "yes" ]; then
            log_warning "Aborted."
            exit 0
        fi
    fi
    
    cd "$REPO_DIR" || exit 1
    
    remote_url=$(git remote get-url origin 2>/dev/null || echo "")
    
    rm -rf .git
    git init -b main
    git commit --allow-empty -m "Initial commit"
    
    if [ -n "$remote_url" ]; then
        git remote add origin "$remote_url"
        log_info "Remote restored: $remote_url"
    fi
    
    log_success "All history cleared!"
    echo ""
    echo -e "Now run: ${CYAN}git push origin main --force${NC}"
}

cmd_list() {
    echo ""
    echo -e "${BOLD}Available Templates${NC}"
    echo ""
    echo -e "${YELLOW}bitcoin${NC}"
    echo "  BITCOIN text with ₿ icons on both sides"
    echo "  Best for: 2009 (Bitcoin's birth year)"
    echo ""
    build_bitcoin_scene | while read -r line; do
        echo "  $line" | sed "s/4/█/g; s/3/▓/g; s/2/▒/g; s/1/░/g; s/0/ /g"
    done
    echo ""
    echo -e "${YELLOW}minecraft${NC}"
    echo "  Your text + tree and terrain scene"
    echo "  Requires: --text option"
    echo ""
    build_minecraft_scene "TEXT" 1 | while read -r line; do
        echo "  $line" | sed "s/4/█/g; s/3/▓/g; s/2/▒/g; s/1/░/g; s/0/ /g"
    done
    echo ""
}

TEMPLATE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        generate|preview|reset|reset-all|list|help)
            ACTION="$1"
            shift
            ;;
        -t|--text)
            TEXT="$2"
            shift 2
            ;;
        -y|--year)
            YEAR="$2"
            shift 2
            ;;
        -T|--template)
            TEMPLATE="$2"
            shift 2
            ;;
        -p|--preview)
            PREVIEW_ONLY=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--version)
            show_version
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

case "$ACTION" in
    generate)
        show_banner
        cmd_generate
        ;;
    preview)
        show_banner
        cmd_preview
        ;;
    reset)
        show_banner
        cmd_reset
        ;;
    reset-all)
        show_banner
        cmd_reset_all
        ;;
    list)
        show_banner
        cmd_list
        ;;
    help|"")
        show_help
        ;;
    *)
        log_error "Unknown command: $ACTION"
        show_help
        exit 1
        ;;
esac
