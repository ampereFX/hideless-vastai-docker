#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    #"package-1"
    #"package-2"
)

NODES=(

)

WORKFLOWS=(

)

CHECKPOINT_MODELS=(
)

DIFFUSION_MODELS=(
    # Format: TAG "URL"
    z-image-turbo "https://huggingface.co/T5B/Z-Image-Turbo-FP8/resolve/main/z-image-turbo-fp8-e4m3fn.safetensors"
    # wan22 14b i2v default comfy weights
    wan22_14b_i2v_comfy "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors"
    wan22_14b_i2v_comfy "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors"
)

UNET_MODELS=(
    # wan 2.2 14b rapid all in one gguf (mega v12 q5_k)
    wan22_14b_rapid_aio "https://huggingface.co/befox/WAN2.2-14B-Rapid-AllInOne-GGUF/resolve/main/Mega-v12/wan2.2-rapid-mega-aio-v12-Q5_K.gguf"
    # wan 2.2 14b i2v gguf q6_k
    wan22_14b_i2v "https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/HighNoise/Wan2.2-I2V-A14B-HighNoise-Q6_K.gguf"
    wan22_14b_i2v "https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/LowNoise/Wan2.2-I2V-A14B-LowNoise-Q6_K.gguf"
    # turbowan 2.2 14b i2v gguf q6_k
    turbowan22_14b_i2v_gguf "https://huggingface.co/vantagewithai/TurboWan2.2-I2V-A14B-720P-ComfyUI-GGUF/resolve/main/high/TurboWan2.2-I2V-A14B-high-720P-Q6_K.gguf"
    turbowan22_14b_i2v_gguf "https://huggingface.co/vantagewithai/TurboWan2.2-I2V-A14B-720P-ComfyUI-GGUF/resolve/main/low/TurboWan2.2-I2V-A14B-low-720P-Q6_K.gguf"
    # wan 2.2 5b ti2v gguf q8_0
    wan22_5b_ti2v_gguf "https://huggingface.co/QuantStack/Wan2.2-TI2V-5B-GGUF/resolve/main/Wan2.2-TI2V-5B-Q8_0.gguf"
    # qwen image gguf q4_k_m
    qwen_image "https://huggingface.co/unsloth/Qwen-Image-GGUF/resolve/main/qwen-image-Q4_K_M.gguf"
    # qwen image edit 2511 gguf q4_k_m
    qwen_image_edit_2511 "https://huggingface.co/unsloth/Qwen-Image-Edit-2511-GGUF/resolve/main/qwen-image-edit-2511-Q4_K_M.gguf"
)

LORA_MODELS=(
    # Format: TAG "URL"
    # wan2.2 i2v lightning lora
    wan22_14b_i2v "https://huggingface.co/lightx2v/Wan2.2-Lightning/resolve/main/Wan2.2-I2V-A14B-4steps-lora-rank64-Seko-V1/high_noise_model.safetensors::wan22_i2v_14b_4steps_lora_rank64_seko_v1_high.safetensors"
    wan22_14b_i2v "https://huggingface.co/lightx2v/Wan2.2-Lightning/resolve/main/Wan2.2-I2V-A14B-4steps-lora-rank64-Seko-V1/low_noise_model.safetensors::wan22_i2v_14b_4steps_lora_rank64_seko_v1_low.safetensors"
    # wan2.2 distill loras
    wan22_14b_i2v "https://huggingface.co/lightx2v/Wan2.2-Distill-Loras/resolve/main/wan2.2_i2v_A14b_high_noise_lora_rank64_lightx2v_4step_1022.safetensors"
    wan22_14b_i2v "https://huggingface.co/lightx2v/Wan2.2-Distill-Loras/resolve/main/wan2.2_i2v_A14b_low_noise_lora_rank64_lightx2v_4step_1022.safetensors"
    # wan22 14b i2v lightx2v 4steps default comfy lora
    wan22_14b_i2v_comfy "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_high_noise.safetensors"
    wan22_14b_i2v_comfy "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_low_noise.safetensors"
    # qwen image edit 2511 lightning lora 4 steps
    qwen_image_edit_2511 "https://huggingface.co/lightx2v/Qwen-Image-Edit-2511-Lightning/resolve/main/Qwen-Image-Edit-2511-Lightning-4steps-V1.0-bf16.safetensors"
)

