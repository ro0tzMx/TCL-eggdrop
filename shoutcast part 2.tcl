bind pub D !dj_ proc_serdj
bind pub D !auto proc_auto
bind pub - !rl proc_rl
bind pub - !enlace proc_enlace
bind pub - !dj proc_dj
bind pub - !pido proc_pido
bind pub - !tema proc_tema
bind pub A !oyentes proc_oyentes
bind pub - !facebook pub_facebook
bind pub - !xiialive pub_xiialive
bind pub - !tunein pub_tunein
bind pub - !winamp pub_winamp
bind pub - !reproductor pub_reproductor
#bind pub - !RL-App pub_rlapp
bind pub - !app pub_rlapp

bind pub D !abre pub_abrepeticiones
bind pub D !cierra pub_cierrapeticiones
bind pub - !status.peticiones pub_statuspeticiones

#bind time - "*5 * * * *" isonline
#bind time - "*0 * * * *" isonline
bind time - "00 * * * *" advertise
bind time - "20 * * * *" advertise
bind time - "40 * * * *" advertise

### advertise 
proc advertise { nick uhost hand chan arg } {
global dj ciudad peticiones
 if {$dj != "AutoMix"} {
 		if {$peticiones == "Abiertas"} {
				poststuff privmsg " 1»10R1« 1Emitiendo: 1»10¤1«16 $dj 1»10¤1«1 Desde1 »6¤1«10 $ciudad 1»6¤1« 1Sintoniza 1En: 10https://radio.puntochat.net 11 La Radio Que Prende Tus Sentidos 10 Peticiones 1!pido Tema Artista 10Comandos 1Escribe 6!RL 1»10L1«"
   } else {
   	 		poststuff privmsg " 1»10R1« 1Emitiendo: 1»10¤1«16 $dj 1»10¤1«1 Desde1 »6¤1«10 $ciudad 1»6¤1« 1Sintoniza 1En: 10https://radio.puntochat.net 11 Radio Mars la radio estelar que prende tus sentidos 10 Comandos 1Escribe 6!RL 1»10L1«"
   }
 } else {
  poststuff privmsg " 1»10R1« 1Emitiendo: 1»10¤1«16 $dj 1»10¤1«1 Desde1 »6¤1«10 $ciudad 1»6¤1« 1Sintoniza 1En: 10https://radio.puntochat.net 11 Radio Mars la radio estelar que prende tus sentidos 10 Comandos 1Escribe 6!RL 1»10L1«"
 }
}

### poststuff
proc poststuff { modo text } {
global radiochans dj
	foreach chan [channels] {
 		putserv "$modo $chan :$text" 
	}
}

