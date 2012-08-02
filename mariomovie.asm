nbasic_stack = 256
spritemem = 768
background_tile_array = 512
music_bug_fix = 100
texts = 0
palette_data_array = 2
att_data_array = 4
background_data_array = 6
songs = 8
which_song = 10
mute = 14
mute_new = 18
sprite_anim_data_array = 22
sprite_data_array = 24
sprite_anim_data_array2 = 26
sprite_data_array2 = 28
background_data_arrayop = 30
palette_start = 36
att_start = 37
current_NT = 38
rle_counter = 39
background_shape_distance = 40
background_shape = 41
background_tile_array_counter = 42
background_tile_array_counter_down = 43
song_number_new = 44
song_timez = 45
new_music_page = 46
new_music_page_big = 47
music_counter_file = 48
music_counter = 49
songloadloop = 50
whichsong = 51
mute_joy1a = 52
whichsongcounter = 53
global_tempo = 54
sound1a = 55
sound1b = 56
sound2a = 57
sound2b = 58
sound3a = 59
sound3b = 60
sound4a = 61
sound4b = 62
color_show = 63
color_show_beige = 64
color_show_beige2 = 65
color_show_beige3 = 66
sprite_type = 67
spritemem_array_pos = 68
sprite_mem_loc_master = 69
total_blocks_master = 70
anim_file_counter = 71
direction = 72
counter = 73
sprite_delay = 74
sprite_data_pos = 75
new_sprite_data_pos = 76
total_blocks = 77
sprite_delay_master = 78
sprite_type2 = 79
spritemem_array_pos2 = 80
sprite_mem_loc_master2 = 81
total_blocks_master2 = 82
anim_file_counter2 = 83
direction2 = 84
counter2 = 85
sprite_delay2 = 86
sprite_data_pos2 = 87
new_sprite_data_pos2 = 88
total_blocks2 = 89
sprite_delay_master2 = 90
timer = 91
music_timer = 92
scene_timer = 93
dvdcounter = 94
PPUHI = 95
PPULOW = 96
PPULOW_START = 97
TEXTPOS = 98
CHARCOUNTER = 99
special_5 = 110
special_scroll_5 = 111
scene5_temp = 112
scene5_temp_2 = 113
timer_noise = 114
scene5_loop = 115
special = 116
special_temp = 117
special_temp_2 = 118
special_temp_2_master = 119
scroll_delay = 120
scroll_delay_master = 121
special_scroll = 122
scroll = 123
scroll2 = 124
nmi_2_do_special = 125
scene6_temp = 126
scene6_temp_2 = 127
scene6_loop = 128
att_var = 129
special_att_counter = 130
special_att = 131
scene10temp = 132
pong_trick = 133
pong_trick_loc = 134
pong_trick_temp = 135
scene10loop_var = 136
nmi_to_do = 137
sprite_mem_loc = 138
sprite_across_counter = 139
sprite_down_counter = 140
sprite_width = 141
x_offset = 142
temp = 143
sprite_y = 144
sprite_x = 145
erase_sprite_var = 146
palette_counter = 147
tempcounter = 148
NT_down = 149
background_low = 150
backgroundshape_loc = 151
backgroundshape_loc_offset = 152
background_tile_loc = 153
NT_across = 154
background_hi = 155
draw_background_across_counter = 156
palette_text = 157
character = 158
joy1a = 159
joy1b = 160
joy1select = 161
joy1start = 162
joy1up = 163
joy1down = 164
joy1left = 165
joy1right = 166
i1 = 167
i2 = 168
i3 = 169
i4 = 170
nmi_to_do_special = 171


	.inesprg 2
	.ineschr 1
	.inesmir 1
	.inesmap 0
	
	.org $8000

	.bank 0

start:

	sei
	cld

;++++++++++++++++++++++++++++++++++++++++++++++++
;Clear Memory and crap.......
;++++++++++++++++++++++++++++++++++++++++++++++++


.vblank_clear1
	lda $2002
	bpl .vblank_clear1
	
.vblank_clear2
	lda $2002
	bpl .vblank_clear2

.vblank_clear3
	lda $2002
	bpl .vblank_clear3

	sei
	cld

.vblank_clear4
	lda $2002
	bpl .vblank_clear4
	
.vblank_clear5
	lda $2002
	bpl .vblank_clear5

.vblank_clear6
	lda $2002
	bpl .vblank_clear6
	
        lda #$00
        ldx #$00
.clear_out_ram
		sta $000,x
        sta $100,x
        sta $200,x
        sta $300,x
        sta $400,x
        sta $500,x
        sta $600,x
        sta $700,x
        inx
        bne .clear_out_ram
 
        lda #$00
        ldx #$00
.clear_out_sprites
		sta $2000,x
        sta $2100,x
        sta $2200,x
        sta $2300,x
        sta $2400,x
        sta $2500,x
        sta $2600,x
        sta $2700,x
        sta $2800,x
        sta $2900,x
        sta $2a00,x
        sta $2b00,x
        sta $2c00,x
        sta $2d00,x
        sta $2e00,x
        sta $2f00,x
        inx
        bne .clear_out_sprites
        
        ldx #$FF
        txs
 
	jsr vwait
	jsr vwait

 jsr clear_att

 lda   #%10010000
 sta   $2000
 lda   #%00011000     
 sta   $2001

init_vars:
 lda #0
 sta palette_start
 lda #0
 sta att_start
 lda #0
 sta current_NT
 lda #0
 sta rle_counter
 lda #0
 sta background_shape_distance
 lda #0
 sta background_shape
 lda #0
 sta background_tile_array_counter
 lda #10
 sta background_tile_array_counter_down
 lda #0
 sta song_number_new
 lda #0
 sta song_timez
 lda #0
 sta new_music_page
 lda #0
 sta new_music_page_big
 lda #0
 sta music_counter_file
 lda #6
 sta music_counter
 lda #0
 sta songloadloop
 lda #1
 sta whichsong
 lda #1
 sta mute_joy1a
 lda #0
 sta whichsongcounter
 lda #6
 sta global_tempo
 lda #15
 sta 16405
 lda #1
 ldx #0
 sta mute,x
 lda #1
 ldx #1
 sta mute,x
 lda #1
 ldx #2
 sta mute,x
 lda #0
 ldx #3
 sta mute,x
 lda #1
 ldx #0
 sta mute_new,x
 lda #1
 ldx #1
 sta mute_new,x
 lda #1
 ldx #2
 sta mute_new,x
 lda #0
 ldx #3
 sta mute_new,x
 ldx #0
 lda theme1,x
 ldx #0
 sta songs,x
 ldx #1
 lda theme1,x
 ldx #1
 sta songs,x
 ldx #0
 lda songs,x
 ldx #0
 sta which_song,x
 ldx #1
 lda songs,x
 ldx #1
 sta which_song,x
 lda #0
 sta sound1a
 lda #0
 sta sound1b
 lda #0
 sta sound2a
 lda #0
 sta sound2b
 lda #0
 sta sound3a
 lda #0
 sta sound3b
 lda #0
 sta sound4a
 lda #0
 sta sound4b
 lda #0
 sta color_show
 lda #0
 sta color_show_beige
 lda #0
 sta color_show_beige2
 lda #0
 sta color_show_beige3
 lda #0
 sta sprite_type
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_mem_loc_master
 lda #0
 sta total_blocks_master
 lda #0
 sta anim_file_counter
 lda #0
 sta direction
 lda #0
 sta counter
 lda #0
 sta sprite_delay
 lda #0
 sta sprite_data_pos
 lda #0
 sta new_sprite_data_pos
 lda #0
 sta total_blocks
 lda #0
 sta sprite_delay_master
 lda #0
 sta sprite_type2
 lda #0
 sta spritemem_array_pos2
 lda #0
 sta sprite_mem_loc_master2
 lda #0
 sta total_blocks_master2
 lda #0
 sta anim_file_counter2
 lda #0
 sta direction2
 lda #0
 sta counter2
 lda #0
 sta sprite_delay2
 lda #0
 sta sprite_data_pos2
 lda #0
 sta new_sprite_data_pos2
 lda #0
 sta total_blocks2
 lda #0
 sta sprite_delay_master2
 lda #0
 sta timer
 lda #0
 sta music_timer
 lda #0
 sta scene_timer
 lda #0
 sta dvdcounter
 lda #32
 sta PPUHI
 lda #230
 sta PPULOW
 lda PPULOW
 sta PPULOW_START
 lda #0
 sta TEXTPOS
 lda #0
 sta CHARCOUNTER
 lda #0
 sta special_5
 lda #0
 sta special_scroll_5
 lda #0
 sta scene5_temp
 lda #0
 sta scene5_temp_2
 lda #0
 sta timer_noise
 lda #0
 sta scene5_loop
 lda #0
 sta special
 lda #0
 sta special_temp
 lda #0
 sta special_temp_2
 lda #64
 sta special_temp_2_master
 lda #5
 sta scroll_delay
 lda #5
 sta scroll_delay_master
 lda #0
 sta special_scroll
 lda #0
 sta scroll
 lda #0
 sta scroll2
 lda #0
 sta nmi_2_do_special
 lda #0
 sta scene6_temp
 lda #128
 sta scene6_temp_2
 lda #0
 sta scene6_loop
 lda #0
 sta att_var
 lda #0
 sta special_att_counter
 lda #0
 sta special_att
 lda #0
 sta scene10temp
 lda #0
 sta pong_trick
 lda #49
 sta pong_trick_loc
 lda #0
 sta pong_trick_temp
 lda #2
 sta scene10loop_var
 jsr screen_off

dvdtitle:
 lda #2
 sta scene_timer
 jsr scene_title

dvdscene1:
 jsr scene1

dvdscene2:
 jsr scene2

dvdscene3:
 jsr scene3
 lda #0
 ldx #0
 sta songs,x
 lda #128
 ldx #1
 sta songs,x
 lda #0
 sta scene5_temp
 lda #128
 sta scene5_temp_2
 lda #3
 sta global_tempo
 lda #208
 sta timer_noise
 lda #6
 sta scene5_loop
 jsr scene5

dvdscene4:
 ldx #0
 lda background12,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background12,x
 ldx #1
 sta background_data_array,x
 jsr scene4
 lda #0
 ldx #0
 sta songs,x
 lda #128
 ldx #1
 sta songs,x
 lda #0
 sta scene5_temp
 lda #128
 sta scene5_temp_2
 lda #3
 sta global_tempo
 lda #209
 sta timer_noise
 lda #6
 sta scene5_loop
 jsr scene5
 jsr scene4redux

dvdscene5:
 lda #9
 sta scene10loop_var
 jsr scene10
 lda #0
 ldx #0
 sta songs,x
 lda #128
 ldx #1
 sta songs,x
 lda #3
 sta global_tempo
 lda #210
 sta timer_noise
 lda #6
 sta scene5_loop
 jsr scene5

dvdscene6:
 jsr scene6
 lda #0
 ldx #0
 sta songs,x
 lda #128
 ldx #1
 sta songs,x
 lda #3
 sta global_tempo
 lda #210
 sta timer_noise
 lda #7
 sta scene5_loop
 jsr scene5

dvdscene7:
 jsr scene7
 lda #0
 ldx #0
 sta songs,x
 lda #128
 ldx #1
 sta songs,x
 lda #0
 sta scene5_temp
 lda #128
 sta scene5_temp_2
 lda #9
 sta global_tempo
 lda #217
 sta timer_noise
 lda #16
 sta scene5_loop
 jsr scene5

dvdscene8:
 jsr scene12
 lda #0
 ldx #0
 sta songs,x
 lda #128
 ldx #1
 sta songs,x
 lda #0
 sta scene5_temp
 lda #128
 sta scene5_temp_2
 lda #9
 sta global_tempo
 lda #217
 sta timer_noise
 lda #18
 sta scene5_loop
 jsr scene5

dvdscene9:
 jsr scene8
 lda #0
 sta scene5_temp
 lda #128
 sta scene5_temp_2
 lda #9
 sta global_tempo
 lda #247
 sta timer_noise
 lda #3
 sta scene5_loop
 jsr scene5

dvdscene10:
 jsr scene9

dvdscene11:
 jsr scene11

dvdscene12:
 jsr scene16

dvdscene14:
 jsr scene17
 jsr scene18a

dvdscene15:
 lda #4
 sta scene_timer
 jsr scene19
 jmp start

sculpture1_score:
 jsr reset_nmi_vars
 lda #0
 sta scene5_temp
 lda #128
 sta scene5_temp_2
 lda #9
 sta global_tempo
 lda #64
 sta timer_noise
 lda #16
 sta scene5_loop
 jsr scene5

sculpture2_score:
 jsr reset_nmi_vars
 lda #0
 ldx #2
 sta background_data_arrayop,x
 lda #16
 sta scene10loop_var
 jsr scene10
 ldx #0
 lda bridge18,x
 ldx #0
 sta songs,x
 ldx #1
 lda bridge18,x
 ldx #1
 sta songs,x
 jsr melody_guitar
 lda #0
 sta scene5_temp
 lda #128
 sta scene5_temp_2
 lda #9
 sta global_tempo
 lda #64
 sta timer_noise
 lda #16
 sta scene5_loop
 jsr scene5

sculpture3_score:
 jsr reset_nmi_vars
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jsr scene9
 jmp sculpture1_score

main:
 jmp main

animate_sprites:
 lda #3
 sta nmi_to_do
 rts

animate_sprites2:
 lda #5
 sta nmi_to_do
 rts

animate_both_sprites:
 lda #6
 sta nmi_to_do
 rts

move_sprite_1:
 lda #0
 cmp counter
 bne nbasic_autolabel_1

	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta direction
	 inc anim_file_counter

	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta counter
	 inc anim_file_counter

	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta sprite_delay
	
	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta sprite_delay_master
	 inc anim_file_counter

	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta sprite_data_pos
	 inc anim_file_counter

	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta new_sprite_data_pos
	 inc anim_file_counter

	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta total_blocks
	 inc anim_file_counter

nbasic_autolabel_1:
 dec sprite_delay
 lda #0
 cmp sprite_delay
 beq nbasic_autolabel_2
 rts

nbasic_autolabel_2:
 lda #0
 cmp sprite_delay
 bne nbasic_autolabel_3
 lda sprite_delay_master
 sta sprite_delay

nbasic_autolabel_3:
 lda #240
 cmp direction
 bne nbasic_autolabel_4

counter_up_loop_1:
 lda #0
 cmp counter
 bcs nbasic_autolabel_5
 lda total_blocks_master
 sta total_blocks
 lda sprite_mem_loc_master
 sta sprite_mem_loc
 jsr move_y_up
 dec counter

nbasic_autolabel_5:

nbasic_autolabel_4:
 lda #241
 cmp direction
 bne nbasic_autolabel_6

counter_down_loop_1:
 lda #0
 cmp counter
 bcs nbasic_autolabel_7
 lda total_blocks_master
 sta total_blocks
 lda sprite_mem_loc_master
 sta sprite_mem_loc
 jsr move_y_down
 dec counter

nbasic_autolabel_7:

nbasic_autolabel_6:
 lda #242
 cmp direction
 bne nbasic_autolabel_8

counter_left_loop_1:
 lda #0
 cmp counter
 bcs nbasic_autolabel_9
 lda total_blocks_master
 sta total_blocks
 lda sprite_mem_loc_master
 sta sprite_mem_loc
 jsr move_y_left
 dec counter

nbasic_autolabel_9:

nbasic_autolabel_8:
 lda #243
 cmp direction
 bne nbasic_autolabel_10

counter_right_loop_1:
 lda #0
 cmp counter
 bcs nbasic_autolabel_11
 lda total_blocks_master
 sta total_blocks
 lda sprite_mem_loc_master
 sta sprite_mem_loc
 jsr move_y_right
 dec counter

