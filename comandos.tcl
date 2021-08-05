#####Comandos
set adminchans "#radio_music"
set adminchans2 "#radio_music"
set djadminchans "#radio_music"
set chans ""

set addfile "saludos.dat"

bind pub n !restart proc_restart
bind pub n !rehash proc_rehash
bind pub O !op proc_op
bind pub O !deop proc_deop
bind pub O !voice proc_voice
bind pub O !devoice proc_devoice
bind pub O !comandos proc_command
bind pub A !join proc_join
bind pub A !part proc_part
bind pub A !ame proc_ame
bind pub A !ignore proc_ignore
bind pub A !uignore proc_quitarignore
bind pub A !lista.founder proc_listafounder
bind pub A !lista.cofounder proc_listacofounder
bind pub A !lista.root proc_listaroot
bind pub A !lista.admin proc_listaadmin
bind pub A !lista.dj proc_listadj
bind pub A !lista.amig@rl proc_listaAmigRL
bind pub F !añade.founder addfundadora
bind pub F !añade.cofounder addcofounder
bind pub A !añade.root addroot
bind pub A !añade.admin addadmin
bind pub A !añade.dj adddj
bind pub A !añade.Amig@RL addAmigRL

bind join - * joinnick                              
bind nick - * changenick

bind pub D !datosradio procdatos
proc procdatos { nick uhost hand chan text } {
  putquick "PRIVMSG $nick : IP: 213.165.68.183 "
  putquick "PRIVMSG $nick : Puerto: 9223 "
  putquick "PRIVMSG $nick : Clave: avaavamigue2010 "
  
}

proc proc_die { nick uhost hand chan text } {
 if {$text == ""} {
  die $nick
 } else { die $text }
}

proc proc_restart { nick uhost hand chan text } {
  putquick "PRIVMSG $chan :Restart Pedido por \002$nick\002."
  restart
}

proc proc_rehash { nick uhost hand chan text } {
  putquick "PRIVMSG $chan :Rehash Pedido por \002$nick\002. "
  rehash
}

### comandos op deop voice devoice
proc proc_op { nick uhost hand chan text } {
 if {$text == ""} {
  putserv "MODE $chan +o $nick"
  return 0 
 }
  putserv "MODE $chan +o $text"
}

proc proc_deop { nick uhost hand chan text } {
  global botnick
  if {$text == $botnick} {
    putserv "PRIVMSG $chan :Eso ni lo pienses causita!!"
    return 0
  }
   if {$text == ""} {
     putserv "MODE $chan -o $nick"
     return 0
   }
putserv "MODE $chan -o $text"
}

proc proc_voice { nick uhost hand chan text } {
  if {$text == ""} {
  putserv "MODE $chan +v $nick"
  return 0 
 }
  putserv "MODE $chan +v $text"
}

proc proc_devoice { nick uhost hand chan text } {
  global botnick
  if {$text == $botnick} {
    putserv "PRIVMSG $chan :Eso nooooo!!"
    return 0
  }
   if {$text == ""} {
     putserv "MODE $chan -v $nick"
     return 0
   }
putserv "MODE $chan -v $text"
}

### comando !comandos
proc proc_command { nick host hand chan arg } {
global adminchans
	if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
		putserv "PRIVMSG $adminchans : 1»10R1« 1 Para ver los comandos del bot entre en el siguiente enlace https://comandos.puntochat.net/ 1»10L1«"
	}
}

### entra y sale de canales
proc proc_join { nick host hand chan arg } {
global adminchans 
	if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
			if {$arg == ""} { 
			   putserv "PRIVMSG $adminchans :\002 $nick Use !join <canal> Ejem: !join #radio_"
    		return 0
			}
			channel add $arg
			save
			rehash
			putserv "PRIVMSG $adminchans : 1»10R1« 1Entrando a 10 $arg 1»10L1«"
	}
}

proc proc_part { nick host hand chan arg } {
global adminchans canal
	if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
		if {$arg == ""} { 
		  putserv "PRIVMSG $adminchans :\002 $nick Use !part <canal> Ejem: !part #radio_"
    	return 0
		}
		channel remove $arg
		save
		rehash
 		putserv "PRIVMSG $adminchans : 1»10R1« 1Saliendo de 10 $arg 1»10L1«"
	}
}

