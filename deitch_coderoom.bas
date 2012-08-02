;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;
;	Super Mario Movie 2004
;
;	All programming by Cory Arcangel of the BEige Programming Ensemble 
;	Script + Set Design:  www.paperrad.org + Cory
;	MUSIC: ROTFLOL
;	Required to Compile:  nesasm, nbasic by Bob Rost
;
;	Special Thanks 4 Cory: Mom, Dad, Justin, Jamie, Le Mut, Slash (gnr), techno, 
;	Team Gallery (Jose Brendan Miriam), Dimebag (RIP), Pre 90's NHL hockey,
;	current OHL hockey, All the Peepz on NESDEV, Nullsleep, Chris Covell,
;	Bodenstandig 2000, Lektrolab (Emma), All my BEIGe peepz,
;	Stan + Woody Vasulka (+ all other early video peepz), Rudy Tardy 
;	RSG, Frankie MArtin, Memblers, Yoshi, Brad Taylor, Simple Text, jodi.org
;
;	Special Thanks 4 Paper Rad: 
;   All Trolls, O.D.B.R.I.P., ratface dream angel 24-7 lifer, M.B., Foxy Productions,
;   dogface, Michael Abbott, the entire geocities infrastructure, extreme sports,
;	Lil C++, TCP, All da bong stars @ Xerox Park, John Grisham, Jason Bonham,
;	Tweety & Bodyman, 2short
;	
;	"Don't Fuck with Us" - BEIGE Programming Ensemble 2004
;	"Money is a Major Issue" - Paper Rad
;	"Fuck all you fake ass pixel wannabes" - Box Eyes the digital destroyer
;	"You mess with the best you die like the rest" - Doogie Houser, MD
;	"Punks jump up to get beat down" - Brand Nubian
;	"Jump up Jump up and get down" - House of Pain
;	"Celebrate the New Dark Age" - Polvo
;	"It's cool to look bummy and be a dum dummy" - Slick Rick
;
;	www.paperrad.org
;	www.beigerecords.com/cory/	
;
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++
;Okay,.....(this editor I am using doesnt have spell check, so I apologize for ;all the poor spelling) so for this movie I wrote the code half in nbasic, and ;half in 6502 assembly.  nbasic is a basic wrapper for 6502 assembly by Bob ;Rost.  6502 assembly is the code that the Nintendo takes because it has a 6502 ;microprocessor.  FYI the Atari 2600 and Commodore64 also had that processor.  ;Anyway, I used nbasic language cause this was a large project, and the prospect ;of writing this movie from scratch in assembly was a bit too much for me.  ;nbasic is a good prototyping language I think,.........but recently I started ;going through it and converting it all to assembly, because some bizarre bugs ;started appearing here and there that had no rational explanation.  I suspsect ;this to be from nbasic, and my quick coding.  So a good going over with the old ;assembly brush would probably fix it all,....So yeah,....this is kinda half ;converted into 6502 assembly.  Sorry about that.  I am a poser.  
;+++++++++

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

;+++++++++
;This just clears the stuff out of the Nintendos memory from the last game you ;played!  If you just played Duck Hunt, no sence in having Ducks appear in the ;movie!
;+++++++++

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

;+++++++++
;This next section is where all our variable get set up.  So baically when we ;turn the machine on we want everything set to zero.  Very very easy!!!!!!!
;+++++++++

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

;+++++++++
;Okay, so now we are ready for the big time!!!!  After we have cleared ;everything, and our variables are set up, we need to actually play our movie.  ;I have organized this movie in a timeline.  Take a look.  All the scenes are ;below!
;+++++++++
	
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

;This is the code for the cubes.....
	
sculpture1_score:
	gosub reset_nmi_vars
	set [songs 0] [theme1 0]
	set [songs 1] [theme1 1]
	gosub melody_guitar
	set scene_timer $10
	gosub sculpture1
	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 9	
	set timer_noise $40
	set scene5_loop $10
	gosub scene5
	;goto sculpture1_score

sculpture2_score:
	gosub reset_nmi_vars
	set scene10loop_var $10
	set scene10temp $00
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
	set [songs 0] [harmonybass17 0]
	set [songs 1] [harmonybass17 1]
	gosub melody_guitar
	set scene5_temp $00 
	set scene5_temp_2 $80
	set global_tempo 9	
	set timer_noise $40
	set scene5_loop $10
	gosub scene5
	;goto sculpture3_score
	goto sculpture1_score
																
main:
	goto main
		
;+++++++++
;Here are several routines to set up the proper variables to allow the Nintendo ;to animate sprites.  I have written a sprite animation routine that resonds to ;the variable "nmi_to_do".  So when this flag "nmi_to_do" is set to three it ;means we will then animate sprites.  The Nintendo only has a brief amount of ;time to get stuff done (the time that the electron beam takes to jump to the ;top of the sceeen) so all of the important stuff is decided by this flag.  For ;example, if it is set to one, the movie will draw a new back ground.  This is a ;good way to do it so these routines will never step on each others feet.
;+++++++++

;++++++++++++++++++++++++++++++++++++++++++++++++
;Animate Sprites
;++++++++++++++++++++++++++++++++++++++++++++++++
	
animate_sprites:
	set nmi_to_do 3
	return

;++++++++++++++++++++++++++++++++++++++++++++++++
;Animate 2 sprites
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

;+++++++++
;This is the big daddy Sprite animator.  Basically it reads a binary file that ;has a little Sprite animation file format i set up.  It looks like this:
;F1 01 01 00 00 08
;The first value makes the sprite move in a certain way.  These are as follows:
;f0 - up
;f1 - down
;f2 - left
;f3 - right
;f4 - stay put
;f5 - draw new sprite
;f6 - loop back to location
;The second value is a counter,......so if I say $FF, then it will to the f1-6 ;command 256 times.  
;The third value is a slow down thing.  So if I set this to 03, it will do the ;animation every third jump of the electron beam.
;The fourth value is for when we want to draw a new sprite.  This is where to ;draw it in our Sprite Array
;The fifth is our new Sprite data if we are changing Sprites.
;The sixth is the total number of blocks we want to draw new if we are drawing a ;new sprite and the loop back location of the animation (this file) if we use f6
;To end the file I say FF, or 0F, I cant remember.........I sure one will work. 
;+++++++++

;++++++++++++++++++++++++++++++++++++++++++++++++
;move sprites,.....
;	
;	This is the sprite animation routine...
;	we have to set these variables before doing anything.....	
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

;+++++++++
;These next few routines, are for erasing, turning on and off the screen in ;between scenes,...basic janitorial duties in terms of code.  Totally ;boring...... 
;+++++++++

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

;+++++++++
;This guy loop and does not go forward until the measure of music is done.  This ;is how the whole movie is timed up to the music.     
;+++++++++

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

;+++++++++
;The Nintendo is organized into 2 screens.  One is visible and one is off left.  ;So that is how the nintendo is able to scroll scenes.  The nintendo as far as I ;know is the first game System to allow for side scrolling games, which of ;course changed games forever.  So this below routine changes to the left ;screen.  Which is where I put the text.  So for every scene of the movie, there ;is a blank screen off left which will then be switched to to display the text.  
;+++++++++

;++++++++++++++++++++++++++++++++++++++++++++++++
;Show Number 2
;++++++++++++++++++++++++++++++++++++++++++++++++
show_number_2:
	set scroll $ff	
	return

;+++++++++
;Switch it back to the scene after drawing the text! 
;+++++++++

;++++++++++++++++++++++++++++++++++++++++++++++++
;Show Number 1
;++++++++++++++++++++++++++++++++++++++++++++++++
show_number_1:
	set scroll $00	
	return

;+++++++++
;This makes takes our Sprite data and pushes it onto the screen.  I totally ;messed up with this code, and have both this pushing action and all the ;calculations happen during the electron jump, which is silly, but somehow it ;kinda works, so I left it.  If I could do it again, I would definately have ;this happen outside of the electron jump (NMI),....I am stupid.
;+++++++++

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

;+++++++++
;This makes our Sprites (which are any character that can movie) un-visible.
;+++++++++

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

;+++++++++
;This makes our Sprites (which are any character that can movie) visible.
;+++++++++

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

;+++++++++
;These next two routines are for loading what colors go where on the Nitnendo
;+++++++++

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

;+++++++++
;This is our routine which actually loads the colors
;+++++++++
			
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

;+++++++++
;This is a routine which I am not sure I am using anymore.  It was susposed to ;draw scenes from the original game that I took from a disassembler.  Funny huh?  ;It was for the first ending of the movie, but I think I deleted it and added ;the white ending........
;+++++++++

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

;+++++++++
;This is my ULTRA mega load background routine.  It loads a backinto an area of ;the nitnendos RAM which I have set up.  But it doesnt stire the exact ;background.  It stores pointers to 4 * 4 blocks which are defined by us.  This ;information is extracted from a RLE compressed file format I set up.  This is a ;super simple form of compression.  For example instead of 5 bytes to store a ;black block, I say repeat something 5 times.  Cool!!!!!!!   
;+++++++++

	
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

;+++++++++
;This is the routine that takes the information fromt the load background and ;turns it into a background and then draws it to the screen.  
;+++++++++

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
;Clear Screen,...............
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
	

;+++++++++
;This routine is our routine that draws text to the screen.  It is kinda like a ;typewriter.  
;+++++++++

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