#### isonline
#
#proc isonline { nick uhost hand chan arg } {
#global radiochans announce tellusers tellsongs tellbitrate urltopic dj
#global offlinetext offlinetopic onlinetext onlinetopic
#global streamip streampass streamport dj
#global doalertadmin alertadmin
#
#if {$announce == 1 || $tellsongs == 1 || $tellusers == 1 || $tellbitrate == 1} {
#set isonlinefile "isonline"
#set oldisonline "isonline: 0"
#set oldcurlist "curlist: 0"
#set oldcurhigh "curhigh: 0"
#set oldsong "cursong: 0"
#set oldbitrate "bitrate: 0"
#if {[file exists $isonlinefile]} {
#putlog "shoutcast: Comprobando si El Enlace está en LINEA"
#set temp [open "isonline" r]
#while {[eof $temp] != 1} {
#set zeile [gets $temp]
#if {[string first "isonline:" $zeile] != -1 } { set oldisonline $zeile }
#if {[string first "curlist:" $zeile] != -1 } { set oldcurlist $zeile }
#if {[string first "curhigh:" $zeile] != -1 } { set oldcurhigh $zeile }
#if {[string first "cursong:" $zeile] != -1 } { set oldsong $zeile }
#if {[string first "bitrate:" $zeile] != -1 } { set oldbitrate $zeile }
#}
#close $temp
#}
#
#
#if {[catch {set sock [socket $streamip $streamport] } sockerror]} {
#putlog "error: $sockerror"
#return 0} else {
#puts $sock "GET /admin.cgi?pass=$streampass&mode=viewxml&page=0 HTTP/1.0"
#puts $sock "User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9)"
#puts $sock "Host: $streamip"
#puts $sock "Connection: close"
#puts $sock ""
#flush $sock
#while {[eof $sock] != 1} {
#set bl [gets $sock]
#if { [string first "standalone" $bl] != -1 } {
#set streamstatus "isonline: [string range $bl [shrink + 14 "<STREAMSTATUS>" 0 $bl] [shrink - 1 "</STREAMSTATUS>" 0 $bl]]"
#set repl "curlist: [string range $bl [shrink + 19 "<REPORTEDLISTENERS>" 0 $bl] [shrink - 1 "</REPORTEDLISTENERS>" 0 $bl]]"
#set curhigh "curhigh: [string range $bl [shrink + 15 "<PEAKLISTENERS>" 0 $bl] [shrink - 1 "</PEAKLISTENERS>" 0 $bl]]"
#set currentl [string range $bl [shrink + 18 "<CURRENTLISTENERS>" 0 $bl] [shrink - 1 "</CURRENTLISTENERS>" 0 $bl]]
#set surl "serverurl: [string range $bl [shrink + 11 "<SERVERURL>" 0 $bl] [shrink - 1 "</SERVERURL>" 0 $bl]]"
#set cursong "cursong: [string range $bl [shrink + 11 "<SONGTITLE" 0 $bl] [shrink - 1 "</SONGTITLE>" 0 $bl]]"
#set songurl [string range $bl [shrink + 9 "<SONGURL>" 0 $bl] [shrink - 1 "</SONGURL>" 0 $bl]]
#set bitrate "bitrate: [string range $bl [shrink + 9 "<BITRATE>" 0 $bl] [shrink - 1 "</BITRATE>" 0 $bl]]"
#set stitle "stitle: [string range $bl [shrink + 13 "<SERVERTITLE>" 0 $bl] [shrink - 1 "</SERVERTITLE>" 0 $bl]]"
#set sgenre "sgenre: [string range $bl [shrink + 13 "<SERVERGENRE>" 0 $bl] [shrink - 1 "</SERVERGENRE>" 0 $bl]]"
#}}
#close $sock
#}
#
#set temp [open "isonline" w+]
#puts $temp "$streamstatus\n$repl\n$curhigh\n$cursong\n$bitrate\n$stitle\n$sgenre\n$surl"
#close $temp
#if {$announce == 1 } {
#if {$streamstatus == "isonline: 0" && $oldisonline == "isonline: 1"} {
#	poststuff privmsg $offlinetext
#	if {$doalertadmin == "1"} { sendnote domsen $alertadmin "La radio Esta Ahora APAGADA" }
#	if {$urltopic == 1} { poststuff topic $offlinetopic }
#}
#if {$streamstatus == "isonline: 1" && $oldisonline == "isonline: 0" } {
#if {$sgenre != ""} {
#set sgenre " ([lrange $sgenre 1 [llength $sgenre]] )"
#}
#poststuff privmsg "$onlinetext"
#if {$urltopic == 1} { poststuff topic "$onlinetopic" }
#}}
#if {($tellusers == 1) && ($streamstatus == "isonline: 1") && ($oldcurhigh != "curhigh: 0") } {
#if {$oldcurhigh != $curhigh} {
#poststuff privmsg ""
##poststuff privmsg "Posibles Oyentes: [lindex $curhigh 1]"
#}
#if {$oldcurlist != $repl} {
#poststuff privmsg ""
##poststuff privmsg " Actualmente hay : 4 [lindex $repl 1] ($currentl)  Oyentes"
#}}
#if {($tellsongs == 1) && ($oldsong != $cursong) && ($streamstatus == "isonline: 1") } {
#if {$songurl != ""} { set songurl " ($songurl)"}
#regsub -all "&#x3C;" $cursong "<" cursong
#regsub -all "&#x3E;" $cursong ">" cursong
#regsub -all "&#x26;" $cursong "+" cursong  
#regsub -all "&#x22;" $cursong "\"" cursong
#regsub -all "&#x27;" $cursong "'" cursong
#regsub -all "&#xFF;" $cursong "" cursong
#regsub -all "&#xB4;" $cursong "´" cursong
#regsub -all "&#x96;" $cursong "-" cursong
#regsub -all "&#xF6;" $cursong "ö" cursong
#regsub -all "&#xE4;" $cursong "ä" cursong
#regsub -all "&#xFC;" $cursong "ü" cursong
#regsub -all "&#xD6;" $cursong "Ö" cursong
#regsub -all "&#xC4;" $cursong "Ä" cursong
#regsub -all "&#xDC;" $cursong "Ü" cursong
#regsub -all "&#xDF;" $cursong "ß" cursong
#putlog $cursong
#}
#
#if {($tellbitrate == 1) && ($oldbitrate != $bitrate) && ($streamstatus == "isonline: 1") && ($oldbitrate != "bitrate: 0")} {
#poststuff privmsg "Calidad Sonido a [lindex $bitrate 1]kbps"
#}}}