nbasic_autolabel_11:

nbasic_autolabel_10:
 lda #244
 cmp direction
 bne nbasic_autolabel_12

counter_still_loop_1:
 lda #0
 cmp counter
 bcs nbasic_autolabel_13
 dec counter

nbasic_autolabel_13:

nbasic_autolabel_12:
 lda #245
 cmp direction
 bne nbasic_autolabel_14

finish_changing_sprite:
 inc sprite_data_pos

	ldy new_sprite_data_pos
	lda [sprite_data_array],y
	sta temp
	 lda temp
 ldx sprite_data_pos
 sta spritemem,x
 inc sprite_data_pos
 inc new_sprite_data_pos

	ldy new_sprite_data_pos
	lda [sprite_data_array],y
	sta temp
	 lda temp
 ldx sprite_data_pos
 sta spritemem,x
 inc new_sprite_data_pos
 inc sprite_data_pos
 inc sprite_data_pos

	dec total_blocks
	bne finish_changing_sprite
	 dec counter

nbasic_autolabel_14:
 lda #246
 cmp direction
 bne nbasic_autolabel_15
 lda total_blocks
 sta anim_file_counter
 lda #0
 sta counter

nbasic_autolabel_15:
 lda #255
 cmp direction
 bne nbasic_autolabel_16
 lda #0
 sta nmi_to_do

nbasic_autolabel_16:
 rts

move_sprite_2:
 lda #0
 cmp counter2
 bne nbasic_autolabel_17

	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta direction2
	 inc anim_file_counter2

	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta counter2
	 inc anim_file_counter2

	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta sprite_delay2
	
	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta sprite_delay_master2
	 inc anim_file_counter2

	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta sprite_data_pos2
	 inc anim_file_counter2

	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta new_sprite_data_pos2
	 inc anim_file_counter2

	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta total_blocks2
	 inc anim_file_counter2

nbasic_autolabel_17:
 dec sprite_delay2
 lda #0
 cmp sprite_delay2
 beq nbasic_autolabel_18
 rts

nbasic_autolabel_18:
 lda #0
 cmp sprite_delay2
 bne nbasic_autolabel_19
 lda sprite_delay_master2
 sta sprite_delay2

nbasic_autolabel_19:
 lda #240
 cmp direction2
 bne nbasic_autolabel_20

counter_up_loop_12:
 lda #0
 cmp counter2
 bcs nbasic_autolabel_21
 lda total_blocks_master2
 sta total_blocks2
 lda sprite_mem_loc_master2
 sta sprite_mem_loc
 jsr move_y_up2
 dec counter2

nbasic_autolabel_21:

nbasic_autolabel_20:
 lda #241
 cmp direction2
 bne nbasic_autolabel_22

counter_down_loop_12:
 lda #0
 cmp counter2
 bcs nbasic_autolabel_23
 lda total_blocks_master2
 sta total_blocks2
 lda sprite_mem_loc_master2
 sta sprite_mem_loc
 jsr move_y_down2
 dec counter2

nbasic_autolabel_23:

nbasic_autolabel_22:
 lda #242
 cmp direction2
 bne nbasic_autolabel_24

counter_left_loop_12:
 lda #0
 cmp counter2
 bcs nbasic_autolabel_25
 lda total_blocks_master2
 sta total_blocks2
 lda sprite_mem_loc_master2
 sta sprite_mem_loc
 jsr move_y_left2
 dec counter2

nbasic_autolabel_25:

nbasic_autolabel_24:
 lda #243
 cmp direction2
 bne nbasic_autolabel_26

counter_right_loop_12:
 lda #0
 cmp counter2
 bcs nbasic_autolabel_27
 lda total_blocks_master2
 sta total_blocks2
 lda sprite_mem_loc_master2
 sta sprite_mem_loc
 jsr move_y_right2
 dec counter2

nbasic_autolabel_27:

nbasic_autolabel_26:
 lda #244
 cmp direction2
 bne nbasic_autolabel_28

counter_still_loop_12:
 lda #0
 cmp counter2
 bcs nbasic_autolabel_29
 dec counter2

nbasic_autolabel_29:

nbasic_autolabel_28:
 lda #245
 cmp direction2
 bne nbasic_autolabel_30

finish_changing_sprite2:
 inc sprite_data_pos2

	ldy new_sprite_data_pos2
	lda [sprite_data_array2],y
	sta temp
	 lda temp
 ldx sprite_data_pos2
 sta spritemem,x
 inc sprite_data_pos2
 inc new_sprite_data_pos2

	ldy new_sprite_data_pos2
	lda [sprite_data_array2],y
	sta temp
	 lda temp
 ldx sprite_data_pos2
 sta spritemem,x
 inc new_sprite_data_pos2
 inc sprite_data_pos2
 inc sprite_data_pos2

	dec total_blocks2
	bne finish_changing_sprite2
	 dec counter2

nbasic_autolabel_30:
 lda #246
 cmp direction2
 bne nbasic_autolabel_31
 lda total_blocks2
 sta anim_file_counter2
 lda #0
 sta counter2

nbasic_autolabel_31:
 lda #255
 cmp direction2
 bne nbasic_autolabel_32
 lda #0
 sta nmi_to_do

nbasic_autolabel_32:
 rts

move_y_up:

	ldx sprite_mem_loc
	lda spritemem,x
	tay
	dey
	tya
	sta spritemem,x
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	dec total_blocks
	bne move_y_up
	
 rts

move_y_down:

	;jsr vwait
	ldx sprite_mem_loc
	lda spritemem,x
	tay
	iny
	tya
	sta spritemem,x
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	dec total_blocks
	bne move_y_down
 rts

move_y_left:

	;jsr vwait
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	ldx sprite_mem_loc
	lda spritemem,x
	tay
	dey
	tya
	sta spritemem,x
	inc sprite_mem_loc
	dec total_blocks
	bne move_y_left
 rts

move_y_right:

	;jsr vwait
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	ldx sprite_mem_loc
	lda spritemem,x
	tay
	iny
	tya
	sta spritemem,x
	inc sprite_mem_loc
	dec total_blocks
	bne move_y_right
 rts

move_y_up2:

	ldx sprite_mem_loc
	lda spritemem,x
	tay
	dey
	tya
	sta spritemem,x
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	dec total_blocks2
	bne move_y_up2
	
 rts

move_y_down2:

	;jsr vwait
	ldx sprite_mem_loc
	lda spritemem,x
	tay
	iny
	tya
	sta spritemem,x
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	dec total_blocks2
	bne move_y_down2
 rts

move_y_left2:

	;jsr vwait
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	ldx sprite_mem_loc
	lda spritemem,x
	tay
	dey
	tya
	sta spritemem,x
	inc sprite_mem_loc
	dec total_blocks2
	bne move_y_left2
 rts

move_y_right2:

	;jsr vwait
	inc sprite_mem_loc
	inc sprite_mem_loc
	inc sprite_mem_loc
	ldx sprite_mem_loc
	lda spritemem,x
	tay
	iny
	tya
	sta spritemem,x
	inc sprite_mem_loc
	dec total_blocks2
	bne move_y_right2
 rts

draw_sprites:
 lda #0
 sta sprite_across_counter
 lda #0
 sta sprite_down_counter
 lda #0
 cmp sprite_type
 bne nbasic_autolabel_33
 lda #7
 sta total_blocks
 lda #2
 sta sprite_width
 lda #240
 sta x_offset

nbasic_autolabel_33:
 lda #1
 cmp sprite_type
 bne nbasic_autolabel_34
 lda #5
 sta total_blocks
 lda #3
 sta sprite_width
 lda #232
 sta x_offset

nbasic_autolabel_34:
 lda #2
 cmp sprite_type
 bne nbasic_autolabel_35
 lda #1
 sta total_blocks
 lda #0
 sta sprite_width

nbasic_autolabel_35:
 lda #3
 cmp sprite_type
 bne nbasic_autolabel_36
 lda #2
 sta total_blocks
 lda #3
 sta sprite_width
 lda #232
 sta x_offset

nbasic_autolabel_36:
 lda #4
 cmp sprite_type
 bne nbasic_autolabel_37
 lda #3
 sta total_blocks
 lda #2
 sta sprite_width
 lda #240
 sta x_offset

nbasic_autolabel_37:
 lda #5
 cmp sprite_type
 bne nbasic_autolabel_38
 lda #0
 sta total_blocks
 lda #0
 sta sprite_width

nbasic_autolabel_38:
 lda #6
 cmp sprite_type
 bne nbasic_autolabel_39
 lda #35
 sta total_blocks
 lda #6
 sta sprite_width
 lda #208
 sta x_offset

nbasic_autolabel_39:

sprite_across_loop_1:
 lda sprite_width
 cmp sprite_down_counter
 bne nbasic_autolabel_40
 lda #0
 sta sprite_down_counter
 lda #8
 clc
 adc sprite_y
 sta temp
 lda temp
 sta sprite_y
 lda x_offset
 clc
 adc sprite_x
 sta temp
 lda temp
 sta sprite_x

nbasic_autolabel_40:
 inc sprite_across_counter
 inc sprite_down_counter
 lda sprite_y
 ldx spritemem_array_pos
 sta spritemem,x
 inc spritemem_array_pos
 
	ldy sprite_data_pos
	lda [sprite_data_array],y
	sta temp
	 lda temp
 ldx spritemem_array_pos
 sta spritemem,x
 inc sprite_data_pos
 inc spritemem_array_pos
 
	ldy sprite_data_pos
	lda [sprite_data_array],y
	sta temp
	 lda temp
 ldx spritemem_array_pos
 sta spritemem,x
 inc sprite_data_pos
 inc spritemem_array_pos
 lda sprite_x
 ldx spritemem_array_pos
 sta spritemem,x
 inc spritemem_array_pos
 lda #8
 clc
 adc sprite_x
 sta sprite_x
 lda total_blocks
 cmp sprite_across_counter
 bmi nbasic_autolabel_41
 jmp sprite_across_loop_1

nbasic_autolabel_41:
 rts

erase_sprites:
 lda #0
 sta erase_sprite_var

erase_sprites_1:
 lda #252
 ldx erase_sprite_var
 sta spritemem,x

		dec erase_sprite_var
		bne erase_sprites_1
		 rts

scene_music_loop:

	lda #$00
	cmp scene_timer
	bne scene_music_loop
	 rts

show_number_2:
 lda #255
 sta scroll
 rts

show_number_1:
 lda #0
 sta scroll
 rts
 
PutSpritesOnScreen:
	lda #$00
	sta $2003 ; nesdev message
	lda #3
    sta $4014 
    rts

vwait:
	lda $2002
	bpl vwait
	rts

sprites_off:

 	lda   #%10010000
 	sta   $2000
 	lda   #%00001000     
 	sta   $2001
 	rts
	
sprites_on:

 	lda   #%10010000
 	sta   $2000
 	lda   #%00011000     
 	sta   $2001
 	rts
	
screen_on:

 	lda   #%10010000
 	sta   $2000
 	lda   #%00011000     
 	sta   $2001
 	rts
	
screen_on_black_white:

 	lda   #%10010000
 	sta   $2000
 	lda   #%00011001  
 	sta   $2001
 	rts
	
screen_off:

 	lda   #%00000000
 	sta   $2000
 	lda   #%00000000    
 	sta   $2001
 	rts
	
screen_off_with_music:

 	lda   #%10010000
 	sta   $2000
 	lda   #%00000000    
 	sta   $2001
 	rts
	
delay_1_sec:
 lda #255
 cmp timer
 beq nbasic_autolabel_42
 jmp delay_1_sec

nbasic_autolabel_42:
 rts

clear_att:
 lda #35
 sta 8198
 lda #0
 sta 8198


	ldx #$00
att_clear:	
	lda #$00
	sta $2007
	dex
	bne att_clear
	 lda #39
 sta 8198
 lda #0
 sta 8198


	ldx #$00
att_clear2:	
	lda #$00
	sta $2007
	dex
	bne att_clear2

	 rts

load_att:
 lda #1
 cmp current_NT
 bne nbasic_autolabel_43
 lda #39
 sta 8198

nbasic_autolabel_43:
 lda #0
 cmp current_NT
 bne nbasic_autolabel_44
 lda #35
 sta 8198

nbasic_autolabel_44:
 lda #192
 sta 8198

	ldx #$40
	ldy #$00
load_att_1:
		lda [att_data_array],y
		sta $2007
		iny
		dex
		bne load_att_1
		 rts

load_att_rand:
 ldx att_start
 lda #1
 cmp current_NT
 bne nbasic_autolabel_45
 lda #39
 sta 8198

nbasic_autolabel_45:
 lda #0
 cmp current_NT
 bne nbasic_autolabel_46
 lda #35
 sta 8198

nbasic_autolabel_46:
 lda #192
 sta 8198

load_att_2:

		txa
		tay
		lda [att_data_array],y
		sta $2007
		 inx
 cpx #64
 bne load_att_2
 rts

load_palette:
 ldx #0
 lda #63
 sta 8198
 lda #0
 sta 8198

load_palette_1:

		txa
		tay
		lda [palette_data_array],y
		sta $2007
		 inx
 cpx #32
 bne load_palette_1
 rts

load_palette_rand:
 lda #63
 sta 8198
 lda #0
 sta 8198
 ldx #16

load_palette_2:

		lda palette_start
		tay
		lda [palette_data_array],y
		sta $2007
		
		inc palette_start
		dex
		bne load_palette_2
		 rts

change_palette_main:
 jsr change_palette_init
 lda #4
 sta nmi_to_do

delay_until_done_palette:
 lda #0
 cmp nmi_to_do
 beq nbasic_autolabel_47
 jmp delay_until_done_palette

nbasic_autolabel_47:
 rts

change_palette_init:
 lda #63
 sta PPUHI
 lda #0
 sta PPULOW
 lda #0
 sta palette_counter
 rts

change_palette:
 lda PPUHI
 sta 8198
 lda PPULOW
 sta 8198

		lda palette_counter
		tay
		lda [palette_data_array],y
		sta $2007
		 inc palette_counter
 inc PPULOW
 lda #16
 cmp palette_counter
 bne nbasic_autolabel_48
 lda #0
 sta nmi_to_do

nbasic_autolabel_48:
 rts

draw_2_screens:
 lda #32
 sta 8198
 lda #0
 sta 8198


	ldx #$08
	ldy #$00
load_bg:
	lda [background_data_array],y
	sta $2007
	iny
	bne load_bg
	txa
	pha
	ldx #$01
	inc background_data_array,x
	pla
	tax
	dex
	bne load_bg
	 rts

draw_background_all:
 jsr load_background
 jsr draw_background_init
 lda #120
 sta tempcounter

background_all_loop:
 jsr draw_background
 dec tempcounter

	bne background_all_loop
	 rts

draw_background_main:
 jsr load_background
 jsr draw_background_init
 lda #1
 sta nmi_to_do

delay_until_done:
 lda #0
 cmp nmi_to_do
 beq nbasic_autolabel_49
 jmp delay_until_done

nbasic_autolabel_49:
 rts

draw_background_mainop:
 jsr load_backgroundop
 jsr draw_background_init
 lda #1
 sta nmi_to_do

delay_until_doneop:
 lda #0
 cmp nmi_to_do
 beq nbasic_autolabel_50
 jmp delay_until_doneop

nbasic_autolabel_50:
 rts

load_background:
 lda #0
 sta background_shape
 lda #0
 sta background_tile_array_counter

load_background2:
 lda #0
 sta background_shape_distance
 lda #0
 sta rle_counter

load_shape_and_distance:

	ldy rle_counter
	lda [background_data_array],y
	sta background_shape_distance
	iny
	inc rle_counter
	lda [background_data_array],y
	sta background_shape
	iny
	inc rle_counter
	inc background_shape_distance			;so a 0 = one tile
	
