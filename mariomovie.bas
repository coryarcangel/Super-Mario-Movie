;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;
;	Super Mario Movie 2004
;
;	All programming by Cory Arcangel of the BEige Programming Ensemble 
;	Script + Set Design:  www.paperrad.org + Cory
;	
;	Required to Compile:  nesasm, nbasic by Bob Rost
;
;	Special Thanks 4 Cory: Mom, Dad, Justin, Jamie, Le Mut, Slash (gnr), techno, 
;	Team Gallery (Jose Brendan Miriam), Dimebag (RIP), Pre 90's NHL hockey,
;	current OHL hockey, All the Peepz on NESDEV, Nullsleep, Chris Covell,
;	Bodenstandig 2000, Lektrolab (Emma), All my BEIGe peepz,
;	Stan + Woody Vasulka (+ all other early video peepz), Radical Software,
;	RSG, Frankie MArtin, Memblers, Yoshi, Brad Taylor, + all the old megadeth i
;	listened while programming this thing.................
;
;	Special Thanks 4 paperrad.org: 
;
;	"Don't Fuck with Us" - BEIGE Programming Ensemble 2004
;	"Money is a Major Issue" - Paper Rad
;
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

array absolute $300 spritemem 256

asm

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

endasm

	gosub clear_att

;++++++++++++++++++++++++++++++++++++++++++++++++
;init graphic settings
;++++++++++++++++++++++++++++++++++++++++++++++++

asm
 lda   #%10010000
 sta   $2000
 lda   #%00011000     
 sta   $2001
endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;set variables
;++++++++++++++++++++++++++++++++++++++++++++++++

init_vars:
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;set variables for TEXT

	array texts 2							; for drawtext routine

;++++++++++++++++++++++++++++++++++++++++++++++++
;set variables for palette

	;array palette $10							; for drawtext routine
	array palette_data_array 2
	set palette_start 0
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;set variables for att

	;array palette $10							; for drawtext routine
	array att_data_array 2
	set att_start 0
			
;++++++++++++++++++++++++++++++++++++++++++++++++
;set variables for drawbackground
	
	array absolute $200 background_tile_array $f0		; for load_background routine
	set current_NT 0						; for draw_background
	array background_data_array 2
	set rle_counter 0
	set background_shape_distance 0
	set background_shape 0
	set background_tile_array_counter 0
	set background_tile_array_counter_down 10
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;set music variables

	array songs 2
	array which_song 4
	array mute 4
	array mute_new 4
		
	set song_number_new 0
	set song_timez 0
	set new_music_page 0
	set new_music_page_big 0
	set music_counter_file 0
	set music_counter 6
	set songloadloop 0
	set whichsong 1
	set mute_joy1a 1
	set whichsongcounter 0
	set global_tempo 6
	set $4015 %00001111	

	set [mute 0] 1
	set [mute 1] 1
	set [mute 2] 1
	set [mute 3] 0
	set [mute_new 0] 1
	set [mute_new 1] 1
	set [mute_new 2] 1
	set [mute_new 3] 0
	set [songs 0] [theme1 0]
	set [songs 1] [theme1 1]
	set [which_song 0] [songs 0]
	set [which_song 1] [songs 1]

	set sound1a $00
	set sound1b $00
	set sound2a $00
	set sound2b $00
	set sound3a $00
	set sound3b $00
	set sound4a $00
	set sound4b $00
	set color_show 0
	set color_show_beige 0
	set color_show_beige2 0
	set color_show_beige3 0
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;set variables for 2 Sprites

	set sprite_type 0
	set spritemem_array_pos 0
	set sprite_mem_loc_master 0
	set total_blocks_master 0
	set anim_file_counter 0
	array sprite_anim_data_array 2
	array sprite_data_array 2
	set direction 0
	set counter 0
	set sprite_delay 0
	set sprite_data_pos 0
	set new_sprite_data_pos 0
	set total_blocks 0
 	set sprite_delay_master 0

;++++++++++++++++++++++++++++++++++++++++++++++++
;set variables sprite2

	set sprite_type2 0
	set spritemem_array_pos2 0
	set sprite_mem_loc_master2 0
	set total_blocks_master2 0
	set anim_file_counter2 0
	array sprite_anim_data_array2 2
	array sprite_data_array2 2
	set direction2 0
	set counter2 0
	set sprite_delay2 0
	set sprite_data_pos2 0
	set new_sprite_data_pos2 0
	set total_blocks2 0
 	set sprite_delay_master2 0


;++++++++++++++++++++++++++++++++++++++++++++++++
;set variables for the timer and current scene
	
	set timer 0
	set music_timer 0
	set scene_timer 0
	set dvdcounter 0
	;set current_scene 0

;++++++++++++++++++++++++++++++++++++++++++++++++
; set text for draw text routine

	set PPUHI $20
	set PPULOW $e6
	set PPULOW_START PPULOW
	set TEXTPOS 0
	set CHARCOUNTER 0

;++++++++++++++++++++++++++++++++++++++++++++++++
; set text for special routines

	array absolute 100 music_bug_fix 10
	
	set special_5 0
	set special_scroll_5 0
	set scene5_temp 0
	set scene5_temp_2 0
	set timer_noise 0
	set scene5_loop 0
		
	set special 0
	set special_temp 0
	set special_temp_2 0
	set special_temp_2_master $40
	
	set scroll_delay $05
	set scroll_delay_master $05
		
	set special_scroll 0
	set scroll 0
	set scroll2 0

	set nmi_2_do_special 0

	set scene6_temp $00
	set scene6_temp_2 $80
	set scene6_loop 0
	
	set att_var 0
	set special_att_counter 0
	
	array background_data_arrayop 6
	set special_att 0
	
	set scene10temp 0
	
	set pong_trick 0
	set pong_trick_loc $31
	set pong_trick_temp $00

	set scene10loop_var $02

		
;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENEZ Start HERE
;++++++++++++++++++++++++++++++++++++++++++++++++
	
	gosub screen_off

dvdtitle:	
	set scene_timer 2
	gosub scene_title		

dvdscene1:	
	gosub scene1 ; 		on the block

dvdscene2:	
	gosub scene2 ;			falling	

dvdscene3:			
	gosub scene3 ; 		upside down triangle

	set [songs 0] $00
	set [songs 1] $80
	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 3		
	set timer_noise $d0
	set scene5_loop $06
	gosub scene5 			;noise

dvdscene4:
	set [background_data_array 0] [background12 0]
	set [background_data_array 1] [background12 1]	
	gosub scene4 ; 		running

	set [songs 0] $00
	set [songs 1] $80
	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 3		
	set timer_noise $d1
	set scene5_loop $06
	gosub scene5 			;noise

	gosub scene4redux

dvdscene5:
	set scene10loop_var $09
	gosub scene10	; clouds weirdness

	set [songs 0] $00
	set [songs 1] $80
	set global_tempo 3		
	set timer_noise $d2
	set scene5_loop $06
	gosub scene5 

dvdscene6:		
	gosub scene6	; underground world	

	set [songs 0] $00
	set [songs 1] $80
	set global_tempo 3		
	set timer_noise $d2
	set scene5_loop $07
	gosub scene5 
	
dvdscene7:	
	gosub scene7	; flying 1

	set [songs 0] $00
	set [songs 1] $80
	set scene5_temp $00 
	set scene5_temp_2 $80	
	set global_tempo 9	
	set timer_noise $d9
	set scene5_loop $10
	gosub scene5 

dvdscene8:	
	gosub scene12 	; egypt

	set [songs 0] $00
	set [songs 1] $80
	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 9	
	set timer_noise $d9
	set scene5_loop $12
	gosub scene5 	

dvdscene9:	
	gosub scene8	; flying 2


	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 9	
	set timer_noise $f7
	set scene5_loop $03
	gosub scene5 

dvdscene10:	
	gosub scene9	; got to rave

dvdscene11:	
	gosub scene11	; got there arrive


dvdscene12:	
	gosub scene16	; pong

dvdscene14:
	gosub scene17	;b.i.g. poppa

	gosub scene18a ;crazy into mario

dvdscene15:	
	set scene_timer 4
	gosub scene19	
	
	goto start
	
sculpture1_score:
	gosub reset_nmi_vars
	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 9	
	set timer_noise $40
	set scene5_loop $10
	gosub scene5
	;goto sculpture1_score

sculpture2_score:
	gosub reset_nmi_vars
	set [background_data_arrayop 2] $00
	;set scene10temp $00
	set scene10loop_var $10
	gosub scene10
	set [songs 0] [bridge18 0]
	set [songs 1] [bridge18 1]
	gosub melody_guitar
	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 9	
	set timer_noise $40
	set scene5_loop $10
	gosub scene5
	;goto sculpture2_score

sculpture3_score:
	gosub reset_nmi_vars
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	gosub scene9
	goto sculpture1_score
																
main:
	goto main
		


;++++++++++++++++++++++++++++++++++++++++++++++++
;Animate Sprites
;++++++++++++++++++++++++++++++++++++++++++++++++
	
animate_sprites:
	set nmi_to_do 3
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Animate Sprites 2
;++++++++++++++++++++++++++++++++++++++++++++++++
	
animate_sprites2:
	set nmi_to_do 5
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Animate Both Sprites 2
;++++++++++++++++++++++++++++++++++++++++++++++++
	
animate_both_sprites:
	set nmi_to_do 6
	return
		
;++++++++++++++++++++++++++++++++++++++++++++++++
;move sprites,.....
;	
;	set anim_file_counter 0					;our trusty old animation pointer
;	set total_blocks_master 8			;number of blocks to animate
;	set sprite_mem_loc_master 0			;where our sprite is
;	set counter 0							;set counter to 0
;
;	set anim_file_counter_2 0					;our trusty old animation pointer
;	set total_blocks_master_2 6			;number of blocks to animate
;	set sprite_mem_loc_master_2 32			;where our sprite is
;	set counter_2 0						;set counter to 0
;
;++++++++++++++++++++++++++++++++++++++++++++++++

;move sprite1  +++++++++++++++++++++++++++++++++++++++++++

move_sprite_1:			
	
	if counter = 0 then	
	asm
	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta direction
	endasm
	;set direction [sprite_anim_file anim_file_counter]
	inc anim_file_counter
	
	asm
	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta counter
	endasm
	;set counter [sprite_anim_file anim_file_counter]
	inc anim_file_counter
	
	asm
	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta sprite_delay
	endasm
	asm
	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta sprite_delay_master
	endasm
	;set sprite_delay [sprite_anim_file anim_file_counter]
	;set sprite_delay_master [sprite_anim_file anim_file_counter]
	inc anim_file_counter
	
	asm
	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta sprite_data_pos
	endasm
	;set sprite_data_pos [sprite_anim_file anim_file_counter]
	inc anim_file_counter
	
	asm
	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta new_sprite_data_pos
	endasm
	;set new_sprite_data_pos [sprite_anim_file anim_file_counter]
	inc anim_file_counter
	
	asm
	ldy anim_file_counter
	lda [sprite_anim_data_array],y
	sta total_blocks
	endasm
	;set total_blocks [sprite_anim_file anim_file_counter]
	inc anim_file_counter
	endif

	dec sprite_delay

	if sprite_delay <> 0 return
	if sprite_delay = 0 set sprite_delay sprite_delay_master

	if direction = $f0 then
counter_up_loop_1:	
	if counter >= 0 then 
	set total_blocks total_blocks_master
	set sprite_mem_loc sprite_mem_loc_master
	gosub move_y_up
	dec counter
	endif
	endif 

	if direction = $f1 then
counter_down_loop_1:	
	if counter >= 0 then 
	set total_blocks total_blocks_master
	set sprite_mem_loc sprite_mem_loc_master
	gosub move_y_down
	dec counter
	endif
	endif 

	if direction = $f2 then