### !dj_ 
proc proc_serdj { nick uhost hand chan text } {
global djnick adminchans adminchans2 djadminchans chans 
global ciudadtxt djtxt ciudad dj 
putlog "$adminchans"
	if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
		if {$text == ""} { putserv "PRIVMSG $chan :\002 $nick, Usa !dj_ <ciudad>  Ejem. !dj_ Peru \002" ; return 0 }  
		
		poststuff privmsg "1»10R1« 10Agradece1 La Magnífica Emision A 1.:6¤1:. 10 $dj 1.:6¤1:. Emitiendo Ahora 1»6¤1«10 $nick 1»6¤1« 1Sintoniza En: 10https://radio.puntochat.net 11Radio Mars la radio estelar que prende tus sentidos 11»10L1«"
		putquick "MODE #radio -o $dj"
		putquick "MODE #radio +v $dj"
		putquick "MODE #radio +o $nick"

		set ciudad [lindex $text 0]
		set dj $nick
		
		set temp [open $ciudadtxt w+]
			puts $temp $ciudad
		close $temp
		
		set temp [open $djtxt w+]
			puts $temp $dj
		close $temp		
		
	}
}

### !auto
proc proc_auto { nick uhost hand chan text } {
global dj ciudad djtxt ciudadtxt peticionestxt peticiones
	poststuff privmsg "1»10R1« 10Agradece1 La Magnífica Emision A 1.:6¤1:. 10 $dj 1.:6¤1:. Emitiendo Ahora 1»6¤1«10 AutoMix 1»6¤1« 1Sintoniza En: 10https://radio.puntochat.net 11Radio Mars la radio estelar que prende tus sentidos 11»10L1«"
	set temp [open $djtxt w+]
		set dj "AutoMix"
		puts $temp "Auto"
	close $temp
	
	set temp [open $ciudadtxt w+]
	  set ciudad "PuntoChat"
		puts $temp "PuntoChat"
	close $temp
	
	set temp [open $peticionestxt w+]
	 set peticiones "Cerradas"
		puts $temp "Cerradas"
	close $temp
}

### !rl 
proc proc_rl { nick uhost hand chan text } {
	putserv "privmsg $chan :  1$nick »10R1« 1Comandos Radio .¤. RadioMars .¤. 10!Enlace 1 Para Ver Nuestro Link 10!Tema1 Conoces La Cancion Que Está 1Sonando 10!Dj 1Nuestro Dj En Emision 10!Pido Tema Artista 1Para Pedir Temas 10!Facebook 1- 10!Tunein - !Winamp - !Reproductor - !xiialive - !app 1Gracias1 Por Sintonizar 10https://radio.puntochat.net 61Radio Mars la radio estelar que prende tus sentidos6 1»10L1«"
}

### !enlace
proc proc_enlace { nick uhost hand chan arg } {
	putserv "privmsg $chan :   1 $nick »10R1« 1Sintoniza En: 10https://radio.puntochat.net 61Radio Mars la radio estelar que prende tus sentidos 61»10L1« "
}

### !dj
proc proc_dj { nick uhost hand chan arg } {
global dj
putserv "privmsg $chan : 1$nick »10R1« 1Emitiendo:  1»6¤1«10 $dj 1»6¤1«  1Sintoniza En: 10https://radio.puntochat.net 61Radio Mars la radio estelar que prende tus sentidos 61»10L1«" 
}

