'--------------------------------------------------------------
'                   Thomas Jensen | stdout.no
'--------------------------------------------------------------
'  file: AVR_SWITCH_4CH_v.1.0
'  date: 17/02/2007
'--------------------------------------------------------------
$regfile = "attiny2313.dat"
$crystal = 8000000
Config Watchdog = 1024
Config Portb = Output
Config Porta.0 = Input
Config Porta.1 = Input
Config Portd.0 = Input
Config Portd.1 = Input
Config Portd.2 = Input
Config Portd.3 = Output
Config Portd.4 = Output
Config Portd.5 = Output
Config Portd.6 = Output

Dim A As Byte , Ledtimer As Integer
Dim Bryter1 As Bit , Bryter2 As Bit , Bryter3 As Bit , Bryter4 As Bit

Ledtimer = 100
Bryter1 = 0
Bryter2 = 0
Bryter3 = 0
Bryter4 = 0

Portb = 0
Portd.3 = 0
Portd.4 = 0
Portd.5 = 0
Portd.6 = 0

'Boot sequence
For A = 0 To 7
    Portb.a = Not Portb.a                                   'all LEDs on
    Waitms 250
Next A

For A = 0 To 7
    Portb.a = Not Portb.a                                   'all LEDs off
    Waitms 250
Next A

Waitms 1000

Start Watchdog

Main:                                                       'start loop
'Change status
If Pina.0 = 1 And Bryter1 = 0 Then                          'push button 1
   Bryter1 = 1
   Portd.3 = Not Portd.3
   Ledtimer = 100
   End If
If Pina.1 = 1 And Bryter2 = 0 Then                          'push button 2
   Bryter2 = 1
   Portd.4 = Not Portd.4
   Ledtimer = 100
   End If
If Pind.0 = 1 And Bryter3 = 0 Then                          'push button 3
   Bryter3 = 1
   Portd.5 = Not Portd.5
   Ledtimer = 100
   End If
If Pind.1 = 1 And Bryter4 = 0 Then                          'push button 4
   Bryter4 = 1
   Portd.6 = Not Portd.6
   Ledtimer = 100
   End If

'Reset button timers
If Pina.0 = 0 Then Bryter1 = 0                              'push button 1
If Pina.1 = 0 Then Bryter2 = 0                              'push button 2
If Pind.0 = 0 Then Bryter3 = 0                              'push button 3
If Pind.1 = 0 Then Bryter4 = 0                              'push button 4

'LEDs
If Ledtimer > 0 Then
   Decr Ledtimer
   Portb.0 = Portd.3                                        'ch 1 LED green
   Portb.1 = Not Portd.3                                    'ch 1 LED red
   Portb.2 = Portd.4                                        'ch 2 LED green
   Portb.3 = Not Portd.4                                    'ch 2 LED red
   Portb.4 = Portd.5                                        'ch 3 LED green
   Portb.5 = Not Portd.5                                    'ch 3 LED red
   Portb.6 = Portd.6                                        'ch 4 LED green
   Portb.7 = Not Portd.6                                    'ch 4 LED red
   End If
If Ledtimer = 0 Then
   Portb = 0                                                'all LEDs off
   End If

'Lights out
If Pind.2 = 0 Then
   Ledtimer = 100
   Portd.3 = 0
   Portd.4 = 0
   Portd.5 = 0
   Portd.6 = 0
   End If

Reset Watchdog
Waitms 100
Goto Main                                                   'restart loop
End