background_shape_fill:
 lda #254
 cmp background_shape
 bne nbasic_autolabel_51
 jmp load_background2

nbasic_autolabel_51:
 lda background_shape
 ldx background_tile_array_counter
 sta background_tile_array,x
 inc background_tile_array_counter
 lda #240
 cmp background_tile_array_counter
 bne nbasic_autolabel_52
 rts

nbasic_autolabel_52:
 dec background_shape_distance
 lda #0
 cmp background_shape_distance
 bcs nbasic_autolabel_53
 jmp background_shape_fill

nbasic_autolabel_53:
 jmp load_shape_and_distance
 rts

load_backgroundop:
 lda #0
 sta background_shape
 lda #0
 sta background_tile_array_counter

load_background2op:
 lda #0
 sta background_shape_distance
 lda #0
 sta rle_counter

load_shape_and_distanceop:

	ldx rle_counter
	lda background_data_arrayop,x
	;lda #$00
	sta background_shape_distance
	inx
	inc rle_counter
	lda background_data_arrayop,x
	;lda #$00
	sta background_shape
	inx
	inc rle_counter
	inc background_shape_distance			;so a 0 = one tile
	
background_shape_fillop:
 lda #254
 cmp background_shape
 bne nbasic_autolabel_54
 jmp load_background2op

nbasic_autolabel_54:
 lda background_shape
 ldx background_tile_array_counter
 sta background_tile_array,x
 inc background_tile_array_counter
 lda #240
 cmp background_tile_array_counter
 bne nbasic_autolabel_55
 rts

nbasic_autolabel_55:
 dec background_shape_distance
 lda #0
 cmp background_shape_distance
 bcs nbasic_autolabel_56
 jmp background_shape_fillop

nbasic_autolabel_56:
 jmp load_shape_and_distanceop
 rts

draw_background_init:
 lda #0
 sta NT_down
 lda #0
 sta background_low
 lda #0
 sta backgroundshape_loc
 lda #0
 sta backgroundshape_loc_offset
 lda #0
 sta background_tile_loc
 lda #0
 sta NT_across
 lda #0
 cmp current_NT
 bne nbasic_autolabel_57
 lda #32
 sta background_hi

nbasic_autolabel_57:
 lda #1
 cmp current_NT
 bne nbasic_autolabel_58
 lda #36
 sta background_hi

nbasic_autolabel_58:
 rts

draw_background:
 lda background_hi
 sta 8198
 lda background_low
 sta 8198
 lda #4
 sta draw_background_across_counter

draw_background_across:
 ldx background_tile_loc
 lda background_tile_array,x
 clc
 asl a
 asl a
 sta backgroundshape_loc
 lda backgroundshape_loc_offset
 clc
 adc backgroundshape_loc
 sta backgroundshape_loc
 ldx backgroundshape_loc
 lda background_shapes,x
 sta 8199
 inc backgroundshape_loc
 inc background_low
 ldx backgroundshape_loc
 lda background_shapes,x
 sta 8199
 inc backgroundshape_loc
 inc background_low
 inc NT_across
 inc background_tile_loc
 dec draw_background_across_counter

	bne draw_background_across
	 lda #16
 cmp NT_across
 bne nbasic_autolabel_59
 lda background_tile_loc
 sec
 sbc #16
 sta background_tile_loc
 lda #2
 sta backgroundshape_loc_offset

nbasic_autolabel_59:
 lda #32
 cmp NT_across
 bne nbasic_autolabel_60
 lda #0
 sta backgroundshape_loc_offset
 lda #0
 sta NT_across

nbasic_autolabel_60:
 lda #0
 cmp background_low
 bne nbasic_autolabel_61
 inc background_hi

nbasic_autolabel_61:
 lda #35
 cmp background_hi
 bne nbasic_autolabel_62
 lda #192
 cmp background_low
 bne nbasic_autolabel_63
 lda #0
 sta nmi_to_do

nbasic_autolabel_63:

nbasic_autolabel_62:
 lda #39
 cmp background_hi
 bne nbasic_autolabel_64
 lda #192
 cmp background_low
 bne nbasic_autolabel_65
 lda #0
 sta nmi_to_do

nbasic_autolabel_65:

nbasic_autolabel_64:
 rts

clear_screen:

 	lda   #%00000000
 	sta   $2000
 	lda   #%00000000     
 	sta   $2001
	 lda #32
 sta 8198
 lda #0
 sta 8198


	ldy #$03
	ldx #$00
clear:
	lda #$24
	sta $2007
	dex
	bne clear
	dey
	bne clear	
	
	ldx #$c0
clear2:
	lda #$24
	sta $2007
	dex
	bne clear2

	ldx #$40
clear3:
	lda #$00
	sta $2007
	dex
	bne clear3
	
	
 	lda   #%10010000
 	sta   $2000
 	lda   #%00011000     
 	sta   $2001
	rts
	
draw_text_main:
 jsr draw_text_init
 lda #1
 sta palette_text
 lda #2
 sta nmi_to_do

delay_until_done2:
 lda #0
 cmp nmi_to_do
 beq nbasic_autolabel_66
 jmp delay_until_done2

nbasic_autolabel_66:
 rts

draw_text_init:
 lda #32
 sta PPUHI
 lda #166
 sta PPULOW
 lda PPULOW
 sta PPULOW_START
 lda #0
 sta TEXTPOS
 lda #0
 sta CHARCOUNTER

drawtext:

drawtext_loop:
 lda PPUHI
 sta 8198
 lda PPULOW
 sta 8198

	ldy CHARCOUNTER
	lda [texts],y
	sta character
	 lda #32
 cmp character
 bne nbasic_autolabel_67
 lda #123
 sta character

nbasic_autolabel_67:
 lda #33
 cmp character
 bne nbasic_autolabel_68
 lda #127
 sta character

nbasic_autolabel_68:
 lda #255
 cmp character
 bne nbasic_autolabel_69
 lda #0
 sta nmi_to_do
 jmp drawtext_done

nbasic_autolabel_69:
 lda character
 sec
 sbc #87
 sta character
 inc CHARCOUNTER
 lda character
 sta 8199
 inc PPULOW
 inc TEXTPOS
 lda #250
 cmp PPULOW
 bne nbasic_autolabel_70
 inc PPUHI

nbasic_autolabel_70:
 lda #20
 cmp TEXTPOS
 bne nbasic_autolabel_71
 lda #64
 clc
 adc PPULOW_START
 sta PPULOW
 lda #64
 clc
 adc PPULOW_START
 sta PPULOW_START
 lda #0
 sta TEXTPOS

nbasic_autolabel_71:

drawtext_done:
 rts

joystick1:
 lda #1
 sta 16406
 lda #0
 sta 16406
 lda 16406
 and #1
 sta joy1a
 lda 16406
 and #1
 sta joy1b
 lda 16406
 and #1
 sta joy1select
 lda 16406
 and #1
 sta joy1start
 lda 16406
 and #1
 sta joy1up
 lda 16406
 and #1
 sta joy1down
 lda 16406
 and #1
 sta joy1left
 lda 16406
 and #1
 sta joy1right
 lda #1
 cmp joy1right
 bne nbasic_autolabel_72
 jmp joy1startawesome

nbasic_autolabel_72:
 jmp joy1startnotawesome

joy1startawesome:
 inc dvdcounter
 lda #0
 cmp dvdcounter
 bne nbasic_autolabel_73
 jmp dvdtitle

nbasic_autolabel_73:
 lda #5
 cmp dvdcounter
 bne nbasic_autolabel_74
 jmp dvdscene1

nbasic_autolabel_74:
 lda #10
 cmp dvdcounter
 bne nbasic_autolabel_75
 jmp dvdscene2

nbasic_autolabel_75:
 lda #15
 cmp dvdcounter
 bne nbasic_autolabel_76
 jmp dvdscene3

nbasic_autolabel_76:
 lda #20
 cmp dvdcounter
 bne nbasic_autolabel_77
 jmp dvdscene4

nbasic_autolabel_77:
 lda #25
 cmp dvdcounter
 bne nbasic_autolabel_78
 jmp dvdscene5

nbasic_autolabel_78:
 lda #30
 cmp dvdcounter
 bne nbasic_autolabel_79
 jmp dvdscene6

nbasic_autolabel_79:
 lda #35
 cmp dvdcounter
 bne nbasic_autolabel_80
 jmp dvdscene7

nbasic_autolabel_80:
 lda #40
 cmp dvdcounter
 bne nbasic_autolabel_81
 jmp dvdscene8

nbasic_autolabel_81:
 lda #45
 cmp dvdcounter
 bne nbasic_autolabel_82
 jmp dvdscene9

nbasic_autolabel_82:
 lda #50
 cmp dvdcounter
 bne nbasic_autolabel_83
 jmp dvdscene10

nbasic_autolabel_83:
 lda #55
 cmp dvdcounter
 bne nbasic_autolabel_84
 jmp dvdscene11

nbasic_autolabel_84:
 lda #60
 cmp dvdcounter
 bne nbasic_autolabel_85
 jmp dvdscene12

nbasic_autolabel_85:
 lda #65
 cmp dvdcounter
 bne nbasic_autolabel_86
 jmp dvdscene14

nbasic_autolabel_86:
 lda #70
 cmp dvdcounter
 bne nbasic_autolabel_87
 jmp dvdscene15

nbasic_autolabel_87:
 lda #75
 cmp dvdcounter
 bne nbasic_autolabel_88
 jmp sculpture1_score

nbasic_autolabel_88:
 lda #80
 cmp dvdcounter
 bne nbasic_autolabel_89
 jmp start

nbasic_autolabel_89:

joy1startnotawesome:
 rts

beige_music_loop:
 inc music_counter
 lda global_tempo
 cmp music_counter
 bcs nbasic_autolabel_90
 lda #0
 sta music_counter
 jsr play_music

nbasic_autolabel_90:
 rts

reset_presets:

	ldy music_counter_file
	lda [which_song],y
	iny
	inc music_counter_file
	sta sound1a
	ldy music_counter_file
	lda [which_song],y
	iny
	inc music_counter_file
	sta sound1b
		
	ldy music_counter_file
	lda [which_song],y
	iny
	inc music_counter_file
	sta sound2a
	ldy music_counter_file
	lda [which_song],y
	iny
	inc music_counter_file
	sta sound2b
	
	ldy music_counter_file
	lda [which_song],y
	iny
	inc music_counter_file
	sta sound3a
	ldy music_counter_file
	lda [which_song],y
	iny
	inc music_counter_file
	sta sound3b
	
	ldy music_counter_file
	lda [which_song],y
	iny
	inc music_counter_file
	sta sound4a
	ldy music_counter_file
	lda [which_song],y
	iny
	inc music_counter_file
	sta sound4b
	 rts

play_music:
 lda #0
 cmp new_music_page
 bne nbasic_autolabel_91
 lda #0
 cmp new_music_page_big
 bne nbasic_autolabel_92
 jsr reset_presets

nbasic_autolabel_92:

nbasic_autolabel_91:
 lda #0
 sta i1

	ldx #$00
	lda #$01
	cmp mute,x
	beq skip_p1_mute
	lda sound1a
	sta $4000
	lda sound1b
	sta $4001
	ldy music_counter_file
  	lda [which_song],y
  	cmp #$01
  	beq skip_p1
  	sta color_show
   	asl a
 	tax
 	lda frequzzz,x
 	sta $4002
 	sta i1
 	inx
 	lda frequzzz,x
	sta $4003
 	 jmp no_skip_p1

skip_p1_mute:
 lda #0
 sta 16384
 lda #0
 sta 16385

skip_p1:

no_skip_p1:
 inc music_counter_file
 lda #0
 sta i2

	ldx #$01
	lda #$01
	cmp mute,x
	beq skip_p2
	lda sound2a
	sta $4004
	lda sound2b
	sta $4005
	ldy music_counter_file
  	lda [which_song],y
  	cmp #$01
  	beq skip_p2
   	sta color_show_beige
  	asl a
 	tax
 	lda frequzzz,x
 	sta $4006
 	sta i2
 	inx
 	lda frequzzz,x
 	ora %10011111
 	sta $4007
 	
skip_p2:
 inc music_counter_file
 lda #0
 sta i3

	ldx #$02
	lda #$01
	cmp mute,x
	beq skip_p3_mute
	lda sound3a
	sta $4008
	lda sound3b
	sta $4009
	ldy music_counter_file
  	lda [which_song],y
  	cmp #$01
  	beq skip_p3
  	sta color_show_beige2
  	asl a
 	tax
 	lda frequzzz,x
 	sta $400a
 	sta i3
 	inx
 	lda frequzzz,x
 	sta $400b
 	 jmp no_skip_p3_mute

skip_p3_mute:
 lda #0
 sta 16392
 lda #0
 sta 16393

no_skip_p3_mute:

skip_p3:
 inc music_counter_file
 lda #0
 sta i4

	ldx #$03
	lda #$01
	cmp mute,x
	beq skip_p4
	lda sound4a
	sta $400c
	lda sound4b
	sta $400d
	ldy music_counter_file
  	lda [which_song],y
   	cmp #$01
  	beq skip_p4
  	sta color_show_beige3
  	asl a
 	tax
 	lda frequzzz,x
 	sta $400e
 	sta i4
 	inx
 	lda frequzzz,x
 	sta $400f
 	
skip_p4:
 inc music_counter_file
 inc new_music_page
 lda #0
 cmp new_music_page
 bne nbasic_autolabel_93
 inc new_music_page_big

nbasic_autolabel_93:


	lda #$00
	cmp music_counter_file
	bne continue_no_plus

	ldx #$01
	inc which_song,x

	
continue_no_plus:

	ldy music_counter_file
  	lda [which_song],y
  	cmp #$0f
  	bne go_on
	
	lda #$00
	sta new_music_page
	sta new_music_page_big
	sta music_counter_file
	 dec scene_timer
 ldx #0
 lda songs,x
 ldx #0
 sta which_song,x
 ldx #1
 lda songs,x
 ldx #1
 sta which_song,x
 ldx #0
 lda mute_new,x
 ldx #0
 sta mute,x
 ldx #1
 lda mute_new,x
 ldx #1
 sta mute,x
 ldx #2
 lda mute_new,x
 ldx #2
 sta mute,x
 ldx #3
 lda mute_new,x
 ldx #3
 sta mute,x
 inc music_counter

go_on:
 rts

nmi:

pha
tya
pha
txa
pha
 inc timer
 lda #0
 cmp nmi_to_do
 bne nbasic_autolabel_94
 jmp skip_nmi_to_do

nbasic_autolabel_94:
 lda #1
 cmp nmi_to_do
 bne nbasic_autolabel_95
 jsr draw_background

nbasic_autolabel_95:
 lda #2
 cmp nmi_to_do
 bne nbasic_autolabel_96
 jsr drawtext

nbasic_autolabel_96:
 lda #3
 cmp nmi_to_do
 bne nbasic_autolabel_97
 jsr move_sprite_1

nbasic_autolabel_97:
 lda #4
 cmp nmi_to_do
 bne nbasic_autolabel_98
 jsr change_palette

nbasic_autolabel_98:
 lda #5
 cmp nmi_to_do
 bne nbasic_autolabel_99
 jsr move_sprite_2

nbasic_autolabel_99:
 lda #6
 cmp nmi_to_do
 bne nbasic_autolabel_100
 jsr move_sprite_1
 jsr move_sprite_2

nbasic_autolabel_100:

skip_nmi_to_do:
 lda #1
 cmp nmi_to_do_special
 bne nbasic_autolabel_101
 jsr move_sprite_1

