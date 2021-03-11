

function get_noteinfo(sfx_num,note_num)
    local addr = 0x3200 + 68*sfx_num + 2*note_num
    local note = { @addr , @(addr + 1) }
    noteinfo = {}
    --add pitch
    noteinfo.pitch = band(note[1],0x3f)
    --add waveform
    noteinfo.waveform = bor(band(shr(note[1],6),0x3),shl(band(note[2],0x1),2))
    --add volume
    noteinfo.volume = band(lshr(note[2],1),0x7)
    --add effect
    noteinfo.effect = band(lshr(note[2],4),0x7)
    --add full bytes
    noteinfo.fullbytes = bor(note[1],shl(note[2],8))
    return noteinfo
end


function get_sfx_speed(sfx)
    return @(0x3200 + 68*sfx + 65)
end

function set_sfx_speed(sfx, speed)
    poke(0x3200 + 68*sfx + 65, speed)
end

function get_sfx_loop_start(sfx)
    return @(0x3200 + 68*sfx + 66)
end

function get_sfx_loop_end(sfx)
    return @(0x3200 + 68*sfx + 67)
end