### mensajes por /ame
proc proc_ame { nick uhost hand chan text } {
		foreach chan [channels] {
				 putact $chan "$text"
	  }		
}

### ignores
proc proc_ignore { nick uhost hand chan text } {
global adminchans 
	if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
   	newignore $text $nick "Ignore agregado por $nick el [clock format [clock seconds] -format "%d.%m%Y"] a las [clock format [clock seconds] -format %H:%M:%S] " 0 
   	putserv "PRIVMSG $adminchans : 1»10R1« 1 Ignore agregado a $text 1»10L1«" 
  }
}

proc proc_quitarignore { nick uhost hand chan text } {
global adminchans 
	if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
   	killignore $text
   	putserv "PRIVMSG $adminchans : 1»10R1« 1 Ignore retirado a $text 1»10L1«" 
  }
}

### lista usuarios
proc proc_listafounder { nick uhost hand chan text } {
global adminchans
	if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
	 set master "founder"
	 set lista(unf) ""
	 foreach host [getuser $master hosts] { 
	 		set results [split $host "!"]
	 		set nik [lindex $results 0]
	    append lista(unf) " $nik "
	 }
		foreach ann [array names lista] {
	 		append tout1 "$lista(unf)"
		}
	putserv "PRIVMSG $adminchans : 1»10R1« 1 [join $tout1] 1»10L1«" 
}}

proc proc_listacofounder { nick uhost hand chan text } {
global adminchans
if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
	 set master "cofounder"
	 set lista(unf) ""
	 foreach host [getuser $master hosts] { 
	 		set results [split $host "!"]
	 		set nik [lindex $results 0]
	    append lista(unf) " $nik "
	 }
		foreach ann [array names lista] {
	 		append tout1 "$lista(unf)"
		}
	putserv "PRIVMSG $adminchans : 1»10R1« 1 [join $tout1] 1»10L1«" 
}}

proc proc_listaroot { nick uhost hand chan text } {
global adminchans
if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
	 set master "root"
	 set lista(unf) ""
	 foreach host [getuser $master hosts] { 
	 		set results [split $host "!"]
	 		set nik [lindex $results 0]
	    append lista(unf) " $nik "
	 }
		foreach ann [array names lista] {
	 		append tout1 "$lista(unf)"
		}
	putserv "PRIVMSG $adminchans : 1»10R1« 1 [join $tout1] 1»10L1«" 
}}

proc proc_listaadmin { nick uhost hand chan text } {
global adminchans
if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
	 set master "admin"
	 set lista(unf) ""
	 foreach host [getuser $master hosts] { 
	 		set results [split $host "!"]
	 		set nik [lindex $results 0]
	    append lista(unf) " $nik "
	 }
		foreach ann [array names lista] {
	 		append tout1 "$lista(unf)"
		}
	putserv "PRIVMSG $adminchans : 1»10R1« 1 [join $tout1] 1»10L1«" 
}}

proc proc_listadj { nick uhost hand chan text } {
global adminchans
if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
	 set master "djs"
	 set lista(unf) ""
	 foreach host [getuser $master hosts] { 
	 		set results [split $host "!"]
	 		set nik [lindex $results 0]
	    append lista(unf) " $nik "
	 }
		foreach ann [array names lista] {
		 	append tout1 "$lista(unf)"
		}
	putserv "PRIVMSG $adminchans : 1»10R1« 1 [join $tout1] 1»10L1«" 
}}

proc proc_listaAmigRL { nick uhost hand chan text } {
global adminchans
if {([lsearch -exact [string tolower $adminchans] [string tolower $chan]] != -1) || ($adminchans == "")} {
	 set master "amigarl"
	 set lista(unf) ""
	 foreach host [getuser $master hosts] { 
	 		set results [split $host "!"]
	 		set nik [lindex $results 0]
	    append lista(unf) " $nik "
	 }
		foreach ann [array names lista] {
		 	append tout1 "$lista(unf)"
		}
	putserv "PRIVMSG $adminchans : 1»10R1« 1 [join $tout1] 1»10L1«" 
}}