nbasic_autolabel_101:
 jsr beige_music_loop
 jsr PutSpritesOnScreen
 jsr joystick1
 lda #0
 cmp palette_text
 bne nbasic_autolabel_102
 jmp skip_palette_text

nbasic_autolabel_102:
 lda #1
 cmp palette_text
 bne nbasic_autolabel_103
 lda #0
 sta special
 lda #63
 sta 8198
 lda #16
 sta 8198
 lda #13
 sta 8199
 lda #63
 sta 8198
 lda #1
 sta 8198
 lda #48
 sta 8199

nbasic_autolabel_103:
 lda #2
 cmp palette_text
 bne nbasic_autolabel_104
 lda #63
 sta 8198
 lda #16
 sta 8198

	ldy #$10
	lda [palette_data_array],y
	sta $2007
	iny
	lda #$3f
	sta $2006
	lda #$01
	sta $2006
	ldy #$01
	lda [palette_data_array],y
	sta $2007
 lda #0
 sta palette_text

nbasic_autolabel_104:

skip_palette_text:
 lda #0
 cmp special
 bne nbasic_autolabel_105
 jmp skip_special

nbasic_autolabel_105:
 lda #1
 cmp special
 bne nbasic_autolabel_106
 lda #63
 sta 8198
 lda #16
 sta 8198
 lda special_temp
 sta 8199

nbasic_autolabel_106:
 lda #2
 cmp special
 bne nbasic_autolabel_107
 dec special_temp_2
 lda #0
 cmp special_temp_2
 bpl nbasic_autolabel_108
 jmp skip_spcial_2

nbasic_autolabel_108:
 lda special_temp_2_master
 sta special_temp_2
 lda #63
 sta 8198
 lda #16
 sta 8198
 lda special_temp
 sta 8199
 inc special_temp

skip_spcial_2:

nbasic_autolabel_107:
 lda #3
 cmp special
 bne nbasic_autolabel_109
 dec special_temp_2
 lda #0
 cmp special_temp_2
 bpl nbasic_autolabel_110
 jmp skip_spcial_3

nbasic_autolabel_110:
 lda special_temp_2_master
 sta special_temp_2
 lda #63
 sta 8198
 lda #0
 sta 8198
 lda special_temp
 sta 8199
 inc special_temp
 inc special_temp
 inc special_temp
 lda special_temp
 sta 8199
 inc special_temp
 inc special_temp
 inc special_temp
 lda special_temp
 sta 8199
 inc special_temp
 inc special_temp
 inc special_temp
 lda special_temp
 sta 8199
 inc special_temp
 inc special_temp
 inc special_temp

skip_spcial_3:

nbasic_autolabel_109:
 lda #4
 cmp special
 bne nbasic_autolabel_111
 dec special_temp_2
 lda #0
 cmp special_temp_2
 bpl nbasic_autolabel_112
 jmp skip_spcial_4

nbasic_autolabel_112:
 lda special_temp_2_master
 sta special_temp_2
 lda #63
 sta 8198
 lda #1
 sta 8198
 lda special_temp
 sta 8199
 inc special_temp
 lda special_temp
 sta 8199
 inc special_temp
 lda special_temp
 sta 8199
 inc special_temp
 lda special_temp
 sta 8199
 inc special_temp
 lda #63
 sta 8198
 lda #16
 sta 8198
 lda color_show
 sta 8199

skip_spcial_4:

nbasic_autolabel_111:
 lda #5
 cmp special
 bne nbasic_autolabel_113
 dec special_temp_2
 lda #0
 cmp special_temp_2
 bpl nbasic_autolabel_114
 jmp skip_spcial_5

nbasic_autolabel_114:
 lda special_temp_2_master
 sta special_temp_2
 lda #63
 sta 8198
 lda #16
 sta 8198
 lda color_show
 sta 8199

skip_spcial_5:

nbasic_autolabel_113:
 lda #6
 cmp special
 bne nbasic_autolabel_115
 dec special_temp_2
 lda #0
 cmp special_temp_2
 bpl nbasic_autolabel_116
 jmp skip_spcial_6

nbasic_autolabel_116:
 lda special_temp_2_master
 sta special_temp_2
 lda #63
 sta 8198
 lda #0
 sta 8198
 lda color_show
 sta 8199
 lda color_show_beige
 sta 8199
 lda color_show_beige2
 sta 8199
 lda color_show_beige3
 sta 8199

skip_spcial_6:

nbasic_autolabel_115:
 lda #7
 cmp special
 bne nbasic_autolabel_117
 lda #63
 sta 8198
 lda #16
 sta 8198
 lda #13
 sta 8199
 lda color_show
 sta 8199
 lda color_show_beige
 sta 8199
 lda color_show_beige2
 sta 8199
 lda color_show_beige3
 sta 8199

nbasic_autolabel_117:
 lda #8
 cmp special
 bne nbasic_autolabel_118
 lda #63
 sta 8198
 lda #16
 sta 8198
 lda color_show
 sta 8199
 lda color_show_beige
 sta 8199
 lda color_show_beige2
 sta 8199
 lda color_show_beige3
 sta 8199

nbasic_autolabel_118:
 lda #9
 cmp special
 bne nbasic_autolabel_119
 lda #63
 sta 8198
 lda #16
 sta 8198
 lda color_show
 sta 8199

nbasic_autolabel_119:
 lda #10
 cmp special
 bne nbasic_autolabel_120
 lda #63
 sta 8198
 lda #0
 sta 8198
 lda color_show
 sta 8199
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show
 lda color_show
 sta 8199
 inc color_show

nbasic_autolabel_120:

skip_special:
 lda #0
 cmp special_scroll
 bne nbasic_autolabel_121
 jmp skip_special_scroll

nbasic_autolabel_121:
 lda #1
 cmp special_scroll
 bne nbasic_autolabel_122

decscroll:
 dec scroll_delay

	bne skip_scroll
	 lda scroll_delay_master
 sta scroll_delay
 dec scroll

skip_scroll:
	
nbasic_autolabel_122:
 lda #2
 cmp special_scroll
 bne nbasic_autolabel_123

decscroll2:
 inc scroll2
 inc scroll2
 inc scroll2
 inc scroll2

skip_scroll2:

nbasic_autolabel_123:
 lda #3
 cmp special_scroll
 bne nbasic_autolabel_124
 inc scroll
 inc scroll
 inc scroll
 inc scroll

nbasic_autolabel_124:
 lda #4
 cmp special_scroll
 bne nbasic_autolabel_125
 inc scroll
 inc scroll
 inc scroll
 inc scroll
 lda color_show
 sta scroll2
 lda color_show_beige
 sta scroll

nbasic_autolabel_125:
 lda #5
 cmp special_scroll
 bne nbasic_autolabel_126
 inc scroll
 inc scroll
 inc scroll
 inc scroll
 lda color_show
 sta scroll2

nbasic_autolabel_126:
 lda #6
 cmp special_scroll
 bne nbasic_autolabel_127
 dec scroll2
 dec scroll2
 dec scroll2
 dec scroll2
 dec scroll2
 dec scroll2

nbasic_autolabel_127:
 lda #7
 cmp special_scroll
 bne nbasic_autolabel_128
 inc scroll

	lda #$ff
	cmp scroll
	bne special_scroll_nothing
	 lda #0
 sta special_scroll

special_scroll_nothing:
	
nbasic_autolabel_128:

skip_special_scroll:
 lda #0
 cmp special_att
 bne nbasic_autolabel_129
 jmp skip_special_att

nbasic_autolabel_129:
 lda #1
 cmp special_att
 bne nbasic_autolabel_130
 lda PPUHI
 sta 8198
 lda PPULOW
 sta 8198
 lda att_var
 sta 8199
 inc att_var
 inc PPULOW
 lda #255
 cmp PPULOW
 bne nbasic_autolabel_131
 lda #192
 sta PPULOW

nbasic_autolabel_131:

nbasic_autolabel_130:
 lda #2
 cmp special_att
 bne nbasic_autolabel_132
 lda PPUHI
 sta 8198
 lda PPULOW
 sta 8198
 lda att_var
 sta 8199
 inc PPULOW
 lda #0
 cmp PPULOW
 bne nbasic_autolabel_133
 lda #192
 sta PPULOW
 inc att_var

nbasic_autolabel_133:

nbasic_autolabel_132:

skip_special_att:
 lda #0
 cmp pong_trick
 bne nbasic_autolabel_134
 jmp skip_pong_trick

nbasic_autolabel_134:
 lda #1
 cmp pong_trick
 bne nbasic_autolabel_135
 inc pong_trick_temp
 lda pong_trick_temp
 ldx pong_trick_loc
 sta spritemem,x
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_temp
 lda pong_trick_temp
 ldx pong_trick_loc
 sta spritemem,x
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_temp
 lda pong_trick_temp
 ldx pong_trick_loc
 sta spritemem,x
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_temp
 lda pong_trick_temp
 ldx pong_trick_loc
 sta spritemem,x
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 lda #117
 cmp pong_trick_loc
 bne nbasic_autolabel_136
 lda #49
 sta pong_trick_loc

nbasic_autolabel_136:
 lda #129
 cmp pong_trick_loc
 bne nbasic_autolabel_137
 lda #49
 sta pong_trick_loc

nbasic_autolabel_137:

nbasic_autolabel_135:
 lda #2
 cmp pong_trick
 bne nbasic_autolabel_138
 inc pong_trick_temp
 lda pong_trick_temp
 ldx pong_trick_loc
 sta spritemem,x
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_temp
 lda pong_trick_temp
 ldx pong_trick_loc
 sta spritemem,x
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_temp
 lda pong_trick_temp
 ldx pong_trick_loc
 sta spritemem,x
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_temp
 lda pong_trick_temp
 ldx pong_trick_loc
 sta spritemem,x
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 inc pong_trick_loc
 lda #21
 cmp pong_trick_loc
 bne nbasic_autolabel_139
 lda #1
 sta pong_trick_loc

nbasic_autolabel_139:
 lda #33
 cmp pong_trick_loc
 bne nbasic_autolabel_140
 lda #1
 sta pong_trick_loc

nbasic_autolabel_140:

skip_pong_trick:

nbasic_autolabel_138:
 lda #0
 sta 8198
 lda #0
 sta 8198
 lda scroll
 sta 8197
 lda scroll2
 sta 8197

pla
tax
pla
tay
pla
rti

;++++++++++++++++++++++++++++++++++++++++++++++++
;IRQ
;++++++++++++++++++++++++++++++++++++++++++++++++

 irq:

	rti

reset_nmi_vars:
 jsr screen_off
 jsr clear_att
 jsr erase_sprites
 lda #0
 sta nmi_to_do
 lda #0
 sta palette_text
 lda #0
 sta special
 lda #0
 sta special_temp
 lda #0
 sta special_temp_2
 lda #0
 sta special_scroll
 lda #0
 sta scroll_delay_master
 lda #0
 sta scroll_delay
 lda #0
 sta special_att
 lda #0
 sta att_var
 lda #0
 sta PPULOW
 lda #0
 sta PPUHI
 lda #0
 sta pong_trick
 lda #0
 sta pong_trick_temp
 lda #0
 sta pong_trick_loc
 lda #0
 sta scroll
 lda #0
 sta scroll2
 jsr show_number_2
 lda #0
 sta nmi_to_do_special
 rts

drums:
 lda #1
 ldx #0
 sta mute,x
 lda #1
 ldx #1
 sta mute,x
 lda #1
 ldx #2
 sta mute,x
 lda #0
 ldx #3
 sta mute,x
 lda #1
 ldx #0
 sta mute_new,x
 lda #1
 ldx #1
 sta mute_new,x
 lda #1
 ldx #2
 sta mute_new,x
 lda #0
 ldx #3
 sta mute_new,x
 rts

drums_bass:
 lda #1
 ldx #0
 sta mute,x
 lda #1
 ldx #1
 sta mute,x
 lda #0
 ldx #2
 sta mute,x
 lda #0
 ldx #3
 sta mute,x
 lda #1
 ldx #0
 sta mute_new,x
 lda #1
 ldx #1
 sta mute_new,x
 lda #0
 ldx #2
 sta mute_new,x
 lda #0
 ldx #3
 sta mute_new,x
 rts

drums_bass_melody:
 lda #0
 ldx #0
 sta mute,x
 lda #1
 ldx #1
 sta mute,x
 lda #0
 ldx #2
 sta mute,x
 lda #0
 ldx #3
 sta mute,x
 lda #0
 ldx #0
 sta mute_new,x
 lda #1
 ldx #1
 sta mute_new,x
 lda #0
 ldx #2
 sta mute_new,x
 lda #0
 ldx #3
 sta mute_new,x
 rts

bass_guitar:
 lda #1
 ldx #0
 sta mute,x
 lda #0
 ldx #1
 sta mute,x
 lda #0
 ldx #2
 sta mute,x
 lda #1
 ldx #3
 sta mute,x
 lda #1
 ldx #0
 sta mute_new,x
 lda #0
 ldx #1
 sta mute_new,x
 lda #0
 ldx #2
 sta mute_new,x
 lda #1
 ldx #3
 sta mute_new,x
 rts

melody:
 lda #0
 ldx #0
 sta mute,x
 lda #1
 ldx #1
 sta mute,x
 lda #1
 ldx #2
 sta mute,x
 lda #1
 ldx #3
 sta mute,x
 lda #0
 ldx #0
 sta mute_new,x
 lda #1
 ldx #1
 sta mute_new,x
 lda #1
 ldx #2
 sta mute_new,x
 lda #1
 ldx #3
 sta mute_new,x
 rts

melody_guitar:
 lda #0
 ldx #0
 sta mute,x
 lda #0
 ldx #1
 sta mute,x
 lda #1
 ldx #2
 sta mute,x
 lda #1
 ldx #3
 sta mute,x
 lda #0
 ldx #0
 sta mute_new,x
 lda #0
 ldx #1
 sta mute_new,x
 lda #1
 ldx #2
 sta mute_new,x
 lda #1
 ldx #3
 sta mute_new,x
 rts

drums_bass_guitar_melody:
 lda #0
 ldx #0
 sta mute,x
 lda #0
 ldx #1
 sta mute,x
 lda #0
 ldx #2
 sta mute,x
 lda #0
 ldx #3
 sta mute,x
 lda #0
 ldx #0
 sta mute_new,x
 lda #0
 ldx #1
 sta mute_new,x
 lda #0
 ldx #2
 sta mute_new,x
 lda #0
 ldx #3
 sta mute_new,x
 rts

set_song:
 ldx #0
 lda songs,x
 ldx #0
 sta which_song,x
 ldx #1
 lda songs,x
 ldx #1
 sta which_song,x
 rts

start_music:
 lda #0
 sta music_counter_file
 lda #0
 sta music_counter
 lda #0
 sta new_music_page
 lda #0
 sta new_music_page_big
 rts

draw_text_all:
 jsr sprites_off
 jsr show_number_1
 jsr draw_text_main
 lda #0
 sta timer
 jsr delay_1_sec
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #2
 sta palette_text
 jsr show_number_2
 jsr animate_sprites
 jsr sprites_on
 rts

mario_bottom:

	ldx #$1c
	lda spritemem,x
	cmp #$fe
	bne mario_bottom
	 rts

mario_off:

	ldy #$20
	ldx #$00
erase_mario:
	lda #$FC
	sta spritemem,x
	inx
	dey
	bne erase_mario
	 rts

mario_off_right:
 ldx #3
 lda spritemem,x
 cmp #240
 beq nbasic_autolabel_141
 jmp mario_off_right

nbasic_autolabel_141:
 rts

scene_title:
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 ldx #0
 lda theme1,x
 ldx #0
 sta songs,x
 ldx #1
 lda theme1,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda background35,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background35,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda background34,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background34,x
 ldx #1
 sta background_data_array,x

	lda #$24
	sta $2006
	lda #$00
	sta $2006 
	
	ldx #$80