counter_left_loop_1:	
	if counter >= 0 then 
	set total_blocks total_blocks_master
	set sprite_mem_loc sprite_mem_loc_master
	gosub move_y_left
	dec counter
	endif
	endif 

	if direction = $f3 then
counter_right_loop_1:	
	if counter >= 0 then 
	set total_blocks total_blocks_master
	set sprite_mem_loc sprite_mem_loc_master
	gosub move_y_right
	dec counter
	endif
	endif 

	if direction = $f4 then
counter_still_loop_1:	
	if counter >= 0 then 
	dec counter
	endif
	endif 
	
	if direction = $f5 then
finish_changing_sprite:
	inc sprite_data_pos
	asm
	ldy new_sprite_data_pos
	lda [sprite_data_array],y
	sta temp
	endasm
	set [spritemem sprite_data_pos] temp
	inc sprite_data_pos
	inc new_sprite_data_pos
	asm
	ldy new_sprite_data_pos
	lda [sprite_data_array],y
	sta temp
	endasm
	set [spritemem sprite_data_pos] temp
	inc new_sprite_data_pos
	inc sprite_data_pos
	inc sprite_data_pos
	asm
	dec total_blocks
	bne finish_changing_sprite
	endasm		
	dec counter
	endif

	if direction = $f6 then
	set anim_file_counter total_blocks ;total blocks on f6 equals the place to go back to!!!
	set counter 0
	endif

	if direction = $ff set nmi_to_do 0
		
return


;move sprite2  +++++++++++++++++++++++++++++++++++++++++++

move_sprite_2:			
	
	if counter2 = 0 then	
	asm
	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta direction2
	endasm
	;set direction [sprite_anim_file anim_file_counter]
	inc anim_file_counter2
	
	asm
	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta counter2
	endasm
	;set counter [sprite_anim_file anim_file_counter]
	inc anim_file_counter2
	
	asm
	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta sprite_delay2
	endasm
	asm
	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta sprite_delay_master2
	endasm
	;set sprite_delay [sprite_anim_file anim_file_counter]
	;set sprite_delay_master [sprite_anim_file anim_file_counter]
	inc anim_file_counter2
	
	asm
	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta sprite_data_pos2
	endasm
	;set sprite_data_pos [sprite_anim_file anim_file_counter]
	inc anim_file_counter2
	
	asm
	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta new_sprite_data_pos2
	endasm
	;set new_sprite_data_pos [sprite_anim_file anim_file_counter]
	inc anim_file_counter2
	
	asm
	ldy anim_file_counter2
	lda [sprite_anim_data_array2],y
	sta total_blocks2
	endasm
	;set total_blocks [sprite_anim_file anim_file_counter]
	inc anim_file_counter2
	endif

	dec sprite_delay2

	if sprite_delay2 <> 0 return
	if sprite_delay2 = 0 set sprite_delay2 sprite_delay_master2

	if direction2 = $f0 then
counter_up_loop_12:	
	if counter2 >= 0 then 
	set total_blocks2 total_blocks_master2
	set sprite_mem_loc sprite_mem_loc_master2
	gosub move_y_up2
	dec counter2
	endif
	endif 

	if direction2 = $f1 then
counter_down_loop_12:	
	if counter2 >= 0 then 
	set total_blocks2 total_blocks_master2
	set sprite_mem_loc sprite_mem_loc_master2
	gosub move_y_down2
	dec counter2
	endif
	endif 

	if direction2 = $f2 then
counter_left_loop_12:	
	if counter2 >= 0 then 
	set total_blocks2 total_blocks_master2
	set sprite_mem_loc sprite_mem_loc_master2
	gosub move_y_left2
	dec counter2
	endif
	endif 

	if direction2 = $f3 then
counter_right_loop_12:	
	if counter2 >= 0 then 
	set total_blocks2 total_blocks_master2
	set sprite_mem_loc sprite_mem_loc_master2
	gosub move_y_right2
	dec counter2
	endif
	endif 

	if direction2 = $f4 then
counter_still_loop_12:	
	if counter2 >= 0 then 
	dec counter2
	endif
	endif 
	
	if direction2 = $f5 then
finish_changing_sprite2:
	inc sprite_data_pos2
	asm
	ldy new_sprite_data_pos2
	lda [sprite_data_array2],y
	sta temp
	endasm
	set [spritemem sprite_data_pos2] temp
	inc sprite_data_pos2
	inc new_sprite_data_pos2
	asm
	ldy new_sprite_data_pos2
	lda [sprite_data_array2],y
	sta temp
	endasm
	set [spritemem sprite_data_pos2] temp
	inc new_sprite_data_pos2
	inc sprite_data_pos2
	inc sprite_data_pos2
	asm
	dec total_blocks2
	bne finish_changing_sprite2
	endasm		
	dec counter2
	endif

	if direction2 = $f6 then
	set anim_file_counter2 total_blocks2 ;total blocks on f6 equals the place to go back to!!!
	set counter2 0
	endif

	if direction2 = $ff set nmi_to_do 0
		
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;move x, y vars around.....requires sprite_mem_loc and total_blocks
;++++++++++++++++++++++++++++++++++++++++++++++++
	
move_y_up:
asm
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
	
endasm
	return
	
move_y_down:
asm
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
endasm
	return

move_y_left:
asm
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
endasm
	return
	
move_y_right:
asm
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
endasm
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;move2 x, y vars around.....requires sprite_mem_loc and total_blocks
;++++++++++++++++++++++++++++++++++++++++++++++++
	
move_y_up2:
asm
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
	
endasm
	return
	
move_y_down2:
asm
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
endasm
	return

move_y_left2:
asm
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
endasm
	return
	
move_y_right2:
asm
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
endasm
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;draw sprite 0
;++++++++++++++++++++++++++++++++++++++++++++++++

draw_sprites:			; 	this will draw a 2 by 6 sprite
	set sprite_across_counter 0
	set sprite_down_counter 0

	if sprite_type = 0 then
	set total_blocks 7
	set sprite_width 2
	set x_offset $f0
	endif

	if sprite_type = 1 then
	set total_blocks 5
	set sprite_width 3
	set x_offset $e8
	endif
	
	if sprite_type = 2 then
	set total_blocks 1
	set sprite_width 0
	;set x_offset $e8
	endif

	if sprite_type = 3 then
	set total_blocks 2
	set sprite_width 3
	set x_offset $e8
	endif
	
	if sprite_type = 4 then
	set total_blocks 3
	set sprite_width 2
	set x_offset $f0
	endif

	if sprite_type = 5 then
	set total_blocks 0
	set sprite_width 0
	;set x_offset $e8
	endif

	if sprite_type = 6 then
	set total_blocks 35
	set sprite_width 6
	set x_offset $d0
	endif

				
sprite_across_loop_1:
	
	if sprite_down_counter = sprite_width then
 	set sprite_down_counter 0
	set temp + sprite_y 8
	set sprite_y temp
	set temp + sprite_x x_offset
	set sprite_x temp
	endif
	
	inc sprite_across_counter
 	inc sprite_down_counter
 	set [spritemem spritemem_array_pos] sprite_y
	inc spritemem_array_pos
	asm 
	ldy sprite_data_pos
	lda [sprite_data_array],y
	sta temp
	endasm
	set [spritemem spritemem_array_pos] temp
	inc sprite_data_pos
	inc spritemem_array_pos
	asm 
	ldy sprite_data_pos
	lda [sprite_data_array],y
	sta temp
	endasm
	set [spritemem spritemem_array_pos] temp
	inc sprite_data_pos
	inc spritemem_array_pos
	set [spritemem spritemem_array_pos] sprite_x
	inc spritemem_array_pos
	set sprite_x + sprite_x 8
	if sprite_across_counter <= total_blocks then
	goto sprite_across_loop_1
	endif 			
return

;++++++++++++++++++++++++++++++++++++++++++++++++
;erase sprites
;++++++++++++++++++++++++++++++++++++++++++++++++
erase_sprites:

	set erase_sprite_var 0

	erase_sprites_1:
		set [spritemem erase_sprite_var] $FC
		asm
		dec erase_sprite_var
		bne erase_sprites_1
		endasm 
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;scene_music_loop
;++++++++++++++++++++++++++++++++++++++++++++++++
scene_music_loop:
	asm
	lda #$00
	cmp scene_timer
	bne scene_music_loop
	endasm
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Show Number 2
;++++++++++++++++++++++++++++++++++++++++++++++++
show_number_2:
	set scroll $ff	
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Show Number 1
;++++++++++++++++++++++++++++++++++++++++++++++++
show_number_1:
	set scroll $00	
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;put sprtiezzz on screen
;++++++++++++++++++++++++++++++++++++++++++++++++

asm 
PutSpritesOnScreen:
	lda #$00
	sta $2003 ; nesdev message
	lda #3
    sta $4014 
    rts
endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;vblankzzzzzz
;++++++++++++++++++++++++++++++++++++++++++++++++

asm
vwait:
	lda $2002
	bpl vwait
	rts
endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;Sprite Off
;++++++++++++++++++++++++++++++++++++++++++++++++
sprites_off:
	asm
 	lda   #%10010000
 	sta   $2000
 	lda   #%00001000     
 	sta   $2001
 	rts
	endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;Sprite On
;++++++++++++++++++++++++++++++++++++++++++++++++
sprites_on:	
	asm
 	lda   #%10010000
 	sta   $2000
 	lda   #%00011000     
 	sta   $2001
 	rts
	endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;Screen On
;++++++++++++++++++++++++++++++++++++++++++++++++
screen_on:	
	asm
 	lda   #%10010000
 	sta   $2000
 	lda   #%00011000     
 	sta   $2001
 	rts
	endasm
	

;++++++++++++++++++++++++++++++++++++++++++++++++
;Screen On Black and white
;++++++++++++++++++++++++++++++++++++++++++++++++
screen_on_black_white:	
	asm
 	lda   #%10010000
 	sta   $2000
 	lda   #%00011001  
 	sta   $2001
 	rts
	endasm
		
;++++++++++++++++++++++++++++++++++++++++++++++++
;Screen Off
;++++++++++++++++++++++++++++++++++++++++++++++++
screen_off:	
	asm
 	lda   #%00000000
 	sta   $2000
 	lda   #%00000000    
 	sta   $2001
 	rts
	endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;Screen Off with music
;++++++++++++++++++++++++++++++++++++++++++++++++
screen_off_with_music:	
	asm
 	lda   #%10010000
 	sta   $2000
 	lda   #%00000000    
 	sta   $2001
 	rts
	endasm
		
;++++++++++++++++++++++++++++++++++++++++++++++++
;Delay One Second
;++++++++++++++++++++++++++++++++++++++++++++++++

delay_1_sec:	
	if timer <> $ff goto delay_1_sec
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Clear Attributes and Name Tables!!!!!!
;++++++++++++++++++++++++++++++++++++++++++++++++

clear_att:
	
	set $2006 $23
	set $2006 $00
	
	asm

	ldx #$00
att_clear:	
	lda #$00
	sta $2007
	dex
	bne att_clear
	endasm

	set $2006 $27
	set $2006 $00
	
	asm

	ldx #$00
att_clear2:	
	lda #$00
	sta $2007
	dex
	bne att_clear2

	endasm
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;load att...........watch out for this,...this is fucked...needs fixing
;++++++++++++++++++++++++++++++++++++++++++++++++
	
load_att:
	
	if current_NT = $01 set $2006 $27
	if current_NT = $00 set $2006 $23	
	set $2006 $c0
	asm
	ldx #$40
	ldy #$00
load_att_1:
		lda [att_data_array],y
		sta $2007
		iny
		dex
		bne load_att_1
		endasm
		return

;++++++++++++++++++++++++++++++++++++++++++++++++
;load att
;++++++++++++++++++++++++++++++++++++++++++++++++
	
