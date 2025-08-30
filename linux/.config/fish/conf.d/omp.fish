function __omp_update_vi_mode --on-event fish_prompt
    switch "$fish_bind_mode"
        case insert
            set -gx VI_MODE "󱩽 I"
        case default
            set -gx VI_MODE " N"
        case visual
            set -gx VI_MODE " V"
        case visual_line
            set -gx VI_MODE "󰡮 VL"
        case visual_block
            set -gx VI_MODE "󱂔 VB"
        case replace
            set -gx VI_MODE " R"
        case '*'
            set -gx VI_MODE "$fish_bind_mode"
    end
end

function __omp_force_repaint --on-variable fish_bind_mode
    commandline -f repaint
end