loop_80:		
	lda #$24
	sta $2007
	dex
	bne loop_80
	
	ldx #$01
	ldy #$00
load_clouds:
	lda [background_data_array],y
	sta $2007
	iny
	bne load_clouds
	ldx #$01
	inc background_data_array,x

	ldx #$00
	ldy #$00
load_clouds2:
	lda [background_data_array],y
	sta $2007
	iny
	dex
	bne load_clouds2
	 jsr screen_on
 lda #7
 sta special_scroll
 jsr scene_music_loop
 rts

scene1:
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 ldx #0
 lda theme1,x
 ldx #0
 sta songs,x
 ldx #1
 lda theme1,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr melody
 jsr start_music
 ldx #0
 lda palette_data1,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data1,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #0
 sta current_NT
 ldx #0
 lda att_data2,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda att_data2,x
 ldx #1
 sta att_data_array,x
 jsr load_att
 lda #1
 sta current_NT
 ldx #0
 lda att_data2,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda att_data2,x
 ldx #1
 sta att_data_array,x
 jsr load_att
 lda #1
 sta current_NT
 ldx #0
 lda background2,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background2,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #80
 sta sprite_y
 lda #112
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data1,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data1,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 jsr animate_sprites
 jsr show_number_2
 jsr screen_on
 ldx #0
 lda backgroundtextintro1,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtextintro1,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 ldx #0
 lda backgroundtextintro2,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtextintro2,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #7
 sta scene_timer
 jsr scene_music_loop
 jsr melody_guitar
 ldx #0
 lda backgroundtext1,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext1,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #2
 sta special
 lda #1
 sta current_NT
 ldx #0
 lda background3,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background3,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 jsr animate_sprites
 lda #3
 sta scene_timer
 jsr scene_music_loop
 jsr drums_bass_guitar_melody
 ldx #0
 lda backgroundtext2,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext2,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #80
 sta sprite_data_pos
 lda #110
 sta sprite_y
 lda #110
 sta sprite_x
 lda #1
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr change_palette_main
 ldx #0
 lda sprite_anim_data1,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data1,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 jsr animate_sprites
 lda #1
 sta current_NT
 ldx #0
 lda background4,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background4,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 ldx #0
 lda sprite_anim_data2,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data2,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #16
 sta special_temp
 lda #16
 sta special_temp_2
 lda #2
 sta special
 lda #32
 sta scroll_delay
 lda #32
 sta scroll_delay_master
 lda #1
 sta special_scroll
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #1
 sta special_scroll
 ldx #0
 lda sprite_anim_data3,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data3,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 lda #0
 sta counter
 jsr animate_sprites
 lda #16
 sta special_temp
 lda #16
 sta special_temp_2
 lda #2
 sta special
 jsr mario_bottom
 jsr mario_off
 lda #0
 sta nmi_to_do
 lda #1
 sta scene_timer
 jsr scene_music_loop
 rts

	.bank 1
	.org $a000

scene2:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda fallingreverb2,x
 ldx #0
 sta songs,x
 ldx #1
 lda fallingreverb2,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #1
 sta current_NT
 ldx #0
 lda background4,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background4,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #80
 sta sprite_y
 lda #112
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data4,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data4,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 lda #0
 sta counter
 jsr show_number_2
 jsr screen_on
 lda #3
 sta scroll_delay
 lda #3
 sta scroll_delay_master
 lda #2
 sta special_scroll
 lda #10
 sta special_temp_2
 lda #10
 sta special_temp_2_master
 lda #2
 sta special
 lda #1
 sta nmi_to_do_special
 lda #2
 sta scene_timer
 jsr scene_music_loop
 jsr drums_bass
 lda #1
 sta current_NT
 ldx #0
 lda background5,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background5,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #2
 sta scene_timer
 jsr scene_music_loop
 jsr drums_bass_guitar_melody
 lda #1
 sta current_NT
 ldx #0
 lda background6,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background6,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta timer
 jsr delay_1_sec
 lda #0
 sta timer
 jsr delay_1_sec
 lda #0
 sta timer
 lda #1
 sta scene_timer
 jsr scene_music_loop
 rts

scene3:
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 ldx #0
 lda aaliyah4,x
 ldx #0
 sta songs,x
 ldx #1
 lda aaliyah4,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda background8,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background8,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda att_data1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda att_data1,x
 ldx #1
 sta att_data_array,x
 jsr load_att
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #0
 sta sprite_y
 lda #45
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data5,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data5,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 jsr animate_sprites
 lda #0
 sta counter
 jsr show_number_2
 jsr screen_on
 lda #2
 sta special
 lda #64
 sta special_temp
 lda #64
 sta special_temp_2
 lda #64
 sta special_temp_2_master
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda backgroundtext3a,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext3a,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #127
 sta sprite_y
 lda #65
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data6,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data6,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 lda #0
 sta counter
 jsr animate_sprites
 lda #2
 sta special
 lda #64
 sta special_temp
 lda #64
 sta special_temp_2
 lda #64
 sta special_temp_2_master
 lda #0
 sta current_NT
 ldx #0
 lda background9,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background9,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 jsr animate_sprites

wait_head_hit:
 ldx #0
 lda spritemem,x
 cmp #117
 beq nbasic_autolabel_142
 jmp wait_head_hit

nbasic_autolabel_142:
 lda #1
 sta scene_timer
 jsr scene9
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 ldx #0
 lda crazy6,x
 ldx #0
 sta songs,x
 ldx #1
 lda crazy6,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #0
 sta current_NT
 ldx #0
 lda background10,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background10,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda background9,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background9,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda att_data1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda att_data1,x
 ldx #1
 sta att_data_array,x
 jsr load_att
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #127
 sta sprite_y
 lda #65
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data6,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data6,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 lda #0
 sta counter
 jsr animate_sprites
 lda #2
 sta special
 lda #64
 sta special_temp
 lda #64
 sta special_temp_2
 lda #64
 sta special_temp_2_master
 jsr show_number_2
 jsr screen_on
 lda #2
 sta special
 lda #64
 sta special_temp
 lda #64
 sta special_temp_2
 lda #64
 sta special_temp_2_master

wait_head_hit3:
 ldx #0
 lda spritemem,x
 cmp #117
 beq nbasic_autolabel_143
 jmp wait_head_hit3

nbasic_autolabel_143:
 jsr show_number_1

wait_head_hit4:
 ldx #0
 lda spritemem,x
 cmp #127
 beq nbasic_autolabel_144
 jmp wait_head_hit4

nbasic_autolabel_144:
 lda #0
 sta anim_file_counter
 lda #0
 sta counter
 jsr animate_sprites

wait_head_hit5:
 ldx #0
 lda spritemem,x
 cmp #117
 beq nbasic_autolabel_145
 jmp wait_head_hit5

nbasic_autolabel_145:
 jsr show_number_2

wait_head_hit6:
 ldx #0
 lda spritemem,x
 cmp #127
 beq nbasic_autolabel_146
 jmp wait_head_hit6

nbasic_autolabel_146:
 lda #0
 sta anim_file_counter
 lda #0
 sta counter
 jsr animate_sprites

wait_head_hit7:
 ldx #0
 lda spritemem,x
 cmp #117
 beq nbasic_autolabel_147
 jmp wait_head_hit7

nbasic_autolabel_147:
 jsr show_number_1

wait_head_hit8:
 ldx #0
 lda spritemem,x
 cmp #127
 beq nbasic_autolabel_148
 jmp wait_head_hit8

nbasic_autolabel_148:
 lda #0
 sta anim_file_counter
 lda #0
 sta counter
 jsr animate_sprites

wait_head_hit9:
 ldx #0
 lda spritemem,x
 cmp #117
 beq nbasic_autolabel_149
 jmp wait_head_hit9

nbasic_autolabel_149:
 lda #1
 sta scene_timer
 jsr scene9
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 ldx #0
 lda crazy7,x
 ldx #0
 sta songs,x
 ldx #1
 lda crazy7,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda background9,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background9,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda att_data2,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda att_data2,x
 ldx #1
 sta att_data_array,x
 jsr load_att
 lda #1
 sta current_NT
 ldx #0
 lda att_data1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda att_data1,x
 ldx #1
 sta att_data_array,x
 jsr load_att
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #127
 sta sprite_y
 lda #65
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data6,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data6,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 lda #0
 sta counter
 jsr animate_sprites
 lda #2
 sta special
 lda #64
 sta special_temp
 lda #64
 sta special_temp_2
 lda #64
 sta special_temp_2_master
 jsr show_number_1
 jsr screen_on
 ldx #0
 lda backgroundtext5,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext5,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 ldx #0
 lda sprite_anim_data1,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data1,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #0
 sta nmi_to_do
 ldx #0
 lda sprite_anim_data7,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data7,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #0
 sta counter
 jsr animate_sprites
 jsr mario_off_right
 jsr sprites_off
 lda #1
 sta scene_timer
 jsr scene_music_loop
 rts

scene4redux:
 ldx #0
 lda background14,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background14,x
 ldx #1
 sta background_data_array,x
 jsr scene4
 ldx #0
 lda backgroundtext7,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext7,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #50
 sta special_temp_2_master
 lda #50
 sta special_temp_2
 lda #5
 sta special
 lda #9
 sta global_tempo
 lda #208
 sta timer_noise
 lda #5
 sta scene5_loop
 jsr scene5
 ldx #0
 lda background15,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background15,x
 ldx #1
 sta background_data_array,x
 jsr scene4
 ldx #0
 lda backgroundtext7a,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext7a,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 rts

scene4:
 jsr screen_off
 jsr erase_sprites
 lda #0
 sta nmi_to_do
 lda #0
 sta palette_text
 lda #0
 sta special
 lda #0
 sta special_temp
 lda #0
 sta special_temp_2
 lda #0
 sta special_scroll
 lda #0
 sta scroll_delay_master
 lda #0
 sta scroll_delay
 lda #0
 sta special_att
 lda #0
 sta att_var
 lda #0
 sta PPULOW
 lda #0
 sta PPUHI
 lda #0
 sta pong_trick
 lda #0
 sta pong_trick_temp
 lda #0
 sta pong_trick_loc
 lda #0
 sta scroll
 lda #0
 sta scroll2
 jsr show_number_2
 lda #0
 sta nmi_to_do_special
 lda #6
 sta global_tempo
 ldx #0
 lda crazy8,x
 ldx #0
 sta songs,x
 ldx #1
 lda crazy8,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #1
 sta current_NT
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #127
 sta sprite_y
 lda #0
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data7,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data7,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 lda #0
 sta counter
 jsr animate_sprites
 jsr show_number_2
 jsr screen_on
 lda #1
 sta special_temp_2_master
 lda #1
 sta special_temp_2
 lda #5
 sta special
 jsr mario_off_right
 jsr sprites_off
 lda #1
 sta scene_timer
 jsr scene_music_loop
 rts

scene5:
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 jsr screen_off
 ldx #0
 lda rand1,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta palette_data_array,x
 lda #45
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #3
 sta att_start
 jsr load_att_rand
 jsr show_number_2
 jsr screen_on
 jsr sprites_off
 lda #1
 sta palette_text

scene5loop:
 lda scene5_temp
 ldx #0
 sta palette_data_array,x
 lda scene5_temp_2
 ldx #1
 sta palette_data_array,x
 lda scene5_temp
 sta palette_start
 lda #1
 sta current_NT
 lda scene5_temp
 ldx #0
 sta background_data_array,x
 lda scene5_temp_2
 ldx #1
 sta background_data_array,x
 jsr screen_off
 jsr draw_background_all
 jsr screen_on
 jsr sprites_off
 lda timer_noise
 sta timer
 jsr delay_1_sec

	inc scene5_temp
	
	dec scene5_loop
	bne scene5loop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	 rts

scene5a:
 jsr screen_off
 lda #6
 sta global_tempo
 ldx #0
 lda theme1,x
 ldx #0
 sta songs,x
 ldx #1
 lda theme1,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 jsr screen_off
 ldx #0
 lda rand1,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta palette_data_array,x
 lda #45
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #3
 sta att_start
 jsr load_att_rand
 jsr show_number_2
 jsr screen_on
 jsr sprites_off
 lda #10
 sta special

scene5aloop:
 lda scene5_temp
 ldx #0
 sta palette_data_array,x
 lda scene5_temp_2
 ldx #1
 sta palette_data_array,x
 lda scene5_temp
 sta palette_start
 lda #1
 sta current_NT
 lda scene5_temp
 ldx #0
 sta background_data_array,x
 lda scene5_temp_2
 ldx #1
 sta background_data_array,x
 jsr screen_off
 jsr draw_background_all
 jsr screen_on
 jsr sprites_off
 lda timer_noise
 sta timer
 jsr delay_1_sec

	inc scene5_temp
	
	dec scene5_loop
	bne scene5aloop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	 rts

scene5b:
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 jsr set_song
 jsr start_music
 jsr screen_off
 ldx #0
 lda rand1,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta palette_data_array,x
 lda #45
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #3
 sta att_start
 jsr load_att_rand
 jsr show_number_2
 jsr screen_on
 jsr sprites_off
 lda #10
 sta special

scene5bloop:
 lda scene5_temp
 ldx #0
 sta palette_data_array,x
 lda scene5_temp_2
 ldx #1
 sta palette_data_array,x
 lda scene5_temp
 sta palette_start
 lda #1
 sta current_NT
 lda scene5_temp
 ldx #0
 sta background_data_array,x
 lda scene5_temp_2
 ldx #1
 sta background_data_array,x
 jsr screen_off
 jsr draw_background_all
 jsr screen_on
 jsr sprites_off
 lda timer_noise
 sta timer
 jsr delay_1_sec

	inc scene5_temp
	
	dec scene5_loop
	bne scene5bloop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	 rts

scene6:
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 ldx #0
 lda bootyA12,x
 ldx #0
 sta songs,x
 ldx #1
 lda bootyA12,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda rand1,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta palette_data_array,x
 lda #0
 sta palette_start
 jsr load_palette_rand
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda background17,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background17,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #4
 sta att_start
 jsr load_att_rand
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #16
 sta sprite_data_pos
 lda #112
 sta sprite_y
 lda #167
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 lda #80
 sta sprite_data_pos
 lda #120
 sta sprite_y
 lda #12
 sta sprite_x
 lda #4
 sta sprite_type
 jsr draw_sprites
 lda #88
 sta sprite_data_pos
 lda #136
 sta sprite_y
 lda #16
 sta sprite_x
 lda #3
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data8,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data8,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #7
 sta total_blocks_master
 lda #32
 sta sprite_mem_loc_master
 jsr animate_sprites
 lda #0
 sta counter
 jsr show_number_2
 jsr screen_on
 lda #15
 sta special_temp_2
 lda #15
 sta special_temp_2_master
 lda #4
 sta special
 lda #1
 sta scene_timer
 jsr scene_music_loop
 jsr drums_bass_melody
 ldx #0
 lda backgroundtext8,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext8,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #4
 sta special
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda backgroundtext9,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext9,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #4
 sta special
 lda #1
 sta scene_timer
 jsr scene_music_loop
 jsr drums_bass_melody
 ldx #0
 lda backgroundtext10,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext10,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #4
 sta special

scene6loop:

	ldx #$27
	lda spritemem,x
	cmp #$94
	bne scene6loop
	 lda #0
 sta nmi_to_do
 ldx #0
 lda sprite_anim_data9,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data9,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #8
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 jsr animate_sprites
 lda #0
 sta counter
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda sprite_anim_data10,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data10,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #17
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 jsr animate_sprites
 jsr mario_off_right
 jsr sprites_off
 lda #1
 sta scene_timer
 jsr scene_music_loop
 rts