;+++++++++
;This joystick routine simple makes it so we can advance through the scenes.  ;Like a DVD player.  Thats why I called it dvdcounter.  It also allows us to ;fast forward to the last scene which is the secret scene for the blocks.  
;+++++++++

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
;BEIGE music GLOBAL timer [for da Dj'zzzzzzz] this is our music engine I ;originall wrote for my project the IPOD.  
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

;+++++++++
;This is our NMI routine.  Here is where all the cool stuff happens.  basically ;the movie does its thing which basically turns on and off flags and the NMI ;routine deals with these flags.  The NMI routine is the space during the ;electron beam jump that the Nintendo has for drawing to the screen.  So here is ;where we actually do the hard work.  This also kinda sucks cause we only have ;so much time during this jump or the screen will flicker.  Actually if you ;watch the movie enough times, you will actually see the screen flicker which is ;funny.  This means I am trying to do too much.  But since the movie is kinda ;about the Nintendo breaking, I though this was OK to leave in.  Bugs and ;all........
;+++++++++

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
;Reset all parameters for scenes!,...this is our reset for inbetween scenes.   
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
;Cool music settings,...this is our music breakdown settings.  
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
;Draw Text All,......to be honest, i cant remember what this does.  
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
;checks to C if Mario falls off bottom of screen
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
;checks to C if Mario disappear
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
	
;+++++++++++++++++
;ok here is where our movie gets played out.  All the code is written linerally.  ;First I set the music, then draw the colors, the assign the colors, then draw 2 ;backgrounds, then draw the sprites, then animate the sprites, and set any ;special color stuff that the scene needs to operate.  I do this for every scene ;so this is why the movie gets so big so quick.  So see if you can follow ;along!!!! 
;+++++++++++++++++++
	
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
;Here is where we import all our data for the music, backgrounds, sprites, and ;animation!!!!! yah!!!!!!!!
;+++++++++++++++++++

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
	.incbin "bridge18.nes"

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
	.bank 4
	.org $0000

    .incbin "mario.chr"  ;gotta be 8192 bytes long

endasm

;++++++++++++++++++++++++++++++++++++++++++++++++
;Include Files Stores on Disk ordered from A-Z
;++++++++++++++++++++++++++++++++++++++++++++++++

;+++++++++++++++++++++++++++++++++++
; aaliyah4.nes

0000000 0101 0160 225a 4344 0101 0101 0001 0101
0000010 0001 0101 0001 0101 4a4a 274a 0101 0101
0000020 0001 0101 0101 0101 0101 0101 0101 0101
0000030 4848 1748 0101 0101 5050 2750 5353 2753
0000040 0101 0101 0101 0101 5252 2a52 0101 0101
*
0000060 0101 0101 0101 0101 0101 2a50 0101 0101
0000070 5257 3a52 0101 0101 5752 2a57 5363 3a53
0000080 0101 0101 0101 0101 5050 3050 0101 0101
0000090 0101 0101 0101 0101 5040 2050 0101 0101
00000a0 0101 0101 0101 0101 0101 0101 0101 0101
00000b0 4848 4048 0101 0101 5040 2050 5350 2053
00000c0 0101 0101 0101 0101 5257 1852 0101 0101
00000d0 0101 0101 0101 0101 5057 2850 0101 0101
00000e0 0101 0101 0101 0101 4858 2a48 0101 0101
00000f0 0101 0101 0101 0101 4555 2a45 0101 0101
0000100 5040 5550 0101 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; backgroundtextintro1.txt

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 6173 2061 2076 6964 656f 2067
0000020 616d 6520 2020 2020 6772 6f77 7320 6f6c
0000030 6420 2020 2020 2020 2020 2020 6974 7320
0000040 636f 6e74 656e 7420 616e 6420 2020 2020
0000050 696e 7465 726e 616c 206c 6f67 6963 2020
0000060 2020 2020 6465 7465 7269 6f72 6174 65ff
0000070

;+++++++++++++++++++++++++++++++++++
; backgroundtextintro2.txt

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 666f 7220 6120 6368 6172 6163
0000020 7465 7220 2020 2020 6361 7567 6874 2069
0000030 6e20 7468 6973 2020 2020 2020 6272 6561
0000040 6b64 6f77 6e20 2020 2020 2020 2020 2020
0000050 7072 6f62 6c65 6d73 2061 6666 6563 7420
0000060 2020 2020 6576 6572 7920 6172 6561 206f
0000070 6620 6c69 6665 ff00                    
0000077

;+++++++++++++++++++++++++++++++++++
; bg10.txt

0000000 6d61 7269 6f08 206f 6820 2020 2020 2020
0000010 2020 2020 2020 2020 2020 2020 2020 2020
0000020 2020 2020 2020 2020 6d75 7368 726f 6f6d
0000030 2020 6c6f 6f6b 2075 2020 2020 6e65 6564
0000040 2074 6f20 7461 6c6b 2074 6f20 2020 2020
0000050 7261 7374 6572 2062 6c61 7374 6572 2020
0000060 2020 2020 6865 2069 7320 7468 6520 676f
0000070 6420 6865 7265 2020 6920 6865 6172 2068
0000080 6520 6973 2064 6a69 6e67 2020 7468 6520
0000090 6576 696c 7261 7665 2074 6f6e 6967 6874
00000a0 696c 6c20 7461 6b65 2075 2074 6865 7265
00000b0 ff00                                   
00000b1

;+++++++++++++++++++++++++++++++++++
; bgtext.txt

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 2270 6f65 7472 7920 6a6f 7572
0000020 6e61 6c20 6461 7920 6f6e 653a 2076 6964
0000030 656f 2067 616d 6520 6869 7374 6f72 792c
0000040 2066 6f72 7469 6669 6564 206d 7973 7465
0000050 7279 2c20 7065 7472 6966 6965 642c 206d
0000060 7973 7465 7279 22ff                    
0000068

;+++++++++++++++++++++++++++++++++++
; bgtext.txt2

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 7374 616e 6469 6e67 2068 6572
0000020 6520 6f72 2c20 6a75 6d70 696e 6720 7768
0000030 6572 652c 2068 6f77 2064 6964 2069 2067
0000040 6574 2068 6572 653f 3f3f 3f3f ff00     
000004d

;+++++++++++++++++++++++++++++++++++
; bgtext.txt3

0000000 2020 2020 2020 2020 2020 2020 2020 2020
*
0000040 2073 6372 6577 2069 7420 2020 2020 2020
0000050 2020 2020 20ff                         
0000056

;+++++++++++++++++++++++++++++++++++
; bgtext.txt3a

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 224c 6f73 7420 7069 7a7a 6173
0000020 2c20 776f 726c 6420 7265 7669 7369 6f6e
0000030 732c 206c 616e 6473 6361 7065 206c 6f72
0000040 6e2c 2077 6861 7420 6973 2066 6f72 2c20
0000050 6576 6572 22ff                         
0000056

;+++++++++++++++++++++++++++++++++++
; bgtext.txt4

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 5768 6572 6520 6973 206c 7569
0000020 6769 2c20 5468 6520 7175 6573 7469 6f6e
0000030 206d 6172 6b20 7969 656c 6473 206e 6f74
0000040 6869 6e67 2062 7574 206e 6f69 7365 2020
0000050 7768 656e 2073 6d61 7368 6564 2062 7920
0000060 6d79 2020 2068 6561 6422 ff00          
000006b

;+++++++++++++++++++++++++++++++++++
; bgtext.txt5

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 3537 3435 3772 6668 2020 3939
0000020 3920 6120 2066 6438 3938 3738 3838 3838
0000030 3838 3838 3838 3838 3838 3838 3838 3838
*
0000060 3838 3838 ff00                         
0000065

;+++++++++++++++++++++++++++++++++++
; bgtext.txt6

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 7768 7920 616d 2069 2072 756e
0000020 6e69 6e67 2079 6f75 6173 6bff          
000002c

;+++++++++++++++++++++++++++++++++++
; bgtext.txt7

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 224d 696e 7574 6573 2070 6173
0000020 732c 2061 2070 756e 6b20 6261 6e64 2c20
0000030 6d6f 6d65 6e74 7320 6c61 7374 2c20 6365
0000040 6e74 7572 6965 7322 ff00               
0000049

;+++++++++++++++++++++++++++++++++++
; bgtext.txt7a

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 6920 7573 6564 2074 6f20 6320
0000020 6661 6d69 6c69 6172 7368 6170 6573 2069
0000030 6e20 7468 6520 636c 6f75 6473 2020 2020
0000040 2020 3233 7220 2020 2020 2020 2020 2020
0000050 206e 6f77 2074 682e f3f3 4f39 4f34 f34f
0000060 34f9 f40f 2261 732c 646e 6173 6d64 6e61
0000070 732c 6d64 7878 7820 6869 7374 6f72 792c
0000080 2066 6f72 7469 6669 6564 206d 7973 7465
0000090 7279 22ff                              
0000094

;+++++++++++++++++++++++++++++++++++
; bgtext.txt8

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 2274 6865 206d 6173 7465 7220
0000020 7469 6d65 2063 6c6f 636b 2069 7320 736f
0000030 2063 6f72 7275 7074 206d 7920 6d65 3435
0000040 376f 7269 6573 2070 726f 7669 6465 206e
0000050 6f20 7265 6173 6f6e 2066 6f72 2061 6e79
0000060 3737 3737 7468 696e 6722 3334 3633 3435
0000070 3634 3536 3734 3537 ff00               
0000079

;+++++++++++++++++++++++++++++++++++
; bgtext.txt9

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 3434 3434 3434 3434 3434 3434
0000020 3434 796f 7576 6520 6265 656e 696e 2020
0000030 736f 6d65 6f6e 6573 2063 6c6f 7365 7420
0000040 666f 7220 7477 656e 7479 2079 6534 7273
0000050 206f 6620 636f 7572 7365 2074 6865 2064
0000060 6174 6120 6920 7320 6d65 6c74 6936 3636
0000070 6e34 3534 3667 6767 ff00               
0000079

;+++++++++++++++++++++++++++++++++++
; bgtext.txt10

0000000 2020 2020 2020 2034 3534 3534 3534 3534
0000010 3533 3472 2243 6f6d 6520 7769 7468 206d
0000020 652c 2069 7420 6973 2061 2073 7069 7269
0000030 7420 7261 7665 206c 6561 726e 696e 6720
0000040 6e6f 6973 6520 6e69 7465 2245 4545 45ff
0000050

;+++++++++++++++++++++++++++++++++++
; bgtext.txt11

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 2022 6d61 6769 6320 6d6f 756e
0000020 7461 696e 2069 7320 6e6f 7420 7468 6520
0000030 7361 6d65 2074 6869 6e67 2061 7320 6861
0000040 756e 7465 6420 6361 7374 6c65 2220 7265
0000050 ff00                                   
0000051

;+++++++++++++++++++++++++++++++++++
; bgtext.txt12

0000000 2020 2020 2020 2435 2345 2452 3452 3452
0000010 4625 6345 2274 6869 7320 6973 2074 6865
0000020 2072 6176 6522 202a 4564 5645 6457 5675
0000030 4768 5678 4576 3456 2345 2345 2452 5463
0000040 7456 7456 3456 3456 2435 2345 2345 2234
0000050 0504 ff00                              
0000053

;+++++++++++++++++++++++++++++++++++
; bgtext.txt14

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 2274 6869 7320 776f 726c 6420
0000020 6973 2073 7472 6f62 696e 6720 6d65 206f
0000030 7574 2222 736f 6d65 7468 696e 6773 2068
0000040 6170 7065 6e69 6e67 2069 6e20 6d79 2062
0000050 7261 696e 2c20 6927 6d20 6861 7669 6e67
0000060 2061 202d 2d2d 6178 2c6d 616e 7861 6e78
0000070 7878 7820 2aff                         
0000076

;+++++++++++++++++++++++++++++++++++
; bgtext.txt15

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 2279 6573 2c20 796f 7572 2070
0000020 6f65 7472 7920 6861 7320 7072 6570 6172
0000030 6564 2079 6f75 2077 656c 6c2c 2020 2020
0000040 2020 2020 2020 2020 2020 2020 2020 2020
0000050 0d74 6869 7320 6973 2079 6f75 7220 652d
0000060 0d79 6f75 2061 7265 2063 6f6e 6672 6f6e
0000070 7469 6e67 2079 6f75 7220 656e 6572 6779
0000080 2220 ff00                              
0000083

;+++++++++++++++++++++++++++++++++++
; bgtext.txt16

0000000 2020 2020 2020 2020 2020 2020 2020 2020
0000010 2020 2020 7468 6520 6461 7461 2e2e 2e2e
0000020 2e69 7473 2f2f 2f2f 2f2f 732f 6466 7364
0000030 6673 6466 7364 6673 6420 7468 6520 6461
0000040 7461 2e2e 2e2e 2e69 7473 2f2f 2f2f 2f2f
0000050 732f 6466 7364 6673 6466 7364 6673 6420
0000060 7468 6520 6461 7461 2e2e 2e2e 2e69 7473
0000070 2f2f 2f2f 2f2f 732f 6466 7364 6673 6466
0000080 7364 6673 6420 7468 6520 6461 7461 2e2e
0000090 2e2e 2e69 7473 2f2f 2f2f 2f2f 732f 6466
00000a0 7364 6673 6466 7364 6673 6420 7468 6520
00000b0 6461 7461 2e2e 2e2e 2e69 7473 2f2f 2f2f
00000c0 2f2f 732f 6466 7364 6673 6466 7364 6673
00000d0 6420 20ff                              
00000d4

;+++++++++++++++++++++++++++++++++++
; bgtext.txt17

0000000 6461 6e63 696e 6764 616e 6369 6e67 6461
0000010 6e63 696e 6764 616e 6369 6e67 6461 6e63
0000020 696e 6764 616e 6369 6e67 6461 6e63 696e
0000030 6764 616e 6369 6e67 6461 6e63 696e 6764
0000040 616e 6367 696e 6764 616e 6369 6e67 6461
0000050 6e63 696e 6764 616e 6369 6e67 6461 6e63
0000060 696e 6764 616e 6369 6e67 6461 6e63 696e
0000070 6764 616e 6369 6e67 6461 6e63 696e 6764
0000080 616e 6369 6e67 6461 6e63 6769 6e67 6461
0000090 6e63 696e 6764 616e 6369 6e67 6461 6e63
00000a0 696e 6764 616e 6369 6e67 6461 6e63 696e
00000b0 6764 616e 6369 6e67 6461 6e63 696e 6764
00000c0 616e 6369 6e67 6461 6e63 696e 6764 616e
00000d0 6367 696e 67ff                         
00000d6

;+++++++++++++++++++++++++++++++++++
; bootyA12.nes

0000000 628b 22b9 99ff 44ff 3a42 4250 0130 0101
0000010 3a00 0101 0100 0101 4a30 0120 0131 0101
0000020 4a43 4350 0143 0101 3a00 0101 0100 0101
0000030 2a00 0150 0143 0101 3a00 0120 0043 0101
0000040 3a00 0100 0034 0101 3940 4050 0040 0101
0000050 3900 0100 0000 0101 4940 0120 0040 0101
0000060 3900 0150 0041 0101 3a00 0100 0040 0101
0000070 3a00 0101 0040 0101 3900 0120 0031 0101
0000080 3a40 0101 0040 0101 4047 4750 0030 0101
0000090 3a00 0101 0000 0101 5047 0120 0048 0101
00000a0 4000 4850 0001 0101 2a00 0101 0048 0101
00000b0 2000 0150 0048 0101 4000 0120 0048 0101
00000c0 2a00 0101 0034 0101 2945 4550 0045 0101
00000d0 2a00 0101 0000 0101 4945 0120 0000 0101
00000e0 2a00 0101 0000 0101 2945 0150 0000 0101
00000f0 2a00 0150 0000 0101 3930 0120 0000 0101
0000100 2a32 0101 0031 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; bootyA13.nes

0000000 628b bbbb 99ff 44ff 3a42 4250 0130 0101
0000010 3a00 0101 0100 0101 4a30 0120 0131 0101
0000020 4a43 4350 0143 0101 3a00 0101 0100 0101
0000030 2a00 0150 0143 0101 3a00 0120 0043 0101
0000040 3a00 0100 0034 0101 3940 4050 0040 0101
0000050 3900 0100 0000 0101 4940 0120 0040 0101
0000060 3900 0150 0041 0101 3a00 0100 0040 0101
0000070 3a00 0101 0040 0101 3900 0120 0031 0101
0000080 3a40 0101 0040 0101 4047 4750 0030 0101
0000090 3a00 0101 0000 0101 5047 0120 0048 0101
00000a0 4000 4850 0001 0101 2a00 0101 0048 0101
00000b0 2000 0150 0048 0101 4000 0120 0048 0101
00000c0 2a00 0101 0034 0101 2945 4550 0045 0101
00000d0 2a00 0101 0000 0101 4945 0120 0000 0101
00000e0 2a00 0101 0000 0101 2945 0150 0000 0101
00000f0 2a00 0150 0000 0101 3930 0120 0000 0101
0000100 2a32 0101 0031 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; bootyC14.nes

0000000 628b 22b9 227f 44ff 3a42 4250 0030 0101
0000010 0000 0100 0000 0101 4a30 0120 0031 0101
0000020 0143 4350 0143 0101 0000 0101 0000 0101
0000030 2a00 0150 0043 0101 3a00 0120 0043 0101
0000040 0000 0100 0034 0101 3940 4050 0040 0101
0000050 0000 0100 0000 0101 4940 0120 0040 0101
0000060 3900 0150 0041 0101 0000 0100 0040 0101
0000070 0000 0101 0040 0101 3900 0120 0031 0101
0000080 0040 0101 0040 0101 4047 4750 0030 0101
0000090 0000 0100 0000 0101 5047 0120 0048 0101
00000a0 4000 4850 0001 0101 0000 0100 0048 0101
00000b0 2000 0150 0048 0101 4000 0120 0048 0101
00000c0 0000 0100 0034 0101 2945 4550 0045 0101
00000d0 0000 0100 0000 0101 4945 0120 0000 0101
00000e0 0000 0100 0000 0101 2945 0150 0000 0101
00000f0 0000 0100 0000 0101 3930 0120 0000 0101
0000100 0032 0100 0031 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; bridge18.nes


0000000 157f 157f 017f 36ba 3550 2700 0101 0121
0000010 0101 3731 0101 0141 3550 2751 0101 0161
0000020 334a 3771 0101 0181 3752 2791 0101 0122
0000030 3249 3710 0101 0111 0101 2712 0101 0113
0000040 0101 3714 0101 0115 3249 2a16 0101 0117
0000050 0101 3a18 0101 0119 3249 2a20 0101 0121
0000060 3045 3a22 0101 0123 333a 2a24 0101 0125
0000070 2a35 3a26 0101 0127 0101 2a28 0101 0129
0000080 0101 3a30 0101 0131 3550 2700 0101 0121
0000090 0101 3731 0101 0141 3550 2751 0101 0161
00000a0 334a 3771 0101 0181 3752 2791 0101 0122
00000b0 3249 3710 0101 0111 0101 2712 0101 0113
00000c0 0101 3714 0101 0115 3249 2a16 0101 0117
00000d0 0101 3a18 0101 0119 3249 2a20 0101 0121
00000e0 3045 3a22 0101 0123 334a 2a24 0101 0125
00000f0 0101 3a26 0101 0127 0101 2a28 0101 0129
0000100 0101 3a30 0101 0131 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; bridgedrums19.nes

0000000 157f 157f 337f 44ff 3550 2550 0101 0133
0000010 0101 0134 0101 0135 3550 4520 0101 0137
0000020 334a 1550 0101 0139 3752 0101 0101 0101
0000030 3249 5550 0101 0101 0101 5a20 0101 0113
0000040 0101 5901 0101 0101 3249 2550 0101 0101
0000050 0101 0101 0101 0101 3249 1520 0101 0101
0000060 3045 1550 0101 0101 333a 0101 0101 0101
0000070 2a35 5550 0101 0101 0101 6220 0101 0113
0000080 0101 6001 0100 0101 3550 1550 0101 0133
0000090 0101 0134 0101 0135 3550 4520 0101 0137
00000a0 334a 3750 0101 0139 3752 0101 0101 0101
00000b0 3249 5550 0101 0101 0101 5a20 0101 0101
00000c0 0101 5901 0101 0101 3249 0150 0101 0101
00000d0 0101 0101 0101 0101 3249 0120 0101 0101
00000e0 3045 5950 0101 0155 333a 5701 0101 0157
00000f0 0101 0150 0101 0159 0101 0120 0101 1561
0000100 0101 0162 0100 0163 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; climaxarpeggio20.nes

0000000 157f 157f 337f 44ff 3348 1350 0101 0101
0000010 0101 3301 0101 0101 3301 6320 0101 0101
0000020 3201 6250 0101 0101 354a 1520 0101 0101
0000030 3501 3550 0101 0101 0101 6550 0101 0101
0000040 0101 2550 0101 0101 354a 1550 0101 0101
0000050 0101 3550 0101 0101 3501 1550 0101 0101
0000060 3301 6350 0101 0101 3750 6720 0101 0101
0000070 3701 3750 0101 0101 0101 1750 0101 0113
0000080 0101 3750 0100 0101 3750 6750 0101 0133
0000090 0101 3750 0101 0135 3701 1750 0101 0137
00000a0 3501 3750 0101 0139 3952 6920 0101 0101
00000b0 3901 3950 0101 0101 0101 1950 0101 0101
00000c0 0101 3950 0101 0101 3952 1950 0101 0150
00000d0 0101 3901 0101 0101 3901 6920 0101 0101
00000e0 3701 6750 0101 0155 0101 1701 0101 0157
00000f0 0000 0150 0101 0159 0101 0120 0101 0161
0000100 0101 0162 0100 0163 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; cory17.nes


0000000 017f 157f 4477 36ba 334a 3000 2001 2021
0000010 1001 1031 1001 2041 334a 4a51 1a01 3a61
0000020 3701 3771 1701 2781 1701 1791 5701 2722
0000030 3801 4810 1801 3811 2001 5012 3301 5313
0000040 1701 3714 5701 2715 2752 5216 2201 4217
0000050 1a01 3a18 3a01 2a19 3201 5220 1201 4221
0000060 1a01 3a22 4353 2a23 2b01 1a24 5a01 2a25
0000070 3201 5226 1201 4227 3557 5728 5301 5329
0000080 1a01 3a30 2a01 2a31 1050 5032 4001 4033
0000090 2001 3034 2001 2035 3001 5036 4001 4037
00000a0 3001 3038 2001 2039 1001 1040 2001 2041
00000b0 2801 4842 3801 3843 5001 5044 1301 5345
00000c0 4301 4346 3301 3347 3057 5248 4101 4149
00000d0 3801 3850 2801 2851 3057 5052 4001 4053
00000e0 1801 3854 3801 2855 1858 4856 5801 3857
00000f0 3a01 3a58 2a01 2a59 2a55 4560 3501 3561
0000100 1001 5062 4001 4063 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; crazy6.nes

0000000 0ffa 0160 225a 4344 0101 0101 0001 0101
0000010 0001 0101 0001 0101 4a5a 274a 0101 0101
0000020 0001 0101 0101 0101 0101 0101 0101 0101
0000030 4845 1748 0101 0101 5040 2750 5347 2753
0000040 0101 0101 0101 0101 5257 2a52 0101 0101
0000050 0101 0101 0101 0101 525a 2a52 0101 0101
0000060 0101 0101 0101 0101 0101 2a50 0101 0101
0000070 5257 3a52 0101 0101 5752 2a57 5363 3a53
0000080 0101 0101 0101 0101 5055 3050 0101 0101
0000090 0101 0101 0101 0101 5040 2050 0101 0101
00000a0 0101 0101 0101 0101 0101 0101 0101 0101
00000b0 4855 4048 0101 0101 5055 2050 5340 2053
00000c0 0101 0101 0101 0101 5257 1852 0101 0101
00000d0 0101 0101 0101 0101 5057 2850 0101 0101
00000e0 0101 0101 0101 0101 4855 2a48 0101 0101
00000f0 0101 0101 0101 0101 4558 2a45 0101 0101
0000100 5040 5550 0101 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; crazy7.nes

0000000 b5f5 b5f5 225a aa47 4a4a 2050 0001 0101
0000010 0001 2001 0001 0101 4a4a 2020 0100 0101
0000020 0001 2001 0101 0101 4a4a 2050 0101 0101
0000030 0101 2001 0101 0101 4a4a 2001 0101 2001
0000040 4a4a 2001 0101 0101 4a4b 2050 0001 0101
0000050 4a01 2001 0001 0101 4a4b 2020 0100 0101
0000060 0001 2001 0101 0101 4a4c 2050 4a01 0101
0000070 4a01 2001 0101 0101 4a4c 2001 0101 2001
0000080 4a4d 2001 0101 0101 5055 2350 0101 0101
0000090 0101 2300 0101 0101 5040 2320 0101 0101
00000a0 0101 2350 0101 0101 0101 2301 0101 0101
00000b0 4855 2350 0101 0101 5055 2320 5340 2301
00000c0 0101 2301 0101 0101 5055 2750 0101 0101
00000d0 0101 2750 0101 0101 5040 2720 0101 0101
00000e0 0101 2750 0101 0101 0101 2701 0101 0101
00000f0 0101 2727 0101 0127 0101 2727 0101 2701
0000100 0101 2727 0101 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; crazy8.nes

0000000 b5f5 b5f5 225a 43ff 4a4a 2050 0001 0101
0000010 0001 2001 0001 0101 4a4a 2020 0100 0101
0000020 0001 2001 0101 0101 4a4a 2050 0101 0101
0000030 0101 2001 0101 0101 4a4a 2001 0101 2001
0000040 4a4a 2001 0101 0101 4a4b 2050 0001 0101
0000050 4a01 2001 0001 0101 4a4b 2020 0100 0101
0000060 0001 2001 0101 0101 4a4c 2050 4a01 0101
0000070 4a01 2001 0101 0101 4a4c 2001 0101 2001
0000080 4a4d 2001 0101 0101 5055 2350 0101 0101
0000090 0101 2300 0101 0101 5040 2320 0101 0101
00000a0 0101 2350 0101 0101 0101 2301 0101 0101
00000b0 4855 2350 0101 0101 5055 2320 5340 2301
00000c0 0101 2301 0101 0101 5055 2750 0101 0101
00000d0 0101 2750 0101 0101 5040 2720 0101 0101
00000e0 0101 2750 0101 0101 0101 2701 0101 0101
00000f0 0101 2727 0101 0127 0101 2727 0101 2701
0000100 0101 2727 0101 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; end.txt

0000000 7468 6520 656e 6420 7468 6520 656e 6478
0000010 6367 6767 6767 6774 6865 2065 6e64 2074
0000020 6865 2065 6e64 7863 6767 6767 6767 7468
0000030 6520 656e 6420 7468 6520 656e 6478 6367
0000040 6767 6767 6774 6865 2065 6e64 2074 6865
0000050 2065 6e64 7863 6767 6767 6767 7468 6520
0000060 656e 6420 7468 6520 656e 6478 6367 6767
0000070 6767 6774 6865 2065 6e64 2074 6865 2065
0000080 6e64 7863 6767 6767 6767 7468 6520 656e
0000090 6420 7468 6520 656e 6478 6367 6767 6767
00000a0 67ff                                   
00000a2

;+++++++++++++++++++++++++++++++++++
; ending2.hex

0000000 2424 2424 2424 2424 2424 2424 2424 2424
*
0000040 2424 1d11 0e24 0e17 0d24 2424 2424 2424
0000050 2424 2424 2424 2424 2424 2424 2424 2424
*
00000d0 2424 3637 2424 2424 2424 2424 2424 2424
00000e0 2424 2424 2424 2424 2424 2424 2424 2424
00000f0 2435 2525 3824 2424 2424 2424 2424 2424
0000100 2424 2424 2424 2424 2424 2424 2424 2424
0000110 2439 3a3b 3c24 2424 2424 2424 2424 2424
0000120 2424 2424 2424 2424 2424 2424 2424 2424
*
00002a0 2424 2424 3132 2424 2424 2424 2424 2424
00002b0 2424 2424 2424 2424 2424 2424 2424 2424
00002c0 2424 2430 2634 3324 2424 2424 2424 2424
00002d0 2424 2424 2424 2424 2424 2424 2424 2424
00002e0 2424 3026 2626 2633 2424 2424 2424 2424
00002f0 2424 2424 2424 2424 2424 2424 2424 2424
0000300 2430 2634 2626 3426 3324 2424 2424 2424
0000310 2424 2424 2424 2424 3637 3637 3637 2424
0000320 3026 2626 2626 2626 2633 2424 2424 2424
0000330 2424 2424 2424 2435 2525 2525 2525 3824
0000340 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5
*
0000360 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7
*
0000380 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5
*
00003a0 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7
*
00003c0 aaaa eaaa aaaa aaaa 0000 0000 a020 0000
00003d0 0000 0000 0a02 0000 0000 0000 0000 0000
00003e0 0000 0000 0000 0000 0000 0000 0000 0000
00003f0 5050 5050 5050 5050 0505 0505 0505 0505
0000400 2424 2424 2424 2424 2424 2424 2424 2424
*
0000480 2424 2424 2424 2424 3637 2424 2424 2424
0000490 2424 2424 2424 2424 2424 2424 2424 2424
00004a0 2424 2424 2424 2435 2525 3824 2424 2424
00004b0 2424 2424 2424 2424 2424 2424 2424 2424
00004c0 2424 2424 2424 2439 3a3b 3c24 2424 2424
00004d0 2424 2424 2424 2424 2424 2424 2424 2424
*
0000540 2424 2424 2424 2424 2424 2424 5354 2424
0000550 2424 2424 2424 2424 2424 2424 2424 2424
0000560 2424 2424 2424 2424 2424 2424 5556 2424
0000570 2424 2424 2424 2424 2424 2424 2424 2424
*
0000640 5354 2424 2424 2424 4545 5354 4545 5354
0000650 2424 2424 2424 2424 2424 2424 2424 2424
0000660 5556 2424 2424 2424 4747 5556 4747 5556
0000670 2424 2424 2424 2424 2424 2424 2424 2424
*
00006e0 2424 3132 2424 2424 2424 2424 2424 2424
00006f0 2424 2424 2424 2424 2424 2424 2424 2424
0000700 2430 2634 3324 2424 2424 2424 2424 2424
0000710 2424 2424 2424 2424 2424 2424 2424 2424
0000720 3026 2626 2633 2424 2424 2424 2424 2435
0000730 2424 2424 2424 2424 2424 2424 2424 2424
0000740 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5
0000750 2424 2424 2424 2424 2424 2424 2424 2424
0000760 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7
0000770 2424 2424 2424 2424 2424 2424 2424 2424
0000780 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5 b4b5
0000790 2424 2424 2424 2424 2424 2424 2424 2424
00007a0 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7 b6b7
00007b0 2424 2424 2424 2424 2424 2424 2424 2424
00007c0 0000 0000 0000 0000 0088 aa00 0000 0000
00007d0 0000 0030 0000 0000 0000 0000 0000 0000
00007e0 3000 d0d0 0000 0000 0000 0000 0000 0000
00007f0 5050 5050 0000 0000 0505 0505 0000 0000
0000800

;+++++++++++++++++++++++++++++++++++
; falling3.nes

0000000 777f 737f 8f7f 44ff 5050 3030 0001 0130
0000010 4a01 2001 0001 0101 4857 3320 0001 0101
0000020 4701 2330 0001 0101 4553 3701 0001 0101
0000030 4301 2730 0001 0101 4255 3520 0001 0101
0000040 4001 2500 0001 0101 5050 3850 0001 0101
0000050 4a01 2800 0001 0101 4858 3720 0001 0101
0000060 4701 2750 0001 0101 4558 3701 0001 0101
0000070 4301 2750 0001 0101 4257 3320 0001 0101
0000080 4001 2300 0001 0101 5050 3050 0001 0101
0000090 4a01 2000 0001 0101 4857 3310 0001 0101
00000a0 4701 2350 0001 0101 4553 3701 0001 0101
00000b0 4301 2750 0001 0101 4255 3520 0001 0101
00000c0 4001 2500 0001 0101 5050 3350 0001 0101
00000d0 4a01 2300 0001 0101 4858 3510 0001 0101
00000e0 4701 2550 0001 0101 4558 3101 0001 0101
00000f0 4301 2150 0001 0101 4757 3300 0001 0100
0000100 0001 0001 0101 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; fallingreverb2.nes

0000000 777f 737f 8f7f 44ff 5050 3030 0101 0130
0000010 4a01 2001 0101 0101 4857 3320 0101 0101
0000020 4701 2330 0101 0101 4553 3701 0101 0101
0000030 4301 2730 0101 0101 4255 3520 0101 0101
0000040 4001 2500 0101 0101 5050 3850 0101 0101
0000050 4a01 2800 0101 0101 4858 3720 0101 0101
0000060 4701 2750 0101 0101 4558 3701 0101 0101
0000070 4301 2750 0101 0101 4257 3320 0101 0101
0000080 4001 2300 0101 0101 5050 3050 0101 0101
0000090 4a01 2000 0101 0101 4857 3310 0101 0101
00000a0 4701 2350 0101 0101 4553 3701 0101 0101
00000b0 4301 2750 0101 0101 4255 3520 0101 0101
00000c0 4001 2500 0101 0101 5050 3350 0101 0101
00000d0 4a01 2300 0101 0101 4858 3510 0101 0101
00000e0 4701 2550 0101 0101 4558 3101 0101 0101
00000f0 4301 2150 0101 0101 4757 3300 0101 0100
0000100 0000 0001 0101 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; freeq.dat

0000000 097f 897f 8f7f 41ff cd1e 00d0 0160 ce1c
0000010 00a9 00cd 1c00 b003 0f00               
0000019

;+++++++++++++++++++++++++++++++++++
; frequzzz2.hex


0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0000020 f10f 880f 0b0f b80e 540e fb0d 990d 530d
0000030 050d bf0c 740c 330c 0000 0000 0000 000f
0000040 f80b bb0b 8c0b 550b 240b f80a cc0a a50a
0000050 7e0a 5c0a 3a0a 190a 0000 0000 0000 0000
0000060 fb09 df09 c409 aa09 9309 7b09 6709 5309
0000070 4009 2d09 1c09 0d09 0000 0000 0000 0000
0000080 fd08 ef08 e108 d508 c908 be08 b308 a908
0000090 9f08 9608 8e08 8608 0000 0000 0000 0000
00000a0 7e08 7708 7008 6a08 6408 5e08 5908 5408
00000b0 4f08 4b08 4608 4208 0000 0000 0000 0003
00000c0 3f08 3b08 3808 3408 3108 2f08 2c08 2908
00000d0 2708 2508 2308 2108 0000 0000 0000 0000
00000e0

;+++++++++++++++++++++++++++++++++++
; grime11.nes

0000000 b5f5 b5f5 225a aa47 4a4a 0150 0001 0101
0000010 0101 0101 0101 0101 3434 0120 0101 0101
0000020 3535 0150 0101 0101 0101 0101 0101 0101
0000030 0101 0101 0101 0101 0101 0110 0101 0101
0000040 0101 0101 0101 0101 4a4a 0150 0001 0101
0000050 0101 0101 0101 0101 3434 0120 0101 0101
0000060 3535 0150 0101 0101 0101 0101 0101 0101
0000070 0101 0110 0101 0101 0101 0127 0101 0101
0000080 0101 0127 0101 0101 5055 0150 0000 0001
0000090 0101 0100 0101 0101 5040 0120 0000 0101
00000a0 0101 0150 0101 0101 0101 0101 0101 0101
00000b0 4855 0150 0101 0101 5055 0120 5340 0101
00000c0 0101 0101 0000 0101 5055 0150 0101 0101
00000d0 0000 0150 0101 0101 5040 0120 0101 0101
00000e0 0101 0150 0101 0110 0101 0101 0101 0101
00000f0 0101 0127 0101 0127 0101 0127 0101 0101
0000100 0101 0127 0101 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; harmony16.nes

0000000 157f 157f 017f 36ba 334a 2700 0101 0121
0000010 0101 3731 0101 0141 334a 2751 0101 0161
0000020 0101 3771 0101 0181 0101 2791 0101 0122
0000030 0101 3710 0101 0111 0101 2712 0101 0113
0000040 0101 3714 0101 0115 3752 2a16 0101 0117
0000050 0101 3a18 0101 0119 0101 2a20 0101 0121
0000060 0101 3a22 3353 0123 0101 2a24 0101 0125
0000070 0101 3a26 0101 0127 3557 2a28 0101 0129
0000080 0101 3a30 0101 0131 3050 3032 0101 0133
0000090 0101 4034 0101 0135 0101 3036 0101 0137
00000a0 0101 4038 0101 0139 0101 3040 0101 0141
00000b0 0101 4042 0101 0143 0101 3044 0101 4045
00000c0 0101 0146 0101 0147 3057 2848 0101 0149
00000d0 0101 3850 0101 0151 3057 2852 0101 0153
00000e0 0101 3854 0101 0155 2858 2a56 0101 0157
00000f0 0101 3a58 0101 0159 2a55 2a60 0101 0161
0000100 0101 5562 0101 0163 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; harmonybass17.nes

0000000 157f 157f 4477 36ba 334a 3000 0101 2021
0000010 0101 1031 0101 2041 334a 4a51 0101 3a61
0000020 0101 3771 0101 2781 0101 1791 0101 2722
0000030 0101 4810 0101 3811 0101 5012 0101 5313
0000040 0101 3714 0101 2715 3752 5216 0101 4217
0000050 0101 3a18 0101 2a19 0101 5220 0101 4221
0000060 0101 3a22 3353 2a23 0101 1a24 0101 2a25
0000070 0101 5226 0101 4227 3557 5728 0101 5329
0000080 0101 3a30 0101 2a31 3050 5032 0101 4033
0000090 0101 3034 0101 2035 0101 5036 0101 4037
00000a0 0101 3038 0101 2039 0101 1040 0101 2041
00000b0 0101 4842 0101 3843 0101 5044 0101 5345
00000c0 0101 4346 0101 3347 3057 5248 0101 4149
00000d0 0101 3850 0101 2851 3057 5052 0101 4053
00000e0 0101 3854 0101 2855 2858 4856 0101 3857
00000f0 0101 3a58 0101 2a59 2a55 4560 0101 3561
0000100 0101 5062 0101 4063 0f00               
0000109


;+++++++++++++++++++++++++++++++++++
; mario.chr

0000000 030f 1f1f 1c24 2666 0000 0000 1f3f 3f7f
0000010 e0c0 80fc 80c0 0020 0020 6000 f0fc fefe
0000020 6070 1807 0f1f 3f7f 7f7f 1f07 001e 3f7f
0000030 fc7c 0000 e0f0 f8f8 fcfc f8c0 c267 2f37
0000040 7f7f ffff 0707 0f0f 7f7e fcf0 f8f8 f070
0000050 fdfe b4f8 f8f9 fbff 3736 5c00 0001 031f
0000060 1f3f ffff fc70 7038 0824 e3f0 f870 7038
0000070 ffff ff1f 0000 0000 1f1f 1f1f 0000 0000
0000080 0000 0107 0f0f 0e12 0000 0000 0000 0f1f
0000090 0000 f0e0 c0fe 4060 0000 0010 3000 f8fe
00000a0 1333 3018 040f 1f1f 1f3f 3f1f 0708 1717
00000b0 0010 7e3e 0000 c0e0 ffff fefe fce0 40a0
00000c0 3f3f 3f1f 1f1f 1f1f 3727 2303 0100 0000
00000d0 f0f0 f0f8 f8f8 f8f8 ccff ffff ff70 0008
00000e0 ffff fffe f0c0 8000 f0f0 f0f0 f0c0 8000
00000f0 fcfc f878 7878 7e7e 1060 8000 7878 7e7e
0000100 0003 0f1f 1f1c 2426 0000 0000 001f 3f3f
0000110 00e0 c080 fc80 c000 0000 2060 00f0 fcfe
0000120 6660 3018 0f1f 3f3f 7f7f 3f1f 0016 2f2f
0000130 20fc 7c00 00e0 e0f0 fefc fcf8 c060 2030
0000140 3f3f 3f3f 3f3f 3f1f 2f2f 2f0f 0703 0000
0000150 f090 0008 0c1c fcf8 10f0 f0f0 f0e0 c0e0
0000160 0f0f 0707 070f 0f03 0103 0104 070f 0f03
0000170 f8f0 e0f0 b080 e0e0 f8f0 e070 b080 e0e0
0000180 033f 7f19 0909 285c 0030 707f ffff f7f3
0000190 f8e0 e0fc 2630 8010 0018 1000 f8f8 feff
00001a0 3e1e 3f38 3030 003a e70f 0f1f 1f1f 0f07
00001b0 781e 80fe 7e7e 7f7f fffe fcc6 8eee ffff
00001c0 3c3f 1f0f 073f 2120 0300 000e 073f 3f3f
00001d0 ffff fffe fefe fc70 ff7f 3f0e c0c0 e0e0
00001e0 0f9f cfff 7f3f 1e0e 0080 c8fe 7f3f 1e0e
00001f0 20c0 8080 0000 0000 e000 0000 0000 0000
0000200 0000 030f 1f1f 1c24 0000 0000 0000 1f3f
0000210 0004 e6e0 ffff 8f83 0e1f 1f1f 1f03 ffff
0000220 2626 6078 180f 7fff 3f3f 7f7f 1f00 7eff
0000230 0121 fe7a 06fe fcfc ffff fefe fede 5c6c
0000240 ffcf 8707 070f 1f1f ffff fefc f8b0 6000
0000250 f8f8 f0b8 f8f9 fbff 2830 1840 0001 030f
0000260 1fff ffff fffe c080 10ec e3e0 e0e0 c080
0000270 ffff ff3f 0000 0000 0f0f 0f0f 0000 0000
0000280 1333 3018 040f 1f1f 1f3f 3f1f 0709 1317
0000290 0010 7e30 e0f0 f0e0 ffff feff fefc f8e0
00002a0 1f1f 0f0f 0f1f 1f1f 1717 0300 0000 0000
00002b0 f0f0 f8f8 b8f8 f8f8 d090 1808 4000 0000
00002c0 3fff ffff f6c6 8400 30f0 f0f1 f6c6 8400
00002d0 f0e0 8000 0000 0000 0000 0000 0000 0000
00002e0 1f1f 3f3f 1f0f 0f1f 1f1f 3f3e 7c78 f0e0
00002f0 f0f0 f8f8 b8f8 f8f0 b090 1808 4000 0000
0000300 e0f0 f0f0 f0f0 f8f0 c0e0 fcfe ff7f 0300
0000310 1f1f 1f3f 3e3c 3818 0000 1038 3e3c 3818
0000320 0003 0707 0a0b 0c00 0000 0007 0f0f 0f03
0000330 00e0 fc20 2010 3c00 0000 00f0 fcfe fcf8
0000340 0707 071f 1f3e 2101 070f 1b18 1030 2101
0000350 e0e0 e0f0 f0e0 c0e0 a8fc f800 0000 c0e0
0000360 070f 0e14 1618 003f 0000 0f1f 1f1f 073c
0000370 c0f8 4040 2078 00c0 0000 e0f8 fcf8 f0c0
0000380 3f0e 0f1f 3f7c 7038 fced c000 0060 7038
0000390 f0f8 e4fc fc7c 0000 7e1e 040c 0c0c 0000
00003a0 070f 0e14 1618 000f 0000 0f1f 1f1f 070d
00003b0 1f1f 1f1c 0c07 0707 1e1c 1e0f 0700 0707
00003c0 e060 f070 e0e0 f080 6090 0080 00e0 f080
00003d0 071f 3f12 1308 1f31 0010 3f7f 7f3f 030f
00003e0 c0f0 4000 3018 c0f8 0000 e0f8 fcf8 b038
00003f0 3139 1f1f 0f5f 7e3c 1f07 000e 0f53 7c3c
0000400 f8f8 f0e0 e0c0 0000 f8f8 f000 0080 0000
0000410 00e0 fc27 2711 3e04 0707 03f7 ffff fefc
0000420 3f7f 3f0f 1f3f 7f4f 3e7f ffe2 5038 7040
0000430 f8f9 f9b7 ffff e000 e871 014b 0303 0000
0000440 0707 0f3f 3f3f 2604 0503 0130 3030 2604
0000450 f0f0 f0e0 c000 0000 fefc e000 0000 0000
0000460 0707 0f1f 3f0f 1c18 0503 0110 300c 1c18
0000470 e0e0 e0e0 c080 0000 c0e0 f078 1808 0000
0000480 070f 1f0f 3f0f 1c18 070f 3e7c 300c 1c18
0000490 e0e0 e040 c080 0000 6060 6080 0000 0000
00004a0 7fff fffb 0f0f 0f1f 73f3 f0f4 f0f0 7060
00004b0 3f7e 7c7c 3c3c fcfc 0000 0000 3c3c fcfc
00004c0 6070 1808 0f1f 3f7f 7f7f 1f07 0b1b 3b7b
00004d0 fc7c 0020 f0f8 fcfe fcfc f8e0 d0d8 dcde
00004e0 0b0f 1f1e 3c3c 3c7c c4e0 e040 003c 3c7c
00004f0 1f3f 0d07 0f0e 1c3c 1d3c 3a38 3000 1c3c
0000500 0000 0000 0000 0000 2255 5555 5555 7722
0000510 0007 1fff 071f 0f06 0000 0000 0000 0000
0000520 3fff ffff ffff fb76 0000 cf07 7f00 0000
0000530 20f8 ffc3 fdfe f040 0000 3cfc fee0 0000
0000540 40e0 4040 4141 4f47 40e0 403f 3e3e 3038
0000550 0000 0000 0000 e0c0 0000 00f8 f8f8 1838
0000560 4346 4440 4040 4040 3c39 3b3f 0000 0000
0000570 80c0 4000 0000 0000 7838 b8f8 0000 0000
0000580 3130 387c 7fff fffb 3f3f 0f77 77f7 f7f7
0000590 107e 3e00 1efe ffff fffe fefe fafa f3e7
00005a0 ffff e3c3 8748 3cfc f0f8 fc7c 7838 3cfc
00005b0 00ff c383 83ff ffff ff00 c381 81c3 ff00
00005c0 1f1f 0f07 0100 0000 0000 0000 0000 0000
00005d0 f0fb ffff fe3e 0c04 000b 1f1f 1e3e 0c04
00005e0 1f1f 0f0f 0700 0000 0000 0000 0000 0000
00005f0 fbff ffff ff00 0000 030f 0f0f 0f00 0000
0000600 0018 3c7e 6edf dfdf 0018 3c7e 76fb fbfb
0000610 0018 183c 3c3c 3c1c 0010 1020 2020 2020
0000620 0008 0808 0808 0800 0008 0808 0808 0808
0000630 0008 0804 0404 0404 0010 1038 3838 3838
0000640 3c7e 77fb 9f5f 8e20 0018 3c0e 0e04 0000
0000650 5c2e 8f3f 7b77 7e3c 0000 0406 1e3c 1800
0000660 134f 3fbf 3f7a f8f8 0000 010a 170f 2f1f
0000670 0008 050f 2f1d 1c3c 0000 0000 0507 0f07
0000680 0000 0000 020b 070f 0000 0000 0000 0103
0000690 0000 0000 0008 0404 0060 f0f8 7c3e 7e7f
00006a0 0202 0205 717f 7f7f 3f5f 7f3e 0e0a 5120
00006b0 0000 0000 0000 0004 0000 0000 0000 0e1f
00006c0 0202 0001 133f 7f7f 3f7f 7ffe ecca 5120
00006d0 0040 6070 7327 0f1f 0040 6377 7c38 f8e4
00006e0 0000 0000 0307 0f1f 0000 0307 0c18 f8e4
00006f0 7f7f 3f3f 1f1f 0f07 0344 2810 0804 0304
0000700 0307 0f1f 3f77 77f5 0307 0f1f 277b 78fb
0000710 c0e0 f0f8 fcee eeaf c0e0 f0f8 e4de 1edf
0000720 f1ff 7800 0018 1c0e ffff 7f0f 0f07 0300
0000730 8fff 1e00 0c3e 7e7c ffff fef0 f0c0 8000
0000740 0000 0000 0000 0000 0000 1824 2418 0000
0000750 0002 4141 6133 063c 3c7e ffff ffff 7e3c
0000760 0307 0f1f 3f7f 7fff 0307 0f1f 3f63 41c1
0000770 c0e0 f0f8 fcfe feff c080 0000 8cfe fef3
0000780 ffff ff78 0000 0000 c1e3 ff47 0f0f 0f07
0000790 ffff ff1e 0020 2040 f1f9 ffe2 f0f0 f0e0
00007a0 161f 3f7f 3d1d 3f1f 161f 0000 050d 3f1f
00007b0 8080 c0e0 f0f0 f0f8 8080 0000 00a0 a0e0
00007c0 3cfa b172 f2db df5f 0004 4e8c 0c7f ffff
00007d0 0000 0001 0101 061e 0000 0000 0000 0101
00007e0 0000 0000 0000 0000 ff7f 3f1f 0f07 0301
00007f0 007c d692 baee fe38 ff83 296d 4511 01c7
0000800 0015 3f62 5fff 9f7d 0808 021f 2202 0200
0000810 0000 0000 0000 0000 0808 0808 0808 0808
0000820 2f1e 2f2f 2f15 0d0e 101e 1050 1008 0000
0000830 0000 0000 0000 0000 0000 00fe 0000 0000
0000840 1c3e 7fff fffe 7c38 1c2a 77ee ddaa 7428
0000850 00ff ffff ffff ffff fffe fe00 efef ef00
0000860 ffff ffff ffff ffff fefe fe00 efef ef00
0000870 7fff ffff ffff ffff 007f 5f7f 7f7f 7f7f
0000880 684e e0e0 e0f0 f8fc b89e 80c0 e0f0 f87c
0000890 3f5c 393b bbf9 fcfe 0023 574f 5727 c321
00008a0 c0f0 f0f0 f0e0 c000 0030 7070 f0e0 c000
00008b0 fefc 610f fffe f0e0 130f 1ef0 fcf8 f0e0
00008c0 6e40 e0e0 e0e0 e0c0 be90 80c0 c080 0000
00008d0 0101 0303 077f 7f3f 0101 0303 077f 7d3d
00008e0 0607 3f3c 197b 7f3f 0604 3023 0664 6000
00008f0 3f7f 7f1f 3f3f 0706 0060 6000 2030 0406
0000900 0307 0f0f 0f0f 0703 0001 0100 0000 0000
0000910 f8f8 f8a0 e1ff ffff feff ff40 0103 0303
0000920 0f0f 0f1f 1f1f 0f07 0101 0000 0000 0000
0000930 e0f8 f8f8 fffe f0c0 e0fe ff7f 0302 0000
0000940 010f 0f1f 3933 377f 010d 0800 362c 0860
0000950 7f3f 3f3f 1f0f 0f01 6000 2030 0008 0d01
0000960 0000 0303 4767 7777 0101 0343 6777 7b78
0000970 0000 0000 8898 f8f0 0000 8084 ccdc bc3c
0000980 7e7f ff1f 0730 1c0c 3307 07e3 383f 1c0c
0000990 7e38 f6ed df38 7060 98c7 c892 30f8 7060
00009a0 0000 0003 0347 6777 0001 0103 4367 777b
00009b0 0000 0000 0088 98f8 0000 0080 84cc dcbc
00009c0 777e 7fff 1f07 70f0 7833 0707 e338 7ff0
00009d0 f07e 38f6 eddf 383c 3c98 c7c8 9230 f83c
00009e0 0307 0a1a 1c1e 0b08 0010 7f7f 7f1f 0f0f
00009f0 1c3f 3f3d 3f1f 0000 0333 393a 3818 0000
0000a00 0000 044c 4e4e 466f 1038 3c74 7676 7e7d
0000a10 001f 3f3f 4f5f 7f7f 0000 110a 342a 5120
0000a20 7f67 a3b0 d8de dcc8 7f67 6370 383e 7cb8
0000a30 7f7f 7f1f 4770 7039 510a 04ea 797f 7039
0000a40 e8e8 e0c0 1070 e0c0 5838 1030 f0f0 e0c0
0000a50 0000 0020 6666 6662 0008 1c3c 7a7a 7a7e
0000a60 0000 1f3f 7f4f 5f7f 0000 0011 0a34 2a51
0000a70 777f 3fb7 b3db dad8 7f7d 3f37 333b 3a78
0000a80 7f7f 7f7f 1f07 70f0 2051 0a04 ea39 7ff0
0000a90 cce8 e8e0 c018 7c3e bc58 3810 30f8 fc3e
0000aa0 030f 1f3f 3b3f 7f7f 0000 0006 0e0c 0000
0000ab0 80f0 f8fc fefe fffe 0000 0000 0000 0f18
0000ac0 7f7f 7f7f ff0f 0300 0000 0000 f83e 3b18
0000ad0 fefb ffff f6e0 c000 1014 1010 3878 f830
0000ae0 0003 0f1f 3f3b 3f7f 0000 0000 060e 0c00
0000af0 00c0 f0f8 fcfe feff 0000 0000 0000 000f
0000b00 7f7f 7f7f 7fff 0f03 0000 0000 00f8 7ef3
0000b10 fefe fbff fff6 e0c0 1810 1410 1038 7cde
0000b20 0001 0101 0100 0008 000d 1e1e 1e1f 0f07
0000b30 78f0 f8e4 c0ca cac0 78f0 001a 3f35 353f
0000b40 0f1f 9fff ff7f 7420 0000 80e0 e070 7321
0000b50 e4ff fefc 9c1e 0000 1a07 0c18 78fe fcf0
0000b60 0001 0303 0703 0100 0001 0200 387c 7e3f
0000b70 005f 7f7f 3f3f 1400 3f40 6060 2030 1301
0000b80 c0e0 f030 383c 3cfc c0e0 30d0 d0d0 d000
0000b90 070f 1f22 2025 251f 070f 021d 1f1a 1a02
0000ba0 fefe 7e3a 0201 4141 387c fcfc fcfe bebe
0000bb0 1f3f 7e5c 4080 8282 1c3e 3f3f 3f7f 7d7d
0000bc0 8280 a044 4340 211e 7d7f 5f3b 3c3f 1e00
0000bd0 1c3f 3e3c 4080 8282 1c3e 3f1f 3f7f 7d7d
0000be0 0000 8080 929d c7ef 0000 0060 6265 3f1f
0000bf0 0023 333f 3f7f 7f7f 703c 3c18 0000 0207
0000c00 fef8 a000 0000 8080 cf7a 5a10 0000 c080
0000c10 7e7f 7d3f 1e8f 8f19 8584 86c6 e773 73e1
0000c20 e00e 73f3 f9f9 f870 804e 77f3 fbf9 fa78
0000c30 0e66 e2f6 ffff 1f98 1139 7d39 0000 e0e7
0000c40 0000 0004 0f0f 1f07 0000 0707 1610 0038
0000c50 f3e7 eeec cdcf cfdf cf1f 1710 3330 3020
0000c60 273f 3f78 3c1f 1f73 3830 40c7 0766 e06c
0000c70 9f3e 7cfc f8f8 c040 60c0 8004 9eff f0f8
0000c80 7f7e 7801 071f 3c7c 2401 07fe ff7f 3f7f
0000c90 fcf8 a0fe fcf0 8000 cf7a 0afe fc00 0000
0000ca0 7e7f 7f3f 1f8f 8f18 8586 83c3 e170 70e0
0000cb0 9f3e 7cf8 f83c 18f8 60c0 8000 98fc feff
0000cc0 7f7f 7801 0713 f103 2400 07fe ff7f ff03
0000cd0 0000 1c1d 1bc3 e3e1 030f 2362 643c 1c1e
0000ce0 e0cd 1d4f eeff 3f3f 1f3d 6d4f eef3 2003
0000cf0 3f3f 0000 70b8 fcfc 0707 1f3f 0f47 0300
0000d00 070f 1f3f 3e7c 7878 0000 0307 0f0f 1f1f
0000d10 3f5c 393b bfff fefe 0023 574f 572f df21
0000d20 c0c0 8080 8080 0000 0000 0000 8080 0000
0000d30 fefc 610f 7f3f 1f1e 230f 1ef0 1c3f 1f1e
0000d40 f078 e4c8 ccbe be3e 0080 1830 34fe fefe
0000d50 0001 0007 0707 071f 0000 0104 0606 0707
0000d60 0000 0f3f 3f0f 0000 0f3f 7ff8 f87f 3f0f
0000d70 787c 7e7f 3f3f 1b09 1f1f 1f0b 0101 0000
0000d80 0c00 0000 077f 7c00 031f 3f3f 7800 03ff
0000d90 01e1 7179 3d3d 1f03 0000 0000 0000 0000
0000da0 3f3f 1f1b 3630 7f3f 2327 1f07 0f1f 7f3f
0000db0 f8f8 f8b8 18d8 d8b8 e080 8040 e0e0 e0c0
0000dc0 0102 0404 0808 1010 0307 0f1f 3f7f ff1f
0000dd0 000f 130d 0d13 0c20 1f10 0c12 122c 3f3f
0000de0 0024 0024 0004 0000 3736 3636 1616 1202
0000df0 0f41 0088 0044 0000 107e ffff f676 3a1a
0000e00 387c fefe 3b03 0303 0000 3804 0000 0000
0000e10 0333 7b7f fffb 0303 0000 0038 4000 0000
0000e20 dcc0 e0e0 e0e0 e0c0 fca0 8080 0000 0000
0000e30 3f5f 3f3f bbf8 fefe 0727 574f 5727 c121
0000e40 1f0f 0f1f 1f1e 3830 1d0f 0f1f 1f1e 3830
0000e50 0020 6060 70f0 f8f8 0000 3810 4c18 8624
0000e60 f8fc fc7e 7e3e 1f07 0042 0a40 1002 0802
0000e70 00c0 70b8 f4f2 f57b 0000 8040 080c 0a84
0000e80 00df 10ff dfff fff9 0000 cf20 2020 262e
0000e90 1f1f 3efc f8f0 c000 e0e0 c000 0000 0000
0000ea0 f8fc feff ffdf df00 2f23 2120 2000 0000
0000eb0 c1f1 797d 3d3f 1f03 c1b1 596d 353b 1f03
0000ec0 0206 0e0e 1e1e 3e3e 0002 0008 0200 2800
0000ed0 3e3e 3e3e 1e1e 0e02 0410 0210 0400 0a00
0000ee0 c1f1 797d 3d3f 1f03 c1b1 596d 353b 1f03
0000ef0 7c00 00ff c37f 1f03 000f 1fff fc63 1f03
0000f00 ffff 7c00 007c ffff 0000 fec6 c6fe 0000
0000f10 ffff 0004 0c18 3000 0000 0606 0c18 7060
0000f20 ffff 0004 0404 0808 0000 0606 0404 0808
0000f30 0810 1000 0010 1008 0810 3030 3030 1008
0000f40 7f3f 3f3e 1f0f 0300 0000 0103 0100 0000
0000f50 030f ff7f 7f7f 7f7f 030e f800 0000 0000
0000f60 0000 0000 0000 0000 2265 2525 2525 7772
0000f70 0000 0000 0000 0000 6295 1525 4585 f7f2
0000f80 0000 0000 0000 0000 a2a5 a5a5 f5f5 2722
0000f90 0000 0000 0000 0000 f285 85e5 1515 f7e2
0000fa0 0000 0000 0000 0000 6295 5565 b595 9762
0000fb0 0000 0000 0000 0000 2050 5050 5050 7020
0000fc0 0000 0000 0000 0000 0000 0000 0000 0000
0000fd0 0000 0000 0000 0000 66e6 6666 6667 f300
0000fe0 0000 0000 0000 0000 5e59 5959 5ed8 9800
0000ff0 0000 0000 007c 3800 0000 0000 0004 0800
0001000 384c c6c6 c664 3800 0000 0000 0000 0000
0001010 1838 1818 1818 7e00 0000 0000 0000 0000
0001020 7cc6 0e3c 78e0 fe00 0000 0000 0000 0000
0001030 7e0c 183c 06c6 7c00 0000 0000 0000 0000
0001040 1c3c 6ccc fe0c 0c00 0000 0000 0000 0000
0001050 fcc0 fc06 06c6 7c00 0000 0000 0000 0000
0001060 3c60 c0fc c6c6 7c00 0000 0000 0000 0000
0001070 fec6 0c18 3030 3000 0000 0000 0000 0000
0001080 7cc6 c67c c6c6 7c00 0000 0000 0000 0000
0001090 7cc6 c67e 060c 7800 0000 0000 0000 0000
00010a0 386c c6c6 fec6 c600 0000 0000 0000 0000
00010b0 fcc6 c6fc c6c6 fc00 0000 0000 0000 0000
00010c0 3c66 c0c0 c066 3c00 0000 0000 0000 0000
00010d0 f8cc c6c6 c6cc f800 0000 0000 0000 0000
00010e0 fec0 c0fc c0c0 fe00 0000 0000 0000 0000
00010f0 fec0 c0fc c0c0 c000 0000 0000 0000 0000
0001100 3e60 c0ce c666 3e00 0000 0000 0000 0000
0001110 c6c6 c6fe c6c6 c600 0000 0000 0000 0000
0001120 7e18 1818 1818 7e00 0000 0000 0000 0000
0001130 1e06 0606 c6c6 7c00 0000 0000 0000 0000
0001140 c6cc d8f0 f8dc ce00 0000 0000 0000 0000
0001150 6060 6060 6060 7e00 0000 0000 0000 0000
0001160 c6ee fefe d6c6 c600 0000 0000 0000 0000
0001170 c6e6 f6fe dece c600 0000 0000 0000 0000
0001180 7cc6 c6c6 c6c6 7c00 0000 0000 0000 0000
0001190 fcc6 c6c6 fcc0 c000 0000 0000 0000 0000
00011a0 7cc6 c6c6 decc 7a00 0000 0000 0000 0000
00011b0 fcc6 c6ce f8dc ce00 0000 0000 0000 0000
00011c0 78cc c07c 06c6 7c00 0000 0000 0000 0000
00011d0 7e18 1818 1818 1800 0000 0000 0000 0000
00011e0 c6c6 c6c6 c6c6 7c00 0000 0000 0000 0000
00011f0 c6c6 c6ee 7c38 1000 0000 0000 0000 0000
0001200 c6c6 d6fe feee c600 0000 0000 0000 0000
0001210 c6ee 7c38 7cee c600 0000 0000 0000 0000
0001220 6666 663c 1818 1800 0000 0000 0000 0000
0001230 fe0e 1c38 70e0 fe00 0000 0000 0000 0000
0001240 0000 0000 0000 0000 0000 0000 0000 0000
0001250 ffff ffff ffff ffff 0000 0000 0000 0000
0001260 0000 0000 0000 0000 ffff ffff ffff ffff
0001270 ffff ffff ffff ffff ffff ffff ffff ffff
0001280 0000 007e 7e00 0000 0000 0000 0000 0000
0001290 0000 4428 1028 4400 0000 0000 0000 0000
00012a0 ffff ffff ffff ffff 7f7f 7f7f 7f7f 7f7f
00012b0 183c 3c3c 1818 0018 0000 0000 0000 0000
00012c0 ff7f 7f7f 7fff e3c1 ff80 8080 8000 1c3e
00012d0 8080 80c1 e3ff ffff 7f7f 7f3e 1c00 00ff
00012e0 387c 7c7c 7c7c 3800 0804 0404 0404 0800
00012f0 0306 0c0c 0808 0403 0305 0b0b 0f0f 0703
0001300 0102 0408 1020 4080 0103 070f 1f3f 7fff
0001310 0000 0000 0007 38c0 0000 0000 0007 3fff
0001320 0000 0000 00e0 1c03 0000 0000 00e0 fcff
0001330 8040 2010 0804 0201 80c0 e0f0 f8fc feff
0001340 040e 0e0e 6e64 6060 ffff ffff ffff ffff
0001350 070f 1f1f 7fff ff7f 0708 1000 6080 8040
0001360 0307 1f3f 3f3f 79f7 0304 1820 2020 4688
0001370 c0e0 f0f4 febf dfff c020 1014 0a41 2101
0001380 90b8 f8fa ffff fffe 90a8 480a 0501 0102
0001390 3b1d 0e0f 0700 0000 2412 0908 0700 0000
00013a0 ffbf 1cc0 f3ff 7e1c 0040 e33f 0c81 621c
00013b0 bf7f 3d83 c7ff ff3c 4080 c27c 3800 c33c
00013c0 fcfe fffe fef8 6000 0402 0100 0698 6000
00013d0 c020 1010 1010 20c0 c0e0 f0f0 f0f0 e0c0
00013e0 0000 0000 3f7f e0c0 0000 0000 0000 1c3e
00013f0 889c 8880 8080 8080 7f7f 7f3e 1c00 0000
0001400 fefe fefe fefe fefe ffff ffff ffff ffff
0001410 0814 24c4 0340 a126 0008 1838 fcbf 5ed9
0001420 ffff ffff 7f7f 7f7f 8181 8181 8181 8181
0001430 ffff ffff ffff ffff 0101 0101 0101 0101
0001440 7f80 8098 9c8c 8080 007f 7f67 677f 7f7f
0001450 ff01 01ff 1010 10ff 00ff ffff ffff ffff
0001460 8080 8080 8080 8080 7f7f 7f7f 7f7f 7f7f
0001470 0101 01ff 1010 10ff ffff ffff ffff ffff
0001480 ff00 0000 0000 0000 00ff ffff ffff ffff
0001490 fe01 0119 1d0d 0101 00ff ffe7 e7ff ffff
00014a0 0101 0101 0101 0101 ffff ffff ffff ffff
00014b0 3f7f 7fff ffff ffff 3f60 40c0 8080 8080
00014c0 ffff ffff ffff 7e3c 8080 8080 8081 423c
00014d0 ffff ffff ffff ffff ff00 0000 0000 0000
00014e0 ffff ffff ffff fe7c 0000 0000 0001 827c
00014f0 ffff ffff ffff fe7c 0000 0000 0001 83ff
0001500 f8fc fefe ffff ffff f804 0202 0101 0101
0001510 ffff ffff ffff 7e3c 0101 0101 0181 423c
0001520 0008 0808 1010 1000 ffff ffff ffff ffff
0001530 007f 7f78 7373 737f 7f80 a087 8f8e 8e86
0001540 00ff ff3f 9f9f 9f1f fe01 05c1 e171 71f1
0001550 7e7e 7f7e 7e7f 7fff 8181 8081 81a0 80ff
0001560 7f7f ff7f 7fff ffff f1c1 c181 c1c5 01ff
0001570 7f80 a080 8080 8080 7fff ffff ffff ffff
0001580 fe01 0501 0101 0101 feff ffff ffff ffff
0001590 8080 8080 80a0 807f ffff ffff ffff ff7f
00015a0 0101 0101 0105 01fe ffff ffff ffff fffe
00015b0 0000 0000 fcfe 0703 0000 0000 0000 387c
00015c0 1139 1101 0101 0101 fefe fe7c 3800 0000
00015d0 ef28 2828 2828 ef00 20e7 e7e7 e7e7 ef00
00015e0 fe82 8282 8282 fe00 027e 7e7e 7e7e fe00
00015f0 8080 8098 9c8c 807f 7f7f 7f67 677f 7f7f
0001600 ffff 83f3 f3f3 f3f3 ff80 fc8c 8c8c 8c8c
0001610 ffff f0f6 f6f6 f6f6 ff00 0f09 0909 0909
0001620 ffff 0000 0000 0000 ff00 ffff ffff ffff
0001630 ffff 0157 2f57 2f57 ff01 ffa9 d1a9 d1a9
0001640 f3f3 f3f3 f3f3 ff3f 8c8c 8c8c 8c8c ff3f
0001650 f6f6 f6f6 f6f6 ffff 0909 0909 0909 ffff
0001660 0000 0000 0000 ffff ffff ffff ffff ffff
0001670 2f57 2f57 2f57 fffc d1a9 d1a9 d1a9 fffc
0001680 3c3c 3c3c 3c3c 3c3c 2323 2323 2323 2323
0001690 fbfb fbfb fbfb fbfb 0404 0404 0404 0404
00016a0 bc5c bc5c bc5c bc5c 44a4 44a4 44a4 44a4
00016b0 1f20 4040 8080 8081 1f3f 7f7f ffff fffe
00016c0 ff80 80c0 ffff fefe ff7f 7f3f 0000 0101
00016d0 ff7f 7fff ff07 0303 ff80 8000 00f8 fcfc
00016e0 ff00 0000 0081 c3ff ffff ffff ff7e 3c00
00016f0 f8fc fefe e3c1 8181 f804 0202 1d3f 7f7f
0001700 83ff ffff ffff 7f1f fc80 8080 8080 601f
0001710 fcfc fcfc fefe ffff 0303 0303 0101 00ff
0001720 0101 0101 0303 07ff fefe fefe fcfc f8ff
0001730 ffff ffff ffff ffff 0000 0000 0000 00ff
0001740 81c1 e3ff ffff fffe 7f3f 1d01 0101 03fe
0001750 ffff ffff fffb b5ce 8080 8080 8084 cab1
0001760 ffff ffff ffdf ad73 0101 0101 0121 538d
0001770 7777 7777 7777 7777 0000 0000 77ff ffff
0001780 0000 0000 0000 00ff ffff ffff ffff ffff
0001790 7777 7777 0000 0000 ffff ff77 7777 7777
00017a0 0101 0119 1d0d 01fe ffff ffe7 e7ff fffe
00017b0 2078 7ffe fefe fefe 0021 2141 4141 4141
00017c0 049a fafd fdfd fdfd 0080 8080 8080 8080
00017d0 7e38 2100 0100 0100 2121 0101 0101 0101
00017e0 fa8a 8480 8080 8080 8080 8080 8080 8080
00017f0 0204 0010 0040 8000 0101 0608 1820 20c0
0001800 0b0b 3b0b fb0b 0b0a 0404 c4f4 f404 0405
0001810 9010 1f10 1f10 1090 70f0 f0ff fff0 f070
0001820 3f78 e7cf 5858 5090 c087 18b0 e7e7 efef
0001830 b0fc e2c1 c183 8f7e 6f43 5d3f 3f7f 7fff
0001840 fe03 0f91 7060 2031 03ff f16e cfdf ffff
0001850 3f3f 1d39 7bf3 86fe fdfb fbf7 f70f 7fff
0001860 ffff ffff ff80 80ff ff80 8080 80ff ff80
0001870 feff ffff ff03 03ff fe03 0303 03ff ff03
0001880 00ff ffff ffff 0000 00ff 0000 0000 ffff
0001890 3cfc fcfc fcfc 0404 23f3 0b0b 0b07 ffff
00018a0 ffff ffff 80ff ffff 8080 8080 ff80 8080
00018b0 ffff ffff 03ff ffff 0303 0303 ff03 0303
00018c0 ffff ffff ff00 ffff 0000 0000 00ff 0000
00018d0 fcfc fefe fe02 fefe 0707 0303 03ff 0303
00018e0 ff80 8080 8080 8080 80ff ffff ffff ffff
00018f0 ff03 0303 0303 0303 03ff ffff ffff ffff
0001900 0202 0202 0202 0404 ffff ffff ffff ffff
0001910 8080 aad5 aaff ffff ffff d5aa d580 80ff
0001920 0303 ab57 abff fffe ffff 57ab 5703 03fe
0001930 0055 aa55 ffff ff00 ffaa 55aa 0000 ff00
0001940 0454 ac5c fcfc fc3c ffaf 57ab 0b0b f323
0001950 3f3f 3f3f 0000 00ff ffff ffff ffff ffff
0001960 7e7c 7c78 0000 00ff ffff ffff ffff ffff
0001970 1f0f 0f07 0000 00ff ffff ffff ffff ffff
0001980 fefc fcf8 0000 00ff ffff ffff ffff ffff
0001990 0000 0000 ffff 0000 0000 0000 0000 0000
00019a0 1818 1818 1818 1818 0000 0000 0000 0000
00019b0 071f 3fff 7f7f ffff ffff ffff ffff ffff
00019c0 e1f9 fdff fefe ffff ffff ffff ffff ffff
00019d0 f010 1010 1010 10ff 00e0 e0e0 e0e0 e0e0
00019e0 1f10 1010 1010 10ff 000f 0f0f 0f0f 0f0f
00019f0 9292 92fe fe00 0000 4848 6c00 0000 fe00
0001a00 0a0a 3a0a fb0b 0b0b 0505 c5f5 f404 0404
0001a10 9090 9f90 9f90 9090 7070 707f 7f70 7070
0001a20 0101 0101 0101 0101 0000 0000 0000 0000
0001a30 8080 8080 8080 8080 0000 0000 0000 0000
0001a40 0888 91d1 5353 733f ffff ffff fffe bece
0001a50 0000 070f 0c1b 1b1b 0000 0000 0304 0404
0001a60 0000 e0f0 f0f8 f8f8 0000 6030 3098 9898
0001a70 1b1b 1b1b 1b0f 0f07 0404 0404 0403 0000
0001a80 f8f8 f8f8 f8f0 f0e0 9898 9898 9830 3060
0001a90 f111 111f 1010 10ff 0fef efef efef efe0
0001aa0 1f10 10f0 1010 10ff e0ef efef efef ef0f
0001ab0 7fbf dfef f0f0 f0f0 8040 2010 0f0f 0f0f
0001ac0 f0f0 f0f0 ffff ffff 0f0f 0f0f 1f3f 7fff
0001ad0 ffff ffff 0f0f 0f0f 0103 070f ffff ffff
0001ae0 0f0f 0f0f f7fb fdfe ffff ffff ffff ffff
0001af0 0000 0000 0000 1818 0000 0000 0000 0000
0001b00 1f3f 7f7f 7fff ffff 1f20 4040 4080 8282
0001b10 ffff ff7f 7f7f 3f1e 8280 a044 4340 211e
0001b20 f8fc fefe feff ffff f804 0202 0201 4141
0001b30 ffff fffe fefe fc78 4101 0522 c202 8478
0001b40 7f80 8080 8080 8080 807f 7f7f 7f7f 7f7f
0001b50 de61 6161 715e 7f61 61df dfdf dfff c1df
0001b60 8080 c0f0 bf8f 817e 7f7f ff3f 4f71 7fff
0001b70 6161 c1c1 8181 83fe dfdf bfbf 7f7f 7f7f
0001b80 0000 030f 1f3f 7f7f 0000 030c 1020 4040
0001b90 0000 c0f0 f8fc fefe 0000 c030 0804 0202
0001ba0 ffff ffff ffff ffff 8080 8080 8080 8080
0001bb0 ffff ffff ffff ffff 0101 0101 0101 0101
0001bc0 7f7f 7f3f 3f1f 0f07 4040 4020 301c 0f07
0001bd0 fefe fefc fcf8 f0f0 0202 0204 0c38 f0f0
0001be0 0f0f 0f0f 0f0f 070f 0808 0808 080c 050a
0001bf0 f0f0 f0f0 f0f0 e0f0 1050 5050 5030 a050
0001c00 81c1 a3a3 9d81 8181 0041 2222 1c00 0000
0001c10 e3f7 c1c1 c1c1 f7e3 e314 3e3e 3e3e 14e3
0001c20 0000 070f 0c1b 1b1b ffff f8f0 f0e0 e0e0
0001c30 0000 e0f0 f0f8 f8f8 ffff 7f3f 3f9f 9f9f
0001c40 1b1b 1b1b 1b0f 0f07 e0e0 e0e0 e0f3 f0f8
0001c50 f8f8 f8f8 f8f0 f0e0 9f9f 9f9f 9f3f 3f7f
0001c60 e0ff ffff ffff ffff 0070 1f10 707f 7f7f
0001c70 07ff ffff ffff ffff 0003 f800 03fb fbfb
0001c80 ffff ffff fffe ffef 7c7b 7675 7577 1767
0001c90 ffdf efaf af6f efe7 3bfb 7bfb fbf3 f8f3
0001ca0 1f1f 3f3f 7063 e7e5 0f0f 1f1f 3f3c 787a
0001cb0 f0f0 f8f8 0cc4 e4a6 f8f8 fcfc fe3e 1e5f
0001cc0 e9e9 e9ef e2e3 f0ff 7676 7670 7d7c 7f7f
0001cd0 9696 96f6 46c6 0efe 6f6f 6f0f bf3f ffff
0001ce0 0000 0000 0000 7e3c 3c7e 7eff ffff 4200
0001cf0 3c42 99a1 a199 423c 0000 0000 0000 0000
0001d00 0f1f 1f3f 3f7f 7f7f f0e0 e0c0 c080 8080
0001d10 f0f8 f8fc fcfe fefe 0f07 0703 0301 0101
0001d20 7f7f 3f3f 3f3f 1f1f 8080 c0c0 e0f8 feff
0001d30 feff ffff fcfc fefe ff7f 1f07 0303 0181
0001d40 7f7f 7f3f 3f3f 3f1f 8080 80c0 c0e0 e0f0
0001d50 fefe ffff ffff fffe 0101 0103 0307 070f
0001d60 1f0f 0f07 0000 0000 ffff ffff ffff ffff
0001d70 fefc fcf8 0000 0000 ffff ffff ffff ffff
0001d80 7e7e 7e7e 7f7f 7f7f 8181 8181 8181 8181
0001d90 ffff ffff ffff fffe 0101 0103 0307 070f
0001da0 fefe fefe ffff ffff 0101 0101 0101 0101
0001db0 7f7f 7f7f 7f7f 7f7f 8181 8181 8181 8181
0001dc0 ffff ffff fcfe fe7e ff03 0303 0303 03ff
0001dd0 ffff ffff 0000 0000 ffff ffff ffff ffff
0001de0 7f7f 7f7f 7f7f 7f7f 8080 8080 8080 8080
0001df0 ffff ffff ffff fffe 0101 0103 0703 0101
0001e00 7e7e 7f7f 7f7f 7f7f 8181 8181 8181 8181
0001e10 3f3f 3f3f 0000 0000 ffff ffff ffff ffff
0001e20 7e7c 7c78 0000 0000 ffff ffff ffff ffff
0001e30 fefe ffff 7f7f 7f7f 8181 8181 8181 8181
0001e40 7f7f 3f3f 3f3f 1f1f 8080 c0c0 e0f8 feff
0001e50 3fbf ffff fcfc fefe ff7f 1f07 0303 0181
0001e60 7f7f 7e7e 7f7f 7f7f 8181 8181 8181 8181
0001e70 7e7e 7e7e 7f7f 7f7f 8181 8181 8181 8181
0001e80 81c3 c3e7 e7ff ffff 7e3c 3c18 1800 0000
0001e90 0f43 5b53 3119 0f07 f2fe feff ffef f7f8
0001ea0 c1c3 c684 fcfc 0e02 bfbe bd7b 7b07 f3fd
0001eb0 1020 22ba e6e1 c0c0 ffff ff67 599e bfbf
0001ec0 20a6 5426 20c6 5426 20e6 5426 2106 5426
0001ed0 2085 0144 2086 5448 209a 0149 20a5 c946
0001ee0 20ba c94a 20a6 0ad0 d1d8 d8de d1d0 dade
0001ef0 d120 c60a d2d3 dbdb dbd9 dbdc dbdf 20e6
0001f00 0ad4 d5d4 d9db e2d4 dadb e021 060a d6d7
0001f10 d6d7 e126 d6dd e1e1 2126 14d0 e8d1 d0d1
0001f20 ded1 d8d0 d126 ded1 ded1 d0d1 d0d1 2621
0001f30 4614 db42 42db 42db 42db db42 26db 42db
0001f40 42db 42db 4226 2166 46db 216c 0edf dbdb
0001f50 db26 dbdf dbdf dbdb e4e5 2621 8614 dbdb
0001f60 dbde 43db e0db dbdb 26db e3db e0db dbe6
0001f70 e326 21a6 14db dbdb db42 dbdb dbd4 d926
0001f80 dbd9 dbdb d4d9 d4d9 e721 c516 5f95 9595
0001f90 9595 9595 9597 9878 9596 9595 9798 9798
0001fa0 957a 21ed 0ecf 0109 0805 2417 1217 1d0e
0001fb0 170d 1822 4b0d 0124 1915 0a22 0e1b 2410
0001fc0 0a16 0e22 8b0d 0224 1915 0a22 0e1b 2410
0001fd0 0a16 0e22 ec04 1d18 1928 22f6 0100 23c9
0001fe0 5655 23e2 0499 aaaa aa23 ea04 99aa aaaa
0001ff0 00ff ffff ffff ffff ffff ffff ffff ffff
0002000

;+++++++++++++++++++++++++++++++++++
; mario22.nes

0000000 007f 357f 337f 44ff 3a55 2a50 0101 0101
0000010 0101 0100 3501 2501 0155 0120 0101 0101
0000020 3201 2250 0101 0101 0101 0100 3701 2750
0000030 0101 0150 3901 2901 0101 0120 3701 2701
0000040 3501 2501 0101 0100 3559 2530 3901 2930
0000050 0101 0101 4001 3001 4201 3220 0101 0101
0000060 3a01 2a30 405a 3030 0101 0101 3901 2930
0000070 0101 0127 3901 2950 3a62 2a66 3701 2763
0000080 0001 0101 0101 0100 3a57 2a50 0101 0101
0000090 0101 0100 3501 2501 0101 0120 0101 0101
00000a0 3201 2250 0101 0101 0101 0100 3701 2750
00000b0 0101 0150 3901 2901 0101 0120 3701 2701
00000c0 3501 2501 0101 0100 3501 2530 3962 2930
00000d0 0101 0101 4001 3001 4201 3220 0101 0101
00000e0 3a01 2a30 4001 3030 0163 0101 3901 2930
00000f0 0101 0127 3901 2950 3a60 2a66 3701 2763
0000100 0001 0101 0101 0100 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; pong15.nes

0000000 628b bbbb 99ff 44ff 2931 0130 0001 0101
0000010 2a31 0101 0000 0101 4945 0110 0000 0101
0000020 2a00 0130 0000 0101 2945 0101 0000 0101
0000030 2a00 0130 0000 0101 3930 0120 0000 0101
0000040 2a32 0130 0031 0130 2931 0130 0001 0101
0000050 2a31 0101 0000 0101 4945 0120 0000 0101
0000060 2a00 0130 0000 0101 2945 0101 0000 0101
0000070 2a00 0130 0000 0101 3930 0120 0000 0101
0000080 2a32 0130 0031 0130 2931 0130 0001 0101
0000090 2a31 0101 0000 0101 4945 0120 0000 0101
00000a0 2a00 0130 0000 0101 2945 0101 0000 0101
00000b0 2a00 0130 0000 0101 3930 0120 0000 0101
00000c0 2a32 0130 0031 0101 2945 0150 0001 0101
00000d0 2a00 0101 0000 0101 4901 0120 0000 0101
00000e0 2a00 0101 0000 0101 2901 0150 0000 0101
00000f0 2a00 0150 0000 0101 3900 0166 0000 0101
0000100 2a00 0101 0000 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; rand.dat

0000000 cd1e 00d0 0160 ce1c 00a9 00cd 1c00 b003
0000010 4c92 894c 7a89 60a9 008d 5f00 a900 8d60
0000020 00a9 008d 6100 a900 8d62 00a9 008d 6300
0000030 a900 8d64 00a9 00cd 1a00 d005 a920 8d65
0000040 00a9 01cd 1a00 d005 a924 8d65 0060 ad65
0000050 008d 0620 ad60 008d 0620 a904 8d66 00ae
0000060 6300 bd00 0218 0a0a 8d61 00ad 6200 186d
0000070 6100 8d61 00ae 6100 bd28 e18d 0720 ee61
0000080 00ee 6000 ae61 00bd 28e1 8d07 20ee 6100
0000090 ee60 00ee 6400 ee63 00ce 6600 d0c1 a910
00000a0 cd64 00d0 0ead 6300 38e9 108d 6300 a902
00000b0 8d62 00a9 20cd 6400 d00a a900 8d62 00a9
00000c0 008d 6400 a900 cd60 00d0 03ee 6500 a923
00000d0 cd65 00d0 0ca9 c0cd 6000 d005 a900 8d54
00000e0 00a9 27cd 6500 d00c a9c0 cd60 00d0 05a9
00000f0 008d 5400 60a9 008d 0020 a900 8d01 20a9
0000100

;+++++++++++++++++++++++++++++++++++
; smbtitle.hex

0000000 2424 2424 2444 4848 4848 4848 4848 4848
0000010 4848 4848 4848 4848 4848 4924 2424 2424
0000020 2424 2424 2446 d0d1 d8d8 ded1 d0da ded1
0000030 2626 2626 2626 2626 2626 4a24 2424 2424
0000040 2424 2424 2446 d2d3 dbdb dbd9 dbdc dbdf
0000050 2626 2626 2626 2626 2626 4a24 2424 2424
0000060 2424 2424 2446 d4d5 d4d9 dbe2 d4da dbe0
0000070 2626 2626 2626 2626 2626 4a24 2424 2424
0000080 2424 2424 2446 d6d7 d6d7 e126 d6dd e1e1
0000090 2626 2626 2626 2626 2626 4a24 2424 2424
00000a0 2424 2424 2446 d0e8 d1d0 d1de d1d8 d0d1
00000b0 26de d1de d1d0 d1d0 d126 4a24 2424 2424
00000c0 2424 2424 2446 db42 42db 42db 42db db42
00000d0 26db 42db 42db 42db 4226 4a24 2424 2424
00000e0 2424 2424 2446 dbdb dbdb dbdb dfdb dbdb
00000f0 26db dfdb dfdb dbe4 e526 4a24 2424 2424
0000100 2424 2424 2446 dbdb dbde 43db e0db dbdb
0000110 26db e3db e0db dbe6 e326 4a24 2424 2424
0000120 2424 2424 2446 dbdb dbdb 42db dbdb d4d9
0000130 26db d9db dbd4 d9d4 d9e7 4a24 2424 2424
0000140 2424 2424 245f 9595 9595 9595 9595 9798
0000150 7895 9695 9597 9897 9895 7a24 2424 2424
0000160 2424 2424 2424 2424 2424 2424 2424 2424
*
0000190 2424 2424 1618 1f12 0e24 2424 2424 2424
00001a0 2424 2424 2424 2424 2424 2424 2424 2424
*
0000210 2424 0b22 240b 0e12 100e 2424 2424 2424
0000220 2424 2424 2424 2424 2424 2424 2424 2424
0000230 2419 0a19 0e1b 241b 0a0d 2424 2424 2424
0000240

;+++++++++++++++++++++++++++++++++++
; song5.nes


0000000 33fa 0160 225a 4344 0101 0101 0001 0101
0000010 0001 0101 0001 0101 4a5a 274a 0101 0101
0000020 0001 0101 0101 0101 0101 0101 0101 0101
0000030 4845 1748 0101 0101 5040 2750 5347 2753
0000040 0101 0101 0101 0101 5257 2a52 0101 0101
0000050 0101 0101 0101 0101 525a 2a52 0101 0101
0000060 0101 0101 0101 0101 0101 2a50 0101 0101
0000070 5257 3a52 0101 0101 5752 2a57 5363 3a53
0000080 0101 0101 0101 0101 5055 3050 0101 0101
0000090 0101 0101 0101 0101 5040 2050 0101 0101
00000a0 0101 0101 0101 0101 0101 0101 0101 0101
00000b0 4855 4048 0101 0101 5055 2050 5340 2053
00000c0 0101 0101 0101 0101 5257 1852 0101 0101
00000d0 0101 0101 0101 0101 5057 2850 0101 0101
00000e0 0101 0101 0101 0101 4855 2a48 0101 0101
00000f0 0101 0101 0101 0101 4558 2a45 0101 0101
0000100 5040 5550 0101 0101 0f00               
0000109

;+++++++++++++++++++++++++++++++++++
; spriteanimation_pong_d_l.hex

0000000 f101 0300 0000 f201 0300 0000 f601 0100
0000010 0000                                   
0000012

;+++++++++++++++++++++++++++++++++++
; spriteanimation_pong_d_r.hex

0000000 f101 0300 0000 f301 0300 0000 f601 0100
0000010 0000                                   
0000012

;+++++++++++++++++++++++++++++++++++
; spriteanimation_pong_lp_u.hex

0000000 f480 0300 0000 f040 0101 0101 f120 0100
0000010 0000 f4ff 0100 0000                    
0000018

;+++++++++++++++++++++++++++++++++++
; spriteanimation_pong_rp_d.hex

0000000 f460 0100 0000 f140 0100 0000 f4ff 0100
0000010 0000                                   
0000012

;+++++++++++++++++++++++++++++++++++
; spriteanimation_pong_u_l.hex

0000000 f001 0300 0000 f201 0300 0000 f601 0100
0000010 0000                                   
0000012

;+++++++++++++++++++++++++++++++++++
; spriteanimation_pong_u_r.hex

0000000 f001 0300 0000 f301 0300 0000 f601 0100
0000010 0000                                   
0000012

;+++++++++++++++++++++++++++++++++++
; spriteanimation.hex

0000000 f501 0100 1008 f401 ff00 0000 f301 0100
0000010 0000 f401 ff00 0000 f501 0100 0008 f401
0000020 ff00 0000 f201 0100 0000 f601 0100 0000
0000030

;+++++++++++++++++++++++++++++++++++
; spriteanimation2.hex

0000000 f304 0100 0000 f401 ff00 0000 f304 0100
0000010 0000 f401 ff00 0000 f304 0100 0000 f401
0000020 ff00 0000 f304 0100 0000 f600 0000 0030
0000030

;+++++++++++++++++++++++++++++++++++
; spriteanimation3.hex

0000000 f304 0100 0000 f1ff 0100 0000 f601 0100
0000010 0000                                   
0000012

;+++++++++++++++++++++++++++++++++++
; spriteanimation4.hex

0000000 f1ff 0100 0000 f601 0100 0000          
000000c

;+++++++++++++++++++++++++++++++++++
; spriteanimation5.hex

0000000 f180 0100 0000 f501 0100 1008 f401 ff00
0000010 0000 f301 0100 0000 f401 ff00 0000 f501
0000020 0100 0008 f401 ff00 0000 f201 0100 0000
0000030 f601 0100 0006 ff00                    
0000037

;+++++++++++++++++++++++++++++++++++
; spriteanimation6.hex

0000000 f410 0100 0000 f010 0100 0000 f110 0100
0000010 0000 f440 0100 0000 ff00               
0000019

;+++++++++++++++++++++++++++++++++++
; spriteanimation7.hex

0000000 f501 0100 2008 f304 0100 0000 f501 0100
0000010 3008 f304 0100 0000 f501 0100 4008 f304
0000020 0100 0000 f601 0100 0000 ff00          
000002b

;+++++++++++++++++++++++++++++++++++
; spriteanimation8.hex

0000000 f380 0100 0000 f280 0100 0000 f601 0100
0000010 0000                                   
0000012

;+++++++++++++++++++++++++++++++++++
; spriteanimation9.hex

0000000 f010 0100 0000 f20a 0100 0000 f108 0100
0000010 0000 f4ff 0100 0000 f601 0100 0012     
000001e

;+++++++++++++++++++++++++++++++++++
; spriteanimation10.hex

0000000 f501 0100 0004 f410 0100 0000 f204 0100
0000010 0000 f004 0100 0000 f3ff 0100 0000 f601
0000020 0100 0012                              
0000024

;+++++++++++++++++++++++++++++++++++
; spriteanimation11.hex

0000000 f350 0100 0000 f010 0400 0000 f110 0300
0000010 0000 f007 0300 0000 f107 0200 0000 f030
0000020 0400 0000 f120 0300 0000 f004 0300 0000
0000030 f114 0200 0000 f601 0100 0000          
000003c

;+++++++++++++++++++++++++++++++++++
; spriteanimation12.hex

0000000 f350 0100 0000 f160 0100 0000 f4ff 0100
0000010 0000                                   
0000012

;+++++++++++++++++++++++++++++++++++
; spriteanimation14.hex

0000000 f320 0100 0000 f4ff 0100 0000          
000000c

;+++++++++++++++++++++++++++++++++++
; spriteanimation15.hex

0000000 f350 0100 0000 f160 0100 0000 f480 0100
0000010 0000 f060 0100 0000 f3ff 0100 0000 f4ff
0000020 0100 0000                              
0000024

;+++++++++++++++++++++++++++++++++++
; theme1.nes

0000000 60d9 157f 447f 43ff 004a 2750 0001 0101
0000010 0001 3700 0001 0101 4a4a 2729 0101 0101
0000020 0001 3729 0101 0101 0101 2750 0101 0101
0000030 4801 3701 0101 0101 5001 2720 5301 0101
0000040 0101 3701 0101 0101 5252 2a50 0101 0101
0000050 0101 3a01 0101 0101 5201 2a20 0101 0101
0000060 0101 3a01 0153 0101 0101 2a50 0101 0101
0000070 5201 3a01 0101 0130 5757 2a30 5301 0101
0000080 0101 3a30 0101 0101 5050 3050 0101 0101
0000090 0101 4050 0101 0101 5001 3020 0101 0101
00000a0 0101 4050 0101 0101 0101 3001 0101 0101
00000b0 4801 4050 0101 0101 5001 3020 5301 4001
00000c0 0101 0101 0101 0101 5257 2850 0101 0101
00000d0 0101 3801 0101 0101 5057 2820 0101 0101
00000e0 0101 3801 0101 0101 4858 2a50 0101 0101
00000f0 0101 3a01 0101 0130 4555 2a29 0101 0101
0000100 5001 5529 0101 0129 0f00               
0000109