### almacena usuarios en un array
proc init_gusers {} {
global ug_nick ug_ni addfile				   
	if {[file exists $addfile]} {		       
	  set in [open $addfile r]			   
	  	while {![eof $in]} {					   
		    set vline [gets $in]                           
		    if {[eof $in]} {break}  				  
		    set snick [lindex $vline 0]			   
		    set sgreet [lrange $vline 1 end]		   
		    regsub -all -- {\{} $sgreet {} sgreet		  
		    regsub -all -- {\}} $sgreet {} sgreet          
		    set ug_nick($snick) $sgreet                    
	    }								   
	  close $in							   
  }								   
}
init_gusers

### agrega usuarios
proc addfundadora { nick uhost hand chan text } {
global ug_nick ug_ni addfile djadminchans
if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
   set host $text!*@*
   set master "founder"
   set mensajeFounder "  1»10R1« 10R1adio-10M1ars Recibe A Su 10Fundador 1Con Orgullo 10:6†10: $text 10:6†10:"
   if {[file exists $addfile]} {		       
	  set in [open $addfile r]			   
	  	while {![eof $in]} {					   
		    set vline [gets $in]                           
		    if {[eof $in]} {break}  				  
		    set snick [lindex $vline 0]
 	    if {$snick == $text} {
 	    	putserv "PRIVMSG $djadminchans :1 $nick 1»10R1« $text, Ya existe como usuario en el bot 1»10L1«"	
 	    	return 0
 	    }
     }
   close $in							   
    set out [open $addfile a]		  
    	puts $out "$text $mensajeFounder"
    close $out
   }	    
   setuser $master hosts $host
   save
   rehash
   putserv "PRIVMSG $djadminchans : 1 $nick 1»10R1« $text Ha Sido Agregado Como Fundador 1»10L1«"	   				
}}

proc addcofounder { nick uhost hand chan text } {
	global ug_nick ug_ni addfile djadminchans
if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
   set host $text!*@*
   set master "cofounder"
   set mensajeCofounder " 1»10R1« 10R1adio-10M1ars Recibe A Su 10Co-Fundador 1Con Orgullo 10:6†10: $text 10:6†10:"
   if {[file exists $addfile]} {		       
	  set in [open $addfile r]			   
	  	while {![eof $in]} {					   
		    set vline [gets $in]                           
		    if {[eof $in]} {break}  				  
		    set snick [lindex $vline 0]
 	    if {$snick == $text} {
 	    	putserv "PRIVMSG $djadminchans :1 $nick 1»10R1« $text, Ya existe como usuario en el bot 1»10L1«"	
 	    	return 0
 	    }
     }
   close $in							   
    set out [open $addfile a]		  
    	puts $out "$text $mensajeCofounder"
    close $out
   }	    
   setuser $master hosts $host
   save
   rehash
   putserv "PRIVMSG $djadminchans : 1 $nick 1»10R1« $text Ha Sido Agregado Como Co-Fundador 1»10L1«"	  				
}}

proc addroot { nick uhost hand chan text } {
	global ug_nick ug_ni addfile djadminchans
if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
   set host $text!*@*
   set master "root"
   
   if {[file exists $addfile]} {		       
	  set in [open $addfile r]			   
	  	while {![eof $in]} {					   
		    set vline [gets $in]                           
		    if {[eof $in]} {break}  				  
		    set snick [lindex $vline 0]
 	    if {$snick == $text} {
 	    	putserv "PRIVMSG $djadminchans :1 $nick 1»10R1« $text, Ya existe como usuario en el bot 1»10L1«"	
 	    	return 0
 	    }
     }
   close $in							   
    set out [open $addfile a]		  
    	puts $out "$text $mensajeRoot"
    close $out
   }	    
   setuser $master hosts $host
   save
   rehash
   putserv "PRIVMSG $djadminchans : 1 $nick 1»10R1« $text Ha Sido Agregado Como Root 1»10L1«"	  				
}}