###  !pido
proc proc_pido { nick uhost hand chan arg } {
global peticiones djadminchans dj botnick
	 putlog "$peticiones" 
	 if {$peticiones == "Abiertas"} {
			if {$arg == ""} {putserv "privmsg $chan :\002 1$nick 1»10R1« 0101Para pedir una cancion Use !pido <tema>  1»10L1«\002";return 0}
	 
	 putserv "privmsg $djadminchans :1$dj 1»10R1« 10$nick 1 Pide $arg Desde $chan 1»10L1«"
	 putserv "privmsg $dj :1$dj 1»10R1« 10$nick 1 Pide $arg Desde $chan 1»10L1«"
	 putserv "privmsg $chan :  1$nick 1»10R1« 1Tu 0110Peticion 01Ha 01Sido 01Registrada 01En 01Un 01Momento 01Se 01Te 0110Complacerá 1... Por Favor Espera 6 3 01 Minutos 01Para 01Pedir 10Otra 01Canción. Gracias Por Sintonizar 10https://radio.puntochat.net 1»10L1«"
   	
	 newignore $nick $botnick "Ignore por peticion de cancion, duracion 3minutos" 3		
	 } else {
	   putserv "privmsg $chan :  1$nick 1»10R1« 0101En 0101Este 0101Momento Las Peticiones Están 6Cerradas 1Espera Que Nuestro Dj Vuelva Abrir Peticiones 1Gracias Por Sintonizar 10https://radio.puntochat.net 1»10L1«"
	 }
}

### !tema

proc proc_tema { nick uhost hand chan arg } {
global streamip streamport streampass dj
putlog "shoutcast: $nick pedido la canción actual"
if {[catch {set sock [socket $streamip $streamport] } sockerror]} {
putlog "error: $sockerror"
return 0 } else {
puts $sock "GET /stats?sid=1 HTTP/1.0" 
puts $sock "User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9)"
puts $sock "Host: $streamip"
puts $sock "Connection: close"
puts $sock ""
flush $sock
while {[eof $sock] != 1} {
set bl [gets $sock]
if { [string first "standalone" $bl] != -1 } {
set songtitle [string range $bl [shrink + 11 "<SONGTITLE" 0 $bl] [shrink - 1 "</SONGTITLE>" 0 $bl]]
regsub -all "&#x3C;" $songtitle "<" songtitle
regsub -all "&#x3E;" $songtitle ">" songtitle
regsub -all "&#x26;" $songtitle "+" songtitle  
regsub -all "&#x22;" $songtitle "\"" songtitle
regsub -all "&#x27;" $songtitle "'" songtitle
regsub -all "&#xFF;" $songtitle "" songtitle
regsub -all "&#xB4;" $songtitle "´" songtitle
regsub -all "&#x96;" $songtitle "-" songtitle
regsub -all "&#xF6;" $songtitle "ö" songtitle
regsub -all "&#xE4;" $songtitle "ä" songtitle
regsub -all "&#xFC;" $songtitle "ü" songtitle
regsub -all "&#xD6;" $songtitle "Ö" songtitle
regsub -all "&#xC4;" $songtitle "Ä" songtitle
regsub -all "&#xDC;" $songtitle "Ü" songtitle
regsub -all "&#xDF;" $songtitle "ß" songtitle

	putserv "privmsg $chan : 1 $nick »10R1« 1El Tema En Este Momento Es:1 $songtitle 1 Sintoniza En: 10https://radio.puntochat.net 61Radio Mars la radio estelar que prende tus sentidos 61»10L1«" 
}}
close $sock
	}}

