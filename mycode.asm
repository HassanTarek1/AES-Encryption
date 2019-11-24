; multi-segment executable file template.
INCLUDE 'EMU8086.INC'
.STACK 100H
.DATA
ARR DB 16 DUP(?)
.CODE 

XOR AX,AX
CALL READ
CALL SHIFTROWS
MOV AH,4CH    
INT 21H

    READ PROC        
        MOV AX,@DATA
        MOV DS,AX
        XOR AX,AX
        MOV SI,0
    
        INPUT:CMP SI,16
            JZ  FINISH
            MOV AH,1                                      
            INT 21H 
            MOV DH,AL
            MOV ARR[SI],DH
            INC SI
            JMP INPUT
                       
        FINISH:RET
        READ ENDP 
    SHIFTROWS PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV CX,1
        
        
        LOOP1:
            CMP CX,4
            JZ FIN
         
            MOV SI,CX
            MOV DI,SI
            MOV BL,CL
            ADD DI,SI
            LOOP2:
                  
                  CMP BX,DI
                  JZ CINC
                  MOV BH,0
                  LOOP3:CMP BH,3
                        JZ SINC
                        MOV DL,ARR[SI]
                        MOV AX,4
                        ADD SI,AX
                        INC BH
                        MOV DH,ARR[SI]
                        MOV ARR[SI],DL
                        MOV ARR[SI-4],DH
                        JMP LOOP3
                  
             SINC:
                  SUB SI,12
                  INC BL
                  MOV BH,0 
                  JMP LOOP2
             CINC:
                INC CX
                JMP LOOP1     
        
        FIN:
            RET
            SHIFTROWS ENDP
    
    

      