VAE_MODELS=(
    # flux vae
    base "https://huggingface.co/StableDiffusionVN/Flux/resolve/main/Vae/flux_vae.safetensors::ae.safetensors"
    # wan2.1 vae
    wan_base "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
    # wan2.2 vae
    wan_base "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors"
    # lightx2v wan autoencoders
    wan_base "https://huggingface.co/lightx2v/Autoencoders/resolve/main/lighttaew2_1.safetensors"
    wan_base "https://huggingface.co/lightx2v/Autoencoders/resolve/main/lighttaew2_2.safetensors"
    wan_base "https://huggingface.co/lightx2v/Autoencoders/resolve/main/lightvaew2_1.safetensors"
    wan_base "https://huggingface.co/lightx2v/Autoencoders/resolve/main/taew2_1.safetensors"
    wan_base "https://huggingface.co/lightx2v/Autoencoders/resolve/main/taew2_2.safetensors"
    # qwen image vae
    qwen_image_edit_2511 "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors"
)

ESRGAN_MODELS=(
    base "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"
    base "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
)

CONTROLNET_MODELS=(
)

TEXT_ENCODER_MODELS=(
    # umt5 xxl encoder gguf q5_k_m
    wan_base "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q5_K_M.gguf"
    # umt5 xxl encoder fp8 e4m3fn
    wan_base "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
    # qwen3 4b z-image-engineer
    z-image-turbo "https://huggingface.co/BennyDaBall/qwen3-4b-Z-Image-Engineer/resolve/main/Models/Qwen3-4b-Z-Engineer-V2-Q8_0.gguf"
    # qwen3 4b base
    qwen_image "https://huggingface.co/unsloth/Qwen3-4B-GGUF/resolve/main/Qwen3-4B-Q8_0.gguf"
    # qwen2.5 vl 7b instruct
    qwen_image_edit_2511 "https://huggingface.co/lmstudio-community/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/Qwen2.5-VL-7B-Instruct-Q6_K.gguf"
    # RENAMING: URL::FILENAME (Tag steht davor)
    qwen_image_edit_2511 "https://huggingface.co/lmstudio-community/Qwen2.5-VL-7B-Instruct-GGUF/resolve/main/mmproj-model-f16.gguf::Qwen2.5-VL-7B-Instruct-Q6_K.mmproj-model-f16.gguf"
)