scene7:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda bootyB13,x
 ldx #0
 sta songs,x
 ldx #1
 lda bootyB13,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda background19,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta palette_data_array,x
 lda #19
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #4
 sta att_start
 jsr load_att_rand
 lda #0
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #4
 sta att_start
 jsr load_att_rand
 lda #1
 sta current_NT
 ldx #0
 lda background19,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background19,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 jsr show_number_2
 jsr screen_on
 jsr sprites_off
 lda #39
 sta special_temp_2
 lda #39
 sta special_temp_2_master
 lda #4
 sta special
 lda #3
 sta special_scroll
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #4
 sta special_scroll
 lda #1
 sta current_NT
 ldx #0
 lda background20,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background20,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta current_NT
 ldx #0
 lda background20,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background20,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #1
 sta current_NT
 ldx #0
 lda background21,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background21,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta current_NT
 ldx #0
 lda background21,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background21,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #1
 sta current_NT
 ldx #0
 lda background22,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background22,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta current_NT
 ldx #0
 lda background22,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background22,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #90
 sta sprite_y
 lda #15
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 lda #80
 sta sprite_data_pos
 lda #106
 sta sprite_y
 lda #0
 sta sprite_x
 lda #4
 sta sprite_type
 jsr draw_sprites
 lda #88
 sta sprite_data_pos
 lda #122
 sta sprite_y
 lda #10
 sta sprite_x
 lda #3
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda bootyC14,x
 ldx #0
 sta songs,x
 ldx #1
 lda bootyC14,x
 ldx #1
 sta songs,x
 ldx #0
 lda sprite_anim_data11,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data11,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta anim_file_counter
 lda #15
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 lda #0
 sta counter
 jsr animate_sprites
 jsr sprites_on
 lda #5
 sta special_scroll

scene7_loop:

	ldx #$27
	lda spritemem,x
	cmp #$f0
	bne scene7_loop
	 lda #0
 sta nmi_to_do
 jsr sprites_off
 lda #2
 sta scene_timer
 jsr scene_music_loop
 rts

scene12:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda bootyA12,x
 ldx #0
 sta songs,x
 ldx #1
 lda bootyA12,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda background19,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta palette_data_array,x
 lda #19
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda background32,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background32,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background32,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background32,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #90
 sta sprite_y
 lda #15
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 lda #80
 sta sprite_data_pos
 lda #106
 sta sprite_y
 lda #0
 sta sprite_x
 lda #4
 sta sprite_type
 jsr draw_sprites
 lda #88
 sta sprite_data_pos
 lda #122
 sta sprite_y
 lda #10
 sta sprite_x
 lda #3
 sta sprite_type
 jsr draw_sprites
 jsr show_number_2
 jsr screen_on
 jsr sprites_off
 lda #35
 sta special_temp_2
 lda #35
 sta special_temp_2_master
 lda #4
 sta special
 lda #2
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda sprite_anim_data15,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data15,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #15
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 jsr animate_sprites
 jsr sprites_on

scene12_loop:

	ldx #$27
	lda spritemem,x
	cmp #$f0
	bne scene12_loop
	 jsr sprites_off
 lda #2
 sta scene_timer
 jsr scene_music_loop
 rts

scene8:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda bootyB13,x
 ldx #0
 sta songs,x
 ldx #1
 lda bootyB13,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda background19,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta palette_data_array,x
 lda #19
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #4
 sta att_start
 jsr load_att_rand
 lda #0
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #4
 sta att_start
 jsr load_att_rand
 lda #1
 sta current_NT
 ldx #0
 lda background23,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background23,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background23,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background23,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 jsr show_number_2
 jsr screen_on
 jsr sprites_off
 lda #4
 sta special_scroll
 lda #45
 sta special_temp_2
 lda #45
 sta special_temp_2_master
 lda #4
 sta special
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #1
 sta current_NT
 ldx #0
 lda background24,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background24,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta current_NT
 ldx #0
 lda background24,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background24,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #1
 sta current_NT
 ldx #0
 lda background25,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background25,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta current_NT
 ldx #0
 lda background25,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background25,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #1
 sta current_NT
 ldx #0
 lda background26,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background26,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta current_NT
 ldx #0
 lda background26,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background26,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #90
 sta sprite_y
 lda #15
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 lda #80
 sta sprite_data_pos
 lda #106
 sta sprite_y
 lda #0
 sta sprite_x
 lda #4
 sta sprite_type
 jsr draw_sprites
 lda #88
 sta sprite_data_pos
 lda #122
 sta sprite_y
 lda #10
 sta sprite_x
 lda #3
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda bootyC14,x
 ldx #0
 sta songs,x
 ldx #1
 lda bootyC14,x
 ldx #1
 sta songs,x
 ldx #0
 lda sprite_anim_data11,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data11,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #15
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 jsr animate_sprites
 jsr sprites_on
 lda #5
 sta special_scroll

scene8_loop:

	ldx #$27
	lda spritemem,x
	cmp #$f0
	bne scene8_loop
	 lda #0
 sta nmi_to_do
 jsr sprites_off
 lda #2
 sta scene_timer
 jsr scene_music_loop
 jsr screen_off
 rts

scene9:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda song5,x
 ldx #0
 sta songs,x
 ldx #1
 lda song5,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda background19,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta palette_data_array,x
 lda #19
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #4
 sta att_start
 jsr load_att_rand
 lda #0
 sta current_NT
 ldx #0
 lda rand1,x
 ldx #0
 sta att_data_array,x
 ldx #1
 lda rand1,x
 ldx #1
 sta att_data_array,x
 lda #4
 sta att_start
 jsr load_att_rand
 lda #1
 sta current_NT
 ldx #0
 lda background23,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background23,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background23,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background23,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta special_scroll
 jsr show_number_2
 jsr screen_on
 jsr sprites_off
 lda #10
 sta special_temp_2
 lda #10
 sta special_temp_2_master
 lda #4
 sta special
 lda #39
 sta PPUHI
 lda #192
 sta PPULOW
 lda #1
 sta special_att
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #0
 sta special_att
 rts

scene10:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda grime11,x
 ldx #0
 sta songs,x
 ldx #1
 lda grime11,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data6,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data6,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda background19,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta palette_data_array,x
 lda #19
 sta palette_start
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta special_scroll
 jsr show_number_2
 jsr screen_on
 jsr sprites_off
 lda #39
 sta PPUHI
 lda #192
 sta PPULOW
 lda #2
 sta special_att
 lda #10
 sta special_temp_2
 lda #10
 sta special_temp_2_master
 lda #6
 sta special

scene10loop:
 ldx #2
 lda background_data_arrayop,x
 sta scene10temp
 inc scene10temp
 lda #0
 ldx #0
 sta background_data_arrayop,x
 lda #6
 ldx #1
 sta background_data_arrayop,x
 lda scene10temp
 ldx #2
 sta background_data_arrayop,x
 lda #0
 ldx #3
 sta background_data_arrayop,x
 lda #254
 ldx #4
 sta background_data_arrayop,x
 lda #254
 ldx #5
 sta background_data_arrayop,x
 lda #1
 sta current_NT
 jsr draw_background_mainop
 lda #0
 sta timer
 jsr delay_1_sec

	dec scene10loop_var
	bne scene10loop
	 lda #0
 sta special_att
 rts

scene11:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda pong15,x
 ldx #0
 sta songs,x
 ldx #1
 lda pong15,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda background19,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta palette_data_array,x
 lda #19
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda background23,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background23,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background23,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background23,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 jsr show_number_2
 lda #50
 sta special_temp_2
 lda #50
 sta special_temp_2_master
 lda #4
 sta special
 jsr screen_on
 jsr sprites_off
 lda #4
 sta special_scroll
 lda #1
 sta scene_timer
 jsr scene_music_loop
 lda #1
 sta current_NT
 ldx #0
 lda background27,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background27,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta current_NT
 ldx #0
 lda background27,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background27,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #90
 sta sprite_y
 lda #15
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 lda #80
 sta sprite_data_pos
 lda #106
 sta sprite_y
 lda #0
 sta sprite_x
 lda #4
 sta sprite_type
 jsr draw_sprites
 lda #88
 sta sprite_data_pos
 lda #122
 sta sprite_y
 lda #10
 sta sprite_x
 lda #3
 sta sprite_type
 jsr draw_sprites
 ldx #0
 lda sprite_anim_data12,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data12,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #15
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 jsr animate_sprites
 jsr sprites_on
 lda #0
 sta special_scroll
 lda #0
 sta scroll
 lda #0
 sta scroll2
 jsr show_number_2
 lda #2
 sta scene_timer
 jsr scene_music_loop
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 ldx #0
 lda backgroundtext11,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext11,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #30
 sta special_temp_2
 lda #30
 sta special_temp_2_master
 lda #4
 sta special
 lda #2
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda backgroundtext12,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext12,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #30
 sta special_temp_2
 lda #30
 sta special_temp_2_master
 lda #4
 sta special
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda sprite_anim_data14,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data14,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #15
 sta total_blocks_master
 lda #0
 sta sprite_mem_loc_master
 lda #192
 sta timer
 jsr delay_1_sec
 jsr sprites_off
 lda #1
 sta scene_timer
 jsr scene_music_loop
 rts

scene16:
 jsr reset_nmi_vars
 lda #1
 sta global_tempo
 ldx #0
 lda pong15,x
 ldx #0
 sta songs,x
 ldx #1
 lda pong15,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr melody
 jsr start_music
 ldx #0
 lda palette_data7,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data7,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #1
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #192
 sta sprite_y
 lda #30
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 lda #118
 sta sprite_data_pos
 lda #208
 sta sprite_y
 lda #15
 sta sprite_x
 lda #4
 sta sprite_type
 jsr draw_sprites
 lda #100
 sta sprite_data_pos
 lda #96
 sta sprite_y
 lda #16
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 lda #100
 sta sprite_data_pos
 lda #96
 sta sprite_y
 lda #224
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 lda #116
 sta sprite_data_pos
 lda #96
 sta sprite_y
 lda #224
 sta sprite_x
 lda #5
 sta sprite_type
 jsr draw_sprites
 jsr show_number_2
 jsr screen_on
 lda #49
 sta pong_trick_loc
 lda #0
 sta pong_trick_temp
 lda #1
 sta pong_trick
 lda #1
 sta special_temp_2
 lda #1
 sta special_temp_2_master
 lda #7
 sta special

pong_loop:
 ldx #0
 lda sprite_anim_data16,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data16,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #1
 sta total_blocks_master
 lda #112
 sta sprite_mem_loc_master
 jsr animate_sprites
 lda #7
 sta special
 jsr sprites_on

scene16_loop:

	ldx #$70
	lda spritemem,x
	cmp #$ff
	bne scene16_loop
	 ldx #0
 lda sprite_anim_data20,x
 ldx #0
 sta sprite_anim_data_array2,x
 ldx #1
 lda sprite_anim_data20,x
 ldx #1
 sta sprite_anim_data_array2,x
 lda #0
 sta counter2
 lda #0
 sta anim_file_counter2
 lda #8
 sta total_blocks_master2
 lda #48
 sta sprite_mem_loc_master2
 ldx #0
 lda sprite_anim_data17,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data17,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #1
 sta total_blocks_master
 lda #112
 sta sprite_mem_loc_master
 jsr animate_both_sprites

scene16_loop2:

	ldx #$73
	lda spritemem,x
	cmp #$1f
	bne scene16_loop2
	 ldx #0
 lda sprite_anim_data18,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data18,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #1
 sta total_blocks_master
 lda #112
 sta sprite_mem_loc_master

scene16_loop3:

	ldx #$70
	lda spritemem,x
	cmp #$e2
	bne scene16_loop3
	 ldx #0
 lda sprite_anim_data19,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data19,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #1
 sta total_blocks_master
 lda #112
 sta sprite_mem_loc_master
 ldx #0
 lda sprite_anim_data21,x
 ldx #0
 sta sprite_anim_data_array2,x
 ldx #1
 lda sprite_anim_data21,x
 ldx #1
 sta sprite_anim_data_array2,x
 lda #0
 sta counter2
 lda #0
 sta anim_file_counter2
 lda #8
 sta total_blocks_master2
 lda #80
 sta sprite_mem_loc_master2

scene16_loop4:

	ldx #$73
	lda spritemem,x
	cmp #$da
	bne scene16_loop4
	 ldx #0
 lda sprite_anim_data16,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data16,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #1
 sta total_blocks_master
 lda #112
 sta sprite_mem_loc_master
 jsr animate_both_sprites
 lda #1
 sta pong_trick
 lda #7
 sta special
 jsr sprites_on

scene16_loop5:

	ldx #$70
	lda spritemem,x
	cmp #$ff
	bne scene16_loop5
	 ldx #0
 lda sprite_anim_data17,x
 ldx #0
 sta sprite_anim_data_array,x
 ldx #1
 lda sprite_anim_data17,x
 ldx #1
 sta sprite_anim_data_array,x
 lda #0
 sta counter
 lda #0
 sta anim_file_counter
 lda #1
 sta total_blocks_master
 lda #112
 sta sprite_mem_loc_master
 jsr animate_both_sprites
 lda #4
 sta global_tempo
 ldx #0
 lda harmony16,x
 ldx #0
 sta songs,x
 ldx #1
 lda harmony16,x
 ldx #1
 sta songs,x
 lda #8
 sta special
 jsr sprites_off
 lda #2
 sta scene_timer
 jsr scene_music_loop
 jsr erase_sprites
 rts

scene17:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda harmonybass17,x
 ldx #0
 sta songs,x
 ldx #1
 lda harmonybass17,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data2,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data2,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda background19,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda background19,x
 ldx #1
 sta palette_data_array,x
 lda #19
 sta palette_start
 jsr load_palette_rand
 lda #1
 sta current_NT
 ldx #0
 lda background18,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background18,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #0
 sta sprite_data_pos
 lda #96
 sta sprite_y
 lda #15
 sta sprite_x
 lda #0
 sta sprite_type
 jsr draw_sprites
 jsr show_number_2
 jsr screen_on
 jsr animate_sprites
 jsr sprites_on
 lda #4
 sta special_temp_2
 lda #4
 sta special_temp_2_master
 lda #4
 sta special
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda backgroundtext14,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext14,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #4
 sta special_temp_2
 lda #4
 sta special_temp_2_master
 lda #4
 sta special
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda backgroundtext15,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext15,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #4
 sta special_temp_2
 lda #4
 sta special_temp_2_master
 lda #4
 sta special
 lda #39
 sta PPUHI
 lda #192
 sta PPULOW
 lda #2
 sta special_att
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda cory17,x
 ldx #0
 sta songs,x
 ldx #1
 lda cory17,x
 ldx #1
 sta songs,x
 lda #2
 sta special_scroll
 lda #6
 sta special
 lda #1
 sta scene_timer
 jsr scene_music_loop
 lda #4
 sta special_scroll
 lda #1
 sta pong_trick_loc
 lda #0
 sta pong_trick_temp
 lda #2
 sta pong_trick
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda backgroundtext15,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext15,x
 ldx #1
 sta texts,x
 jsr draw_text_main
 lda #1
 sta scene_timer
 jsr scene_music_loop
 lda #0
 sta current_NT
 ldx #0
 lda background12,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #1
 sta current_NT
 ldx #0
 lda background21,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_main
 lda #1
 sta scene_timer
 jsr scene_music_loop
 ldx #0
 lda backgroundtext15,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext15,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 jsr reset_nmi_vars
 jsr show_number_2
 jsr screen_on
 ldx #0
 lda backgroundtext16,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext16,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #2
 sta special_scroll
 lda #6
 sta special
 lda #4
 sta special_scroll
 lda #1
 sta pong_trick_loc
 lda #0
 sta pong_trick_temp
 lda #39
 sta PPUHI
 lda #192
 sta PPULOW
 lda #2
 sta special_att
 lda #2
 sta pong_trick
 ldx #0
 lda backgroundtext15,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext15,x
 ldx #1
 sta texts,x
 jsr draw_text_main
 ldx #0
 lda bridge18,x
 ldx #0
 sta songs,x
 ldx #1
 lda bridge18,x
 ldx #1
 sta songs,x
 lda #1
 sta scene_timer
 jsr scene_music_loop
 jsr reset_nmi_vars
 jsr show_number_2
 jsr screen_on
 ldx #0
 lda climaxarpeggio20,x
 ldx #0
 sta songs,x
 ldx #1
 lda climaxarpeggio20,x
 ldx #1
 sta songs,x
 ldx #0
 lda backgroundtext17,x
 ldx #0
 sta texts,x
 ldx #1
 lda backgroundtext17,x
 ldx #1
 sta texts,x
 jsr draw_text_all
 lda #1
 sta scene_timer
 jsr scene_music_loop
 rts