load_att_rand:
	set x att_start
	if current_NT = $01 set $2006 $27
	if current_NT = $00 set $2006 $23	
	set $2006 $c0
	load_att_2:
		asm
		txa
		tay
		lda [att_data_array],y
		sta $2007
		endasm
		inc x
		if x <> $40 branchto load_att_2
		return
			
;++++++++++++++++++++++++++++++++++++++++++++++++
;load palette
;++++++++++++++++++++++++++++++++++++++++++++++++
	
load_palette:
	set x 0
	set $2006 $3F
	set $2006 $00
	load_palette_1:
		asm
		txa
		tay
		lda [palette_data_array],y
		sta $2007
		endasm
		inc x
		if x <> 32 branchto load_palette_1
		return

;++++++++++++++++++++++++++++++++++++++++++++++++
;load palette rand (16 only)
;++++++++++++++++++++++++++++++++++++++++++++++++
	
load_palette_rand:

	set $2006 $3F
	set $2006 $00
	set x $10
	load_palette_2:
		asm
		lda palette_start
		tay
		lda [palette_data_array],y
		sta $2007
		
		inc palette_start
		dex
		bne load_palette_2
		endasm
		return


;++++++++++++++++++++++++++++++++++++++++++++++++
;load palette on da fly
;++++++++++++++++++++++++++++++++++++++++++++++++

change_palette_main:
	gosub change_palette_init	
	set nmi_to_do 4
delay_until_done_palette:
	if nmi_to_do <> 0 goto delay_until_done_palette
	return
		
change_palette_init:

	set PPUHI $3f
	set PPULOW $00
	set palette_counter 0
	return
	
change_palette:

		set $2006 PPUHI
		set $2006 PPULOW
		asm
		lda palette_counter
		tay
		lda [palette_data_array],y
		sta $2007
		endasm
		inc palette_counter
		inc PPULOW
		if palette_counter = $10 set nmi_to_do 0
		return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Draw 2 screens stolden from game binaries
;++++++++++++++++++++++++++++++++++++++++++++++++
draw_2_screens:

	set $2006 $20
	set $2006 $00
	
	asm

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
	endasm
	return
			
;++++++++++++++++++++++++++++++++++++++++++++++++
;Draw Background All
;++++++++++++++++++++++++++++++++++++++++++++++++

draw_background_all:

	gosub load_background
	gosub draw_background_init
	set tempcounter $78
background_all_loop:
	gosub draw_background
	dec tempcounter
	asm
	bne background_all_loop
	endasm
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Draw Background Main
;++++++++++++++++++++++++++++++++++++++++++++++++

draw_background_main:
	gosub load_background
	gosub draw_background_init	
	set nmi_to_do 1
delay_until_done:
	if nmi_to_do <> 0 goto delay_until_done
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Draw Background Main OP
;++++++++++++++++++++++++++++++++++++++++++++++++

draw_background_mainop:
	gosub load_backgroundop
	gosub draw_background_init	
	set nmi_to_do 1
delay_until_doneop:
	if nmi_to_do <> 0 goto delay_until_doneop
	return
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;LOAD Background,....you need to set the NT you want to draw to ($00, or $01), 
;and also set background_tile_rle_counter to the the starting pos of the
;background in your "rle_background" array, and then
;cause I am a lazy programmer add one to that and save it as "background_tile_rle_counter_1"
;then load and draw.......................
;
;	set current_NT $00
;	set background_tile_rle_counter $00
;	set background_tile_rle_counter_1 $01
;	gosub load_background
;	gosub draw_background
;++++++++++++++++++++++++++++++++++++++++++++++++

load_background:
	
	set background_shape 0
	set background_tile_array_counter 0
		
load_background2:

	set background_shape_distance 0
	set rle_counter 0

load_shape_and_distance:	
	asm
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
	endasm	

background_shape_fill:	
	if background_shape = $fe goto load_background2
	set [background_tile_array background_tile_array_counter] background_shape
	inc background_tile_array_counter
	if background_tile_array_counter = $f0 return
	dec background_shape_distance
	if background_shape_distance >= 0 goto background_shape_fill
	goto load_shape_and_distance
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;LOAD Background,....this is the special OP ART load background routine
;++++++++++++++++++++++++++++++++++++++++++++++++

load_backgroundop:
	
	set background_shape 0
	set background_tile_array_counter 0
		
load_background2op:

	set background_shape_distance 0
	set rle_counter 0

load_shape_and_distanceop:	
	asm
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
	endasm	

background_shape_fillop:	
	if background_shape = $fe goto load_background2op
	set [background_tile_array background_tile_array_counter] background_shape
	inc background_tile_array_counter
	if background_tile_array_counter = $f0 return
	dec background_shape_distance
	if background_shape_distance >= 0 goto background_shape_fillop
	goto load_shape_and_distanceop
	return


;++++++++++++++++++++++++++++++++++++++++++++++++
;DRAW Background Init
;++++++++++++++++++++++++++++++++++++++++++++++++

draw_background_init:

	set NT_down 0
	set background_low 0
	set backgroundshape_loc 0
	set backgroundshape_loc_offset 0
	set background_tile_loc 0
	set NT_across 0	
	if current_NT = $00 set background_hi $20	
	if current_NT = $01 set background_hi $24
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;DRAW Background,...
;++++++++++++++++++++++++++++++++++++++++++++++++

draw_background:
	
	set $2006 background_hi			;ppu locations
	set $2006 background_low		

	set draw_background_across_counter $04
draw_background_across:
	set backgroundshape_loc << [background_tile_array background_tile_loc] 2
	set backgroundshape_loc + backgroundshape_loc backgroundshape_loc_offset
	set $2007 [background_shapes backgroundshape_loc]
	inc backgroundshape_loc
	inc background_low
	set $2007 [background_shapes backgroundshape_loc]
	inc backgroundshape_loc
	inc background_low
	inc NT_across
	inc background_tile_loc
	dec draw_background_across_counter
	asm
	bne draw_background_across
	endasm
	
	if NT_across = 16 then 
	set background_tile_loc - background_tile_loc 16
	set backgroundshape_loc_offset 2
	endif
	
	if NT_across = 32 then 
	set backgroundshape_loc_offset 0
	set NT_across 0	
	endif
	
	if background_low = 0 then
	inc background_hi
	endif
	
	if background_hi = $23 then
	if background_low = $c0 set nmi_to_do 0
	endif 

	if background_hi = $27 then
	if background_low = $c0 set nmi_to_do 0
	endif 
	
	return
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;Clear Screen
;++++++++++++++++++++++++++++++++++++++++++++++++
clear_screen:

	asm
 	lda   #%00000000
 	sta   $2000
 	lda   #%00000000     
 	sta   $2001
	endasm

	set $2006 $20
	set $2006 $00
	
	asm

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
	
	endasm

	asm
 	lda   #%10010000
 	sta   $2000
 	lda   #%00011000     
 	sta   $2001
	rts
	endasm
	
;++++++++++++++++++++++++++++++++++++++++++++++++
; Draw Text main
;++++++++++++++++++++++++++++++++++++++++++++++++
draw_text_main:
	gosub draw_text_init	
	set palette_text 1
	set nmi_to_do 2
delay_until_done2:
	if nmi_to_do <> 0 goto delay_until_done2
	return
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;Draw Text,...You must set the texts variable/array to 
;a pointer to a ASCII array before using this.	
;Example:
;	set [texts 0] [backgroundtext 0]
;	set [texts 1] [backgroundtext 1]
;would point to this file:
;	backgroundtext:
;		.dw text1start
;	text1start:
;		.incbin "bgtext.txt"
;++++++++++++++++++++++++++++++++++++++++++++++++

draw_text_init:
	set PPUHI $20
	set PPULOW $a6
	set PPULOW_START PPULOW
	set TEXTPOS 0
	set CHARCOUNTER 0
drawtext:	
drawtext_loop:
			
	set $2006 PPUHI
	set $2006 PPULOW
	
	asm
	ldy CHARCOUNTER
	lda [texts],y
	sta character
	endasm
	
	if character = $20 set character $7b
	if character = $21 set character $7f
	if character = $ff then
	set nmi_to_do 0
	goto drawtext_done
	endif
	set character - character $57
	inc CHARCOUNTER
	
	set $2007 character
	
	inc PPULOW
	inc TEXTPOS
	if PPULOW = $fa then
		inc PPUHI
	endif
	if TEXTPOS = $14 then
		set PPULOW + PPULOW_START $40
		set PPULOW_START + PPULOW_START $40
		set TEXTPOS 0
	endif

drawtext_done:
		
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Joystick
;++++++++++++++++++++++++++++++++++++++++++++++++

joystick1:

	set $4016 1 //first strobe byte
	set $4016 0 //second strobe byte
	set joy1a		& [$4016] 1
	set joy1b		& [$4016] 1
	set joy1select	& [$4016] 1
	set joy1start	& [$4016] 1
	set joy1up		& [$4016] 1
	set joy1down	& [$4016] 1
	set joy1left	& [$4016] 1
	set joy1right	& [$4016] 1
		

		;set move_pos 0
		;set move_counter 0
		
		if joy1right = 1 goto joy1startawesome
		goto joy1startnotawesome
joy1startawesome:
		inc dvdcounter
		if dvdcounter = 0 goto dvdtitle
		if dvdcounter = 5 goto dvdscene1
		if dvdcounter = 10 goto dvdscene2
		if dvdcounter = 15 goto dvdscene3
		if dvdcounter = 20 goto dvdscene4
		if dvdcounter = 25 goto dvdscene5
		if dvdcounter = 30 goto dvdscene6
		if dvdcounter = 35 goto dvdscene7
		if dvdcounter = 40 goto dvdscene8
		if dvdcounter = 45 goto dvdscene9
		if dvdcounter = 50 goto dvdscene10	
		if dvdcounter = 55 goto dvdscene11	
		if dvdcounter = 60 goto dvdscene12	
		if dvdcounter = 65 goto dvdscene14	
		if dvdcounter = 70 goto dvdscene15	
		if dvdcounter = 75 goto sculpture1_score			
		;if dvdcounter = 80 goto sculpture2_score	
		;if dvdcounter = 85 goto sculpture3_score				
		if dvdcounter = 80 goto start				
