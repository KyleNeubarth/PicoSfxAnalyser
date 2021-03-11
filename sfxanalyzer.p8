pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--Kyle's sfx note analyzer

noteindex = 0
sfxindex = 0

info = {}

function get_note(sfx, time)
    local addr = 0x3200 + 68*sfxindex + 2*time
    return { @addr , @(addr + 1) }
end

function _update()
	if (btnp(5)) then
		noteindex+=1
		noteindex%=32
	end
	info = get_noteinfo(sfxindex,noteindex)
    
end

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

function _draw()
    cls()
    print("sfx bytes for sfx "..sfxindex.." and note "..noteindex)
    print("full sfx bytes: "..info.fullbytes,0,10)
    print("pitch:"..noteinfo.pitch,0,20)
    print("waveform:"..noteinfo.waveform,0,30)
    print("volume: "..noteinfo.volume,0,40)
    print("effect: "..noteinfo.effect,0,50)

end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010f0000000500113102232033130441405575066760771708073090730a0730b0750c0750d0750e0750f075100751107512075130751407515075160751707518075190751a0751b0751c0751d0751e0751f050
011000001c3601c3511c3411c331233602335123341233311e3601e3511e3411e3311f3601f3511f3411f3311b3601b3511b3411b331233602335123341233311e3601e3511e3411e3311b3601b3511b3411b331
__music__
00 00014344

