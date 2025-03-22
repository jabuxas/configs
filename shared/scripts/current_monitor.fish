set -l mouse_data (xdotool getmouselocation --shell)
set -l M_X
set -l M_Y

for line in $mouse_data
    set -l key (echo $line | awk -F '=' '{print $1}')
    set -l value (echo $line | awk -F '=' '{print $2}')
    switch $key
        case X
            set M_X $value
        case Y
            set M_Y $value
    end
end

set -l xrandr_data (xrandr)

for line in $xrandr_data
    if echo $line | grep -q "connected"
        set -l details (echo $line | awk '/connected/ {if (match($0, /([a-zA-Z0-9\-]+).* ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+)/, a)) print a[1], a[2], a[3], a[4], a[5]}')
        set -l d (echo $details | awk '{print $1}')
        set -l w (echo $details | awk '{print $2}')
        set -l h (echo $details | awk '{print $3}')
        set -l xo (echo $details | awk '{print $4}')
        set -l yo (echo $details | awk '{print $5}')

        if test $M_X -ge $xo -a $M_X -le (math $w + $xo) -a $M_Y -ge $yo -a $M_Y -le (math $h + $yo)
            echo $d
            break
        end
    end
end