### !oyentes
proc proc_oyentes { nick uhost hand chan arg } {
global streamip streamport streampass adminchans
putlog "shoutcast: $nick cuenta solicitada del oyente"
	if {[catch {set sock [socket $streamip $streamport] } sockerror]} {
		putlog "error: $sockerror"
		return 0 } else {
			puts $sock "GET /stats?sid=1 HTTP/1.0"
			puts $sock "User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9)"
			puts $sock "Host: $streamip"
			puts $sock "Connection: close"
			puts $sock ""
			flush $sock
				while {[eof $sock] != 1} {
					set bl [gets $sock]
					if { [string first "standalone" $bl] != -1 } {
						set repl [string range $bl [shrink + 18 "<CURRENTLISTENERS>" 0 $bl] [shrink - 1 "</CURRENTLISTENERS>" 0 $bl]]
						set curhigh [string range $bl [shrink + 15 "<PEAKLISTENERS>" 0 $bl] [shrink - 1 "</PEAKLISTENERS>" 0 $bl]]
						set maxl [string range $bl [shrink + 14 "<MAXLISTENERS>" 0 $bl] [shrink - 1 "</MAXLISTENERS>" 0 $bl]]
						set avgtime [string range $bl [shrink + 13 "<AVERAGETIME>" 0 $bl] [shrink - 1 "</AVERAGETIME>" 0 $bl]]
					}}
			close $sock
			putserv "notice $nick :  1$nick »10R1« Actualmente hay $repl Oyente(s), La Radio Tiene Capacidad para $maxl Oyentes, el número máximo de Oyentes Hasta Ahora es de $curhigh Oyentes, el promedio de escucha es a $avgtime 1»10L1«"
			}

}

### xiialive, facebook, tunein, winamp, reproductor

proc pub_xiialive { nick uhost hand chan arg } {
	putserv "privmsg $chan : 1»10R1«10 Xiialive 1- Búscanos RadioMars 1212121212121https://radio.puntochat.net 1»10L1«"
}

proc pub_facebook { nick uhost hand chan arg } {
	putserv "privmsg $chan :  1$nick »10R1« 1210Facebook 1Https://www.facebook.com/fbpuntochat 1»10L1«"
}

proc pub_tunein { nick uhost hand chan arg } {
	putserv "privmsg $chan :  1$nick »10R1« 10Tunein 1	https://radio.pro-fhi.net:2199/tunein/ytdywjnt.pls1»10L1« "
}

proc pub_winamp { nick uhost hand chan arg } {
	putserv "privmsg $chan :  1$nick »10R1« 10Presiona 1Ctrl + L en 10Winamp 1y 10Pega: 1212121https://radio.pro-fhi.net:2199/tunein/ytdywjnt.pls6 1»10L1«"
}

proc pub_reproductor { nick uhost hand chan arg } {
	putserv "privmsg $chan :   1$nick »10R1«10 Reproductor 12121212121212121	https://radio.pro-fhi.net:2199/tunein/ytdywjnt.pls 1»10L1«"
}

proc pub_rlapp { nick uhost hand chan arg } {
	putserv "privmsg $chan :  \0021»10R1«10 RL APP 1- Descarga Nuestra App Para tu Celular y/o Tablet Desde 121	https://radio.pro-fhi.net:2199/tunein/ytdywjnt.pls 1»10L1«"
}

### !abre , !cierra y !status.peticiones

proc pub_abrepeticiones { nick uhost hand chan arg } {
global djadminchans dj peticiones peticionestxt
		if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
			poststuff privmsg " 16 1»10R1« 0101En 0101Este 0101Momento Nuestro Dj 1:6¤1:110 $dj 1:6¤1:1 Abre Las 6Peticiones 10!Pido 6Tema Artista 1Gracias Por Sintonizar: 10https://radio.puntochat.net 1»10L1«"
			set temp [open $peticionestxt w+]
				set peticiones "Abiertas"
				puts $temp $peticiones
			close $temp
	 }
}

proc pub_cierrapeticiones { nick uhost hand chan arg } {
global djadminchans dj peticiones peticionestxt
	if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
		poststuff privmsg " 1»10R1« 0101En 0101Este 0101Momento Nuestro Dj 1:6¤1:110 $dj 1:6¤1:1 Cierra Las 6Peticiones 1Gracias Por Sintonizar: 10https://radio.puntochat.net 1»10L1«"
		set temp [open $peticionestxt w+]
			set peticiones "Cerradas"
			puts $temp $peticiones
		close $temp
	}
}

proc pub_statuspeticiones { nick uhost hand chan arg } {
global peticiones
	putserv "privmsg $chan :PETICIONES: Las Peticiones estan $peticiones"
}

proc shrink { calc number string start bl} { return [expr [string first "$string" $bl $start] $calc $number] }


putlog "Shoutcast.tcl by Dannyelito"
