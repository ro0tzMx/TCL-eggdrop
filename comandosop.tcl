#canal donde funcionará los comandos
set channel "#opers"
 
# seccion o ruta donde leera el archivo del contador
set swearkicks "swearkicks.dat"
 
#bind del contador
bind kick - * swear:kick:counter
 
bind pub nhlO|nlhO !kbn proc_bakbn
proc proc_bakbn { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]!*@*
    putquick "kick $chan  $text :1\[M\] $nick -> Nick Inadecuado. Cambielo Asi: /Nick pepito y Vuelve a Entrar. "
    putquick "MODE $chan +b $ban"   
  } else { putquick "PRIVMSG $chan : 4ERROR1Syntaxis incorrecta o usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !rep1 proc_rep1
proc proc_rep1 { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    putquick "PRIVMSG $chan :1\[12$text\1] --> \[12Aviso #1\1] Por favor, 12No repita. 1Con una vez ya te leemos. Gracias."
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !rep2 proc_rep2
proc proc_rep2 { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    putquick "PRIVMSG $chan :1\[12$text\1] --> \[12Aviso #2\1] Por favor, 12No repita. 1Con una vez ya te leemos. Gracias." 
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbr proc_kbr
proc proc_kbr { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> No se Permiten las Repeticiones Excesivas en el Canal. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !cap1 proc_cap1
proc proc_cap1 { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    putquick "PRIVMSG $chan :1\[12$text\1] --> \[12Aviso #1\1] Por favor, 12Desactiva 1las 12Mayúsculas 1No Estan Permitidas en el Canal. Gracias."
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !cap2 proc_cap2
proc proc_cap2 { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    putquick "PRIVMSG $chan :1\[12$text\1] --> \[12Aviso #2\1] Por favor, 12Desactiva 1las 12Mayúsculas 1No Estan Permitidas en el Canal. Gracias."  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbm proc_kbm
proc proc_kbm { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> No se Permiten las Mayúsculas en el Canal. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !flood1 proc_flood1
proc proc_flood1 { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    putquick "PRIVMSG $chan :1\[12$text\1] --> \[12Aviso #1\1] Por favor 12Escribe 1en una 12Sola línea. 1Gracias"
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !flood2 proc_flood2
proc proc_flood2 { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    putquick "PRIVMSG $chan :1\[12$text\1] --> \[12Aviso #2\1] Por favor 12Escribe 1en una 12Sola línea. 1Gracias"   
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbf proc_kbf
proc proc_kbf { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> No se Permite Escribir Muchas Lineas Seguidas. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbs proc_bakbs
proc proc_bakbs { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> No se Permite la temática sexual en el esta sala. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbi proc_bakbi
proc proc_bakbi { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> No está Permitido insultar/molestar/faltar al Respeto. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbd proc_bakbd
proc proc_bakbd { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> No está permitido pasar datos personales por el canal. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbt proc_bakbt
proc proc_bakbt { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> No se puede Pedir/Ofrecer Empleo en el Canal. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbsp proc_bakbsp
proc proc_bakbsp { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> Spam/Publicidad no Permitida en el Canal. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kbw proc_bakbw
proc proc_bakbw { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> No se puede Pedir/Ofrecer Drogas en el Canal. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kba proc_bakba
proc proc_bakba { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> Actividad no permitida en el canal, Moderese. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
 
bind pub nhlO|nlhO !kb2 proc_bakick
proc proc_bakick { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "kick $chan  $text :1\[M\] $nick -> Incumplimiento de las Normas del Canal. "
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !ban proc_ban
proc proc_ban { nick uhost hand chan text } {
  global botnick Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    set ban [lindex $text 0]
    set mask *!*@[lindex [split [getchanhost $ban] @] 1]
    putquick "MODE $chan +b $mask"  
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
bind pub nhlO|nlhO !kb1 proc_bakickban
proc proc_bakickban { nick uhost hand chan text } {
  global botnick swearkicks Channel
 set arg1 [lindex $text 2]
  if {[onchan $text]} {
    if {$text == $botnick} { return 0 }
    if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
    set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
    putquick "kick $chan  $text :1\[M\] $nick -> Incumplimiento de las Normas del Canal. "
  } else { putquick "PRIVMSG $chan : 4ERROR1 Syntaxis Incorrecta O Usuario no encontrado en la lista de usuarios." }
}
 
#principio del kb
bind pub nhlO|nlhO !kb do_kbb
proc do_kbb {nick uhost hand chan text} {
global botnick swearkicks
set kickeado [lindex $text 0]
set razon [lrange $text 1 end]
set mask *!*@[lindex [split [getchanhost $kickeado] @] 1]
if {(![file exists $swearkicks])} { set file [open $swearkicks "w"]; puts $file 1; close $file }
set file [open $swearkicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr $currentkicks];
if {$kickeado == ""} {
putquick "PRIVMSG $chan :\037ERROR\037: Debes Poner un Nick. \037SYNTAX\037: !kb Nick Motivo"
return 1
}
if {$razon == ""} {
putquick "PRIVMSG $chan :\037ERROR\037: Debes Poner un Motivo. \037SYNTAX\037: !kb Nick Motivo"
return 1
}
if {![onchan $kickeado $chan]} {
putserv "PRIVMSG $chan :\037ERROR\037: $kickeado No se encuentra en $chan"
return 1
} 
putquick "KICK $chan $kickeado :\[M\] $nick -> $razon "
putquick "MODE $chan +b $mask"
return 1
}
#Final del kb
 
#principio del kb
bind pub nhlO|nlhO !unban un_ban
proc un_ban {nick uhost hand chan text} {
global botnick
set ubnick [lindex $text 0]
if {$text == ""} {
putquick "PRIVMSG $chan :\037ERROR\037: !unban Nick/Ident/Host"
return 1
} 
putquick "MODE $chan -b $ubnick"
putquick "PRIVMSG $chan :\037OK!\037: Ban Removido de $chan."
return 1
}
#Final del kb