scene18:
 jsr reset_nmi_vars
 lda #4
 sta global_tempo
 ldx #0
 lda crazy7,x
 ldx #0
 sta songs,x
 ldx #1
 lda crazy7,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 jsr load_palette
 jsr draw_2_screens
 jsr show_number_1
 jsr screen_on
 lda #9
 sta special
 lda #4
 sta special_scroll
 jsr delay_1_sec
 jsr screen_off
 rts

scene18a:
 lda #0
 sta scene5_temp
 lda #128
 sta scene5_temp_2
 lda #74
 sta global_tempo
 lda #253
 sta timer_noise
 lda #160
 sta scene5_loop
 jsr scene5a
 jsr screen_off
 jsr reset_nmi_vars
 ldx #0
 lda palette_data8,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data8,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #1
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 jsr screen_on
 lda #254
 sta global_tempo
 lda #16
 sta timer
 jsr delay_1_sec
 lda #16
 sta timer
 jsr delay_1_sec
 lda #16
 sta timer
 jsr delay_1_sec
 lda #16
 sta timer
 jsr delay_1_sec
 lda #16
 sta timer
 jsr delay_1_sec
 rts

scene19:
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 ldx #0
 lda mario22,x
 ldx #0
 sta songs,x
 ldx #1
 lda mario22,x
 ldx #1
 sta songs,x
 jsr set_song
 jsr drums_bass_guitar_melody
 jsr start_music
 ldx #0
 lda palette_data6,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data6,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 ldx #0
 lda ending2,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda ending2,x
 ldx #1
 sta background_data_array,x
 jsr draw_2_screens
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 lda #0
 sta spritemem_array_pos
 lda #126
 sta sprite_data_pos
 lda #192
 sta sprite_y
 lda #30
 sta sprite_x
 lda #4
 sta sprite_type
 jsr draw_sprites
 jsr show_number_1
 jsr screen_on
 jsr scene_music_loop
 rts

	.bank 2
	.org $c000

sculpture1:
 jsr reset_nmi_vars
 lda #6
 sta global_tempo
 jsr set_song
 jsr start_music
 ldx #0
 lda palette_data6,x
 ldx #0
 sta palette_data_array,x
 ldx #1
 lda palette_data6,x
 ldx #1
 sta palette_data_array,x
 jsr load_palette
 lda #0
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 lda #1
 sta current_NT
 ldx #0
 lda background1,x
 ldx #0
 sta background_data_array,x
 ldx #1
 lda background1,x
 ldx #1
 sta background_data_array,x
 jsr draw_background_all
 ldx #0
 lda sprite_data1,x
 ldx #0
 sta sprite_data_array,x
 ldx #1
 lda sprite_data1,x
 ldx #1
 sta sprite_data_array,x
 jsr show_number_2
 jsr screen_on
 lda #64
 sta special_temp_2_master
 lda #64
 sta special_temp_2
 lda #5
 sta special
 jsr sprites_off
 jsr scene_music_loop
 rts

	
ending2:
	.dw ending_scene1
ending_scene1:
	.incbin "ending2.hex"

;++++++++++++++++++++++++++++++++++++++++++++++++
;Jacob's music
	
theme1:
	.dw theme1i
theme1i:
	.incbin "theme1.nes"

fallingreverb2:
	.dw fallingreverb2i
fallingreverb2i:
	.incbin "fallingreverb2.nes"
	
falling3:
	.dw falling3i
falling3i:
	.incbin "falling3.nes"

aaliyah4:
	.dw aaliyah4i
aaliyah4i:
	.incbin "aaliyah4.nes"
	
song5:
	.dw song5i
song5i:
	.incbin "song5.nes"
	
crazy6:
	.dw crazy6i
crazy6i:
	.incbin "crazy6.nes"
	
crazy7:
	.dw crazy7i
crazy7i:
	.incbin "crazy7.nes"		
	
crazy8:
	.dw crazy8i
crazy8i:
	.incbin "crazy8.nes"
	
grime11:
	.dw grime11i
grime11i:
	.incbin "grime11.nes"

bootyA12:
	.dw bootyA12i
bootyA12i:
	.incbin "bootyA12.nes"

bootyB13:
	.dw bootyB13i
bootyB13i:
	.incbin "bootyB13.nes"

bootyC14:
	.dw bootyC14i
bootyC14i:
	.incbin "bootyC14.nes"

pong15:
	.dw pong15i
pong15i:
	.incbin "pong15.nes"

harmony16:
	.dw harmony16i
harmony16i:
	.incbin "harmony16.nes"

harmonybass17:
	.dw harmonybass17i 
harmonybass17i:
	.incbin "harmonybass17.nes"

cory17:
	.dw cory17i 
cory17i:
	.incbin "cory17.nes"
	
bridge18:
	.dw bridge18i
bridge18i:
	.incbin "bridgedrums19.nes"

climaxarpeggio20:
	.dw climaxarpeggio20i
climaxarpeggio20i:
	.incbin "climaxarpeggio20.nes"

mario22:
	.dw mario22i	
mario22i:
	.incbin "mario22.nes"
			
	.bank 3
	.org $e000

sprite_data1:
	.dw sprite_data_start
sprite_data_start:
;mario $00
	.db $00, $00, $01, $00, $4c, $00, $4d, $00, $4a, $00, $4a, %01000000, $4b, $00, $4b, %01000000
;mario_looking_otherway $10
	.db $01, %01000000, $00, %01000000, $4d, %01000000, $4c, %01000000, $4a, $00, $4a, %01000000, $4b, $00, $4b, %01000000
;mariorun1r $20
	.db $00, $00, $01, $00, $02, $00, $03, $00, $04, $00, $05, $00, $06, $00, $07, $00
;mariorun2r $30
	.db $08, $00, $09, $00, $0a, $00, $0b, $00, $0c, $00, $0d, $00, $0e, $00, $0f, $00
;mariorun3r $40
	.db $10, $00, $11, $00, $12, $00, $13, $00, $14, $00, $15, $00, $16, $00, $17, $00
;luigi? $50
	.db $70, $01, $71, $01, $72, $01, $73, $01
;block $58
	.db $fd, $00, $fe, $00, $fd, $00, $fe, $00, $fd, $00, $fe, $00
;pong 1 and pong 2 $64
	.db $86, $00, $86, $00, $86, $00, $86, $00, $86, $00, $86, $00, $86, $00, $86, $00
;pong ball $74
	.db $75, $00
;blank $76
	.db $fc, $00, $fc, $00, $fc, $00, $fc, $00
;small mario $7e
	.db $3a, $00, $37, $00, $4f, %00000000, $4f, %01000000
;small mario run 1 $86
	.db $36, $00, $37, $00, $38, %00000000, $39, %01000000
;small mario run 2 $8e
	.db $32, $00, $33, $00, $34, %00000000, $35, %01000000
		
palette_data1:
	.dw palette_data_start
palette_data_start:
	.db $0d,$18,$28,$08,$0d,$18,$28,$08,$0d,$18,$28,$08,$0d,$18,$28,$08
	.db $21,$30,$36,$08,$11,$30,$36,$08,$11,$30,$36,$08,$11,$30,$36,$08

palette_data2:
	.dw palette_data_start2
palette_data_start2:
	.db $0d,$30,$11,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$18,$28,$08
	.db $21,$30,$36,$08,$0d,$11,$14,$11,$0d,$11,$0d,$11,$0d,$11,$0d,$11

palette_data3:
	.dw palette_data_start3
palette_data_start3:
	.db $0d,$11,$12,$13,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$18,$28,$08
	.db $21,$30,$36,$08,$11,$30,$36,$08,$11,$30,$36,$08,$11,$30,$36,$08

palette_data4:
	.dw palette_data_start4
palette_data_start4:
	.db $11,$12,$13,$14,$11,$12,$13,$14,$11,$12,$13,$14,$11,$12,$13,$14
	.db $21,$30,$36,$08,$54,$66,$77,$22,$11,$77,$15,$43,$88,$ff,$3d,$d4

palette_data5:
	.dw palette_data_start5
palette_data_start5:
	.db $11,$12,$13,$14,$11,$12,$13,$14,$11,$12,$13,$14,$11,$12,$13,$14
	.db $0d,$30,$36,$08,$54,$66,$77,$22,$11,$77,$15,$43,$88,$ff,$3d,$d4

	
palette_data6:
	.dw palette_data_start6
palette_data_start6:	

	.db $22, $29, $1A, $0F, $0F, $36, $17, $0F, $0F, $30, $21, $0F, $0F, $17, $17, $0F
	.db $21, $16, $27, $18, $0F, $1A, $30, $27, $0F, $16, $30, $27, $0F, $0F, $36, $17

palette_data7:
	.dw palette_data_start7
palette_data_start7:
	.db $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d
	.db $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d

palette_data8:
	.dw palette_data_start8
palette_data_start8:
	.db $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
	.db $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
	
att_data1:
	.dw att_data_start1
att_data_start1:
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$ff,$00,$00,$00,$00,$00
	.db $00,$00,$ff,$00,$00,$00,$00,$00
	
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00

att_data2:
	.dw att_data_start2
att_data_start2:
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00
	
	
rand1:
	.dw rand_start1
rand_start1:
	.incbin "rand.dat"
	
		
background_shapes:

;blank 00

	.db $24, $24
	.db $24, $24

; pole  01-02

	.db $68, $69
	.db $68, $69

	.db $6a, $24
	.db $6a, $24

; mushroom top 03-05

	.db $24, $6b
	.db $24, $70


	.db $6c, $6d
	.db $71, $72

	.db $6e, $6f
	.db $73, $74

; happy cloud 06

	.db $b0, $b2
	.db $b1, $b3

;castle wall 07

	.db $47, $47
	.db $47, $47

;castle to door 08

	.db $9b, $9c
	.db $27, $27

;castle white door 09

	.db $27, $27
	.db $27, $27

;castle top door 0a

	.db $9d, $9e
	.db $47, $47

;castle top bottom level 0b

	.db $a9, $aa
	.db $47, $47

;water     0c

	.db $25, $25
	.db $4e, $4e

;lightgrey 0d

	.db $26, $26
	.db $26, $26

;white 0e

	.db $27, $27
	.db $27, $27

;other grey 0f

	.db $25, $25
	.db $25, $25

; clouds 10-14

	.db $24, $24
	.db $24, $36

	.db $24, $24
	.db $37, $24

	.db $35, $25
	.db $39, $3a

	.db $25, $38
	.db $3b, $3c

;eye 14

	.db $24, $24
	.db $27, $24

;nose 15

	.db $24, $24
	.db $24, $27

;diag white 16

	.db $24, $27
	.db $27, $27

;cast eyebrow 17

	.db $27, $47
	.db $47, $27

;cast eye 18

	.db $47, $47
	.db $27, $47

;cast rev eyeborw 19

	.db $47, $27
	.db $27, $47

;reverse white ridge diag 1a

	.db $27, $24
	.db $27, $27

;cast ridge 1b

	.db $24, $47
	.db $47, $47

; cast ridge rev 1c

	.db $47, $24
	.db $47, $47

; diag fill 1d

	.db $24, $7f
	.db $7f, $24

; cast ridge with brick background 1e

	.db $a9, $aa
	.db $47, $47

; cast detail mini window 1f

	.db $47, $47
	.db $9f, $9f

; brick detail 20

	.db $44, $49
	.db $47, $47

; circle 21

	.db $b8, $b9
	.db $bc, $bd

; skull 22

	.db $ca, $cb
	.db $cc, $cd

; rainbow block 23

	.db $24, $25
	.db $26, $27

; question block 24
	
	.db $53, $54
	.db $55, $56

;rle_background:

;nothing
background1:
	.dw background1start
background1start:
		.db $ff, $00

;question cube
background2:
	.dw background2start
background2start:
		.db $76, $00
        .db $00, $24
        .db $ff, $00

background3:
	.dw background3start
background3start:
		.db $76, $00
        .db $00, $ff
        .db $ff, $00        

;super mario clouds rip off 
background4:
	.dw background4start
background4start:
			
		.db $08, $00, $00, $10, $00, $11 
		.db $0d, $00, $00, $12, $00, $13
		.db $22, $00, $fe, $fe

;super mario clouds freak out 
background5:
	.dw background5start
background5start:
			
		.db $08, $00, $06, $06, $00, $10, $00, $11 
		.db $0d, $00, $00, $12, $00, $13
		.db $01, $00, $02, $06, $fe, $fe

;more cloudzzzzz
background6:
	.dw background6start
background6start:
			
		.db $00, $06, $01, $00, $fe, $fe		

;more cloudzzzzz
background7:
	.dw background7start
background7start:
			
		.db $00, $00, $00, $06, $00, $00, $00, $06, $00, $00, $00, $06, $00, $00, $00, $06, $00, $00 
		.db $00, $06, $00, $00, $00, $06, $00, $00, $00, $06, $00, $00, $00, $06, $00, $00, $fe, $fe

;cloud floating pyramid and question block background
background8:
	.dw background8start
background8start:
			
		.db $0a, $00, $00, $06, $00, $00, $00, $06, $00, $00, $00, $06
		.db $0b, $00, $00, $06, $00, $00, $00, $06, $00, $00
		.db $0c, $00, $00, $06, $00, $00, $00, $06
		.db $0d, $00, $00, $06, $00, $00
		.db $0e, $00, $00, $06
		.db $13, $00, $00, $24
		.db $3a, $00
		.db $06, $06, $08, $00
		.db $00, $00, $04, $06, $09, $00
		.db $01, $00, $02, $06, $0a, $00
		.db $02, $00, $00, $06, $0c, $00
		.db $ff, $00

;cloud floating pyramid and question block background
background9:
	.dw background9start
background9start:
			
		.db $0a, $00, $00, $06, $00, $00, $00, $06, $00, $00, $00, $06
		.db $0b, $00, $00, $06, $00, $00, $00, $06, $00, $00
		.db $0c, $00, $00, $06, $00, $00, $00, $06
		.db $0d, $00, $00, $06, $00, $00
		.db $0e, $00, $00, $06
		.db $13, $00, $00, $24
		.db $3a, $00
		.db $06, $04, $08, $00
		.db $00, $04, $04, $06, $09, $00
		.db $01, $00, $02, $06, $0a, $04
		.db $02, $00, $00, $06, $0c, $00
		.db $ff, $00

;cloud floating pyramid and question block background
background10:
	.dw background10start