proc addadmin { nick uhost hand chan text } {
	global ug_nick ug_ni addfile djadminchans
if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
   set host $text!*@*
   set master "admin"
   set mensajeAdmin " 1»10R1« 10R1adio-10M1ars Recibe A Su 10Admin 1Con Orgullo 10:6†10: $text 10:6†10:"
   if {[file exists $addfile]} {		       
	  set in [open $addfile r]			   
	  	while {![eof $in]} {					   
		    set vline [gets $in]                           
		    if {[eof $in]} {break}  				  
		    set snick [lindex $vline 0]
 	    if {$snick == $text} {
 	    	putserv "PRIVMSG $djadminchans :1 $nick 1»10R1« $text, Ya existe como usuario en el bot 1»10L1«"	
 	    	return 0
 	    }
     }
   close $in							   
    set out [open $addfile a]		  
    	puts $out "$text $mensajeAdmin"
    close $out
   }	    
   setuser $master hosts $host
   save
   rehash
   putserv "PRIVMSG $djadminchans : 1 $nick 1»10R1« $text Ha Sido Agregado Como Admin 1»10L1«"	  				
}}

proc adddj { nick uhost hand chan text } {
	global ug_nick ug_ni addfile djadminchans
if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
   set host $text!*@*
   set master "djs"
   set mensajeDj "  10R1adio-10M1ars Recibe a su 10Dj  10:6†10: $text 10:6†10:"
   if {[file exists $addfile]} {		       
	  set in [open $addfile r]			   
	  	while {![eof $in]} {					   
		    set vline [gets $in]                           
		    if {[eof $in]} {break}  				  
		    set snick [lindex $vline 0]
 	    if {$snick == $text} {
 	    	putserv "PRIVMSG $djadminchans :1 $nick 1»10R1« $text, Ya existe como usuario en el bot 1»10L1«"	
 	    	return 0
 	    }
     }
   close $in							   
    set out [open $addfile a]		  
    	puts $out "$text $mensajeDj"
    close $out
   }	    
   setuser $master hosts $host
   save
   rehash
   putserv "PRIVMSG $djadminchans : 1 $nick 1»10R1« $text Ha Sido Agregado Como Dj 1»10L1«"	  				
}}

proc addAmigRL { nick uhost hand chan text } {
	global ug_nick ug_ni addfile djadminchans
if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {
   set host $text!*@*
   set master "amigarl"
   set mensajeAmigaRL " 1»10R1« 10R1adio-10M1ars Recibe A Su 10Amig@RL 1Con Orgullo 10:6†10: $text 10:6†10:"
   if {[file exists $addfile]} {		       
	  set in [open $addfile r]			   
	  	while {![eof $in]} {					   
		    set vline [gets $in]                           
		    if {[eof $in]} {break}  				  
		    set snick [lindex $vline 0]
	 	    if {$snick == $text} {
	 	    	putserv "PRIVMSG $djadminchans :1 $nick 1»10R1« $text, Ya existe como usuario en el bot 1»10L1«"	
	 	    	return 0
	 	    }
     }
   close $in							   
    set out [open $addfile a]		  
    	puts $out "$text $mensajeAmigaRL"
    close $out
   }	    
   setuser $master hosts $host
   save
   rehash
   putserv "PRIVMSG $djadminchans : 1 $nick 1»10R1« $text Ha Sido Agregado Como Amig@RL 1»10L1«"	  				
}}

### borra usuarios                        
bind pub A !borra proc_del_user
proc proc_del_user { nick uhost hand chan args } {
	
 global ug_nick ug_ni	addfile	djadminchans
if {([lsearch -exact [string tolower $djadminchans] [string tolower $chan]] != -1) || ($djadminchans == "")} {	 
 set acmd [lindex $args 0]				  
 set unick [lindex $acmd 0]				   
 	if {([info exists ug_nick($unick)])} {           
	   unset ug_nick($unick)				   
	   set out [open $addfile w]		   
		   foreach search [array names ug_nick] {		  
		     if {$search != 0} {				   
		       set snick $search   				   
		       set sgreet $ug_nick($search)	 
		       set output "$snick $sgreet"	   
		       puts $out $output				   
		       }						         
		     }							   
	   close $out						   
		 putserv "PRIVMSG $djadminchans : 1 $nick 1»10R1« $unick Ha Sido Eliminado 1»10L1«"
   } else {							   
	putserv "PRIVMSG $djadminchans : 1 $nick 1»10R1« $unick No se encuentra en la DataBase 1»10L1«"     
  return 0 
   }
proc_borramaster $nick $uhost $hand $chan $args
							   
}}                   
                                          