joy1startnotawesome:		

	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;BEIGE music GLOBAL timer [for da Dj'zzzzzzz]
;++++++++++++++++++++++++++++++++++++++++++++++++

beige_music_loop:

	inc music_counter
	if music_counter >= global_tempo then
	set music_counter 0
	gosub play_music
	endif
	
return

;++++++++++++++++++++++++++++++++++++++++++++++++
;reset presetszzzz
;++++++++++++++++++++++++++++++++++++++++++++++++

reset_presets:

	asm
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
	endasm
	
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;BEIGE music code
;++++++++++++++++++++++++++++++++++++++++++++++++

play_music:

	if new_music_page = 0 then
	if new_music_page_big = 0 then
	gosub reset_presets
	endif
	endif
	
	set i1 0
	asm
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
 	endasm
 	goto no_skip_p1
skip_p1_mute:
 	set $4000 %00000000
	set $4001 %00000000	
skip_p1:
no_skip_p1:
	inc music_counter_file

	set i2 0
	asm
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
 	endasm
skip_p2:
	inc music_counter_file

	set i3 0
	asm
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
 	endasm
	goto no_skip_p3_mute
skip_p3_mute:
 	set $4008 %00000000
	set $4009 %00000000	
no_skip_p3_mute:
skip_p3:
	inc music_counter_file

	set i4 0
	asm
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
 	endasm
skip_p4:
	
	inc music_counter_file
	inc new_music_page
	if new_music_page = 0 inc new_music_page_big
asm

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
	endasm

	;set whichsong_temp >> song_number_new 1
	;set [which_song 0] [songs 0]
	;inc whichsong_temp
	;set [which_song 1] [songs 1]

	
;problem is above!!!!!!!!!

	dec scene_timer

	set [which_song 0] [songs 0]
	set [which_song 1] [songs 1]
		
	set [mute 0] [mute_new 0]
	set [mute 1] [mute_new 1]
	set [mute 2] [mute_new 2]
	set [mute 3] [mute_new 3]

	inc music_counter
		
go_on:

return

;++++++++++++++++++++++++++++++++++++++++++++++++
;NMI Routine!!!!  Very important!!!!!
;++++++++++++++++++++++++++++++++++++++++++++++++

nmi:
			
asm
pha
tya
pha
txa
pha
endasm

inc timer

if nmi_to_do = 0 goto skip_nmi_to_do

if nmi_to_do = 1 then
gosub draw_background
endif

if nmi_to_do = 2 then
gosub drawtext
endif

if nmi_to_do = 3 then
gosub move_sprite_1
endif

if nmi_to_do = 4 then
gosub change_palette
endif

if nmi_to_do = 5 then
gosub move_sprite_2
endif

if nmi_to_do = 6 then
gosub move_sprite_1
gosub move_sprite_2
endif

skip_nmi_to_do:

if nmi_to_do_special = 1 then
gosub move_sprite_1
endif



gosub beige_music_loop
gosub PutSpritesOnScreen
gosub joystick1

if palette_text = 0 goto skip_palette_text

if palette_text = 1 then
set special 0
set $2006 $3f
set $2006 $10
set $2007 $0d
set $2006 $3f
set $2006 $01
set $2007 $30
endif

if palette_text = 2 then
set $2006 $3f
set $2006 $10
asm
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
endasm
	set palette_text 0
endif

skip_palette_text:

if special = 0 goto skip_special

if special = 1 then
set $2006 $3f
set $2006 $10
set $2007 special_temp
endif

if special = 2 then
dec special_temp_2
if special_temp_2 > 0 goto skip_spcial_2
set special_temp_2 special_temp_2_master
set $2006 $3f
set $2006 $10
set $2007 special_temp
inc special_temp
skip_spcial_2:
endif

if special = 3 then
dec special_temp_2
if special_temp_2 > 0 goto skip_spcial_3
set special_temp_2 special_temp_2_master
set $2006 $3f
set $2006 $00
set $2007 special_temp
inc special_temp
inc special_temp
inc special_temp
set $2007 special_temp
inc special_temp
inc special_temp
inc special_temp
set $2007 special_temp
inc special_temp
inc special_temp
inc special_temp
set $2007 special_temp
inc special_temp
inc special_temp
inc special_temp
skip_spcial_3:
endif

if special = 4 then
dec special_temp_2
if special_temp_2 > 0 goto skip_spcial_4
set special_temp_2 special_temp_2_master
set $2006 $3f
set $2006 $01
set $2007 special_temp
inc special_temp
set $2007 special_temp
inc special_temp
set $2007 special_temp
inc special_temp
set $2007 special_temp
inc special_temp
set $2006 $3f
set $2006 $10
set $2007 color_show
skip_spcial_4:
endif

if special = 5 then
dec special_temp_2
if special_temp_2 > 0 goto skip_spcial_5
set special_temp_2 special_temp_2_master
set $2006 $3f
set $2006 $10
set $2007 color_show
skip_spcial_5:
endif

if special = 6 then
dec special_temp_2
if special_temp_2 > 0 goto skip_spcial_6
set special_temp_2 special_temp_2_master
set $2006 $3f
set $2006 $00
set $2007 color_show
set $2007 color_show_beige
set $2007 color_show_beige2
set $2007 color_show_beige3

skip_spcial_6:
endif

if special = 7 then
set $2006 $3f
set $2006 $10
set $2007 $0d
set $2007 color_show
set $2007 color_show_beige
set $2007 color_show_beige2
set $2007 color_show_beige3

endif

if special = 8 then
set $2006 $3f
set $2006 $10
;set $2007 $0d
set $2007 color_show
set $2007 color_show_beige
set $2007 color_show_beige2
set $2007 color_show_beige3
endif

if special = 9 then
set $2006 $3f
set $2006 $10
set $2007 color_show
endif

if special = 10 then
set $2006 $3f
set $2006 $00
set $2007 color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
set $2007 color_show
inc color_show
endif

skip_special:

if special_scroll = 0 goto skip_special_scroll
if special_scroll = 1 then
decscroll:
	dec scroll_delay
	asm
	bne skip_scroll
	endasm
	set scroll_delay scroll_delay_master
	dec scroll
	asm
skip_scroll:
	endasm
	endif

if special_scroll = 2 then
decscroll2:
	inc scroll2
	inc scroll2
	inc scroll2
	inc scroll2
skip_scroll2:
	endif

if special_scroll = 3 then
	inc scroll
	inc scroll
	inc scroll
	inc scroll
	endif
		
if special_scroll = 4 then
	inc scroll
	inc scroll
	inc scroll
	inc scroll
	;set scroll color_show_beige
	set scroll2 color_show
	set scroll color_show_beige
	endif

if special_scroll = 5 then
	inc scroll
	inc scroll
	inc scroll
	inc scroll
	set scroll2 color_show
	endif

if special_scroll = 6 then
	dec scroll2
	dec scroll2
	dec scroll2
	dec scroll2
	dec scroll2
	dec scroll2
	endif

if special_scroll = 7 then
	inc scroll
	asm
	lda #$ff
	cmp scroll
	bne special_scroll_nothing
	endasm
	set special_scroll 0
	asm
special_scroll_nothing:
	endasm
	endif
		
skip_special_scroll:

if special_att = 0 goto skip_special_att
if special_att = 1 then
	set $2006 PPUHI 
	set $2006 PPULOW
	set $2007 att_var
	inc att_var
	inc PPULOW
	if PPULOW = $ff set PPULOW $c0
	endif
 
if special_att = 2 then
	set $2006 PPUHI 
	set $2006 PPULOW
	set $2007 att_var
	inc PPULOW
	;endif
	
	if PPULOW = $00 then
	set PPULOW $c0
	inc att_var
	;dec special_att_counter
	endif
	
	endif

skip_special_att:

if pong_trick = 0 goto skip_pong_trick
if pong_trick = 1 then
	;set pong_trick_temp [spritemem pong_trick_loc]
	inc pong_trick_temp
	set [spritemem pong_trick_loc] pong_trick_temp
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	
	inc pong_trick_temp
	set [spritemem pong_trick_loc] pong_trick_temp
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc

	inc pong_trick_temp
	set [spritemem pong_trick_loc] pong_trick_temp
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	
	inc pong_trick_temp
	set [spritemem pong_trick_loc] pong_trick_temp
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	
	if pong_trick_loc = $75 set pong_trick_loc $31
	if pong_trick_loc = $81 set pong_trick_loc $31
	endif

if pong_trick = 2 then
	inc pong_trick_temp
	set [spritemem pong_trick_loc] pong_trick_temp
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	
	inc pong_trick_temp
	set [spritemem pong_trick_loc] pong_trick_temp
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc

	inc pong_trick_temp
	set [spritemem pong_trick_loc] pong_trick_temp
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	
	inc pong_trick_temp
	set [spritemem pong_trick_loc] pong_trick_temp
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	inc pong_trick_loc
	
	if pong_trick_loc = $15 set pong_trick_loc $01
	if pong_trick_loc = $21 set pong_trick_loc $01

skip_pong_trick:	
	endif
	
set $2006 0
set $2006 0
set $2005 scroll
set $2005 scroll2

asm
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
endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;Reset all parameters for scenes!
;++++++++++++++++++++++++++++++++++++++++++++++++

reset_nmi_vars:

	gosub screen_off
	gosub clear_att	
	gosub erase_sprites
	
	set nmi_to_do 0
	
	set palette_text 0
	
	set special 0
	set special_temp 0
	set special_temp_2 0
		
	set special_scroll 0
	set scroll_delay_master 0
	set scroll_delay 0
	
	set special_att 0
	set att_var 0
	set PPULOW 0
	set PPUHI 0
	
	set pong_trick 0
	set pong_trick_temp 0
	set pong_trick_loc 0
	
	set scroll 0
	set scroll2 0
	
	gosub show_number_2
	
	set nmi_to_do_special 0
	
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Cool music settings
;++++++++++++++++++++++++++++++++++++++++++++++++

drums:
	set [mute 0] 1
	set [mute 1] 1
	set [mute 2] 1
	set [mute 3] 0
	set [mute_new 0] 1
	set [mute_new 1] 1
	set [mute_new 2] 1
	set [mute_new 3] 0
	return

drums_bass:
	set [mute 0] 1
	set [mute 1] 1
	set [mute 2] 0
	set [mute 3] 0
	set [mute_new 0] 1
	set [mute_new 1] 1
	set [mute_new 2] 0
	set [mute_new 3] 0
	return

drums_bass_melody:
	set [mute 0] 0
	set [mute 1] 1
	set [mute 2] 0
	set [mute 3] 0
	set [mute_new 0] 0
	set [mute_new 1] 1
	set [mute_new 2] 0
	set [mute_new 3] 0
	return


bass_guitar:
	set [mute 0] 1
	set [mute 1] 0
	set [mute 2] 0
	set [mute 3] 1
	set [mute_new 0] 1
	set [mute_new 1] 0
	set [mute_new 2] 0
	set [mute_new 3] 1
	return
	
melody:
	set [mute 0] 0
	set [mute 1] 1
	set [mute 2] 1
	set [mute 3] 1
	set [mute_new 0] 0
	set [mute_new 1] 1
	set [mute_new 2] 1
	set [mute_new 3] 1	
	return

melody_guitar:
	set [mute 0] 0
	set [mute 1] 0
	set [mute 2] 1
	set [mute 3] 1
	set [mute_new 0] 0
	set [mute_new 1] 0
	set [mute_new 2] 1
	set [mute_new 3] 1	
	return
	
drums_bass_guitar_melody:
	set [mute 0] 0
	set [mute 1] 0
	set [mute 2] 0
	set [mute 3] 0
	set [mute_new 0] 0
	set [mute_new 1] 0
	set [mute_new 2] 0
	set [mute_new 3] 0	
	return
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;Set Song
;++++++++++++++++++++++++++++++++++++++++++++++++
set_song:

	set [which_song 0] [songs 0]
	set [which_song 1] [songs 1]
			
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;SceneTITLE SCREEN
;++++++++++++++++++++++++++++++++++++++++++++++++
start_music:

	set music_counter_file 0
	set music_counter 0
	set new_music_page 0
	set new_music_page_big 0	
	
	return


;++++++++++++++++++++++++++++++++++++++++++++++++
;Draw Text All
;++++++++++++++++++++++++++++++++++++++++++++++++
draw_text_all:
		
	gosub sprites_off
	gosub show_number_1
		
	gosub draw_text_main
	
	set timer 0
	gosub delay_1_sec
	
	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_main
	
	set palette_text 2			
	gosub show_number_2		
	gosub animate_sprites
	gosub sprites_on	

	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Mario falls off bottom of screen
;++++++++++++++++++++++++++++++++++++++++++++++++

mario_bottom:
	asm
	ldx #$1c
	lda spritemem,x
	cmp #$fe
	bne mario_bottom
	endasm
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Mario disappear
;++++++++++++++++++++++++++++++++++++++++++++++++

mario_off:

	asm
	ldy #$20
	ldx #$00
erase_mario:
	lda #$FC
	sta spritemem,x
	inx
	dey
	bne erase_mario
	endasm

	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Mario disappear
;++++++++++++++++++++++++++++++++++++++++++++++++

mario_off_right:
		if [spritemem 3] <> $f0 goto mario_off_right	
	return
		
;++++++++++++++++++++++++++++++++++++++++++++++++
;SceneTITLE SCREEN
;++++++++++++++++++++++++++++++++++++++++++++++++

scene_title:

	gosub reset_nmi_vars
		
	set global_tempo 6
	set [songs 0] [theme1 0]
	set [songs 1] [theme1 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music

	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette

	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all

	set current_NT $01
	set [background_data_array 0] [background35 0]
	set [background_data_array 1] [background35 1]
	gosub draw_background_all

	set [background_data_array 0] [background34 0]
	set [background_data_array 1] [background34 1]	

;Special Title Screen draw function...Super Mario Movie...
	
	asm
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
	endasm

	gosub screen_on
	set special_scroll 7
	
	gosub scene_music_loop	
			
	return



;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE1
;++++++++++++++++++++++++++++++++++++++++++++++++
scene1:
		
	gosub reset_nmi_vars
	
	set global_tempo 6
	set [songs 0] [theme1 0]
	set [songs 1] [theme1 1]
	gosub set_song
	gosub melody
	gosub start_music

	set [palette_data_array 0] [palette_data1 0]
	set [palette_data_array 1] [palette_data1 1]
	gosub load_palette

	set current_NT $00
	set [att_data_array 0] [att_data2 0]
	set [att_data_array 1] [att_data2 1]
	gosub load_att
	
	set current_NT $01
	set [att_data_array 0] [att_data2 0]
	set [att_data_array 1] [att_data2 1]
	gosub load_att
			
	set current_NT $01
	set [background_data_array 0] [background2 0]
	set [background_data_array 1] [background2 1]
	gosub draw_background_all	
	
	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
	
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 80		
	set sprite_x 112			
	set sprite_type 0
	gosub draw_sprites

	set [sprite_anim_data_array 0] [sprite_anim_data1 0]
	set [sprite_anim_data_array 1] [sprite_anim_data1 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	gosub animate_sprites

	gosub show_number_2
	gosub screen_on

;++++++++++++++++++++++++++++++++++++++++++++++++
;Intro

	set [texts 0] [backgroundtextintro1 0]
	set [texts 1] [backgroundtextintro1 1]
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++

;++++++++++++++++++++++++++++++++++++++++++++++++
;Intro2

	set [texts 0] [backgroundtextintro2 0]
	set [texts 1] [backgroundtextintro2 1]
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++

	set scene_timer 7
	gosub scene_music_loop
	gosub melody_guitar
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;mario log day3

	set [texts 0] [backgroundtext1 0]
	set [texts 1] [backgroundtext1 1]
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++
	
	set special 2
	
	set current_NT $01
	set [background_data_array 0] [background3 0]
	set [background_data_array 1] [background3 1]
	gosub draw_background_main
	gosub animate_sprites
	
	set scene_timer 3
	gosub scene_music_loop
	gosub drums_bass_guitar_melody
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;totally fucked
	
	set [texts 0] [backgroundtext2 0]
	set [texts 1] [backgroundtext2 1]		
	gosub draw_text_all
;		
;++++++++++++++++++++++++++++++++++++++++++++++++
	
	set sprite_data_pos $50			
	set sprite_y 110				
	set sprite_x 110				
	set sprite_type 1
	gosub draw_sprites
	
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub change_palette_main

	set [sprite_anim_data_array 0] [sprite_anim_data1 0]
	set [sprite_anim_data_array 1] [sprite_anim_data1 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	gosub animate_sprites

	set current_NT $01
	set [background_data_array 0] [background4 0]
	set [background_data_array 1] [background4 1]
	gosub draw_background_main

	set [sprite_anim_data_array 0] [sprite_anim_data2 0]
	set [sprite_anim_data_array 1] [sprite_anim_data2 1]

	set special_temp $10
	set special_temp_2 $10
	set special 2	

	set scroll_delay $20
	set scroll_delay_master $20
	set special_scroll 1

	set scene_timer 2
	gosub scene_music_loop

	set special_scroll 1

	set [sprite_anim_data_array 0] [sprite_anim_data3 0]
	set [sprite_anim_data_array 1] [sprite_anim_data3 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	set counter 0
	gosub animate_sprites		
	
	set special_temp $10
	set special_temp_2 $10
	set special 2	

	gosub mario_bottom
	gosub mario_off
	
	set nmi_to_do 0 ;make sure mario is disappeared, but not animating in the background

	set scene_timer 1
	gosub scene_music_loop
	
	return

asm
	.bank 1
	.org $a000
endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE2
;++++++++++++++++++++++++++++++++++++++++++++++++
scene2:

	gosub reset_nmi_vars
	
	set global_tempo 4
	set [songs 0] [fallingreverb2 0]
	set [songs 1] [fallingreverb2 1]
	gosub set_song
	gosub melody
	gosub start_music

	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette
		
	set current_NT $01
	set [background_data_array 0] [background4 0]
	set [background_data_array 1] [background4 1]
	gosub draw_background_all	
	
	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
	
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 80		
	set sprite_x 112			
	set sprite_type 0
	gosub draw_sprites

	set [sprite_anim_data_array 0] [sprite_anim_data4 0]
	set [sprite_anim_data_array 1] [sprite_anim_data4 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	set counter 0

	gosub show_number_2
	gosub screen_on

	set scroll_delay $03
	set scroll_delay_master $03
	set special_scroll 2
	
	set special_temp_2 10
	set special_temp_2_master 10
	set special 2
	
	set nmi_to_do_special 1 ;this covers our sprite animation for the scene
						
	set scene_timer 2
	gosub scene_music_loop
	gosub drums_bass
	
	set current_NT $01
	set [background_data_array 0] [background5 0]
	set [background_data_array 1] [background5 1]
	gosub draw_background_main
	
	set scene_timer 2
	gosub scene_music_loop
	gosub drums_bass_guitar_melody
	
	set current_NT $01
	set [background_data_array 0] [background6 0]
	set [background_data_array 1] [background6 1]
	gosub draw_background_main

	set timer $00
	gosub delay_1_sec
	set timer $00
	gosub delay_1_sec
	set timer $00

	set scene_timer 1
	gosub scene_music_loop
	
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE3
;++++++++++++++++++++++++++++++++++++++++++++++++
scene3:	

	gosub reset_nmi_vars
			
	set global_tempo 6
	set [songs 0] [aaliyah4 0]
	set [songs 1] [aaliyah4 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
		
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette

	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all	

	set current_NT $01
	set [background_data_array 0] [background8 0]
	set [background_data_array 1] [background8 1]
	gosub draw_background_all	

	set current_NT $01
	set [att_data_array 0] [att_data1 0]
	set [att_data_array 1] [att_data1 1]
	gosub load_att
							
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
	
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 0		
	set sprite_x 45			
	set sprite_type 0
	gosub draw_sprites

	set [sprite_anim_data_array 0] [sprite_anim_data5 0]
	set [sprite_anim_data_array 1] [sprite_anim_data5 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	gosub animate_sprites
	set counter 0
	
	gosub show_number_2
	gosub screen_on

	set special 2
	set special_temp $40
	set special_temp_2 $40
	set special_temp_2_master $40	

	set scene_timer 1
	gosub scene_music_loop

;++++++++++++++++++++++++++++++++++++++++++++++++
;screw it

	set [texts 0] [backgroundtext3a 0]
	set [texts 1] [backgroundtext3a 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++	


	
;redraw mario under the ? block
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 127		
	set sprite_x 65			
	set sprite_type 0
	gosub draw_sprites

; reset animation to him jumping
	set [sprite_anim_data_array 0] [sprite_anim_data6 0]
	set [sprite_anim_data_array 1] [sprite_anim_data6 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	set counter 0
	gosub animate_sprites

;set our favorite special settings (see special settings chart)
	set special 2
	set special_temp $40
	set special_temp_2 $40
	set special_temp_2_master $40

	set current_NT $00
	set [background_data_array 0] [background9 0]
	set [background_data_array 1] [background9 1]
	gosub draw_background_main
	gosub animate_sprites
	
wait_head_hit:	
	if [spritemem 0] <> 117 goto wait_head_hit
	
	set scene_timer $01
	gosub scene9	; moandrian

	
;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE3 AGAIN
;++++++++++++++++++++++++++++++++++++++++++++++++
	
	gosub reset_nmi_vars
			
	set global_tempo 6
	set [songs 0] [crazy6 0]
	set [songs 1] [crazy6 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
		
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette

	set current_NT $00
	set [background_data_array 0] [background10 0]
	set [background_data_array 1] [background10 1]
	gosub draw_background_all	

	set current_NT $01
	set [background_data_array 0] [background9 0]
	set [background_data_array 1] [background9 1]
	gosub draw_background_all	

	set current_NT $01
	set [att_data_array 0] [att_data1 0]
	set [att_data_array 1] [att_data1 1]
	gosub load_att
							
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
		
;redraw mario under the ? block
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 127		
	set sprite_x 65			
	set sprite_type 0
	gosub draw_sprites

; reset animation to him jumping
	set [sprite_anim_data_array 0] [sprite_anim_data6 0]
	set [sprite_anim_data_array 1] [sprite_anim_data6 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	set counter 0
	gosub animate_sprites

	set special 2
	set special_temp $40
	set special_temp_2 $40
	set special_temp_2_master $40
	
	gosub show_number_2
	gosub screen_on
	
;set our favorite special settings (see special settings chart)
	set special 2
	set special_temp $40
	set special_temp_2 $40
	set special_temp_2_master $40
	
wait_head_hit3:	
	if [spritemem 0] <> 117 goto wait_head_hit3
	
	gosub show_number_1

wait_head_hit4:	
	if [spritemem 0] <> 127 goto wait_head_hit4
	
	set anim_file_counter $00
	set counter 0
	gosub animate_sprites
		
wait_head_hit5:	
	if [spritemem 0] <> 117 goto wait_head_hit5

	gosub show_number_2

wait_head_hit6:	
	if [spritemem 0] <> 127 goto wait_head_hit6
	
	set anim_file_counter $00
	set counter 0
	gosub animate_sprites
		
wait_head_hit7:	
	if [spritemem 0] <> 117 goto wait_head_hit7

	gosub show_number_1

wait_head_hit8:	
	if [spritemem 0] <> 127 goto wait_head_hit8
	
	set anim_file_counter $00
	set counter 0
	gosub animate_sprites
		
wait_head_hit9:	
	if [spritemem 0] <> 117 goto wait_head_hit9

	set scene_timer $01
	gosub scene9	; moandrian

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE3 AGAIN
;++++++++++++++++++++++++++++++++++++++++++++++++
	
	gosub reset_nmi_vars
			
	set global_tempo 6
	set [songs 0] [crazy7 0]
	set [songs 1] [crazy7 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
		
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette

	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all	

	set current_NT $01
	set [background_data_array 0] [background9 0]
	set [background_data_array 1] [background9 1]
	gosub draw_background_all	

	set current_NT $00
	set [att_data_array 0] [att_data2 0]
	set [att_data_array 1] [att_data2 1]
	gosub load_att
	
	set current_NT $01
	set [att_data_array 0] [att_data1 0]
	set [att_data_array 1] [att_data1 1]
	gosub load_att
							
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
		
;redraw mario under the ? block
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 127		
	set sprite_x 65			
	set sprite_type 0
	gosub draw_sprites

; reset animation to him jumping
	set [sprite_anim_data_array 0] [sprite_anim_data6 0]
	set [sprite_anim_data_array 1] [sprite_anim_data6 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	set counter 0
	gosub animate_sprites

	set special 2
	set special_temp $40
	set special_temp_2 $40
	set special_temp_2_master $40
	
	gosub show_number_1
	gosub screen_on
					
;++++++++++++++++++++++++++++++++++++++++++++++++
;
	set [texts 0] [backgroundtext5 0]
	set [texts 1] [backgroundtext5 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++

	set [sprite_anim_data_array 0] [sprite_anim_data1 0]
	set [sprite_anim_data_array 1] [sprite_anim_data1 1]
	set counter 0
	set anim_file_counter $00	
			
	set scene_timer 2
	gosub scene_music_loop

	set nmi_to_do 0	
	set [sprite_anim_data_array 0] [sprite_anim_data7 0]
	set [sprite_anim_data_array 1] [sprite_anim_data7 1]
	set anim_file_counter $00				
	set counter 0
	
	gosub animate_sprites
	
	gosub mario_off_right
	gosub sprites_off

	set scene_timer 1
	gosub scene_music_loop

	return


;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 4 redux
;++++++++++++++++++++++++++++++++++++++++++++++++
scene4redux:

	set [background_data_array 0] [background14 0]
	set [background_data_array 1] [background14 1]	
	gosub scene4 ; 		running			

;++++++++++++++++++++++++++++++++++++++++++++++++
;
	set [texts 0] [backgroundtext7 0]
	set [texts 1] [backgroundtext7 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++

	set special_temp_2_master 50
	set special_temp_2 50
	set special 5
				
	set global_tempo 9
	set timer_noise $d0
	set scene5_loop $05
	gosub scene5 			;noise

	set [background_data_array 0] [background15 0]
	set [background_data_array 1] [background15 1]	
	gosub scene4 ; 		running

;++++++++++++++++++++++++++++++++++++++++++++++++
;
	set [texts 0] [backgroundtext7a 0]
	set [texts 1] [backgroundtext7a 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++

	return
	

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 4
;++++++++++++++++++++++++++++++++++++++++++++++++

scene4:
			
	;gosub reset_nmi_vars
	;gosub screen_off

	gosub screen_off
	;gosub clear_att	
	gosub erase_sprites
	
	set nmi_to_do 0
	
	set palette_text 0
	
	set special 0
	set special_temp 0
	set special_temp_2 0
		
	set special_scroll 0
	set scroll_delay_master 0
	set scroll_delay 0
	
	set special_att 0
	set att_var 0
	set PPULOW 0
	set PPUHI 0
	
	set pong_trick 0
	set pong_trick_temp 0
	set pong_trick_loc 0
	
	set scroll 0
	set scroll2 0
	
	gosub show_number_2
	
	set nmi_to_do_special 0
	
			
	set global_tempo 6
	set [songs 0] [crazy8 0]
	set [songs 1] [crazy8 1]
	gosub set_song
	gosub melody
	gosub start_music
				
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette

	set current_NT $01
	
	gosub draw_background_all
		
	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all	
								
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	

	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 127		
	set sprite_x 0			
	set sprite_type 0
	gosub draw_sprites

	set [sprite_anim_data_array 0] [sprite_anim_data7 0]
	set [sprite_anim_data_array 1] [sprite_anim_data7 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master 0
	set counter 0
	gosub animate_sprites
	
	gosub show_number_2
	gosub screen_on

	set special_temp_2_master 1
	set special_temp_2 1
	set special 5
	
	gosub mario_off_right
	gosub sprites_off
	
	set scene_timer 1
	gosub scene_music_loop
	
	return


;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 5
;++++++++++++++++++++++++++++++++++++++++++++++++

scene5:

	gosub reset_nmi_vars
			
	set global_tempo 6

	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
	
	;set scene5_loop 60
	
	gosub screen_off
	set [palette_data_array 0] [rand1 0]
	set [palette_data_array 1] [rand1 1]
	set palette_start 45
	gosub load_palette_rand
		
	set current_NT $01
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 3
	gosub load_att_rand
			
	gosub show_number_2		
	
	gosub screen_on
	gosub sprites_off

	set palette_text 1
	
scene5loop:
	set [palette_data_array 0] scene5_temp 
	set [palette_data_array 1] scene5_temp_2
	set palette_start scene5_temp
	;gosub load_palette_rand
	set current_NT $01
	set [background_data_array 0] scene5_temp 
	set [background_data_array 1] scene5_temp_2
	gosub screen_off
	gosub draw_background_all
	gosub screen_on
	gosub sprites_off

	set timer timer_noise
	gosub delay_1_sec
			
	;set scene_timer 1
	;gosub scene_music_loop
	
	asm
	inc scene5_temp
	endasm
	asm
	dec scene5_loop
	bne scene5loop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	endasm	

	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 5a
;++++++++++++++++++++++++++++++++++++++++++++++++

scene5a:

	gosub screen_off
			
	set global_tempo 6
	set [songs 0] [theme1 0]
	set [songs 1] [theme1 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
	
	;set scene5_loop 60
	
	gosub screen_off
	set [palette_data_array 0] [rand1 0]
	set [palette_data_array 1] [rand1 1]
	set palette_start 45
	gosub load_palette_rand
		
	set current_NT $01
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 3
	gosub load_att_rand
			
	gosub show_number_2		
	
	gosub screen_on
	gosub sprites_off
	
	set special 10
	
scene5aloop:
	set [palette_data_array 0] scene5_temp 
	set [palette_data_array 1] scene5_temp_2
	set palette_start scene5_temp
	;gosub load_palette_rand
	set current_NT $01
	set [background_data_array 0] scene5_temp 
	set [background_data_array 1] scene5_temp_2
	gosub screen_off
	gosub draw_background_all
	gosub screen_on
	gosub sprites_off

	set timer timer_noise
	gosub delay_1_sec
			
	;set scene_timer 1
	;gosub scene_music_loop
	
	asm
	inc scene5_temp
	endasm
	asm
	dec scene5_loop
	bne scene5aloop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	endasm	

	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 5b
;++++++++++++++++++++++++++++++++++++++++++++++++

scene5b:

	gosub reset_nmi_vars
			
	set global_tempo 6
	gosub set_song
	gosub start_music
	
	;set scene5_loop 60
	
	gosub screen_off
	set [palette_data_array 0] [rand1 0]
	set [palette_data_array 1] [rand1 1]
	set palette_start 45
	gosub load_palette_rand
		
	set current_NT $01
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 3
	gosub load_att_rand
			
	gosub show_number_2		
	
	gosub screen_on
	gosub sprites_off

	set special 10
	
scene5bloop:
	set [palette_data_array 0] scene5_temp 
	set [palette_data_array 1] scene5_temp_2
	set palette_start scene5_temp
	;gosub load_palette_rand
	set current_NT $01
	set [background_data_array 0] scene5_temp 
	set [background_data_array 1] scene5_temp_2
	gosub screen_off
	gosub draw_background_all
	gosub screen_on
	gosub sprites_off

	set timer timer_noise
	gosub delay_1_sec
			
	;set scene_timer 1
	;gosub scene_music_loop
	
	asm
	inc scene5_temp
	endasm
	asm
	dec scene5_loop
	bne scene5bloop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	endasm	

	return
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 6
;++++++++++++++++++++++++++++++++++++++++++++++++

scene6:

	gosub reset_nmi_vars
			
	set global_tempo 6
	set [songs 0] [bootyA12 0]
	set [songs 1] [bootyA12 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
		
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette
	
	set [palette_data_array 0] [rand1 0]
	set [palette_data_array 1] [rand1 1]
	set palette_start 00
	gosub load_palette_rand

	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all
	
	set current_NT $01
	set [background_data_array 0] [background17 0]
	set [background_data_array 1] [background17 1]
	gosub draw_background_all	
		
	set current_NT $01
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 4
	gosub load_att_rand

	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
			
	set spritemem_array_pos $00		
	set sprite_data_pos $10	
	set sprite_y 112	
	set sprite_x 167			
	set sprite_type 0
	gosub draw_sprites
	
	set sprite_data_pos $50	
	set sprite_y 120
	set sprite_x 12			
	set sprite_type 4
	gosub draw_sprites

	set sprite_data_pos $58
	set sprite_y 136	
	set sprite_x 16			
	set sprite_type 3
	gosub draw_sprites
		
	set [sprite_anim_data_array 0] [sprite_anim_data8 0]
	set [sprite_anim_data_array 1] [sprite_anim_data8 1]
	set anim_file_counter $00				
	set total_blocks_master $07			
	set sprite_mem_loc_master $20
	gosub animate_sprites
	set counter 0

	gosub show_number_2
	gosub screen_on

	set special_temp_2 15
	set special_temp_2_master 15
	set special 4
			
	set scene_timer 1
	gosub scene_music_loop
	gosub drums_bass_melody
			
;++++++++++++++++++++++++++++++++++++++++++++++++
;rotting mushroom

	set [texts 0] [backgroundtext8 0]
	set [texts 1] [backgroundtext8 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++

	set special 4
	
	set scene_timer 1
	gosub scene_music_loop
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;

	set [texts 0] [backgroundtext9 0]
	set [texts 1] [backgroundtext9 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++

	set special 4
	
	set scene_timer 1
	gosub scene_music_loop		
	gosub drums_bass_melody
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;

	set [texts 0] [backgroundtext10 0]
	set [texts 1] [backgroundtext10 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++

	set special 4
	
;wait for mushroom to get close

scene6loop:
	asm
	ldx #$27
	lda spritemem,x
	cmp #$94
	bne scene6loop
	endasm
	set nmi_to_do 0
	
	set [sprite_anim_data_array 0] [sprite_anim_data9 0]
	set [sprite_anim_data_array 1] [sprite_anim_data9 1]
	set anim_file_counter $00				
	set total_blocks_master $08			
	set sprite_mem_loc_master $00
	gosub animate_sprites
	set counter 0
	
;wait till fly off
	set scene_timer 1
	gosub scene_music_loop		

	set [sprite_anim_data_array 0] [sprite_anim_data10 0]
	set [sprite_anim_data_array 1] [sprite_anim_data10 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $11	
	set sprite_mem_loc_master $00
	gosub animate_sprites

	gosub mario_off_right
	gosub sprites_off

	set scene_timer 1
	gosub scene_music_loop	
								
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 7
;++++++++++++++++++++++++++++++++++++++++++++++++

scene7:

	gosub reset_nmi_vars
			
	set global_tempo 4
	set [songs 0] [bootyB13 0]
	set [songs 1] [bootyB13 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
	
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette
	
	set [palette_data_array 0] [background19 0]
	set [palette_data_array 1] [background19 1]
	set palette_start 19
	gosub load_palette_rand
				
	set current_NT $01
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 4
	gosub load_att_rand

	set current_NT $00
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 4
	gosub load_att_rand
				
	set current_NT $01
	set [background_data_array 0] [background19 0]
	set [background_data_array 1] [background19 1]
	gosub draw_background_all	

	set current_NT $00
	set [background_data_array 0] [background19 0]
	set [background_data_array 1] [background19 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
			
	gosub show_number_2
	gosub screen_on
	gosub sprites_off

	set special_temp_2 39
	set special_temp_2_master 39
	set special 4	
	set special_scroll 3
	
	set scene_timer 2
	gosub scene_music_loop	

	set special_scroll 4	

	set current_NT $01
	set [background_data_array 0] [background20 0]
	set [background_data_array 1] [background20 1]
	gosub draw_background_main
	set current_NT $00
	set [background_data_array 0] [background20 0]
	set [background_data_array 1] [background20 1]
	gosub draw_background_main

	set scene_timer 2
	gosub scene_music_loop	

	set current_NT $01
	set [background_data_array 0] [background21 0]
	set [background_data_array 1] [background21 1]
	gosub draw_background_main	
	set current_NT $00
	set [background_data_array 0] [background21 0]
	set [background_data_array 1] [background21 1]
	gosub draw_background_main
	
	set scene_timer 2
	gosub scene_music_loop	

	set current_NT $01
	set [background_data_array 0] [background22 0]
	set [background_data_array 1] [background22 1]
	gosub draw_background_main	
	set current_NT $00
	set [background_data_array 0] [background22 0]
	set [background_data_array 1] [background22 1]
	gosub draw_background_main	

	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 90	
	set sprite_x 15			
	set sprite_type 0
	gosub draw_sprites
	
	set sprite_data_pos $50	
	set sprite_y 106
	set sprite_x 0			
	set sprite_type 4
	gosub draw_sprites

	set sprite_data_pos $58
	set sprite_y 122	
	set sprite_x 10		
	set sprite_type 3
	gosub draw_sprites

	set [songs 0] [bootyC14 0]
	set [songs 1] [bootyC14 1]
		
	set [sprite_anim_data_array 0] [sprite_anim_data11 0]
	set [sprite_anim_data_array 1] [sprite_anim_data11 1]
	set anim_file_counter $00				
	set total_blocks_master $0f	
	set sprite_mem_loc_master $00
	set counter 0
	
	gosub animate_sprites
	gosub sprites_on
						
	set special_scroll 5

scene7_loop:
	asm
	ldx #$27
	lda spritemem,x
	cmp #$f0
	bne scene7_loop
	endasm
	set nmi_to_do 0

	gosub sprites_off
	set scene_timer 2
	gosub scene_music_loop	
		
	return	

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 12
;++++++++++++++++++++++++++++++++++++++++++++++++

scene12:


	gosub reset_nmi_vars
			
	set global_tempo 4
	set [songs 0] [bootyA12 0]
	set [songs 1] [bootyA12 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music

	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette
	
	set [palette_data_array 0] [background19 0]
	set [palette_data_array 1] [background19 1]
	set palette_start 19
	gosub load_palette_rand
								
	set current_NT $01
	set [background_data_array 0] [background32 0]
	set [background_data_array 1] [background32 1]
	gosub draw_background_all	

	set current_NT $00
	set [background_data_array 0] [background32 0]
	set [background_data_array 1] [background32 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
				
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 90	
	set sprite_x 15			
	set sprite_type 0
	gosub draw_sprites
	
	set sprite_data_pos $50	
	set sprite_y 106
	set sprite_x 0			
	set sprite_type 4
	gosub draw_sprites

	set sprite_data_pos $58
	set sprite_y 122	
	set sprite_x 10		
	set sprite_type 3
	gosub draw_sprites
	
	gosub show_number_2
	gosub screen_on
	gosub sprites_off

	set special_temp_2 35
	set special_temp_2_master 35
	set special 4
	
	set scene_timer 2
	gosub scene_music_loop	

	set [sprite_anim_data_array 0] [sprite_anim_data15 0]
	set [sprite_anim_data_array 1] [sprite_anim_data15 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $0f	
	set sprite_mem_loc_master $00
	gosub animate_sprites	
	gosub sprites_on
						
scene12_loop:
	asm
	ldx #$27
	lda spritemem,x
	cmp #$f0
	bne scene12_loop
	endasm

	gosub sprites_off

	set scene_timer 2
	gosub scene_music_loop
			
	return	

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 8
;++++++++++++++++++++++++++++++++++++++++++++++++

scene8:

	gosub reset_nmi_vars
			
	set global_tempo 4
	set [songs 0] [bootyB13 0]
	set [songs 1] [bootyB13 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music

	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette
	
	set [palette_data_array 0] [background19 0]
	set [palette_data_array 1] [background19 1]
	set palette_start 19
	gosub load_palette_rand
				
	set current_NT $01
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 4
	gosub load_att_rand

	set current_NT $00
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 4
	gosub load_att_rand
				
	set current_NT $01
	set [background_data_array 0] [background23 0]
	set [background_data_array 1] [background23 1]
	gosub draw_background_all	

	set current_NT $00
	set [background_data_array 0] [background23 0]
	set [background_data_array 1] [background23 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
			

	gosub show_number_2
	gosub screen_on
	gosub sprites_off

	set special_scroll 4
	set special_temp_2 45
	set special_temp_2_master 45
	set special 4
			
	set scene_timer 2
	gosub scene_music_loop	

	set current_NT $01
	set [background_data_array 0] [background24 0]
	set [background_data_array 1] [background24 1]
	gosub draw_background_main
	set current_NT $00
	set [background_data_array 0] [background24 0]
	set [background_data_array 1] [background24 1]
	gosub draw_background_main
	
	set scene_timer 2
	gosub scene_music_loop	

	set current_NT $01
	set [background_data_array 0] [background25 0]
	set [background_data_array 1] [background25 1]
	gosub draw_background_main	
	set current_NT $00
	set [background_data_array 0] [background25 0]
	set [background_data_array 1] [background25 1]
	gosub draw_background_main

	set scene_timer 2
	gosub scene_music_loop	

	set current_NT $01
	set [background_data_array 0] [background26 0]
	set [background_data_array 1] [background26 1]
	gosub draw_background_main	
	set current_NT $00
	set [background_data_array 0] [background26 0]
	set [background_data_array 1] [background26 1]
	gosub draw_background_main	

	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 90	
	set sprite_x 15			
	set sprite_type 0
	gosub draw_sprites
	
	set sprite_data_pos $50	
	set sprite_y 106
	set sprite_x 0			
	set sprite_type 4
	gosub draw_sprites

	set sprite_data_pos $58
	set sprite_y 122	
	set sprite_x 10		
	set sprite_type 3
	gosub draw_sprites

	set [songs 0] [bootyC14 0]
	set [songs 1] [bootyC14 1]
		
	set [sprite_anim_data_array 0] [sprite_anim_data11 0]
	set [sprite_anim_data_array 1] [sprite_anim_data11 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $0f	
	set sprite_mem_loc_master $00
	gosub animate_sprites
	gosub sprites_on
						
	set special_scroll 5

scene8_loop:
	asm
	ldx #$27
	lda spritemem,x
	cmp #$f0
	bne scene8_loop
	endasm
	set nmi_to_do 0
	gosub sprites_off

	set scene_timer 2
	gosub scene_music_loop	
	
	gosub screen_off		
	return	



;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 9
;++++++++++++++++++++++++++++++++++++++++++++++++

scene9:

	gosub reset_nmi_vars
			
	set global_tempo 4
	set [songs 0] [song5 0]
	set [songs 1] [song5 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
	
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette
	
	set [palette_data_array 0] [background19 0]
	set [palette_data_array 1] [background19 1]
	set palette_start 19
	gosub load_palette_rand
				
	set current_NT $01
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 4
	gosub load_att_rand

	set current_NT $00
	set [att_data_array 0] [rand1 0]
	set [att_data_array 1] [rand1 1]
	set att_start 4
	gosub load_att_rand
				
	set current_NT $01
	set [background_data_array 0] [background23 0]
	set [background_data_array 1] [background23 1]
	gosub draw_background_all	

	set current_NT $00
	set [background_data_array 0] [background23 0]
	set [background_data_array 1] [background23 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
			
	set special_scroll 0
	gosub show_number_2
	
	gosub screen_on
	gosub sprites_off

	set special_temp_2 10
	set special_temp_2_master 10
	set special 4
		
	set PPUHI  $27
	set PPULOW $c0
	set special_att 1


	set scene_timer 2
	gosub scene_music_loop	
	
	set special_att 0
						
	return	
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 10
;++++++++++++++++++++++++++++++++++++++++++++++++

scene10:

	gosub reset_nmi_vars
			
	set global_tempo 4
	set [songs 0] [grime11 0]
	set [songs 1] [grime11 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
	
	set [palette_data_array 0] [palette_data6 0]
	set [palette_data_array 1] [palette_data6 1]
	gosub load_palette
	
	set [palette_data_array 0] [background19 0]
	set [palette_data_array 1] [background19 1]
	set palette_start 19
	;gosub load_palette_rand
									
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
			
	set special_scroll 0
	gosub show_number_2
	
	gosub screen_on
	gosub sprites_off
	
	set PPUHI  $27
	set PPULOW $c0
	
	set special_att 2
	set special_temp_2 10
	set special_temp_2_master 10
	set special 6
		
scene10loop:

	set scene10temp [background_data_arrayop 2]
	inc scene10temp
	set [background_data_arrayop 0] $00
	set [background_data_arrayop 1] $06
	set [background_data_arrayop 2] scene10temp
	set [background_data_arrayop 3]	$00
	set [background_data_arrayop 4]	$fe
	set [background_data_arrayop 5]	$fe
	set current_NT $01
	gosub draw_background_mainop
	set timer $00
	gosub delay_1_sec
	
	asm
	dec scene10loop_var
	bne scene10loop
	endasm
	
	set special_att 0
					
	return	

;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 11
;++++++++++++++++++++++++++++++++++++++++++++++++

scene11:

	gosub reset_nmi_vars
			
	set global_tempo 4
	set [songs 0] [pong15 0]
	set [songs 1] [pong15 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music

	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette
	
	set [palette_data_array 0] [background19 0]
	set [palette_data_array 1] [background19 1]
	set palette_start 19
	gosub load_palette_rand
								
	set current_NT $01
	set [background_data_array 0] [background23 0]
	set [background_data_array 1] [background23 1]
	gosub draw_background_all	

	set current_NT $00
	set [background_data_array 0] [background23 0]
	set [background_data_array 1] [background23 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
			

	gosub show_number_2
	
	set special_temp_2 50
	set special_temp_2_master 50
	set special 4
	gosub screen_on
	gosub sprites_off
	set special_scroll 4
	
	set scene_timer 1
	gosub scene_music_loop	

	set current_NT $01
	set [background_data_array 0] [background27 0]
	set [background_data_array 1] [background27 1]
	gosub draw_background_main	
	
	set current_NT $00
	set [background_data_array 0] [background27 0]
	set [background_data_array 1] [background27 1]
	gosub draw_background_main	

	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 90	
	set sprite_x 15			
	set sprite_type 0
	gosub draw_sprites
	
	set sprite_data_pos $50	
	set sprite_y 106
	set sprite_x 0			
	set sprite_type 4
	gosub draw_sprites

	set sprite_data_pos $58
	set sprite_y 122	
	set sprite_x 10		
	set sprite_type 3
	gosub draw_sprites
	
	set [sprite_anim_data_array 0] [sprite_anim_data12 0]
	set [sprite_anim_data_array 1] [sprite_anim_data12 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $0f	
	set sprite_mem_loc_master $00
	gosub animate_sprites
	gosub sprites_on
						
	set special_scroll 0
	set scroll 0
	set scroll2 0
	gosub show_number_2

	set scene_timer 2
	gosub scene_music_loop

	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_main

;++++++++++++++++++++++++++++++++++++++++++++++++
;
	set [texts 0] [backgroundtext11 0]
	set [texts 1] [backgroundtext11 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++	
	
	set special_temp_2 30
	set special_temp_2_master 30
	set special 4
	set scene_timer 2
	gosub scene_music_loop
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;
	set [texts 0] [backgroundtext12 0]
	set [texts 1] [backgroundtext12 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++	
	
	set special_temp_2 30
	set special_temp_2_master 30
	set special 4

	set scene_timer 1
	gosub scene_music_loop		

	set [sprite_anim_data_array 0] [sprite_anim_data14 0]
	set [sprite_anim_data_array 1] [sprite_anim_data14 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $0f	
	set sprite_mem_loc_master $00

	set timer $c0
	gosub delay_1_sec
	gosub sprites_off
	
	set scene_timer 1
	gosub scene_music_loop		
				
	return	
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 16
;++++++++++++++++++++++++++++++++++++++++++++++++

scene16:

	gosub reset_nmi_vars

	set global_tempo 1
	set [songs 0] [pong15 0]
	set [songs 1] [pong15 1]
	gosub set_song
	gosub melody
	gosub start_music
			
	set [palette_data_array 0] [palette_data7 0]
	set [palette_data_array 1] [palette_data7 1]
	gosub load_palette
									
	set current_NT $01
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all	

	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
			
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y $c0	
	set sprite_x 30			
	set sprite_type 0
	gosub draw_sprites
	
	set sprite_data_pos $76	
	set sprite_y $d0
	set sprite_x 15			
	set sprite_type 4
	gosub draw_sprites

	set sprite_data_pos $64
	set sprite_y $60
	set sprite_x $10			
	set sprite_type 0
	gosub draw_sprites

	set sprite_data_pos $64
	set sprite_y $60
	set sprite_x $e0			
	set sprite_type 0
	gosub draw_sprites

	set sprite_data_pos $74
	set sprite_y $60
	set sprite_x $e0			
	set sprite_type 5
	gosub draw_sprites
	
	gosub show_number_2				
	gosub screen_on
	
	set pong_trick_loc $31
	set pong_trick_temp $00
	set pong_trick 1

	set special_temp_2 $01
	set special_temp_2_master $01
	set special 7

pong_loop:
	
	set [sprite_anim_data_array 0] [sprite_anim_data16 0]
	set [sprite_anim_data_array 1] [sprite_anim_data16 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $01
	set sprite_mem_loc_master $70
	gosub animate_sprites
	
	;set palette_text 1 ; make background black
	set special 7
	gosub sprites_on

scene16_loop:
	asm
	ldx #$70
	lda spritemem,x
	cmp #$ff
	bne scene16_loop
	endasm

	set [sprite_anim_data_array2 0] [sprite_anim_data20 0]
	set [sprite_anim_data_array2 1] [sprite_anim_data20 1]
	set counter2 0
	set anim_file_counter2 $00				
	set total_blocks_master2 $08	
	set sprite_mem_loc_master2 $30
	
	set [sprite_anim_data_array 0] [sprite_anim_data17 0]
	set [sprite_anim_data_array 1] [sprite_anim_data17 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $01	
	set sprite_mem_loc_master $70
	gosub animate_both_sprites

scene16_loop2:
	asm
	ldx #$73
	lda spritemem,x
	cmp #$1f
	bne scene16_loop2
	endasm

	set [sprite_anim_data_array 0] [sprite_anim_data18 0]
	set [sprite_anim_data_array 1] [sprite_anim_data18 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $01	
	set sprite_mem_loc_master $70

scene16_loop3:
	asm
	ldx #$70
	lda spritemem,x
	cmp #$e2
	bne scene16_loop3
	endasm

	set [sprite_anim_data_array 0] [sprite_anim_data19 0]
	set [sprite_anim_data_array 1] [sprite_anim_data19 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $01	
	set sprite_mem_loc_master $70

	set [sprite_anim_data_array2 0] [sprite_anim_data21 0]
	set [sprite_anim_data_array2 1] [sprite_anim_data21 1]
	set counter2 0
	set anim_file_counter2 $00				
	set total_blocks_master2 $08	
	set sprite_mem_loc_master2 $50
	
scene16_loop4:
	asm
	ldx #$73
	lda spritemem,x
	cmp #$da
	bne scene16_loop4
	endasm
	
	set [sprite_anim_data_array 0] [sprite_anim_data16 0]
	set [sprite_anim_data_array 1] [sprite_anim_data16 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $01
	set sprite_mem_loc_master $70
	gosub animate_both_sprites
	
	set pong_trick 1
	set special 7
		
	gosub sprites_on

scene16_loop5:
	asm
	ldx #$70
	lda spritemem,x
	cmp #$ff
	bne scene16_loop5
	endasm

	set [sprite_anim_data_array 0] [sprite_anim_data17 0]
	set [sprite_anim_data_array 1] [sprite_anim_data17 1]
	set counter 0
	set anim_file_counter $00				
	set total_blocks_master $01
	set sprite_mem_loc_master $70
	gosub animate_both_sprites

	set global_tempo 4
	set [songs 0] [harmony16 0]
	set [songs 1] [harmony16 1]	
	set special 8
	gosub sprites_off

	set scene_timer 2
	gosub scene_music_loop	
	
	gosub erase_sprites
	
	return


		
;++++++++++++++++++++++++++++++++++++++++++++++++
;SCENE 17
;++++++++++++++++++++++++++++++++++++++++++++++++

scene17:

	gosub reset_nmi_vars
			
	set global_tempo 4
	set [songs 0] [harmonybass17 0]
	set [songs 1] [harmonybass17 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music
	
	set [palette_data_array 0] [palette_data2 0]
	set [palette_data_array 1] [palette_data2 1]
	gosub load_palette
	
	set [palette_data_array 0] [background19 0]
	set [palette_data_array 1] [background19 1]
	set palette_start 19
	gosub load_palette_rand
								
	set current_NT $01
	set [background_data_array 0] [background18 0]
	set [background_data_array 1] [background18 1]
	gosub draw_background_all	

	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all
	
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	
	
	set spritemem_array_pos $00		
	set sprite_data_pos $00	
	set sprite_y 96
	set sprite_x 15			
	set sprite_type 0
	gosub draw_sprites
	
	gosub show_number_2
	gosub screen_on
	gosub animate_sprites
	gosub sprites_on	
	
	set special_temp_2 4
	set special_temp_2_master 4
	set special 4
	
	set scene_timer 1
	gosub scene_music_loop		

;++++++++++++++++++++++++++++++++++++++++++++++++
;

	set [texts 0] [backgroundtext14 0]
	set [texts 1] [backgroundtext14 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++	
	
	set special_temp_2 4
	set special_temp_2_master 4
	set special 4
	
	set scene_timer 1
	gosub scene_music_loop		

;++++++++++++++++++++++++++++++++++++++++++++++++
;

	set [texts 0] [backgroundtext15 0]
	set [texts 1] [backgroundtext15 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++	

	set special_temp_2 4
	set special_temp_2_master 4
	set special 4
	
	set PPUHI  $27
	set PPULOW $c0
	set special_att 2

	set scene_timer 1
	gosub scene_music_loop	

	set [songs 0] [cory17 0]
	set [songs 1] [cory17 1]
			
	set special_scroll 2 
	set special 6

	set scene_timer 1
	gosub scene_music_loop	

	set special_scroll 4
	set pong_trick_loc $01
	set pong_trick_temp $00
	set pong_trick 2		

	set scene_timer 1
	gosub scene_music_loop	
		
	set [texts 0] [backgroundtext15 0]
	set [texts 1] [backgroundtext15 1]		
	gosub draw_text_main

	set scene_timer 1
	gosub scene_music_loop	

	set current_NT $00
	set [background_data_array 0] [background12 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_main
	
	set current_NT $01
	set [background_data_array 0] [background21 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_main	
		
	set scene_timer 1
	gosub scene_music_loop	

;++++++++++++++++++++++++++++++++++++++++++++++++
;

	set [texts 0] [backgroundtext15 0]
	set [texts 1] [backgroundtext15 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++	

	gosub reset_nmi_vars
	gosub show_number_2				
	gosub screen_on
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;

	set [texts 0] [backgroundtext16 0]
	set [texts 1] [backgroundtext16 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++
	
	set special_scroll 2 
	set special 6
	set special_scroll 4
	set pong_trick_loc $01
	set pong_trick_temp $00
	set PPUHI  $27
	set PPULOW $c0
	set special_att 2
	set pong_trick 2		

	set [texts 0] [backgroundtext15 0]
	set [texts 1] [backgroundtext15 1]		
	gosub draw_text_main

	set [songs 0] [bridge18 0]
	set [songs 1] [bridge18 1]
	
	set scene_timer $01
	gosub scene_music_loop
		
	gosub reset_nmi_vars
	gosub show_number_2				
	gosub screen_on

	set [songs 0] [climaxarpeggio20 0]
	set [songs 1] [climaxarpeggio20 1]
			
;++++++++++++++++++++++++++++++++++++++++++++++++
;screw it

	set [texts 0] [backgroundtext17 0]
	set [texts 1] [backgroundtext17 1]		
	gosub draw_text_all
;
;++++++++++++++++++++++++++++++++++++++++++++++++
	
	set scene_timer $01
	gosub scene_music_loop
	
	return	
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;Scene18
;++++++++++++++++++++++++++++++++++++++++++++++++

scene18:

	gosub reset_nmi_vars
		
	set global_tempo 4
	set [songs 0] [crazy7 0]
	set [songs 1] [crazy7 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music

	gosub load_palette

;Special Title Screen draw function...

	gosub draw_2_screens

	gosub show_number_1
	gosub screen_on

	set special 9	
	set special_scroll 4

	gosub delay_1_sec
	gosub screen_off
			
	return
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;Scene18a
;++++++++++++++++++++++++++++++++++++++++++++++++
scene18a:

	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 74
	set timer_noise $fd
	set scene5_loop $a0
	gosub scene5a

	gosub screen_off
	gosub reset_nmi_vars
	
	set [palette_data_array 0] [palette_data8 0]
	set [palette_data_array 1] [palette_data8 1]
	gosub load_palette

	set current_NT $01
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all	
	gosub screen_on	
	set global_tempo $fe
	
	set timer $10
	gosub delay_1_sec
	set timer $10
	gosub delay_1_sec
	set timer $10
	gosub delay_1_sec
	set timer $10
	gosub delay_1_sec
	set timer $10
	gosub delay_1_sec
			
	return
	
;++++++++++++++++++++++++++++++++++++++++++++++++
;Scene19
;++++++++++++++++++++++++++++++++++++++++++++++++

scene19:

	gosub reset_nmi_vars
		
	set global_tempo 6
	set [songs 0] [mario22 0]
	set [songs 1] [mario22 1]
	gosub set_song
	gosub drums_bass_guitar_melody
	gosub start_music

	set [palette_data_array 0] [palette_data6 0]
	set [palette_data_array 1] [palette_data6 1]
	gosub load_palette

	set [background_data_array 0] [ending2 0]
	set [background_data_array 1] [ending2 1]	

;Special Title Screen draw function...

	gosub draw_2_screens

	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]
	
	set spritemem_array_pos $00		
	set sprite_data_pos $7e
	set sprite_y $c0	
	set sprite_x 30			
	set sprite_type 4
	gosub draw_sprites

	
	
	gosub show_number_1
	gosub screen_on

	gosub scene_music_loop
		
	return

asm
	.bank 2
	.org $c000
endasm
		
;++++++++++++++++++++++++++++++++++++++++++++++++
;Sculpture1
;++++++++++++++++++++++++++++++++++++++++++++++++

sculpture1:
			
	gosub reset_nmi_vars
			
	set global_tempo 6
	gosub set_song
	gosub start_music
				
	set [palette_data_array 0] [palette_data6 0]
	set [palette_data_array 1] [palette_data6 1]
	gosub load_palette


	set current_NT $00
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all
		
	set current_NT $01
	set [background_data_array 0] [background1 0]
	set [background_data_array 1] [background1 1]
	gosub draw_background_all	
								
	set [sprite_data_array 0] [sprite_data1 0]
	set [sprite_data_array 1] [sprite_data1 1]	

	gosub show_number_2
	gosub screen_on

	set special_temp_2_master $40
	set special_temp_2 $40
	set special 5
	
	gosub sprites_off	

	gosub scene_music_loop
	
	return


;++++++++++++++++++++++++++++++++++++++++++++++++
;DATA
;++++++++++++++++++++++++++++++++++++++++++++++++

asm
	
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

;sprite definitions++++++++++++++++++++	
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
		
;palettes+++++++++++++++++++	
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
	
		
;background shape definitions++++++++++++++++++++	
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

;backgrounds++++++++++++++++++++			
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

;random noise cube        				
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

;intro1	
backgroundtextintro1:
	.dw backgroundtextintro1i
backgroundtextintro1i:
	.incbin "backgroundtextintro1.txt"

;intro2	
backgroundtextintro2:
	.dw backgroundtextintro2i
backgroundtextintro2i:
	.incbin "backgroundtextintro2.txt"
			
;my world is turn to noise	
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

endasm