background10start:
			
		.db $0a, $00, $00, $06, $00, $00, $00, $06, $00, $00, $00, $06
		.db $0b, $00, $00, $06, $00, $00, $00, $06, $00, $00
		.db $0c, $00, $00, $06, $00, $00, $00, $06
		.db $0d, $00, $00, $06, $00, $00
		.db $0e, $00, $00, $06
		.db $13, $00, $00, $24
		.db $3a, $00
		.db $1f, $07, $08, $07
		.db $00, $04, $04, $06, $09, $00
		.db $01, $00, $02, $06, $0a, $04
		.db $02, $00, $00, $06, $0c, $00
		.db $ff, $00

;ruin3
background12:
	.dw background12start
background12start:
		

	.db $0f, $1d       
	.db $0f, $1d
	.db $0f, $1d
	.db $0f, $1d
	.db $0f, $1d
	.db $0f, $1d       
	.db $0f, $1d
	.db $01, $1d, $01, $07, $00, $07, $00, $1d, $00, $1c, $02, $07, $02, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $07, $00, $1d, $00, $1c, $00, $1b, $02, $1d, $03, $1d
	.db $01, $1d, $01, $07, $00, $1d, $00, $07, $00, $1d, $00, $07, $04, $07, $02, $1d
	.db $0f, $24
	.db $0f, $23

;ruin2
background14:
	.dw background14start
background14start:

	.db $0f, $1d
	.db $01, $1d, $00, $1b, $04, $1d, $00, $1b, $06, $1d
	.db $01, $1d, $00, $07, $04, $07, $00, $07, $06, $1d
	.db $01, $1d, $01, $07, $00, $1c, $02, $1d, $02, $07, $00, $1c, $03, $1d
	.db $01, $1d, $01, $07, $00, $1c, $02, $1d, $02, $07, $00, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $07, $02, $1d, $02, $07, $04, $1d
	.db $01, $1d, $01, $07, $00, $1d, $00, $07, $02, $1d, $02, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $07, $00, $07, $00, $1c, $02, $1d, $02, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $07, $00, $07, $00, $1c, $00, $1b, $02, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $07, $00, $07, $00, $07, $00, $07, $02, $07, $04, $1d
	.db $0f, $24
	.db $0f, $23									

;ruin2
background15:
	.dw background15start
background15start:

	.db $01, $1d, $00, $1b, $04, $1d, $00, $1b, $06, $1d
	.db $01, $1d, $00, $07, $03, $1d, $01, $07, $06, $1d
	.db $01, $1d, $01, $07, $00, $1c, $02, $1d, $02, $07, $00, $1c, $03, $1d
	.db $01, $1d, $01, $07, $00, $1c, $02, $1d, $02, $07, $00, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $07, $02, $1d, $02, $07, $04, $1d
	.db $01, $1d, $01, $07, $00, $1d, $00, $07, $02, $1d, $02, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $1d, $00, $07, $02, $1d, $02, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $1d, $00, $07, $00, $1c, $02, $1d, $02, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $1d, $00, $07, $00, $1c, $00, $1b, $02, $07, $03, $1d
	.db $01, $1d, $01, $07, $00, $07, $00, $07, $00, $07, $00, $07, $02, $07, $04, $1d
	.db $0f, $24
	.db $0f, $23
	
;ruin2
background16:
	.dw background16start
background16start:

	.db $00, $45, $00, $44, $fe, $fe

;cloud floating pyramid and question block background new scene
background17:
	.dw background17start
background17start:
			
		.db $0a, $22, $00, $54, $00, $55, $00, $67, $00, $11, $00, $12
		.db $0b, $ff, $00, $32, $00, $43, $00, $54, $00, $00
		.db $0c, $00, $00, $06, $00, $55, $00, $06
		.db $0d, $00, $00, $06, $00, $00
		.db $0e, $00, $00, $06
		.db $13, $04, $00, $24
		.db $34, $00
		.db $00, $06, $0e, $00
		.db $00, $06, $0e, $00
		.db $00, $06, $0e, $00
		.db $00, $06, $0e, $00
		.db $00, $06, $0e, $00

;guess who this is????
background18:
	.dw background18start
background18start:

		.db $0f, $0c
        .db $0f, $00
        .db $04, $00, $05, $0e, $04, $00
        .db $03, $00, $05, $0e, $00, $0d, $03, $00
		.db $03, $00, $05, $0e, $01, $0d, $03, $00
		.db $03, $00, $09, $0e, $00, $00
		.db $04, $00, $02, $0d, $01, $0f, $00, $0d, $01, $0f, $02, $00
		.db $03, $00, $01, $0d, $00, $0f, $00, $0d, $01, $0f, $01, $0d, $02, $0f, $01, $00
		.db $01, $00, $02, $0d, $00, $0f, $01, $0d, $02, $0f, $00, $0f, $02, $0f, $00, $00
		.db $01, $00, $02, $0d, $00, $0f, $01, $0d, $02, $0f, $00, $0d, $02, $0f, $00, $00
		.db $01, $00, $02, $0d, $00, $0f, $02, $0f, $04, $0d, $01, $00
		.db $00, $00, $04, $0d, $02, $0f, $04, $0d, $01, $00
		.db $03, $00, $02, $0d, $04, $0f, $04, $00
		.db $04, $00, $01, $0f, $02, $0f
		.db $ff, $00

;guess who this is????
background19:
	.dw background19start
background19start:

		.db $0f, $00
        .db $0f, $00
        .db $04, $00, $05, $0e, $04, $00
		.db $fe, $fe

;guess who this is????
background20:
	.dw background20start
background20start:

		.db $0f, $00
        .db $0f, $00
		.db $01, $00, $02, $0d, $00, $0f, $01, $0d, $02, $0f, $00, $0d 
		.db $fe, $fe

;guess who this is????
background21:
	.dw background21start
background21start:

	.db $13, $00, $00, $24
		.db $3a, $00
		.db $06, $04, $08, $00

;guess who this is????
background22:
	.dw background22start
background22start:

	.db $34, $05, $03, $04
		.db $3a, $00
		.db $06, $04, $08, $00
		.db $fe, $fe

;guess who this is????
background23:
	.dw background23start
background23start:

		.db $00, $00, $00, $09
		.db $fe, $fe
		
;guess who this is????
background24:
	.dw background24start
background24start:

		.db $00, $06, $00, $09
		.db $fe, $fe
		
		
;guess who this is????
background25:
	.dw background25start
background25start:

		.db $00, $00, $00, $06, $00, $09
        .db $06, $22, $05, $0e, $04, $00
		.db $fe, $fe

;guess who this is????
background26:
	.dw background26start
background26start:

		.db $00, $00, $00, $06, $00, $09
        .db $09, $22, $08, $0e, $06, $00
		.db $fe, $fe

background27:
	.dw background27start
background27start:

		.db $0F, $00
		.db $0F, $00 
		.db $06, $00, $00, $1B, $00, $07, $00, $1C, $05, $00, $05, $00, $00, $1B
		.db $02, $07, $00, $1C, $04, $00, $00, $00, $00, $1C
		.db $02, $00, $00, $1B, $04, $07, $00, $1C, $02, $00, $00, $1B, $00, $00, $00, $07 
		.db $02, $0A, $06, $07, $02, $0A, $00, $07, $01, $00, $0C, $07, $00, $00, $02, $00
		.db $0A, $07, $01, $00, $02, $00, $01, $07, $00, $17, $04, $07, $00, $19, $01, $07
		.db $01, $00, $02, $00, $01, $07, $00, $08, $00, $17, $02, $07, $00, $19, $00, $08
		.db $01, $07, $01, $00, $03, $00, $03, $07, $00, $08, $03, $07, $02, $00, $03, $00
		.db $08, $07, $02, $00, $03, $00, $02, $07, $02, $00, $02, $07, $02, $00, $03, $00
		.db $02, $07, $02, $00, $02, $07, $02, $00, $0F, $0C

;checkers
background28:
	.dw background28start
background28start:

		.db $00, $00, $00, $09
		.db $fe, $fe

;one more for the road
background29:
	.dw background29start
background29start:

		.db $02, $00, $00, $09
		.db $fe, $fe

;guess who this is????
background30:
	.dw background30start
background30start:

		.db $00, $00, $00, $09
		.db $fe, $fe
		
;we are at the rave
background32:
	.dw background32start
background32start:

	.db $07, $00, $00, $10, $00, $11, $07, $00
	.db $05, $00, $00, $12, $00, $13, $05, $00
	.db $0f, $00
	.db $0f, $00
	.db $03, $00, $00, $16, $00, $0e, $00, $1a, $08, $00
	.db $03, $00, $00, $14, $01, $0e, $00, $1a, $06, $00, $00, $1b
	.db $02, $00, $00, $15, $03, $0e, $05, $00, $00, $1b, $00, $07
	.db $03, $00, $00, $16, $02, $0e, $00, $1a, $03, $00, $00, $1b, $01, $07
	.db $04, $00, $03, $0e, $00, $1a, $01, $00, $00, $1b, $02, $07
	.db $04, $00, $04, $0e, $00, $1a, $00, $1b, $03, $07
	.db $03, $00, $00, $16, $0a, $0e
	.db $02, $00, $00, $16, $0b, $0e
	.db $01, $00, $00, $16, $0c, $0e
	.db $0f, $0e
	.db $0f, $04
	.db $0f, $04

;we are at the rave
background33:
	.dw background33start
background33start:
	
	.db $2f, $0f
	.db $0f, $0c
	.db $9f, $00
	.db $2f, $1e

;title
background34:
	.dw background34start
background34start:
	
	.incbin "smbtitle.hex"			

;24'zzz all da way
background35:
	.dw background35start
background35start:
	
	.db $af, $00
	.db $00, $00, $00, $03, $00, $04, $00, $05, $0a, $00
	.db $02, $00, $00, $01, $00, $02, $0a, $00	
	.db $02, $00, $00, $01, $00, $02, $0a, $00	
	.db $02, $00, $00, $01, $00, $02, $ff, $00	
		
;text to draw++++++++++++++++++++

backgroundtextintro1:
	.dw backgroundtextintro1i
backgroundtextintro1i:
	.incbin "backgroundtextintro1.txt"

backgroundtextintro2:
	.dw backgroundtextintro2i
backgroundtextintro2i:
	.incbin "backgroundtextintro2.txt"
			
backgroundtext1:
	.dw text1start
text1start:
	.incbin "bgtext.txt"

;im totally fucked
backgroundtext2:
	.dw text2start
text2start:
	.incbin "bgtext2.txt"

;screw it im jumping
backgroundtext3:
	.dw text3start
text3start:
	.incbin "bgtext3.txt"

;land survey
backgroundtext3a:
	.dw text3astart
text3astart:
	.incbin "bgtext3a.txt"
	
;land survey
backgroundtext4:
	.dw text4start
text4start:
	.incbin "bgtext4.txt"

;blocks and head
backgroundtext5:
	.dw text5start
text5start:
	.incbin "bgtext5.txt"

;running
backgroundtext6:
	.dw text6start
text6start:
	.incbin "bgtext6.txt"

;master time clock
backgroundtext7:
	.dw text7start
text7start:
	.incbin "bgtext7.txt"

;clouds maddness
backgroundtext7a:
	.dw text7astart
text7astart:
	.incbin "bgtext7a.txt"
	
	
;luigi?
backgroundtext8:
	.dw text8start
text8start:
	.incbin "bgtext8.txt"
	
;20 years
backgroundtext9:
	.dw text9start
text9start:
	.incbin "bgtext9.txt"

;master raster
backgroundtext10:
	.dw text10start
text10start:
	.incbin "bgtext10.txt"			

;r u here
backgroundtext11:
	.dw text11start
text11start:
	.incbin "bgtext11.txt"	
	
;keep hydrated
backgroundtext12:
	.dw text12start
text12start:
	.incbin "bgtext12.txt"	

;r u dj?
backgroundtext14:
	.dw text14start
text14start:
	.incbin "bgtext14.txt"	
	
;if u pass
backgroundtext15:
	.dw text15start
text15start:
	.incbin "bgtext15.txt"	

;the data,...its
backgroundtext16:
	.dw text16start
text16start:
	.incbin "bgtext16.txt"	
	
;dancing
backgroundtext17:
	.dw text17start
text17start:
	.incbin "bgtext17.txt"	
			
;end
endtext:
	.dw endstart
endstart:
	.incbin "end.txt"	
						
;animation+++++++++++++++++++

;him on block
sprite_anim_data1:
	.dw spritedata_start
	spritedata_start:
	.incbin "spriteanimation.hex"

;him sliding over to jump off block
sprite_anim_data2:
	.dw spritedata_start2
	spritedata_start2:
	.incbin "spriteanimation2.hex"

;him stepping right and falling off block
sprite_anim_data3:
	.dw spritedata_start3
	spritedata_start3:
	.incbin "spriteanimation3.hex"

;free falling 
sprite_anim_data4:
	.dw spritedata_start4
	spritedata_start4:
	.incbin "spriteanimation4.hex"

;free falling onto cloud
sprite_anim_data5:
	.dw spritedata_start5
	spritedata_start5:
	.incbin "spriteanimation5.hex"	

;smashing brick with head
sprite_anim_data6:
	.dw spritedata_start6
	spritedata_start6:
	.incbin "spriteanimation6.hex"	
	
;running right
sprite_anim_data7:
	.dw spritedata_start7
	spritedata_start7:
	.incbin "spriteanimation7.hex"	
	
;luigi??????
sprite_anim_data8:
	.dw spritedata_start8
	spritedata_start8:
	.incbin "spriteanimation8.hex"

;jump on for ride
sprite_anim_data9:
	.dw spritedata_start9
	spritedata_start9:
	.incbin "spriteanimation9.hex"

;here we go to the rave!!!!!!
sprite_anim_data10:
	.dw spritedata_start10
	spritedata_start10:
	.incbin "spriteanimation10.hex"	

;here we go to the rave!!!!!!
sprite_anim_data11:
	.dw spritedata_start11
	spritedata_start11:
	.incbin "spriteanimation11.hex"

;we're at the rave!!!!!!
sprite_anim_data12:
	.dw spritedata_start12
	spritedata_start12:
	.incbin "spriteanimation12.hex"

;going into the rave!!!!!!
sprite_anim_data14:
	.dw spritedata_start14
	spritedata_start14:
	.incbin "spriteanimation14.hex"
	
;egypt????
sprite_anim_data15:
	.dw spritedata_start15
	spritedata_start15:
	.incbin "spriteanimation15.hex"

;pong up left????
sprite_anim_data16:
	.dw spritedata_start16
	spritedata_start16:
	.incbin "spriteanimation_pong_u_l.hex"

;pong down left????
sprite_anim_data17:
	.dw spritedata_start17
	spritedata_start17:
	.incbin "spriteanimation_pong_d_l.hex"

;pong down right????
sprite_anim_data18:
	.dw spritedata_start18
	spritedata_start18:
	.incbin "spriteanimation_pong_d_r.hex"

;pong up right????
sprite_anim_data19:
	.dw spritedata_start19
	spritedata_start19:
	.incbin "spriteanimation_pong_u_r.hex"

;pong left player up ????
sprite_anim_data20:
	.dw spritedata_start20
	spritedata_start20:
	.incbin "spriteanimation_pong_lp_u.hex"

;pong left player up ????
sprite_anim_data21:
	.dw spritedata_start21
	spritedata_start21:
	.incbin "spriteanimation_pong_rp_d.hex"
	
										
;trying to get some music++++++++++++++++++++
	
frequzzz:			

	.incbin "frequzzz2.hex"

						
;++++++++++++++++++++++++++++++++++++++++++++++++
;Load Data Filez
;++++++++++++++++++++++++++++++++++++++++++++++++

	.bank 3
	.org $fffa
	.dw nmi		;//NMI
	.dw start	;//Reset
	.dw irq	;//BRK
	;.bank 4
	;.org $0000

    ;.incbin "mario.chr"  ;gotta be 8192 bytes long