proc proc_borramaster { nick uhost hand chan args } {
   set host $args!*@*
   set master1 "founder"
   set master2 "cofounder"
   set master3 "root"
   set master4 "admin"
   set master5 "djs"
   set master6 "amigarl"
   delhost $master1 $host
   delhost $master2 $host
	 delhost $master3 $host
   delhost $master4 $host
   delhost $master5 $host
   delhost $master6 $host
   save
  rehash
  putquick "PRIVMSG $chan : 1 $nick 1»10R1« $args Ha Sido Eliminado 1»10L1«"
}

###join nick & change nick
set channel1 "#Ritmo-Latino"
set channel2 "#lc-eeuu"
set channel3 "#lc-venezuela"
set channel4 "#LC-de_20_a_30"
proc joinnick {nick uhost hand chan} {
 global ug_nick ug_ni dj peticiones channel1 channel2 addfile channel3 channel4    
 				if {$chan == $channel2} {
						return 0
				}
#  			if {$chan == $channel3} {
#						if {$nick == "Matiasssss"} { putserv "PRIVMSG $chan : 1»10R1« 10R1adio-10M1ars Recibe A Uno De Sus Mejores Amigos 1Con Orgullo 10:6†10: Matias 10:6†10: 1En 1#lc-venezuela 1»10L1«" }
#						if {$nick == "gat0mal0ssss"} { putserv "PRIVMSG $chan : 1»10R1« 10R1adio-10M1ars Recibe A Uno De Sus Mejores Amigos 1Con Orgullo 10:6†10: gat0mal0 10:6†10: 1En 1#lc-venezuela 1»10L1«" }
#						if {$nick == "DONsssss"} { putserv "PRIVMSG $chan : 1»10R1« 10R1adio-10M1ars Recibe A Uno De Sus Mejores Amigos 1Con Orgullo 10:6†10: DON 10:6†10: 1En 1#lc-venezuela 1»10L1«" }
#				}            
   			if {$chan == $channel4} {
						if {$nick == "aNgEl_BoYsss"} { putserv "PRIVMSG $chan :1»10R1« 10R1adio-10M1ars Recibe A Su 10Brother 1Con Orgullo 10:6†10: aNgEl_BoY 10:6†10: 1En 1#dj's-ritmo-latinos Te Ayudaremos Con Tu Web 121212121www.chateonline.net 1Para Que No Trabajes Solito 1»10L1«" }
				}
   		  if {$chan == $channel1} {
					  putserv "PRIVMSG $channel1 : 1»10R1« ¡1Hola! 6_¤_10 $nick 6_¤_ 1ßienvenid@ 10a 10#RadioMars 61En 1Emision 1.:6¤1:.10 $dj 1.:6¤1:. 6 Peticiones 10$peticiones 1Sintonízanos 1En 10https://radio.puntochat.net 1»10L1«" 
				}		        
			  set in [open $addfile r]			   
			  	while {![eof $in]} {					   
				    set vline [gets $in]                           
				    if {[eof $in]} {break}  				  
				    set snick [lindex $vline 0]
				    set mensaje [lrange $vline 1 end]	
			 	    if {$snick == $nick} {
			 	    	putserv "PRIVMSG $chan : $mensaje 1En 1$chan 1»10L1« "
			 	    }
		     }
		   close $in		   
}

proc changenick {nick uhost hand chan newnick} {
 global ug_nick ug_ni channel2 addfile
 set nick $newnick				
	if {$chan != $channel2} {
 			set in [open $addfile r]			   
			  	while {![eof $in]} {					   
				    set vline [gets $in]                           
				    if {[eof $in]} {break}  				  
				    set snick [lindex $vline 0]
				    set mensaje [lrange $vline 1 end]	
			 	    if {$snick == $newnick} {
			 	    	putserv "PRIVMSG $chan : $mensaje 1En 1$chan 1»10L1« "
				 	    }
		     }
		   close $in
  }
} 
 	 	  