VAE_APPROX_MODELS=(
    base "https://github.com/madebyollin/taesd/raw/main/taef1_decoder.pth"
    base "https://github.com/madebyollin/taesd/raw/main/taef1_encoder.pth"
    base "https://github.com/madebyollin/taesd/raw/main/taesd3_decoder.pth"
    base "https://github.com/madebyollin/taesd/raw/main/taesd3_encoder.pth"
    base "https://github.com/madebyollin/taesd/raw/main/taesdxl_decoder.pth"
    base "https://github.com/madebyollin/taesd/raw/main/taesdxl_encoder.pth"
    base "https://github.com/madebyollin/taesd/raw/main/taesd_decoder.pth"
    base "https://github.com/madebyollin/taesd/raw/main/taesd_encoder.pth"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

# --- COLORS ---
C_RESET_ALL='\033[0m'
C_RESET_FG='\033[39m'
C_BOLD='\033[1m'
C_RED='\033[31m'
C_GREEN='\033[32m'
C_YELLOW='\033[33m' 
C_BLUE='\033[34m'
C_PURPLE='\033[35m' 
C_CYAN='\033[36m'   
C_WHITE='\033[37m'
C_GREY='\033[90m'

# Global Download Queue
GLOBAL_DOWNLOAD_QUEUE=()

# --- TUI & INTERACTIVE LOGIC ---

TUI_URLS=()
TUI_TAGS=()
TUI_RENAMES=()
TUI_DIRS=()
TUI_SIZES=()
TUI_SIZES_BYTES=()
TUI_SELECTED=()
TUI_FINAL_NAMES=()

function tui_collect_data() {
    local dir_suffix="$1"
    shift
    local arr=("$@")
    local len=${#arr[@]}
    
    local target_dir="${COMFYUI_DIR}/models/${dir_suffix}"

    for ((i=0; i<len; i+=2)); do
        local tag="${arr[i]}"
        local entry="${arr[i+1]}"
        local url=""
        local rename=""
        
        if [[ "$entry" == *"::"* ]]; then
            url="${entry%%::*}"
            rename="${entry##*::}"
        else
            url="$entry"
            rename=""
        fi

        local final_name=""
        if [[ -n "$rename" ]]; then
            final_name="$rename"
        else
            final_name=$(basename "$url")
            final_name="${final_name%%\?*}"
        fi

        TUI_URLS+=("$url")
        TUI_TAGS+=("$tag")
        TUI_RENAMES+=("$rename")
        TUI_DIRS+=("$dir_suffix")
        TUI_FINAL_NAMES+=("$final_name")
        TUI_SIZES+=("...")
        TUI_SIZES_BYTES+=("0")
        TUI_SELECTED+=("true") 
    done
}

function tui_fetch_sizes() {
    local total=${#TUI_URLS[@]}
    printf "\n${C_BLUE}Fetching file sizes for %d models... (This might take a moment)${C_RESET_ALL}\n" "$total"
    
    for ((i=0; i<total; i++)); do
        local url="${TUI_URLS[i]}"
        printf "\r\033[K${C_GREY}[%d/%d] Checking: %s${C_RESET_ALL}" "$((i+1))" "$total" "${TUI_FINAL_NAMES[i]:0:40}..."
        
        local size_bytes
        if [[ -n $HF_TOKEN && $url =~ huggingface\.co ]]; then
             size_bytes=$(curl -sI -H "Authorization: Bearer $HF_TOKEN" -L "$url" | grep -i "content-length" | tail -n1 | awk '{print $2}' | tr -d '\r')
        else
             size_bytes=$(curl -sI -L "$url" | grep -i "content-length" | tail -n1 | awk '{print $2}' | tr -d '\r')
        fi

        if [[ -z "$size_bytes" || ! "$size_bytes" =~ ^[0-9]+$ ]]; then
            TUI_SIZES[i]="Unknown"
            TUI_SIZES_BYTES[i]=0
        else
            TUI_SIZES_BYTES[i]=$size_bytes
            if (( size_bytes > 1073741824 )); then
                TUI_SIZES[i]=$(awk -v val="$size_bytes" 'BEGIN {printf "%.2f GB", val/1073741824}')
            elif (( size_bytes > 1048576 )); then
                TUI_SIZES[i]=$(awk -v val="$size_bytes" 'BEGIN {printf "%.1f MB", val/1048576}')
            else
                TUI_SIZES[i]=$(awk -v val="$size_bytes" 'BEGIN {printf "%.0f KB", val/1024}')
            fi
        fi
    done
    printf "\n${C_GREEN}Done.${C_RESET_ALL}\n"
}

function tui_sort_data() {
    local count=${#TUI_TAGS[@]}
    local i j
    for ((i = 0; i < count; i++)); do
        for ((j = i + 1; j < count; j++)); do
            if [[ "${TUI_TAGS[i]}" > "${TUI_TAGS[j]}" ]]; then
                local tmp=${TUI_TAGS[i]}; TUI_TAGS[i]=${TUI_TAGS[j]}; TUI_TAGS[j]=$tmp
                tmp=${TUI_URLS[i]}; TUI_URLS[i]=${TUI_URLS[j]}; TUI_URLS[j]=$tmp
                tmp=${TUI_RENAMES[i]}; TUI_RENAMES[i]=${TUI_RENAMES[j]}; TUI_RENAMES[j]=$tmp
                tmp=${TUI_DIRS[i]}; TUI_DIRS[i]=${TUI_DIRS[j]}; TUI_DIRS[j]=$tmp
                tmp=${TUI_SIZES[i]}; TUI_SIZES[i]=${TUI_SIZES[j]}; TUI_SIZES[j]=$tmp
                tmp=${TUI_SIZES_BYTES[i]}; TUI_SIZES_BYTES[i]=${TUI_SIZES_BYTES[j]}; TUI_SIZES_BYTES[j]=$tmp
                tmp=${TUI_SELECTED[i]}; TUI_SELECTED[i]=${TUI_SELECTED[j]}; TUI_SELECTED[j]=$tmp
                tmp=${TUI_FINAL_NAMES[i]}; TUI_FINAL_NAMES[i]=${TUI_FINAL_NAMES[j]}; TUI_FINAL_NAMES[j]=$tmp
            fi
        done
    done
}

function tui_interactive_menu() {
    tui_collect_data "checkpoints" "${CHECKPOINT_MODELS[@]}"
    tui_collect_data "unet" "${UNET_MODELS[@]}"
    tui_collect_data "diffusion_models" "${DIFFUSION_MODELS[@]}"
    tui_collect_data "lora" "${LORA_MODELS[@]}"
    tui_collect_data "controlnet" "${CONTROLNET_MODELS[@]}"
    tui_collect_data "vae" "${VAE_MODELS[@]}"
    tui_collect_data "esrgan" "${ESRGAN_MODELS[@]}"
    tui_collect_data "vae_approx" "${VAE_APPROX_MODELS[@]}"
    tui_collect_data "text_encoders" "${TEXT_ENCODER_MODELS[@]}"

    tui_fetch_sizes
    tui_sort_data

    local cursor=0
    local count=${#TUI_URLS[@]}
    local key=""

    while true; do
        local total_bytes=0
        for ((i=0; i<count; i++)); do
            if [[ "${TUI_SELECTED[i]}" == "true" ]]; then
                total_bytes=$(($total_bytes + ${TUI_SIZES_BYTES[i]}))
            fi
        done
        
        local total_display=""
        if (( total_bytes > 1073741824 )); then
            total_display=$(awk -v val="$total_bytes" 'BEGIN {printf "%.2f GB", val/1073741824}')
        elif (( total_bytes > 1048576 )); then
            total_display=$(awk -v val="$total_bytes" 'BEGIN {printf "%.1f MB", val/1048576}')
        else
            total_display=$(awk -v val="$total_bytes" 'BEGIN {printf "%.0f KB", val/1024}')
        fi

        # Clear Screen ANSI
        printf "\033[2J\033[H"
        
        local term_lines=$(tput lines)
        if [[ -z "$term_lines" || "$term_lines" -lt 20 ]]; then term_lines=20; fi

        local header_height=5
        local footer_height=3
        local page_size=$((term_lines - header_height - footer_height))
        if [[ $page_size -lt 1 ]]; then page_size=1; fi

        local current_page=$((cursor / page_size))
        local total_pages=$(( (count + page_size - 1) / page_size ))
        local start_idx=$((current_page * page_size))
        local end_idx=$((start_idx + page_size))
        if [[ $end_idx -gt $count ]]; then end_idx=$count; fi
        
        printf "${C_BLUE}============================================================================================================================${C_RESET_ALL}\n"
        printf "  ${C_BOLD}SELECT MODELS${C_RESET_ALL} (Space: Toggle | a: All | t: Tag | Arrows: Move/Page | Enter: Download) [Page $((current_page+1))/$total_pages]\n"
        printf "${C_BLUE}============================================================================================================================${C_RESET_ALL}\n"
        
        # Calculate dynamic width for Filename to prevent wrap
        local term_cols=$(tput cols)
        if [[ -z "$term_cols" || "$term_cols" -lt 80 ]]; then term_cols=80; fi
        # Widths: Check(4) + Tag(21) + Type(16) + Size(11) + Separators(12) = ~64
        # Filename width = term_cols - 64
        local fn_width=$((term_cols - 64))
        if [[ $fn_width -lt 10 ]]; then fn_width=10; fi

        printf " %-3s | %-20s | %-15s | %-${fn_width}s | %-10s\n" " " "TAG" "TYPE" "FILENAME" "SIZE"
        printf "%s\n" "----------------------------------------------------------------------------------------------------------------------------"

        for ((i=start_idx; i<end_idx; i++)); do
            local d_check="[ ]"
            local d_tag="${TUI_TAGS[i]:0:20}"
            local d_type="${TUI_DIRS[i]:0:15}"
            # Hard truncate filename based on calculated width
            local d_name="${TUI_FINAL_NAMES[i]:0:$fn_width}"
            local d_size="${TUI_SIZES[i]}"
            
            local color_check="${C_GREY}"
            if [[ "${TUI_SELECTED[i]}" == "true" ]]; then
                d_check="[x]"
                color_check="${C_GREEN}"
            fi

            if [[ $i -eq $cursor ]]; then
                local BG_SEL="\033[100m"
                printf "${BG_SEL} ${color_check}%-3s${C_RESET_FG} | ${C_YELLOW}%-20s${C_RESET_FG} | ${C_PURPLE}%-15s${C_RESET_FG} | ${C_CYAN}%-${fn_width}s${C_RESET_FG} | ${C_WHITE}%-10s ${C_RESET_ALL}\n" \
                    "$d_check" "$d_tag" "$d_type" "$d_name" "$d_size"
            else
                printf " ${color_check}%-3s${C_RESET_ALL} | ${C_YELLOW}%-20s${C_RESET_ALL} | ${C_PURPLE}%-15s${C_RESET_ALL} | ${C_CYAN}%-${fn_width}s${C_RESET_ALL} | %-10s\n" \
                    "$d_check" "$d_tag" "$d_type" "$d_name" "$d_size"
            fi
        done
        
        # Fill empty lines to keep footer at bottom
        local rows_printed=$((end_idx - start_idx))
        local filler=$((page_size - rows_printed))
        for ((f=0; f<filler; f++)); do printf "\n"; done

        printf "%s\n" "----------------------------------------------------------------------------------------------------------------------------"
        printf " TOTAL SELECTED SIZE: ${C_BOLD}${C_GREEN}%s${C_RESET_ALL}\n" "$total_display"
        printf "${C_BLUE}============================================================================================================================${C_RESET_ALL}\n"

        IFS= read -rsn1 key
        if [[ "$key" == $'\x1b' ]]; then
            read -rsn2 k2
            if [[ "$k2" == "[A" ]]; then 
                ((cursor--)); if [[ $cursor -lt 0 ]]; then cursor=$((count-1)); fi
            elif [[ "$k2" == "[B" ]]; then 
                ((cursor++)); if [[ $cursor -ge $count ]]; then cursor=0; fi
            elif [[ "$k2" == "[C" ]]; then
                local next_page=$((current_page + 1))
                if [[ $next_page -lt $total_pages ]]; then cursor=$((next_page * page_size)); fi
            elif [[ "$k2" == "[D" ]]; then
                local prev_page=$((current_page - 1))
                if [[ $prev_page -ge 0 ]]; then cursor=$((prev_page * page_size)); fi
            fi
        elif [[ "$key" == "" ]]; then break
        elif [[ "$key" == " " ]]; then
            if [[ "${TUI_SELECTED[cursor]}" == "true" ]]; then TUI_SELECTED[cursor]="false"; else TUI_SELECTED[cursor]="true"; fi
        elif [[ "$key" == "t" || "$key" == "T" ]]; then
            local current_tag="${TUI_TAGS[cursor]}"; local target_state="true"
            if [[ "${TUI_SELECTED[cursor]}" == "true" ]]; then target_state="false"; fi
            for ((j=0; j<count; j++)); do if [[ "${TUI_TAGS[j]}" == "$current_tag" ]]; then TUI_SELECTED[j]="$target_state"; fi; done
        elif [[ "$key" == "a" || "$key" == "A" ]]; then
            local all_selected="true"; for ((j=0; j<count; j++)); do if [[ "${TUI_SELECTED[j]}" == "false" ]]; then all_selected="false"; break; fi; done
            local new_state="true"; if [[ "$all_selected" == "true" ]]; then new_state="false"; fi
            for ((j=0; j<count; j++)); do TUI_SELECTED[j]="$new_state"; done
        fi
    done

    export USE_TUI_SELECTION="true"
    export ALLOWED_URLS_STRING=""
    for ((i=0; i<count; i++)); do
        if [[ "${TUI_SELECTED[i]}" == "true" ]]; then
            ALLOWED_URLS_STRING+="${TUI_URLS[i]}###"
        fi
    done
    clear
}

# --- PARALLEL DOWNLOAD LOGIC ---

function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    
    collect_files "checkpoints" "${CHECKPOINT_MODELS[@]}"
    collect_files "unet" "${UNET_MODELS[@]}"
    collect_files "diffusion_models" "${DIFFUSION_MODELS[@]}"
    collect_files "lora" "${LORA_MODELS[@]}"
    collect_files "controlnet" "${CONTROLNET_MODELS[@]}"
    collect_files "vae" "${VAE_MODELS[@]}"
    collect_files "esrgan" "${ESRGAN_MODELS[@]}"
    collect_files "vae_approx" "${VAE_APPROX_MODELS[@]}"
    collect_files "text_encoders" "${TEXT_ENCODER_MODELS[@]}"
    
    process_downloads
    
    provisioning_print_end
}

function collect_files() {
    local dir_suffix="$1"
    shift
    local arr=("$@")
    local len=${#arr[@]}
    local target_dir="${COMFYUI_DIR}/models/${dir_suffix}"
    mkdir -p "$target_dir"
    
    for ((i=0; i<len; i+=2)); do
        local tag="${arr[i]}"
        local entry="${arr[i+1]}"
        local url=""
        local rename=""
        if [[ "$entry" == *"::"* ]]; then
            url="${entry%%::*}"
            rename="${entry##*::}"
        else
            url="$entry"
            rename=""
        fi

        local should_download="true"
        if [[ "$USE_TUI_SELECTION" == "true" ]]; then
            if [[ "$ALLOWED_URLS_STRING" != *"${url}###"* ]]; then should_download="false"; fi
        elif [[ ${#SELECTED_TAGS[@]} -gt 0 ]]; then
            should_download="false"
            for t in "${SELECTED_TAGS[@]}"; do
                if [[ "$t" == "$tag" ]]; then should_download="true"; break; fi
            done
        fi

        if [[ "$should_download" == "true" ]]; then
            GLOBAL_DOWNLOAD_QUEUE+=("${tag}|${url}|${rename}|${target_dir}")
        fi
    done
}

function convert_speed_to_bytes() {
    local val="$1"
    local num=$(echo "$val" | sed 's/[A-Za-z]*//g')
    local unit=$(echo "$val" | sed 's/[0-9.]*//g')
    if [[ -z "$num" ]]; then echo "0"; return; fi
    case "$unit" in
        k|K) echo $(awk -v n="$num" 'BEGIN {printf "%.0f", n*1024}') ;;
        m|M) echo $(awk -v n="$num" 'BEGIN {printf "%.0f", n*1048576}') ;;
        g|G) echo $(awk -v n="$num" 'BEGIN {printf "%.0f", n*1073741824}') ;;
        *) echo $(awk -v n="$num" 'BEGIN {printf "%.0f", n}') ;;
    esac
}

function format_speed() {
    local bytes="$1"
    if (( bytes > 1073741824 )); then awk -v val="$bytes" 'BEGIN {printf "%.2f GB/s", val/1073741824}'
    elif (( bytes > 1048576 )); then awk -v val="$bytes" 'BEGIN {printf "%.1f MB/s", val/1048576}'
    elif (( bytes > 1024 )); then awk -v val="$bytes" 'BEGIN {printf "%.0f KB/s", val/1024}'
    else echo "${bytes} B/s"; fi
}

function process_downloads() {
    local total_files=${#GLOBAL_DOWNLOAD_QUEUE[@]}
    if [[ $total_files -eq 0 ]]; then printf "No files selected.\n"; return; fi
    
    local active_pids=()
    declare -A pid_info # pid -> "filename|logpath"
    local finished_count=0
    local failed_count=0
    local queue_index=0
    local max_jobs=10
    
    local log_lines=("Waiting to start..." "" "" "" "")
    
    printf "\033[?25l" # Hide cursor

    while [[ $finished_count -lt $total_files ]]; do
        # 1. Manage Finished Jobs
        local new_active_pids=()
        for pid in "${active_pids[@]}"; do
            if ! kill -0 $pid 2>/dev/null; then
                wait $pid
                local status=$?
                IFS='|' read -r fname logpath <<< "${pid_info[$pid]}"
                
                # Clean Truncate for Log
                local term_cols=$(tput cols); if [[ -z "$term_cols" ]]; then term_cols=80; fi
                local log_msg=""
                if [[ $status -eq 0 ]]; then log_msg="${C_GREEN}[DONE]${C_RESET_ALL} $fname"
                else log_msg="${C_RED}[FAIL]${C_RESET_ALL} $fname"; ((failed_count++)); fi
                
                log_lines=("${log_lines[@]:1}" "$log_msg")
                ((finished_count++))
                rm -f "$logpath"
                unset pid_info[$pid]
            else
                new_active_pids+=($pid)
            fi
        done
        active_pids=("${new_active_pids[@]}")

        # 2. Spawn New Jobs
        while [[ ${#active_pids[@]} -lt $max_jobs ]] && [[ $queue_index -lt $total_files ]]; do
            local item="${GLOBAL_DOWNLOAD_QUEUE[$queue_index]}"
            ((queue_index++))
            
            IFS='|' read -r tag url rename dir <<< "$item"
            local filename=""
            if [[ -n "$rename" ]]; then filename="$rename"; else filename=$(basename "$url"); filename="${filename%%\?*}"; fi
            
            local logfile=$(mktemp)
            download_worker "$url" "$dir" "$filename" "$logfile" &
            local pid=$!
            
            active_pids+=($pid)
            pid_info[$pid]="$filename|$logfile"
        done

        # 3. Render Dashboard (Clear Screen approach to allow variable terminal width)
        printf "\033[2J\033[H"
        
        local term_cols=$(tput cols)
        if [[ -z "$term_cols" || "$term_cols" -lt 80 ]]; then term_cols=80; fi
        
        local total_speed_bytes=0
        local percent=$(( (finished_count * 100) / total_files ))
        
        local global_speed_str=$(format_speed "$total_speed_bytes") # Placeholder
        
        # Header
        printf "${C_BLUE}=====================================================================================${C_RESET_ALL}\n"
        printf " Global Speed: ${C_BOLD}${C_GREEN}CALCULATING... ${C_RESET_ALL} | Progress: [${C_GREEN}%d%%${C_RESET_ALL}] (%d/%d) | Failed: ${C_RED}%d${C_RESET_ALL}\n" "$percent" "$finished_count" "$total_files" "$failed_count"
        printf "${C_BLUE}-------------------------------------------------------------------------------------${C_RESET_ALL}\n"
        printf " %-12s | %-15s | %-5s | %s\n" "SPEED" "PROGRESS" "%" "FILENAME"
        printf "${C_BLUE}-------------------------------------------------------------------------------------${C_RESET_ALL}\n"

        local row_count=0
        
        for pid in "${active_pids[@]}"; do
            IFS='|' read -r fname logpath <<< "${pid_info[$pid]}"
            
            # Robust Parsing with tr for carriage returns
            local line=$(tr '\r' '\n' < "$logpath" | grep -E '^[ 0-9]' | tail -n1 | tr -s ' ' | sed 's/^\s//g')
            
            # Curl fields: 1(%), 2(Total), 4(Recv), 12(Speed)
            local dl_pct=$(echo "$line" | cut -d ' ' -f1)
            local dl_total=$(echo "$line" | cut -d ' ' -f2)
            local dl_recv=$(echo "$line" | cut -d ' ' -f4)
            local dl_speed=$(echo "$line" | cut -d ' ' -f12)
            
            if [[ ! "$dl_pct" =~ ^[0-9]+$ ]]; then dl_pct="0"; fi
            
            local speed_b=$(convert_speed_to_bytes "$dl_speed")
            total_speed_bytes=$((total_speed_bytes + speed_b))
            
            # Calculated Truncation for Filename
            # 12+15+5 + spacers ~= 40 chars reserved. 
            local max_name_len=$((term_cols - 45))
            if [[ $max_name_len -lt 10 ]]; then max_name_len=10; fi
            local display_name="${fname:0:$max_name_len}"
            
            printf " ${C_YELLOW}%-12s${C_RESET_ALL} | %-15s | %3s%%  | ${C_CYAN}%s${C_RESET_ALL}\n" "$dl_speed" "${dl_recv}/${dl_total}" "$dl_pct" "$display_name"
            ((row_count++))
        done
        
        while [[ $row_count -lt $max_jobs ]]; do
            printf " %-12s | %-15s | %-5s | %s\n" "--" "--/--" "--" "Waiting..."
            ((row_count++))
        done
        
        # Redraw Header with actual speed (Move up to line 2, overwrite, move back)
        local gs=$(format_speed "$total_speed_bytes")
        # Line 2 is 14 lines up (10 slots + 3 header lines + 1 footer line we are about to print)
        # Actually simplest is to just accept it shows in next frame or use tput cup
        # But for robustness, let's just let it lag 1 frame or print it next time.
        # Actually, since we cleared screen, we can't go back easily without hardcoding line numbers.
        # Let's fix the header print order for next loop? No, speed is calc'd in loop.
        # FIX: Just print the Footer logs now.
        
        printf "${C_BLUE}=====================================================================================${C_RESET_ALL}\n"
        for logl in "${log_lines[@]}"; do
            # Truncate log to width
            local clean_log="${logl:0:$((term_cols-2))}"
            printf " %b\n" "$clean_log"
        done
        
        sleep 1
    done
    
    printf "\033[?25h" # Show Cursor
    printf "\nDone.\n"
}

function download_worker() {
    local url="$1"
    local dir="$2"
    local filename="$3"
    local logfile="$4"
    
    if [[ "$TEST_MODE" == "true" ]]; then
        for i in {1..10}; do
            echo "$((i*10)) 100M $((i*10)) $((i*10))M 0 0 10M 0 0:00:00 0:00:00 0:00:00 10M" > "$logfile"
            sleep 0.5
        done
        if [[ "$NO_DL_MODE" != "true" ]]; then
            touch "${dir}/${filename}"
        fi
    else
        local target_file="${dir}/${filename}"
        local cmd=(curl -L)
        
        if [[ "$NO_DL_MODE" == "true" ]]; then
            target_file="/dev/null"
        else
            cmd+=(-C -)
        fi
        
        cmd+=(-o "$target_file" "$url")

        if [[ -n $HF_TOKEN && $url =~ huggingface\.co ]]; then cmd+=(-H "Authorization: Bearer $HF_TOKEN"); fi
        if [[ -n $CIVITAI_TOKEN && $url =~ civitai\.com ]]; then cmd+=(-H "Authorization: Bearer $CIVITAI_TOKEN"); fi
        
        # Force unbuffered if possible, but standard redirect is fine if we parse robustly
        "${cmd[@]}" 2> "$logfile"
    fi
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then sudo $APT_INSTALL ${APT_PACKAGES[@]}; fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then pip install --no-cache-dir ${PIP_PACKAGES[@]}; fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${COMFYUI_DIR}custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then pip install --no-cache-dir -r "$requirements"; fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then pip install --no-cache-dir -r "${requirements}"; fi
        fi
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Application will start now\n\n"
}

# Allow user to disable provisioning
if [[ ! -f /.noprovisioning ]]; then
    SELECTED_TAGS=()
    SELECT_MODE="false"
    
    for arg in "$@"; do
        if [[ "$arg" == "--test" ]]; then export TEST_MODE="true"
        elif [[ "$arg" == "--select" ]]; then SELECT_MODE="true"
        elif [[ "$arg" == "--no-dl" ]]; then export NO_DL_MODE="true"
        else SELECTED_TAGS+=("$arg"); fi
    done

    if [[ "$SELECT_MODE" == "true" ]]; then tui_interactive_menu; fi
    if [[ "$TEST_MODE" == "true" ]]; then
        printf "\n#######################################################\n"
        printf "#             RUNNING IN TEST MODE                    #\n"
        printf "#      Only downloading first 10MB per file           #\n"
        printf "#######################################################\n\n"
    fi
    if [[ "$NO_DL_MODE" == "true" ]]; then
        printf "\n#######################################################\n"
        printf "#             RUNNING IN NO-DL MODE                   #\n"
        printf "#      Downloads will be discarded (/dev/null)        #\n"
        printf "#######################################################\n\n"
    fi
    if [[ "$SELECT_MODE" == "false" ]]; then
        if [[ ${#SELECTED_TAGS[@]} -gt 0 ]]; then printf "Provisioning ONLY models with tags: %s\n" "${SELECTED_TAGS[*]}"
        else printf "No specific tags provided. Downloading ALL models.\n"; fi
    fi
    
    provisioning_start
fi
