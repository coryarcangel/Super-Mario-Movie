system ("nbasic mariomovie.bas -quiet -o mariomovie.asm ; nesasm -raw mariomovie.asm");
system ("cp mariomovie.nes ../../../../Volumes/ROMZ/mariomovie.nes");
# system ("open mariomovie.nes");