#Saja Asfour 1210737
#Yara Khattab 1210520
#Section 1


.data 
	newLine:		.asciiz "\n"
	medical_tests:		.space 1000  	# Maximum number of tests to handle
	buffer:			.space 1000  	# Buffer to read a line from the file
	TempBuffer:		.space 1000 	#Buffer for store search test
	fileLoc:		.asciiz "MedicalTest.txt"
	MsgToUser: 		.asciiz	 "\nPlease Choose one of the operation you want from 1-6: \n"
	menu: 			.asciiz	 "Menu: \n"
	option1: 		.asciiz	 "1-Add a new medical test\n"
	option2:		.asciiz	 "2-Search for a test by patient ID\n"
	option3:		.asciiz  "3-Searching for unnormal tests\n"
	option4:		.asciiz  "4-Average test value\n"
	option5:		.asciiz  "5-Update an existing test result\n"
	option6:		.asciiz	  "6-Delete a test\n"
	option7:		.asciiz  "7-Exit the program\n"
	WrongChoose: 		.asciiz  "\nYour Choose is Wrong Please Enter Valid number from previous menu only from 1 to 6:\n"
	Add1:			.asciiz  "Enter a single medical test which should be in the following representation where Patient Id is 7 digit without char\nTest Name is 3 char without numbers\nyear in range from 1950 to 2050 without char\nmonth with range from 01 to 12 without char\nand Result in float representation without char:\n"
	representation:		.asciiz  "Patient ID: TestName, TestDate, result\n"
	fileLoaded :   		.asciiz "File has been loaded"
	strings:		.space 100 	#buffer for store medical test added by user 
	readErrorMsg:		.asciiz "\nError In Reading The File\n"
	openErrorMsg:		.asciiz "\nError In Opening The File\n"
	Errorid:		.asciiz  "The Patient ID is not valid , please Enter ID with 7 digit(int)\n"
	Errorname:		.asciiz  "The test Name is not valid ,please Enter Test Name with 3 character\n"
	Erroryear:		.asciiz  "The year you enter is not valid,please enter year in range  from 1950 to 2050\n"
	Errormonth:		.asciiz  "The month is not valid,please enter month in range from 01 to 12\n"
	floatnumber:		.float 1.0
	floatnumfordiv:		.float 10.0
	Errorfloat:		.asciiz  "The result you enter is invalid please enter it without char\n"
	DoneAddTest:		.asciiz  "Your Test Has been added.\n"
	SelectSearch:		.asciiz  "Choose option you want to search:\n"
	search1:		.asciiz  "1-Retrieve all patient tests\n"
	search2:		.asciiz  "2-Retrieve all up normal patient tests\n"
	search3:		.asciiz  "3-Retrieve all patient tests in a given specific period\n"
	WrongChoose2:		.asciiz  "you enter invalid number please Choose number from 1-3\n"
	EnterID:		.asciiz  "Enter patient ID you want to search:\n"
	wrongsearchId:  	.asciiz  "Your ID is invalid \n"
	bufferName:		.space 1000
	bufferRes:		.space 1000
	bufferDate:		.space 100
	Hemoglobin:		.asciiz "Hgb"
	BGT: 			.asciiz "BGT"
	LDL:			.asciiz "LDL"
	BPT:			.asciiz "BPT"
	LessHemoglobin:		.float 13.8
	MoreHemoglobin:		.float 17.2
	LessBGT:		.float 70.0
	MoreBGT:		.float 99.0
	LessLDL:		.float 100.0
	LessBPT1:		.float 120.0
	LessBPT2:		.float 80.0
	COMMA:			.asciiz ","
	ZeroFloat:		.float 0.0
	year1:			.asciiz "Enter a year the first year: \n"
	year2:			.asciiz "Enter a year the second year: \n"
	Dash:			.asciiz "-"
	wrongYear:		.asciiz "This year does not have any test for user \n"
	EnterTest:		.asciiz "Enter Name of Test you want to search\n"
	bufferUserTest:		.space	10
	bufferId:		.space 100
	point:			.asciiz ":"
	wrongTestName:		.asciiz "The Test Name you enter does not exit in the file\n"
	bufferForAdd:		.space 1000
	bufferForAdd2:		.space 1000
	MsgToUpdate:		.asciiz "Enter the Whole Test you want to Update\n"	
	UpdateBuffer:		.space 100
	BufferTOUpdate:		.space 100
	MSgToUserForUpdate: 	.asciiz "Enter the New Result for test you choose one\nOne result if the test is Hgb or LDL or BGT\nTwo Result if the Test is BPT with Comma between them:\n"
	NewUpdateResult:    	.space  50
	WrongUpDateResult:  	.asciiz "The Test you enter is not found\n"
	MsgToDelete:	     	.asciiz "Enter the whole Test to Delete:\n"
	UpdateMSg:		.asciiz "The Test you choose is Updated\n"
	DeleteMSG:		.asciiz "The Test you choose is Deleted\n"
	EndMsg:			.asciiz "Our program is end :)\n*********************\nEvery Thing is stroed again in our file with all updates made.\n"
	
.macro print_string (%string)
	li $v0, 4	 	#print String
	la $a0, %string 	#$a0=address of string
	syscall
.end_macro


.text
.globl main
  main:

	
	#Open file for for reading purposes
	li $v0, 13          	#syscall 13 - open file
	la $a0, fileLoc       #passing in file name
	li $a1, 0          #set flag 0 (read), 1 (write) , 9 (to append)
	li $a2, 0              #mode is ignored
	syscall
	bltz $v0, openError   #if $v0 is less than 0, there is an error found
	
  	move $t0, $v0 			#save $v0 in t0 to be used later in readLine procedure and in closing the file
  	
        jal read_loop 
        
   #loop for show meun 
  loopMenu :
  	
  	#initilize all reg we use
        li $s1,0
        li $s2,0
        li $s3,0
        li $s4,0
        li $s5,0
        li $s6,0
        li $s7,0
             
        li $t1,0
        li $t2,0
        li $t3,0
        li $t4,0
        li $t5,0
        li $t6,0
        li $t7,0
        li $t8,0
        li $t9,0
        
        li $a0,0
        li $a1,0
        li $a2,0
        li $a3,0
	
	lwc1 $f15,ZeroFloat
	lwc1 $f16,ZeroFloat
	lwc1 $f17,ZeroFloat
	lwc1 $f18,ZeroFloat
	lwc1 $f19,ZeroFloat
	lwc1 $f20,ZeroFloat
	lwc1 $f21,ZeroFloat
	lwc1 $f22,ZeroFloat
	lwc1 $f23,ZeroFloat
	lwc1 $f24,ZeroFloat
	
	jal showMenu	
  	
	li $v0,5				 #Read integer from user
	syscall
	
	beq $v0,1,Add_medical_test	        #if $v0=1 then branch to label Add_medical_test
	beq $v0,2,Search_for_a_test	        #if $v0=2 then branch to label Search_for_a_test
	beq $v0,3,Searching_for_unnormal_tests #if $v0=2 then branch to label Searching_for_unnormal _tests
	beq $v0,4,Average		        #if $v0=4 then branch to label Average
	beq $v0,5,Update		        #if $v0=5 then branch to label Update
	beq $v0,6,Delete		        #if $v0=6 then branch to label Delete
	beq $v0,7,Exit                   #if $v0=7 then branch to label endProgram
	j defultCase
	
	#case 1
	Add_medical_test:
		la $t1, strings			# Load address of the buffer
    		li $t3, 0			# Initialize value to store (zero)

    		# Fill the buffer with zeros
    		li $s0, 128         		# Buffer size (number of iterations)
    		
		loopResA:
    			sb $t3, ($t1)       	# Store zero in the buffer
    			addi $t1, $t1, 1    	# Move to the next memory location
    			subi $s0, $s0, 1    	# Decrement the iteration count
    			bnez $s0, loopResA   	# Repeat until all locations are filled with null
    			

		print_string(Add1)
		print_string(representation)	#message to show the user how to enter the medical test
		
		li $a1,100			#a1= maximum strings length
		la $a0,strings			#$a0=address of strings
		li $v0,8			#read string
		move $s1,$a0			#$s1=address of strings
		syscall
		
		#counters
		li $t1,0   			#counter to test Id
		li $t2,0   			#counter to test Name
		li $t5,0       	  		# Initialize integer result to 0
		li $t3,0        		#initialize year result to 0
		li $t7,0     			#initialize month result to 0
		li $t4,0 			#initialize counter =0 to count number of char in id
		li $s2,0			#initialize counter=0 to count the number of errors in the test format enter by user
		li $s3,0			#initialize counter =0 to count number of char in the year
		li $s4,0			#initialize counter =0 to count number of char in the month
		li $s5,0			#initialize counter=0 to count number of digit in the test name
		li $s6,0			#initialize counter for exp
		li $s7,0			#initialize counter=0 for count char in float result
		lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it (result 1)
		lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for (result 2)
				
		#this loop is to count the digit of id
		loop:			
			lb $t9, 0($s1)       	# Load a character from the strings buffer in t9
		   	beq $t9,':',Id	      	#if $t9=':' then branch to label Id
		   	
		   	#if user enter char insted of int in ID :
		   	blt $t9,'0',Error1   
		   	bgt $t9,'9',Error1
		   	#..........................................
		   	
		   	#to convert the id from string to int 
		   	li $t8, 48	      	# $t8=ASCII value of '0'
		   	sub $t6, $t9, $t8    	#$t6=$t9-$t8
   	    	   	mul $t5, $t5, 10     	# Multiply result by 10
                  	add $t5, $t5, $t6    	# Add current digit to result
   	          	addi $s1, $s1, 1     	# Move to next character
   			addi $t1, $t1, 1     	# Increment counter

   		j loop
   		
   		#loop to test if the id is 7 digit or not
   		Id:
   			li  $t5,0
   			bge $t4,1,ErrorID    	#to test if there any char in id
   		 	blt $t1,7,ErrorID    	#if $t1<7 --> then branch to label ErrorID
   		 	bgt $t1,7,ErrorID    	#if $t1>7 --> then branch to label ErrorID
   		 	
   		 	#if $t1=7 --> then:
   		 	addi $s1,$s1,1	      	# Move to next character
   		 	
		j loop1
		
		#this loop to count the number of char in test name
   		loop1:	
   		 	
   		 	lb $t9, 0($s1)         	# Load a character from the strings buffer to t9
		  	beq $t9,',',name	#if $t9=',' then branch to label name
		  	
		  	#if user enter int insted of char in test name:
		   	blt $t9,'9',Error4  
		   	#..........................................
		   	
		        addi $s1, $s1, 1	# Move to next character
   			addi $t2, $t2, 1       # Increment counter 
   			
   		 j loop1
   		 
   		#loop to test if the name is 3 char or not
   		 name:
   		 	 addi $s1,$s1,1		# Move to next character
   			 blt $t2,3,ErrorName	#if $t2<3--> then branch to label ErrorName
   		 	 bgt $t2,3,ErrorName	#if $t2>3--> then branch to label ErrorName
   		 	 
   		 j loop2
   		 
   		 #this loop to convert the year from string to int
   		 loop2: 
   		 	li $t2,0               
   		 	lb $t9, 0($s1)		# Load a character from the strings buffer to 9
		  	beq $t9,'-',year     	#if $t9='-' then branch to label year
		  	
		  	#if user enter char insted of int in year:
		   	blt $t9,'0',Error2   
		   	bgt $t9,'9',Error2
		   	#..........................................
		   	
   		 	li $t8, 48           	# ASCII value of '0'
   		 	sub $t6, $t9, $t8	#$t6=$t9-$t8
   	    	   	mul $t3, $t3, 10       # Multiply result by 10
                  	add $t3, $t3, $t6      # Add current digit to result
                  	addi $s1, $s1, 1       # Move to next character
                  	
   		 j loop2
   		 
   		 #this loop to test the validity of year
   		 year:
   		 	bge $s3,1,ErrorYear    #to test if there any char in year
   		 	blt $t3,1949,ErrorYear	#if $t3<1949-> then branch to label ErrorYear
   		 	bgt $t3,2051,ErrorYear	#if $t3>2051-> then branch to label ErrorYear
   		 	addi $s1,$s1,1		# Move to next character
   		 	
   		 j loop3
   		 
   		 #this loop to convert the month from string to int
   		 loop3:
   		 	li $t3,0
   		 	lb $t9, 0($s1)         # Load a character from the strings buffer
		  	beq $t9,',',month	#if $t9=',' then branch to label month
		  	
		  	#if user enter char insted of int in year:
		   	blt $t9,'0',Error3  
		   	bgt $t9,'9',Error3
		   	#..........................................
		   	
   		 	li $t8, 48		# ASCII value of '0'
   		 	sub $t6, $t9, $t8	#$t6=$t9-$t8	
   	    	   	mul $t7, $t7, 10       # Multiply result by 10
                  	add $t7, $t7, $t6      # Add current digit to result
                  	addi $s1, $s1, 1       # Move to next character
                  	
                j loop3
                
                #this loop to test the validity of month
                month:
                	bge $s4,1,ErrorMonth   #to test if there any char in month
                 	blt $t7,0,ErrorMonth   #if $t7<0 -->then branch to label ErrorMonth
                 	bgt $t7,13,ErrorMonth	#if $t7>13--> then branch to label ErrorMonth
                 	addi $s1,$s1,1		# Move to next character
                 	
                j loop4
                
                #this loop to convert  from string to int for result 1
       		loop4:
			lb $t9, 0($s1)         # Load a character from the strings buffer
		  	beq $t9,'.',float2	#if $t9='.' then branch to label float2
		  	
		  	#if user enter char insted of int in result:
		   	blt $t9,'0',Error5  
		   	bgt $t9,'9',Error5
		   	#..........................................
		   		
		  	li $t8, 48		# ASCII value of '0'
   		 	sub $t6, $t9, $t8	#$t6=$t9-$t8	
   	    	   	mul $t5, $t5, 10       # Multiply result by 10
                  	add $t5, $t5, $t6      # Add current digit to result
                  	addi $s1, $s1, 1       # Move to next character
                  	
               j loop4
               	
               #this loop to move from int to float and move to next character
               float2:
               
               		bge  $s7,1,ErrorFloat  	#to test if there any char in result
                	mtc1 $t5,$f1		#move the content from $t5 to $f1-->from int to float
                       cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               		addi $s1, $s1, 1       	# Move to next character
               		
               j float
               
               #convert from string to int for fractional part in result 1
               float:
                    
                       lb $t9, 0($s1)         	# Load a character from the strings buffer
                       beq $t9,0,float1	#if we reached the end of line branch to float1
		  	beq $t9,',',incremant	#if $t9=',' then branch to label incremant
		  	beq $t9,10,float1	#if we have new line branch to float1
		  	
		  	#if user enter char insted of int in result:
		   	blt $t9,'0',Error5  
		   	bgt $t9,'9',Error5
		   	#..........................................
		   	
		   	
               	        li $t8, 48		# ASCII value of '0'
   		 	sub $t6, $t9, $t8	#$t6=$t9-$t8	
   	    	   	mul $t3, $t3, 10       	# Multiply result by 10
                  	add $t3, $t3, $t6      	# Add current digit to result
                  	addi $s1, $s1, 1       	# Move to next character	
                  	addi $t2,$t2,1		#number of digit 
                  	
               j float	
               
               #loop for convert fractional part from int to float in result 1
               float1:
               
                       mtc1 $t3,$f2			#move the content from $t3 to $f2-->from int to float
                       cvt.s.w $f2,$f2			#convert the content in $f2 to float number 
               		mul.s  $f3, $f3,$f5            # multiply result by base
               		addi $s6, $s6, 1               # increment counter
               		bne $t2, $s6, float1           # repeat loop until counter equals exponent
		  	div.s $f2,$f2,$f3
		  	
		j AddFloat
		
		#add two number to have the results
		AddFloat:
		
			add.s $f4,$f2,$f1		#$f4=$f2+$f1 which $f4 is the test result
			
		j CountError 
		
		#loop to initialize counters to 0 if we have 2 results
		incremant:  
		  
               		li $t5,0			#set result of int to 0
          		li $t3,0			#set result of int to 0
          		li $s7,0			#set counter of char to 0
          		li $s6,0			#set counter of mul to 0
          		
               	j loop5	
               	
               	#this loop to convert  from string to int for result 2
               	loop5:
               	
               		lb $t9, 0($s1)         # Load a character from the strings buffer
		  	beq $t9,'.',float21	#if $t9='.' then branch to label float21
		  	
		  	#if user enter char insted of int in float:
		   	blt $t9,'0',Error6  
		   	bgt $t9,'9',Error6
		   	#..........................................
		   		
		  	li $t8, 48		# ASCII value of '0'
   		 	sub $t6, $t9, $t8	#$t6=$t9-$t8	
   	    	   	mul $t5, $t5, 10       # Multiply result by 10
                  	add $t5, $t5, $t6      # Add current digit to result
                  	addi $s1, $s1, 1       # Move to next character
                  	
              j loop5
              
              #this loop to move from int to float and move to next character in result 2
              float21:
              
              		bge  $s7,1,ErrorFloat  #to test if there any char in ErrorFloat 
              		mtc1 $t5,$f1		#move the content from $t5 to $f1-->from int to float
                       cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               		addi $s1, $s1, 1       # Move to next character
               		
              j floatF
              
              #convert from string to int for fractional part in result 2
              floatF:
              
              		lb $t9, 0($s1)         # Load a character from the strings buffer
                       beq $t9,0,float11	#if we reached the end of line branch to float11
		  	beq $t9,10,float11	#if we have new line branch to float11
               	        li $t8, 48		# ASCII value of '0'
   		 	sub $t6, $t9, $t8	#$t6=$t9-$t8	
   	    	   	mul $t3, $t3, 10       # Multiply result by 10
                  	add $t3, $t3, $t6      # Add current digit to result
                  	addi $s1, $s1, 1       # Move to next character	
                  	addi $t2,$t2,1		#number of digit 
                  	
               j floatF
               
               #loop for convert fractional part from int to float in result 2
               float11:
               
               		mtc1 $t3,$f2			#move the content from $t3 to $f2 -->from int to float
                       cvt.s.w $f2,$f2			#convert the content in $f2 to float number 
               		mul.s  $f6, $f6,$f7           	#multiply result by base
               		addi $s6, $s6, 1               # increment counter
               		bne $t2, $s6, float11          # repeat loop until counter equals exponent
		  	div.s $f2,$f2,$f6
		  	
		j AddFloat
		
		#this loop if user enter char insted of int in ID	
		Error1:
		
			addi $t4, $t4, 1     #increment the char counter by 1
			addi $s1, $s1, 1     # Move to next character
			
		j loop
		
	        #this loop if user enter char insted of int in year	
		Error2:
		
			addi $s3,$s3,1	     #increment the char counter by 1
			addi $s1,$s1,1      #Move to next character
			
		j loop2
		
	        #this loop if user enter char insted of int in month
	        Error3:
	        
	        	addi $s4,$s4,1	    #increment the char counter by 1
	        	addi $s1,$s1,1	    #Move to next character
	        	
	        j loop3	
	        
               #this loop if user enter int insted of char in test name
		Error4:
		
			addi $s5,$s5,1	   #increment the int counter by 1
			addi $s1,$s1,1	   #Move to next character
			
		j loop1
		
		#this loop if user enter char insted of int in float number
		Error5:
		
			addi $s7,$s7,1		#increment counter if there is an char in float result
			addi $s1,$s1,1		#move to next char
			
		j loop4
		
	        #this loop if user enter char insted of int in float number
		Error6:
		
			addi $s7,$s7,1		#increment counter if there is an char in float result
			addi $s1,$s1,1		#move to next char
			
		j loop5
		
		 #loop to print that id not valid and move to next char
   		ErrorID:
   		
   		 	print_string(Errorid)
   		 	addi $s1, $s1, 1        # Move to next character
   		 	addi $s2, $s2, 1	 #increment the counter for errors
   		 	
   		j loop1
   	
   	        #loop to print that test name not valid and move to next char
   		ErrorName:
   		
   		 	print_string(Errorname)
   		 	addi $s2, $s2, 1	 #increment the counter for errors
   		 	
   		 j loop2
   		 
   		 #loop to print that year not valid and move to next char
   		 ErrorYear:
   		 
   		        print_string(Erroryear)	
   		        addi $s1,$s1,1		 # Move to next character
   		        addi $s2, $s2, 1	 #increment the counter for errors
   		        
   		 j loop3
   		 
   		 #loop to print that month not valid and move to next char
   		 ErrorMonth:
   		 
   		        print_string(Errormonth)
   		        addi $s1,$s1,1		 # Move to next character
   		        addi $s2, $s2, 1	 #increment the counter for errors
   		        	
                j loop4
                
                 #loop to print that result not valid and move to next char
                ErrorFloat:
                
                	print_string(Errorfloat)
                	addi $s1,$s1,1		 # Move to next character
   		        addi $s2, $s2, 1	 #increment the counter for errors
   		        
   		 j CountError
   		 
   		 #in this loop if we have an invalid input then branch to Add_medical_test
   		 #else then we store the input in the file 
   		 CountError:
			bge $s2,1,Add_medical_test
			la  $s2,medical_tests 	#s2=address for medical tests
			la  $s1,bufferForAdd  	#a1=address for bufferForAdd (we use it for concat the medical test with new line)
			la  $t1,newLine
			
			#loop to concat the medical test with new line
			copy_loop1:
			
        			lb $t2, ($s2)   	# Load character from medical_test
        			beqz $t2, copy_loop2  	# If null terminator, switch to copy_loop2 
       				sb $t2, ($s1)   	# Store character in bufferForAdd
        			addi $s1, $s1, 1  	# Move to the next bufferForAdd location 
       				addi $s2, $s2, 1  	# Move to the next medical_test character
       				
       		        j copy_loop1
       		        
       		        # Copy characters from newLine to bufferForAdd
   	 		copy_loop2:
   	 		
        			lb $t2, ($t1)   	# Load character from newLine
        			beqz $t2, LoadAgain  	# If null terminator branch to LoadAgain 
        			sb $t2, ($s1)   	# Store character in bufferForAdd
        			addi $s1, $s1, 1  	# Move to the next bufferForAdd location
        			addi $t1, $t1, 1  	# Move to the next newLine character
        			
        		j copy_loop2
        		
        		
        		#to initlize counters and load new strings
        		LoadAgain:
        		
        			li $s2,0
        			li $s1,0
        			li $t1,0
        			la $s2,bufferForAdd
				la $s1,bufferForAdd2
				la $t1,strings
			
			j copy_loop11
			
			#to concat bufferForAdd with strings(that user enter)
			copy_loop11:
			
        			lb $t2, ($s2)   	# Load character from bufferForAdd
        			beqz $t2, copy_loop21  # If null terminator, switch to copy_loop21  
       				sb $t2, ($s1)   	# Store character in bufferForAdd2
        			addi $s1, $s1, 1  	# Move to the next bufferForAdd2 location
       				addi $s2, $s2, 1  	# Move to the next bufferForAdd character
       				
       		        j copy_loop11
       		        
       		         # Copy characters from strings to bufferForAdd2
   	 		copy_loop21:
   	 		
        			lb $t2, ($t1)   	  # Load character from strings
        			beq $t2,10, writetofile  # If null terminator branch to writetofile
        			sb $t2, ($s1)   	  # Store character in bufferForAdd2
        			addi $s1, $s1, 1  	  # Move to the next bufferForAdd2 location
        			addi $t1, $t1, 1   	  # Move to the next strings character
        			
        		j copy_loop21
        		
        		
        		writetofile:
        		
        			la $s1,bufferForAdd2
        			la $a1,medical_tests
        			
        			parseLoopA:
        			
    					lb $t4, 0($s1)	  # Load a character from the bufferForAdd2
    					beqz $t4,print   # if t4= 0 branch to print
    				
   					# Store the character in the medical_tests
    					sb $t4, 0($a1)             
    					addi $a1, $a1, 1
    			
   			       j continueParseA
  
				continueParseA:
				
    					addi $s1, $s1, 1  # Move to the next character
    					
    				j parseLoopA

                        #print to screen that the new test is added
    			print: 
    			              
    				print_string(DoneAddTest) 
    				
		       j loopMenu
		       
		       
	#case2:
	Search_for_a_test:
		
		print_string(SelectSearch)
		print_string(search1)
		print_string(search2)
		print_string(search3)
		
		li $v0,5		#Read integer from user
		syscall
		
		beq $v0,1,AllTest       #if $v0=1 then branch to label AllTest
		beq $v0,2,UpNormalTest  #if $v0=1 then branch to label UpNormalTest
		beq $v0,3,TestInPeriod  #if $v0=1 then branch to label TestInPeriod
		j defultSearch          #others , branch to defultSearch
		
                  
                # if the user enter invalid choice
		defultSearch:
		
			print_string(WrongChoose2)
			
		j Search_for_a_test 
		
		#option 1 in search 		
		AllTest:
		
			li $t7,0                # counter for check invalid id   
			li $t5,0       
			print_string(EnterID)
			
			li $v0,5		#Read integer from user
			syscall
			
			move $t1,$v0           #load the id that the user enter in t1 
			
			la $a0,medical_tests   #$a0=address of medical_tests 
		        move $s1,$a0          # s1=address of medical_tests 
		        
		       
		    # loop to covert the id in the medical_tests from string to int   
		    L1:	
		    		
			lb $t9, 0($s1)       	      	# Load a character from the medical_tests  buffer
		   	beq $t9,':',inc	      	      	#if $t9=':' then branch to label inc
		   	beq $t9,0,def           	#if we reach end of file branch to def	
		   	beq $t9,32,INCRForDel		#if we find a speace this becouse we have deleted test so skip it
		   	beq $t9,10,INCRForDel
		   	li $t8, 48	      	      	# $t8=ASCII value of '0'
		   	sub $t6, $t9, $t8	      	#$t6=$t9-$t8
   	    	   	mul $t5, $t5, 10             	# Multiply result by 10
                  	add $t5, $t5, $t6            	# Add current digit to result
   	          	addi $s1, $s1, 1             	# Move to next character
   	          	
   		   j L1
   		   
   		   
   		   INCRForDel:
   		   	addi $s1,$s1,1
   		   j L1
   		   # loop to move to next char if the char is ':' to not count it 
   		   inc:
   		   
   		   	addi $s1,$s1,1
   		   	
   		   j CompareId
   		   
   		   #loop to compare the enterd id with the id's in medical_tests(buffer)
		   CompareId:
		   
		   	beq  $t5,$t1,StoreInBuf      #if the two id is equal branch to StoreInBuf
		   	li $t5,0                     #initlize the id result from buffer to 0 
		   	lb $t9, 0($s1)               # Load a character from the medical_tests  buffer
		   	addi $s1,$s1,1               # move to next char
		   	beq $t9,'\n' ,L1             # if we reach the end of line branch to L1
		   	beq $t9,0,def                #if we reach end of file brach to def
		   	
		   j CompareId	
		   
		   # this loop to store the test has the id enterd by user in Temp Buffer
		   StoreInBuf:
		   
		   	# Parse the fields and store them in the Temp Buffer
   		       	addi $t7,$t7,1               # if the user enter a valid id then incremant t7
    			la $t2, TempBuffer           #t2= address of Temp Buffer
    			
			parse_loop1:
			
    				lb $t4, 0($s1)             # Load a character from the medical_test
    				beq $t4,'\n' ,PrintAndEnd  #if we reach the end of line branch to PrintAndEnd
    				beq $t4,0,PrintAndEnd      #if we reach end of file brach to PrintAndEnd
    				
   				# Store the character in the Temp Buffer
    				sb $t4, 0($t2)             
    				addi $t2, $t2, 1
    					
   			j continue_parse1
    	
			continue_parse1:
			
    				addi $s1, $s1, 1     # Move to the next character
    				
    			j parse_loop1
    			
    			# to print the true test
    			PrintAndEnd:
    			
    			    	beq $t7,0,WrongpatinetID  #if id counter t7 is 0 branch to WrongpatinetID
    			    	li $t2,0
    				
    				#if id counter >0 then we have the id in the medical_tests so print TempBuffer
    				li $v0,4             
    				la $a0,TempBuffer
    				syscall
    				
    				li $v0,4
    				la $a0,newLine
    				syscall
    				
    				addi $s1, $s1, 1     # Move to the next character
    				
    			j inc2
    			
    			# this is for set t5 to 0 to store the new id that we want to compare in it 
    			inc2:
    			
    				li $t5,0
    				
    				# Fill the buffer with zeros
    				li $s0, 128         		# Buffer size (number of iterations)
    				la $a0, TempBuffer     		# Load address of the buffer
    				li $t3, 0             		# Initialize value to store (zero)
    				
				loopResB:
				
    					sb $t3, ($a0)       	# Store zero in the buffer
    					addi $a0, $a0, 1    	# Move to the next memory location
    					subi $s0, $s0, 1    	# Decrement the iteration count
    					bnez $s0, loopResB   	# Repeat until all locations are filled
    					
    			j del
    			
    			
    			del:
    			
    				li $a0,0
    				li $t3,0
    				
    			j L1
    			
    			#if the user enter invalid id 
    			def:
    			
    				beq $t7,0,WrongpatinetID  	#if t7=0 branch to WrongpatinetID
    				
    			j loopMenu                       	# else jump to loopmenu
    			
    				
    			#print that the id is invalid 
    			WrongpatinetID:
    			
    			        print_string(wrongsearchId)
    			        
    			j AllTest
    	   		
    	   		
    	   	#option 2 in search 	
		UpNormalTest:
		
			li $t3,0
			li $s4,0 
			li $s5,0
			li $t1,0
			li $s7,0                  	# counter for check invalid id  
			        
			print_string(EnterID)
			
			li $v0,5		  	#Read integer from user
			syscall
			
			move $t1,$v0             	#load the id that rhe user enter in t1 
			
			la $a0,medical_tests    	#$a0=address of medical_tests 
		        move $s1,$a0            	# s1=address of medical_tests 
		       
		        li $s6,0		 	#initialize counter for exp
			
			lwc1 $f3,floatnumber	 	# initialize result for mul to 1 for result 1
		        lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 
		        
		
		        # loop to covert the id in the medical_tests from string to int   
		    	L2:

		    		li $t3,0                     
				li $s4,0 
				lb $t9, 0($s1)       	      # Load a character from the medical_tests buffer
		   		beq $t9,':',incr	      #if $t9=':' then branch to label incr
		   		beq $t9,0,loopMenu           #if we reach end of file branch to loopMenu
		   		beq $t9,32,INCFORDel1
		   		beq $t9,10,INCFORDel1	      #if we rach end of line branch to incrNewLine
		   		li $t8, 48	      	      # $t8=ASCII value of '0'
		   		sub $t6, $t9, $t8	      #$t6=$t9-$t8
   	    	   		mul $t5, $t5, 10             # Multiply result by 10
                  		add $t5, $t5, $t6            # Add current digit to result
   	          		addi $s1, $s1, 1             # Move to next character
   	          		
   		   	j L2
   		   	
   		   	INCFORDel1:
   		   	
   		   		addi $s1,$s1,1
   		   		
   		   	j L2
   		   	
   		   	
   		   	
   		   	# loop to move to next char if the char is ':' to not count it 
   		   	incr:
   		   	
   		   		addi $s1,$s1,1
   		   		
   		   	j CompareId1
   		   	
   		   	#loop to compare the enterd id with the id's in medical_tests(buffer)
		   	CompareId1:
		   	
		   		beq  $t5,$t1,comma1          	#if the two id is equal branch to comma1 
		   		li $t5,0                     	#initlize the id result from buffer to 0
		   		lwc1 $f3,floatnumber	     	# initialize result for mul to 1 for result 1
		        	lwc1 $f5,floatnumfordiv     	# to count the number we want to div by it result 1
		        	lwc1 $f6,floatnumber        	# initialize result for mul to 1 for result 2
		        	lwc1 $f7,floatnumfordiv     	# to count the number we want to div by it for result 2
		        	li $t6,0 
		   		lb $t9, 0($s1)               	# Load a character from the medical_tests  buffer
		   		addi $s1,$s1,1               	# move to next char
		   		beq $t9,'\n' ,L2             	# if we reach the end of line branch to L2
		   		beq $t9,0,def1               	#if we reach end of file brach to def1
		   		
		  	 j CompareId1	
		        
		        #to store test name in buffer name
		        comma1:
		        
		        	addi $s7,$s7,1               # if the user enter a valid id then incremant s7
		        	la $s2,bufferName            #s2=address of bufferName
		        	li $t5,0
		        	
		        	parse_loop2:
		        	
    					lb $t4, 0($s1)                  # Load a character from the medical_test
    					beq $t4,',' ,incremantForComma  #if t4= ',' branch to incremantForComma 
    				
   					# Store the character in the bufferName
    					sb $t4, 0($s2)             
    					addi $s2, $s2, 1
    					
   				j continue_parse2
  
				continue_parse2:
				
    					addi $s1, $s1, 1     # Move to the next character
    					
    				j parse_loop2
    				
		   	j comma1
		   	
		   	#move to next char to not count comma
		   	incremantForComma:
		   	
		   		addi $s1,$s1,1
		   		
		   	j comma2
		   	
		   	#to store date in buffer date
		   	comma2:
		   	
		        	la $s3,bufferDate
		        	li $t5,0
		        	
		        	parse_loop11:
    					lb $t4, 0($s1)             # Load a character from the medical_test
    					beq $t4,',' ,IncrComma2    #if t4= ',' branch to IncrComma2
    					
   					# Store the character in the buffer date
    					sb $t4,0($s3)
    					addi $s3,$s3,1
    					
   				j continue_parse11
  	
				continue_parse11:
				
    					addi $s1, $s1, 1     # Move to the next character
    					
    				j parse_loop11
    				
    			j comma2
    			
    			#to not count the comma
    			IncrComma2:
    			
    				addi $s1, $s1, 1             # Move to the next character
    			j getFloat
    			
    			#this loop to convert  from string to int for the integer part in  float result 1
       			getFloat:
       			
				lb $t9, 0($s1)         # Load a character from the medical_test buffer
		  		beq $t9,'.',getFloat2	#if $t9='.' then branch to label getFloat2
		  		li $t8, 48		# ASCII value of '0'
   		 		sub $t6, $t9, $t8	#$t6=$t9-$t8	
   	    	   		mul $s4, $s4, 10       # Multiply result by 10
                  		add $s4, $s4, $t6      # Add current digit to result
                  		addi $s1, $s1, 1       # Move to next character
                  		
               		j getFloat
               	
               		#this loop to move from int (integer part in result float 1)to float and move to next character
               		getFloat2:
               		
                		mtc1 $s4,$f1		#move the content from $s4 to $f1-->from int to float
                       	        cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               			addi $s1, $s1, 1       # Move to next character
               			
               		j floatConvert
               
               		#convert from string to int for fracthional part in result float 1
               		floatConvert:
                    
                          	lb $t9, 0($s1)                 # Load a character from the medical_test buffer
                        	beq $t9,0,floatConvert1   	#if we reached null branch to floatConvert1	
		  		beq $t9,10,floatConvert1	#if we have new line branch to floatConvert1	
		  		beq $t9,13,incremanEndOfText	#if we reached enf of text branch to incremanEndOfText
		  		beq $t9,',',floatConvert1      #if t9= ',' branch to floatConvert1
               	        	li $t8, 48		        # ASCII value of '0'
   		 		sub $t6, $t9, $t8	        #$t6=$t9-$t8	
   	    	   		mul $t3, $t3, 10              	# Multiply result by 10
                  		add $t3, $t3, $t6             	# Add current digit to result
                  		addi $s1, $s1, 1              	# Move to next character	
                  		addi $t2,$t2,1		       	#number of digit 
                  		
               		j floatConvert	
               		
                        # to not count \r 
               		incremanEndOfText:
               		
               			addi $s1, $s1, 1              # Move to next character	
               			
               		j floatConvert
               		
               		
               		#loop for fractional part to convert from int to float 
              		 floatConvert1:
              		 
                        	mtc1 $t3,$f2			#move the content from $t3 to $f2-->from int to float
                         	cvt.s.w $f2,$f2			#convert the content in $f2 to float number 
               			mul.s  $f3, $f3,$f5            # multiply result by base
               			addi $s6, $s6, 1               # increment counter
               			bne $t2, $s6, floatConvert1    # repeat loop until counter equals exponent
		  		div.s $f2,$f2,$f3
		  		
			j AddFloat1
		
			#add two number to have the result 1
			AddFloat1:
			
				add.s $f4,$f2,$f1		#$f4=$f2+$f1 which $f4 is the test result
				lb $t9, 0($s1)                 # Load a character from the medical test buffer
			        beq $t9,',',incremantRes	#if $t9=',' then branch to label incremantRes(if there another result for BPT)
			        
			j checkRange 
		
			#loop to initialize counters to 0 if we have 2 results
			incremantRes: 
			
				addi $s1,$s1,1   
               			li $s4,0			#set result of int to 0
          			li $t3,0			#set result of int to 0
          			li $s6,0
          			li $t2,0			#set counter of mul to 0
          			
               		j getFloat1	
               	
               		#this loop to convert  from string to int for result 2
               		getFloat1:
               		
               			lb $t9, 0($s1)         		# Load a character from the medical test buffer
		  		beq $t9,'.',Getfloat21		#if $t9=',' then branch to label Getfloat21
		  		li $t8, 48			# ASCII value of '0'
   		 		sub $t6, $t9, $t8		#$t6=$t9-$t8	
   	    	   		mul $s4, $s4, 10       		# Multiply result by 10
                  		add $s4, $s4, $t6      		# Add current digit to result
                  		addi $s1, $s1, 1       		# Move to next character
                  		
             		j getFloat1
              
              		#this loop to move from int to float (int part in result 2)and move to next character
              		Getfloat21:
              		
              			mtc1 $s4,$f1		#move the content from $s4 to $f1-->from int to float
                       	        cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               			addi $s1, $s1, 1       # Move to next character
               			
              		j floatFA
              
              		#convert from string to int for fracshional part in result 2
              		floatFA:
              		
              			lb $t9, 0($s1)         	# Load a character from the mrdical test  buffer
                          	beq $t9,0,Ffloat11	#if we reached the end of line branch to Ffloat11
		  		beq $t9,10,Ffloat11	#if we have new line branch to Ffloat11
		  		beq $t9,13,IncremantR  	#if we rach \r then branch to IncremantR
               	        	li $t8, 48		# ASCII value of '0'
   		 		sub $t6, $t9, $t8	#$t6=$t9-$t8	
   	    	   		mul $t3, $t3, 10       	# Multiply result by 10
                  		add $t3, $t3, $t6      	# Add current digit to result
                  		addi $s1, $s1, 1       	# Move to next character	
                  		addi $t2,$t2,1		#number of digit 
                  		
               		j floatFA
               		
               		#to not count \r 
               		IncremantR:
               		
               			addi $s1,$s1,1
               			
               		j floatFA
               		
               		#loop for fractional part in result 2 to convert from int to float 
               		Ffloat11:
               		
               			mtc1 $t3,$f2			#move the content from $t3 to $f2-->from int to float
               			cvt.s.w $f2,$f2			#convert the content in $f2 to float number 
               			mul.s  $f6, $f6,$f7            # multiply result by base
               			addi $s6, $s6, 1               # increment counter
               			bne $t2, $s6, Ffloat11         # repeat loop until counter equals exponent
		  		div.s $f2,$f2,$f6
		  		
			j AddFloat2
		
			#add two number to have the result 2
			AddFloat2:
			
				add.s $f13,$f2,$f1		#$f13=$f2+$f1 which $f5 is the test result 2
				
			j checkRange 
    				
		   	# to check if there any up normal test 	
		        checkRange:
		        
		        	la $a1,bufferName              		#a1=address of buffer name 
		        	la $a2,Hemoglobin              		#a2=address of Hemoglobin
		        	lwc1 $f10,LessHemoglobin       		#f10=LessHemoglobin
		        	lwc1 $f11,MoreHemoglobin       		#f11=MoreHemoglobin
		        	
		        	# Start of string comparison loop
				compare_loop:
				
					# Load bytes from each string into $t0 and $t1
    					lb $t0, ($a2)
    					lb $t7, ($a1)
    					beq $t0,0,endOfBuffer     	#if we reach end in the buffer a2 branch to endOfBuffer
    					
   					# Compare the bytes (first byte)
    					beq $t0, $t7, check_end  	# If equal branch to check_end 
    				j LoadTest2                  
    				
    				#to check if the buffer a1 is also reach end or not 
    				endOfBuffer:
    				
    					beq $t7,0,checkIfTwoBufferEqual #if buffer a1 also reach end then branch to checkIfTwoBufferEqual
    					
    				j LoadTest2
    				
    				#to check if the two buffer is equal 
    				checkIfTwoBufferEqual:
    				
    					beq $t0, $t7, compare1  # If equal branch to compare1
    					
    				j LoadTest2
    				
    				#check if the result < 13.8
    				compare1:
    				
    					c.lt.s $f10,$f4          # if f4 > f10 then set the cc flags to 1  
    					bc1t compare2            #if cc flags =1 branch to compare2
    					
    				j PrintUpNormal
    				
    				
    				check_end:
    				
    					addi $a2, $a2, 1
    					addi $a1, $a1, 1
    					
    				j compare_loop
    				
    				#check if the result > 17.2
		        	compare2:
		        	
		        		c.lt.s $f11,$f4          	# if f4 > f11 then set the cc flags to 1 
		        		bc1t PrintUpNormal       	#if cc flags =1 branch to PrintUpNormal 
		        		
		        		li $t6,0
		        		lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
    					addi $s1, $s1, 1     		# Move to the next character
    					
    				j L2
    					
    					
		        	#to print the up normal test 
		        	PrintUpNormal:
		        	
		        	     	beq $s7,0,WrongpatinetID1  	#if id counter is 0 branch to WrongpatinetID1
		        		lwc1 $f3,floatnumber	   	# initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
		        		li $t6,0
		        		
		        	        #to print buffer name
		        		li $v0,4
		        		la $a0,bufferName
		        		syscall
		        		
		        		#to print comma','
		        		li $v0,4
		        		la $a0,COMMA
		        		syscall
		        		
		        		#to print buffer date 
		        		li $v0,4
		        		la $a0,bufferDate
		        		syscall
		        		
		        		#to print comma','
		        		li $v0,4
		        		la $a0,COMMA
		        		syscall
		        		
		        		#to print result (float)
		        		li $v0,2
		        		mov.s  $f12,$f4
		        		syscall
		        		
		        		#to print new line 
		        		li $v0,4
		        		la $a0,newLine
		        		syscall
		        		
		        	j L2
		        	
		        	
		        	LoadTest2:
		        	
		        		la $a1,bufferName	#$a1=address of bufferName
		        		la $a2,BGT		#$a2=address of BGT
		        		lwc1 $f10,LessBGT	#f10=LessBGT
		        		lwc1 $f11,MoreBGT	#f11=MoreBGT
		        		
		        	
		        	# Start of string comparison loop
				compare_loop1:
				
					# Load bytes from each string into $t0 and $t1
    					lb $t0, ($a2)
    					lb $t7, ($a1)
    					beq $t0,0,endOfBufferA 	     #to check if the buffer a2 is also reach end or not 
    					
   					# Compare the bytes
    					beq $t0, $t7, check_endA    # If equal branch to check_endA
   					
    				j LoadTest3             
    				
    				#to check if the buffer a1 is also reach end or not 
    				endOfBufferA:
    				
    					beq $t7,0,checkIfTwoBufferEqualA #if buffer a1 also reach end then branch to checkIfTwoBufferEquaA
    					
    				j LoadTest3
    				
    				#to check if the two buffer is equal
    				checkIfTwoBufferEqualA:
    				
    					beq $t0, $t7, compareA  	 # If equal branch to compareA
    					
    				j LoadTest3
    				
    				#check if the result < 70
    				compareA:
    				
    					c.lt.s $f10,$f4          # if f4 > f10 then set the cc flags to 1  
    					bc1t compareB            #if cc flags =1 branch to compareB
    					
    				j PrintUpNormal
    				
    				check_endA:
    				
    					addi $a2, $a2, 1
    					addi $a1, $a1, 1
    					
    				j compare_loop1
    				
    				
    				#check if the result > 99
		        	compareB:
		        	
		        		c.lt.s $f11,$f4          # if f4 > f11 then set the cc flags to 1 
		        		bc1t PrintUpNormal       #if cc flags =1 branch to PrintUpNormal 
		        		
		        		li $t6,0
		        		lwc1 $f3,floatnumber	 # initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv # to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber    # initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv # to count the number we want to div by it for result 2
    					addi $s1, $s1, 1        # Move to the next character
    					
    				j L2
    					
    				
    				LoadTest3:
    				
		        		la $a1,bufferName	#$a1=address of bufferName
		        		la $a2,LDL		#$a2=address of LDL
		        		lwc1 $f10,LessLDL	#f10=LessLDL
		        		
		        	   # Start of string comparison loop
				   compare_loop2:
				   
					# Load bytes from each string into $t0 and $t1
    					lb $t0, ($a2)
    					lb $t7, ($a1)
    					beq $t0,0,endOfBufferB  
    					
   					# Compare the bytes
    					beq $t0, $t7, check_endB  # If equal branch to check_endB
   					
    				j LoadTest4                
    				
    				#check if we reach end of buffer a1 
    				endOfBufferB:
    				
    					beq $t7,0,checkIfTwoBufferEqualB  #if we reach end of buffer a1 branch checkIfTwoBufferEqualB
    					
    				j LoadTest4
    				
    				#check if two buffer is equal
    				checkIfTwoBufferEqualB:
    				
    					beq $t0, $t7, compareC 		   # If equal branch to compareC
    					
    				j LoadTest4
    				
    				#check if the result > 100
    				compareC:
    				
    					c.lt.s $f10,$f4          # if f4 > f10 then set the cc flags to 1  
    					bc1t compareD           #if cc flags =1 branch to compare2
    					
    				j LoadTest4
    				
    				check_endB:
    				
    					addi $a2, $a2, 1
    					addi $a1, $a1, 1
    					
    				j compare_loop2
    				
    				compareD:
    				
    					c.lt.s $f10,$f4          	# if f4 > f10 then set the cc flags to 1  
    					bc1t PrintUpNormal       	#if cc flags =1 branch to PrintUpNormal 
		        		lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
		        		li $t6,0
    					addi $s1, $s1, 1     		# Move to the next character
    				j L2	
    						
    				LoadTest4:
    				
    					la $a1,bufferName		#$a1=address of bufferName
		        		la $a2,BPT			#$a2=address of BPT
		        		lwc1 $f10,LessBPT1		#f10=LessBPT1
		        		lwc1 $f11,LessBPT2		#f11=LessBPT2
		        		
		        	
		        	# Start of string comparison loop
				compare_loop3:
				
					# Load bytes from each string into $t0 and $t1
    					lb $t0, ($a2)
    					lb $t7, ($a1)
    					beq $t0,0,endOfBufferC
    					
   					# Compare the bytes
    					beq $t0, $t7, check_endC  # If equal branch to check_endC 	
    					
    				j L2                  
    				
    				endOfBufferC:
    				
    					beq $t7,0,checkIfTwoBufferEqualC
    					
    				j L2
    				
    				checkIfTwoBufferEqualC:
    				
    					beq $t0, $t7, compareE  # If equal branch to compareE
    					
    				j L2
    				
    				#check if the result > 120
    				compareE:
    				
    					c.lt.s $f10,$f4                     # if f4 > f10 then set the cc flags to 1  
    					bc1t IncremantFloatError            #if cc flags =1 branch to IncremantFloatError
    					
    				j compareF
    				
    				check_endC:
    				
    					addi $a2, $a2, 1
    					addi $a1, $a1, 1
    					
    				j compare_loop3 
    				
    				#this loop count the number of up normal tests by incremant s5 by 1(incremant if first result is upnormal)
    				IncremantFloatError:
    				
    					addi $s5,$s5,1
    					
    				j compareF
    				
    				#check if the result > 80.0
		        	compareF:
		        	
		        		c.lt.s $f11,$f13          # if f13 > f11 then set the cc flags to 1 
		        		bc1t IncremantFloatError1 #if cc flags =1 branch to IncremantFloatError1 
		        		bge $s5,1,PrintUpNormal1  #if the first result in the test is up normal then branch to PrintUpNormal1 it before test the second result
		        		lwc1 $f3,floatnumber	   # initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv   # to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber      # initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv   # to count the number we want to div by it for result 2
		        		li $t6,0
    					addi $s1, $s1, 1          # Move to the next character
    					
    				j L2
    				
    				
    				#this loop count the number of up normal tests by incremant s5 by 1(incremant if second result is upnormal) and then branch to PrintUpNormal1 
    				IncremantFloatError1:
    				
    					addi $s5,$s5,1
    					bge $s5,1,PrintUpNormal1  #if there any up normal test then brannch to PrintUpNormal1 

    				j L2
    				
    				#to print the up normal test 
		        	PrintUpNormal1:
		        	
		        		beq $s7,0,WrongpatinetID1  #if id counter is 0 branch to PrintUpNormal1
		        		li $s5,0
		        		lwc1 $f3,floatnumber	   # initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv   # to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber      # initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv   # to count the number we want to div by it for result 2
		        		li $t6,0
		        		
		        	        #to print buffer name
		        		li $v0,4
		        		la $a0,bufferName
		        		syscall
		        		
		        		#to print comma','
		        		li $v0,4
		        		la $a0,COMMA
		        		syscall
		        		
		        		#to print buffer date 
		        		li $v0,4
		        		la $a0,bufferDate
		        		syscall
		        		
		        		#to print comma','
		        		li $v0,4
		        		la $a0,COMMA
		        		syscall
		        		
		        		#to print result 1(float)
		        		li $v0,2
		        		mov.s  $f12,$f4
		        		syscall
		        		
		        		#to print comma','
		        		li $v0,4
		        		la $a0,COMMA
		        		syscall
		        		
		        		#to print result 2(float)
		        		li $v0,2
		        		mov.s  $f12,$f13
		        		syscall
		        		
		        		#to print new line 
		        		li $v0,4
		        		la $a0,newLine
		        		syscall
		        		
		        	j L2
		        	
		        	
		        	# to check if the user enter an invalid id 
		                def1:
		                
    				       beq $s7,0,WrongpatinetID    #s7=0 --> branch WrongpatinetID
    				       
    			        j loopMenu
    			        
    			        
    				#to print that the id which enterd by user is invalid 
    			        WrongpatinetID1:
    			        
    			               print_string(wrongsearchId)
    			               
    			        j UpNormalTest
    			        
    			        
    		#option 3 in search        
		TestInPeriod:
		
			li $t3,0		 	 # counter for check invalid year
			li $t1,0
			li $s7,0                 	# counter for check invalid id  
			        
			print_string(EnterID)
			
			li $v0,5		 	 #Read integer from user
			syscall
			
			move $t1,$v0             	#load the id that rhe user enter in t1 
		
			print_string(year1)
			
			li $v0,5
			syscall 
			move $s6,$v0			#load the year that the user enter in $s6
			
			print_string(year2)
			
			li $v0,5
			syscall 
			move $s3,$v0			#load the year that the user enter in $s3
			
			la $a0,medical_tests     	#$a0=address of medical_tests 
		        move $s1,$a0            	# s1=address of medical_tests
		        
		         	
		        # loop to covert the id in the medical_tests from string to int   
		    	L3:
		    	
				lb $t9, 0($s1)       	      # Load a character from the medical_tests buffer
		   		beq $t9,':',incr3	      #if $t9=':' then branch to label incr3
		   		beq $t9,0,loopMenu           #if we reach null branch to loopMenu
		   		beq $t9,10,incrNewLine3      #if we reach end of line branch to incrNewLine3
		   		beq $t9,13,incrNewLine3      #if we reach end of Text branch to incrNewLine3
		   		beq $t9 ,32,AddForDelete     #if we have space then we should go to next line(For Deleted Test)
		   		li $t8, 48	      	      # $t8=ASCII value of '0'
		   		sub $t6, $t9, $t8	      #$t6=$t9-$t8
   	    	   		mul $t5, $t5, 10             # Multiply result by 10
                  		add $t5, $t5, $t6            # Add current digit to result
   	          		addi $s1, $s1, 1             # Move to next character
   	          		
   		   	j L3
   		   	
			AddForDelete:
			
				li $t5,0
				addi $s1,$s1,1
				
			j L3
			incrNewLine3:
			
   		   		addi $s1,$s1,1
   		   		
   		   	j L3
   		   	
   		   	
   		   	# loop to move to next char if the char is ':' to not count it 
   		   	incr3:
   		   	
   		   		addi $s1,$s1,1
   		   		
   		   	j CompareId3
   		   	
   		   	
   		   	#loop to compare the enterd id with the id's in medical_tests(buffer)
		   	CompareId3:
		   	
		   		beq  $t5,$t1,C1              #if the two id is equal branch to C1 
		   		li $t5,0                     #initlize the id result from buffer to 0 
		   		lb $t9, 0($s1)               # Load a character from the medical_tests  buffer
		   		addi $s1,$s1,1               # move to next char
		   		beq $t9,'\n' ,L3             # if we reach the end of line branch to L3
		   		beq $t9,0,def3               #if we reach end of file brach to def3
		   		
		  	 j CompareId3
		  	 
		        #to store test name in buffer name
		        C1:
		        
		        	addi $s7,$s7,1               # if the user enter a valid id then incremant s7
		        	la $s2,bufferName            #s2=address of bufferName
		        	li $t5,0
		        	
		        	parse_loop3:
		        	
    					lb $t4, 0($s1)                  # Load a character from the medical_test
    					beq $t4,',' ,incremantForC      #if t4= ',' branch to  incremantForC 
    				
   					# Store the character in the bufferName
    					sb $t4, 0($s2)             
    					addi $s2, $s2, 1
    					
   				j continue_parse3
  
				continue_parse3:
				
    					addi $s1, $s1, 1     # Move to the next character
    					
    				j parse_loop3
    				
		   	j C1
		   	
		   	#move to next char to not count comma
		   	incremantForC:
		   	
		   		addi $s1,$s1,1
		   		
		   	j C2

		   	
		   	C2:
		   	
				lb $t9, 0($s1)       	      # Load a character from the medical_tests buffer
		   		beq $t9,'-',IncrDash	      #if $t9=':' then branch to label IncrDash
		   		beq $t9,10,incrLineNew	
		   		li $t8, 48	      	      # $t8=ASCII value of '0'
		   		sub $t6, $t9, $t8	      #$t6=$t9-$t8
   	    	   		mul $s4, $s4, 10             # Multiply result by 10
                  		add $s4, $s4, $t6            # Add current digit to result
   	          		addi $s1, $s1, 1             # Move to next character
   	          		
   	          	j C2
   	          	
   	          	incrLineNew:
   	          		addi $s1,$s1,1
   	          	j C2
   	          	
   	          	IncrDash:
   	          	
		   		li $t5,0                     #initlize the id result from buffer to 0 
		   		la $a1,bufferRes            #s1=address of bufferRes
		   		
		   	j parse_loop31
		   	
		   	parse_loop31:
		   	
    				lb $t4, 0($s1)                  # Load a character from the medical_test
    				beq $t4,'\n' ,CheckEqualDate    # if we reach the end of line branch to CheckEqualDate
    				beq $t4,0,CheckEqualDate        # if we reach the end of file branch to CheckEqualDate
    				
   				# Store the character in the bufferName
    				sb $t4, 0($a1)             
    				addi $a1, $a1, 1
    				
   			j continue_parse31
  
			continue_parse31:
			
    				addi $s1, $s1, 1     # Move to the next character
    				
    			j parse_loop31
    			
    			#check if the two date is equal
    			CheckEqualDate:
    			
    				bge $s4,$s6,CheckEqualDate2     	#if the two id is equal branch to CheckEqualDate2
    				li $s4,0
    				beq $t9,0,loopMenu                  	# if we reach null branch to loopMenu
    				beq $t4,10,incrNewLine3         	# if we reach the end of line branch to incrNewLine3
    				
    			j L3
    			
    			#incremant for year
    			CheckEqualDate2:
    			
    				ble $s4,$s3,PrintResDate 
    				li $s4,0
    				beq $t9,0,loopMenu              # if we reach null branch to loopMenu
    				beq $t4,10,incrNewLine3         # if we reach the end of line branch to incrNewLine3
    				
    			j L3
    			
    			
    			#print results by date
    			PrintResDate:
    			
    				beq $s7,0,WrongpatinetID1  #if id counter is 0 branch to WrongpatinetID1
    				
    				print_string(bufferName)
    				print_string(COMMA)
    				
    				#print the year 
    				li $v0,1
    				move $a0,$s4
    				syscall
    				li $s4,0
    				
    				
    				print_string(bufferRes)
    				print_string(newLine)
    				
    				
    				# Initialize registers
   				 la $t0, bufferRes     		# Load address of the bufferRes
    				 li $t3, 0             		# Initialize value to store (zero)

    				# Fill the buffer with zeros
    				li $s0, 128         		# Buffer size (number of iterations)
				loopRes:
    					sb $t3, ($t0)       	# Store zero in the buffer
    					addi $t0, $t0, 1    	# Move to the next memory location
    					subi $s0, $s0, 1    	# Decrement the iteration count
    					bnez $s0, loopRes   	# Repeat until all locations are filled
    					
    			j DelBuffer
    			
    		DelBuffer:
    		
    			li $t0,0
    			li $t3,0
    		j L3
    			
    			def3:
    			
    				 beq $s7,0,WrongpatinetID2 	#s7=0 branch to WrongpatinetID2
    				 
    			j loopMenu
    			
    			
    			WrongpatinetID2:
    			
    				 print_string(wrongsearchId)
    				 
    			j TestInPeriod
    			

	#case3:
	Searching_for_unnormal_tests:
	
		li $t3,0
		li $t1,0
		print_string(EnterTest)
		lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
		
		li $a1,10			#a1= maximum string length
		la $a0,bufferUserTest		#$a0=address of bufferUserTest
		li $v0,8			#read string
		move $s3,$a0			#$s1=address of bufferUserTest
		syscall
		
		la $a0,medical_tests     	#$a0=address of medical_tests 
		move $s1,$a0            	# s1=address of medical_tests
		li $t1,0
		
		 #to store id in buffer id
		 Store1:
		 
		        la $s2,bufferId            #s2=address of bufferId
		  	
		        parseLoop:
		        
    				lb $t4, 0($s1)      # Load a character from the medical_test
    				beq $t4,':' ,SKIP   #if we reach the end of line branch to SKIP 
    				beq $t4,0,DEF	     #if we reach the end of file branch to DEF 
    				beq $t4,10,continueParse
    				beq $t4,32,skipForDeletedTest #if we have space then we should go to new line
   				# Store the character in the bufferId
    				sb $t4, 0($s2)             
    				addi $s2, $s2, 1
    				
   			j continueParse
  
			continueParse:
			
    				addi $s1, $s1, 1     # Move to the next character
    				
    			j parseLoop
    			
    			
    				
		   j Store1
		   
		   skipForDeletedTest:
    				la $s2, bufferId		# Load address of the buffer
    				li $t3, 0			# Initialize value to store (zero)

    				# Fill the buffer with zeros
    				li $s0, 100         		# Buffer size (number of iterations)
    		
				loopResDEl:
				
    					sb $t3, ($s2)       	# Store zero in the buffer
    					addi $s2, $s2, 1    	# Move to the next memory location
    					subi $s0, $s0, 1    	# Decrement the iteration count
    					bnez $s0, loopResDEl   # Repeat until all locations are filled with null
    				
    				addi $s1,$s1,1
    			j Store1
		   
		   #This to skip new line
		   SKIP:
		   
		   	addi $s1, $s1, 1     # Move to the next character
		   	
		   j JumpToTestName
		   

		   JumpToTestName:
		   
		   	la $a1,bufferName            #a1=address of bufferName
		   	
		   j parseLoop1
		   
		  #this to store test name in bufferName		   	
		  parseLoop1:
		  
    			lb $t4, 0($s1)                  # Load a character from the medical_test
    			beq $t4,',' ,SKIP2              # if we reach ',' branch to SKIP2
    				
   			# Store the character in the bufferName
    			sb $t4, 0($a1)             
    			addi $a1, $a1, 1
    			
   		j continueParse1
  
		continueParse1:
		
    			addi $s1, $s1, 1     # Move to the next character
    			
    		j parseLoop1
    		
    			
    		SKIP2:
    		
    			addi $s1, $s1, 1     # Move to the next character
    			la   $s7,bufferDate  #$s7=address of bufferDate
    			
    		j JumpToDate
    		
    		JumpToDate:
    		
    			lb $t4, 0($s1)               	# Load a character from the medical_test
    			beq $t4,',' ,Skip3    		# if we reach the end of line branch to Skip3
    			beq $t4,0,DEF                  #if we reach end of file brach to DEF
    				
   			# Store the character in the bufferName
    			sb $t4, 0($s7)             
    			addi $s7, $s7, 1
    			
   		j continueParse31
   		
  
		continueParse31:
		
    			addi $s1, $s1, 1     # Move to the next character
    			
    		j JumpToDate
    		
    			
		Skip3: 
		
			 addi $s1, $s1, 1     # Move to the next character  
			 li $s4,0
			 li $t3,0
			 li $t6,0
			 
		j GETFLOAT
		
		#this loop to convert  from string to int
		GETFLOAT:
		
			lb $t9, 0($s1)         # Load a character from the medical_test buffer
		  	beq $t9,'.',GETFLOAT2	#if $t9='.' then branch to label GETFLOAT2
		  	li $t8, 48		# ASCII value of '0'
   		 	sub $t6, $t9, $t8	#$t6=$t9-$t8	
   	    	   	mul $s4, $s4, 10       # Multiply result by 10
                  	add $s4, $s4, $t6      # Add current digit to result
                  	addi $s1, $s1, 1       # Move to next character
                  	
                j GETFLOAT
                
                
                #this loop to move from int to float and move to next character
                GETFLOAT2:
                
                	mtc1 $s4,$f1		#move the content from $s4 to $f1-->from int to float
                       cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               		addi $s1, $s1, 1       # Move to next character
               		
               	j FLOATConvert
               	
               	
               	#convert from string to int
               	FLOATConvert:
               	
               		lb $t9, 0($s1)                 # Load a character from the medical_test buffer
                       beq $t9,0,FLOATConvert1   	#if we reached the end of line branch to FLOATConvert1	
		  	beq $t9,10,FLOATConvert1	#if we have new line branch to FLOATConvert1	
		  	beq $t9,13,incremanEndText	#if we have new line branch to incremanEndText
		  	beq $t9,',',FLOATConvert1	#if we have ',' branch to FLOATConvert1
               	  	li $t8, 48		        # ASCII value of '0'
   		 	sub $t6, $t9, $t8	        #$t6=$t9-$t8	
   	    	   	mul $t3, $t3, 10              	# Multiply result by 10
                  	add $t3, $t3, $t6             	# Add current digit to result
                  	addi $s1, $s1, 1              	# Move to next character	
                  	addi $t2,$t2,1		       	#number of digit 
                  	
                j FLOATConvert
                
                
                # to not count \r 
               	incremanEndText:
               	
               		addi $s1, $s1, 1              # Move to next character	
               		
               	j FLOATConvert
               	
               	
               	#loop for fractional part
               FLOATConvert1:
               
               		mtc1 $t3,$f2			#move the content from $t3 to $f2 ->from int to float
                       cvt.s.w $f2,$f2			#convert the content in $f2 to float number 
               		mul.s  $f3, $f3,$f5            # multiply result by base
               		addi $s6, $s6, 1               # increment counter
               		bne $t2, $s6, FLOATConvert1    # repeat loop until counter equals exponent
		  	div.s $f2,$f2,$f3
		  	
		j AddFlOAT1
		
		#add two number to have the result 1
		AddFlOAT1:
		
			add.s $f4,$f2,$f1		#$f4=$f2+$f1 which $f4 is the test result
			lb $t9, 0($s1)                 # Load a character from the medical test buffer
			beq $t9,',',incremantResL	#if $t9=',' then branch to label incremantResL
          		lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
		        
		j TESTNAMEcheck
		 
		
		#loop to initialize counters to 0 if we have 2 results
		incremantResL:
		
			addi $s1,$s1,1   
               		li $s4,0			#set result of int to 0
          		li $t3,0			#set result of int to 0
          		li $s6,0			#set counter to 0
          		li $t2,0			#set counter of mul to 0
          		lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
		        
               	j GETFloat1
               	
               	
               	#this loop to convert  from string to int
               	GETFloat1:
               	
               		lb $t9, 0($s1)         		# Load a character from the medical test buffer
		  	beq $t9,'.',GETFloat2		#if $t9=',' then branch to label GETFloat2
		  	li $t8, 48			# ASCII value of '0'
   		 	sub $t6, $t9, $t8		#$t6=$t9-$t8	
   	    	   	mul $s4, $s4, 10       		# Multiply result by 10
                  	add $s4, $s4, $t6      		# Add current digit to result
                  	addi $s1, $s1, 1       		# Move to next character
                  	
             	j GETFloat1
             	
             	
             	#this loop to move from int to float and move to next character
             	GETFloat2:
             	
             		mtc1 $s4,$f1			#move the content from $s4 to $f1-->from int to float
                       cvt.s.w $f1,$f1			#convert the content in $f1 to float number 
               		addi $s1, $s1, 1       		# Move to next character
               		
              	j JUMPfloatFA
              	
              	
              	#convert from string to int
              	JUMPfloatFA:
              	
              		lb $t9, 0($s1)        		 # Load a character from the mrdical test  buffer
                       beq $t9,0,FAfloat11		#if we reached the end of line branch to Ffloat11
		  	beq $t9,10,FAfloat11		#if we have new line branch to Ffloat11
		  	beq $t9,13,IncremantRRR
               	        li $t8, 48			# ASCII value of '0'
   		 	sub $t6, $t9, $t8		#$t6=$t9-$t8	
   	    	   	mul $t3, $t3, 10       		# Multiply result by 10
                  	add $t3, $t3, $t6      		# Add current digit to result
                  	addi $s1, $s1, 1       		# Move to next character	
                  	addi $t2,$t2,1			#number of digit 
                  
               	j JUMPfloatFA
               	
               	
               	IncremantRRR:
               	
               		addi $s1,$s1,1
               		
               	j JUMPfloatFA
               	
               	
               	#loop for fractional part
               	FAfloat11:
               	
               		mtc1 $t3,$f2			#move the content from $t3 to $f2-->from int to float
               		cvt.s.w $f2,$f2			#convert the content in $f2 to float number 
               		mul.s  $f6, $f6,$f7            # multiply result by base
               		addi $s6, $s6, 1               # increment counter
               		bne $t2, $s6, FAfloat11        # repeat loop until counter equals exponent
		  	div.s $f2,$f2,$f6
		  	
		j AddFLO2
               	
               	#add two number to have the result 2
             	AddFLO2:
             	
             		add.s $f13,$f2,$f1		#$f13=$f2+$f1 which $f13 is the test result 2
             		
		j TESTNAMEcheck 
		
             	
             	TESTNAMEcheck:
             	
             		la $a1,bufferUserTest         	#a1=address of bufferUserTest
		        la $a2,bufferName            	#a2=address of bufferName
		        
		        LoopCompare:
		        
				# Load bytes from each string into $t0 and $t1
    				lb $t0, ($a2)
    				lb $t7, ($a1)
    				beq $t0,0,BufferEnd 		#if we reach the end of bufferName branch to BufferEnd
    				
   				# Compare the bytes
    				beq $t0, $t7, checkIfEnd  	# If equal branch to checkIfEnd 
   				
    			j Store1
    			
		       BufferEnd:
		       
		       		beq $t7,0,checkIfBuffersEqual 	#if we reach the end of bufferUserTest branch to checkIfBuffersEqual
    				beq $t7,10,checkIfBuffersEqual	#if we reach new line then branch to checkIfBuffersEqual
    				
    			j Store1
    			
    			#incremant the two buffer to hold new char
		       checkIfEnd:
		       
		       		addi $a2, $a2, 1
    				addi $a1, $a1, 1
    						
    			j LoopCompare
    			
    			checkIfBuffersEqual:
    			
    				li $t7,0		#this becouse the end of bufferUserTest is 10
    				beq $t0, $t7, Range  	# If equal branch to Range
    				
    			j Store1
    				
             					
		# to check if there any up normal test 			
    		Range:
    		
    			addi $t1,$t1,1			#incremant the invalid test counter
			la $a1,bufferName         	#a1=address of buffer name 
		        la $a2,Hemoglobin            	#a2=address of Hemoglobin
		        lwc1 $f10,LessHemoglobin      	#f10=LessHemoglobin
		        lwc1 $f11,MoreHemoglobin      	#f11=MoreHemoglobin
		        li $t3,0
		        li $s4,0
		        li $t6,0
		        
		       # Start of string comparison loop
			compareLoop:
			
				# Load bytes from each string into $t0 and $t1
    				lb $t0, ($a2)
    				lb $t7, ($a1)
    				beq $t0,0,EndOfBuffer
    				
   				# Compare the bytes
    				beq $t0, $t7, checkEnd  # If equal branch to checkEnd
   				
    			j LTest2 
    			                 
    			EndOfBuffer:
    			
    				beq $t7,0,checkTwoBufferEqual
    				
    			j LTest2
    				
    			checkTwoBufferEqual:
    			
    				li $t7,0
    				beq $t0, $t7, COMPARE1  # If equal branch to COMPARE1
    				
    			j LTest2
    			
    			COMPARE1:
    			
    				c.lt.s $f10,$f4          # if f4 > f10 then set the cc flags to 1  
    				bc1t COMPARE2            #if cc flags =1 branch to COMPARE2 (if result >13.8)
    				
    			#if result<13.8
    			j UpNormalPrint
    			
    			
    			#incremant the two buffer
    			checkEnd:
    			
    				addi $a2, $a2, 1
    				addi $a1, $a1, 1	
    					
    			j compareLoop
    			

		        COMPARE2:
		        
		        	c.lt.s $f11,$f4          	# if f4 > f11 then set the cc flags to 1 
		        	bc1t UpNormalPrint       	#if cc flags =1 branch to UpNormalPrint 
		        	
		        	#if the result  > 17.2
		        	li $s4,0	
		        	li $t6,0
		        	li $t3,0
		        	lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        	lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        	lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        	lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
    				addi $s1, $s1, 1     		# Move to the next character
    				
    			j Store1
    			
    			
    			#to print the up normal test 
    			UpNormalPrint:
    			
    				beq $t1,0,WrongTestName		#if test name counter is 0 branch to WrongTestName
		        	lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        	lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        	lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        	lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
		        	
		        	li $t6,0
		        	li $s4,0
    				li $t3,0
    				li $t2,0
		        	li $s6,0
		        	
		        	print_string (bufferId) 
		        	print_string (point) 		        	
		        	print_string (bufferName)  
		        	print_string (COMMA)   
		        	print_string (bufferDate) 
		        	print_string (COMMA)
		        	
		        	#to print result (float)
		        	li $v0,2
		        	mov.s  $f12,$f4
		        	syscall 
		        		
		        	print_string (newLine)
		        	
		        j Store1
		        
		        
		        LTest2:
		        
		        	la $a1,bufferName	#$a1=address of bufferName
		        	la $a2,BGT		#$a2=address of BGT
		        	lwc1 $f10,LessBGT	#f10=LessBGT
		        	lwc1 $f11,MoreBGT	#f11=MoreBGT
		        	li $t3,0
		        	li $s4,0
		        	li $t6,0
		        	
		        	# Start of string comparison loop
				compareLoop1:
				
					# Load bytes from each string into $t0 and $t1
    					lb $t0, ($a2)
    					lb $t7, ($a1)
    					beq $t0,0,EndOfBufferA
    					
   					# Compare the bytes
    					beq $t0, $t7, checkEndA  # If equal branch to checkEndA
   				
    				j LTest3 
    				
    				
    				EndOfBufferA:
    				
    					beq $t7,0,checkTwoBufferEqualA
    					
    				j LTest3
    				
    				checkTwoBufferEqualA:
    				
    					beq $t0, $t7, COMPAREA  # If equal branch to COMPAREA
    					
    				j LTest3
    				

    				COMPAREA:
    				
    					c.lt.s $f10,$f4          # if f4 > f10 then set the cc flags to 1  
    					bc1t COMPAREB            #if cc flags =1 branch to COMPAREB(if result >70)
    					
    				#if result <70	
    				j UpNormalPrint
    				
    			
    				checkEndA:
    				
    					addi $a2, $a2, 1
    					addi $a1, $a1, 1
    					
    				j compareLoop1
    				
    				
				#check if the result > 99
				COMPAREB:
				
		        		c.lt.s $f11,$f4          	# if f4 > f11 then set the cc flags to 1 
		        		bc1t UpNormalPrint       	#if cc flags =1 branch to UpNormalPrint (result>99)
		        		
		        		#result<99
		        		li $s4,0
		        		li $t3,0
		        		li $t6,0
		        		
		        		lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
    					addi $s1, $s1, 1     		# Move to the next character
    					
    				j Store1
    				
    			LTest3:
    			
    				la $a1,bufferName	#$a1=address of bufferName
		        	la $a2,LDL		#$a2=address of LDL
		        	lwc1 $f10,LessLDL	#f10=LessLDL
		        	
				li $t3,0
		        	li $s4,0
		        	li $t6,0
		        	
		        	# Start of string comparison loop
    				compareLoop2:
    				
					# Load bytes from each string into $t0 and $t1
    					lb $t0, ($a2)
    					lb $t7, ($a1)
    					beq $t0,0,EndOfBufferB
    					
   					# Compare the bytes
    					beq $t0, $t7, checkEndB  # If equal branch to checkEndB
    					
    				j LTest4                 
    				
    				
    				EndOfBufferB:
    				
    					beq $t7,0,checkTwoBufferEqualB
    					
    				j LTest4
    				
    			
    				checkTwoBufferEqualB:
    				
    					beq $t0, $t7, COMPAREC # If equal branch to COMPAREC
    					
    				j LTest4
    				
    				
    				COMPAREC:
    				
    					c.lt.s $f10,$f4         # if f4 > f10 then set the cc flags to 1  
    					bc1t COMPARED           #if cc flags =1 branch to COMPARED(if result >100)
    					
    				j LTest4
    				
    			
    				checkEndB:
    				
    					addi $a2, $a2, 1
    					addi $a1, $a1, 1
    					
    				j compareLoop2
    				
    				COMPARED:
    				
    					c.lt.s $f10,$f4          	# if f4 > f10 then set the cc flags to 1  
    					bc1t UpNormalPrint      	#if cc flags =1 branch to UpNormalPrint 
		        		lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
		        		
		        		li $t6,0
		        		li $s4,0
		        		li $t3,0
    					addi $s1, $s1, 1     # Move to the next character
    					
    				j Store1
    					
    					
    				LTest4:
    				
    					la $a1,bufferName	#$a1=address of bufferName
		        		la $a2,BPT		#$a2=address of BPT
		        		lwc1 $f10,LessBPT1	#f10=LessBPT1
		        		lwc1 $f11,LessBPT2	#f11=LessBPT2	
		        		
		        		li $t3,0
		        		li $s4,0
		        		li $t6,0
		        		
		        	# Start of string comparison loop
				compareLoop3:
				
					# Load bytes from each string into $t0 and $t1
    					lb $t0, ($a2)
    					lb $t7, ($a1)
    					beq $t0,0,EndOfBufferC
    					
   					# Compare the bytes
    					beq $t0, $t7, checkEndC # If equal branch to checkEndC
    					
    				j Store1
    				
    				                  
    				EndOfBufferC :
    				
    					beq $t7,0,checkTwoBufferEqualC

    				j Store1
    				
    				
    				checkTwoBufferEqualC:
    				
    					beq $t0, $t7, COMPAREE  # If equal branch to COMPAREE
    					
    				j Store1
    				
    				
    				COMPAREE:
    				
    					c.lt.s $f10,$f4                # if f4 > f10 then set the cc flags to 1  
    					bc1t IncrFloatError1            #if cc flags =1 branch to compare2
    					
    				j COMPAREF
    				
    				
    				#this loop count the number of up normal tests by incremant s5 by 1(incremant if first result is upnormal)
    				IncrFloatError:
    				
    					addi $s5,$s5,1
    					
    				j COMPAREF
    				
    				
    				#check if the result > 80.0
    				COMPAREF:
    				
    					c.lt.s $f11,$f13          # if f13 > f11 then set the cc flags to 1 
		        		bc1t IncrFloatError1 #if cc flags =1 branch to IncrFloatError1 
		        		bge $s5,1,UpNormalPrint1  #if the first result in the test is up normal then branch to UpNormalPrint1 it before test the second result
		        		lwc1 $f3,floatnumber	   # initialize result for mul to 1 for result 1
		        		lwc1 $f5,floatnumfordiv   # to count the number we want to div by it result 1
		        		lwc1 $f6,floatnumber      # initialize result for mul to 1 for result 2
		        		lwc1 $f7,floatnumfordiv   # to count the number we want to div by it for result 2
		        		li $t6,0
		        		li $s4,0
		        		li $t3,0
    					addi $s1, $s1, 1          # Move to the next character
    					
    				j Store1
    				    	
    				    	
    				IncrFloatError1:
    				
    					addi $s5,$s5,1
    					bge $s5,1,UpNormalPrint1 #if there any up normal test then brannch to UpNormalPrint1

    				j Store1
    				
    				checkEndC: 
    				
    					addi $a2, $a2, 1
    					addi $a1, $a1, 1
    					
    				j compareLoop3  
    				
    				
    			UpNormalPrint1 :
    			
				li $s4,0
    				li $t3,0
    				beq $t1,0,WrongTestName		#if id counter is 0 branch to WrongTestName
		        	lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
		        	lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
		        	lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
		        	lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
		        	li $t6,0
		        	li $t2,0
		        	li $s6,0
		        	print_string (bufferId) 
		        	print_string (point) 		        	
		        	print_string (bufferName)  
		        	print_string (COMMA)   
		        	print_string (bufferDate) 
		        	print_string (COMMA)
		        	
		        	#to print result (float)
		        	li $v0,2
		        	mov.s  $f12,$f4
		        	syscall
		        	
		        	print_string (COMMA)
		        	
		        	#to print result (float)
		        	li $v0,2
		        	mov.s  $f12,$f13
		        	syscall
		        	
		        	print_string (newLine)
		        	
		        j Store1
		        
		        		 		        						
		DEF:
		
			beq $t1,0,WrongTestName 	#s7=0 branch to WrongTestName
			
    		j loopMenu
    		
    		
    		WrongTestName:
    		
    			print_string(wrongTestName)
    			
   		j Searching_for_unnormal_tests
   		
   		
   	#case 4
	Average:
	
		li $t3,0
		li $t1,0
		la $a0,medical_tests    	#$a0=address of medical_tests 
		move $s1,$a0            	# s1=address of medical_tests 
		
		InitialForAvg:
		
			lwc1 $f3,floatnumber	 # initialize result for mul to 1 for result 1
			lwc1 $f5,floatnumfordiv # to count the number we want to div by it result 1
			lwc1 $f6,floatnumber    # initialize result for mul to 1 for result 2
			lwc1 $f7,floatnumfordiv # to count the number we want to div by it for result
			lwc1 $f25,floatnumber
			li $s4,0
			li $t3,0
			
		j SkipId
		
		
		SkipId:
			
			lb $t9, 0($s1)       	      		# Load a character from the medical_tests buffer
		   	beq $t9,':',SkipAnchorPoint	      	#if $t9=':' then branch to label SkipAnchorPoint
		   	beq $t9,0,PrintAvgResult           	#if we reach end of file branch to PrintAvgResult
		   	beq $t9,10,SkipNewLine	      		#if we rach end of line branch to SkipNewLine
		   	addi $s1, $s1, 1             		# Move to next character
		   	
		j SkipId
		
		
		SkipAnchorPoint:
		
			addi $s1,$s1,1
			
		j StoreName
		
		# loop to move to next char if the char is '\n' to not count it 
		SkipNewLine:
		
			addi $s1,$s1,1
			
		j SkipId 
		
		
		#to store test name in buffer name
		StoreName:
		
			la $s2,bufferName            		 #s2=address of bufferName
			
			store_loop:
			
    				lb $t9, 0($s1)                  # Load a character from the medical_test
    				beq $t9,',' ,SkipComma		 #if we reach the end of line branch to SkipComma 
    				
   				# Store the character in the bufferName
    				sb $t9, 0($s2)             
    				addi $s2, $s2, 1
    				
   			j continue_store
  
  
			continue_store:
			
    				addi $s1, $s1, 1     		# Move to the next character
    				
    			j store_loop
    			
		j StoreName
		
		
		SkipComma:
		
			addi $s1, $s1, 1     			# Move to the next character
			
		j SkipDate
		
		
		SkipDate:
		
			lb $t9, 0($s1)       	      # Load a character from the medical_tests buffer
		   	beq $t9,',',SkipComma2	      #if $t9=',' then branch to label SkipComma2
		   	beq $t9,10,SkipNewLine	      #if we rach end of line branch to SkipNewLine
		   	addi $s1, $s1, 1             # Move to next character
		   	
		j SkipDate
		
		#move to next char to not count comma
		SkipComma2:
		
			addi $s1, $s1, 1     	     # Move to the next character
			
		j StroreFloat

    		#this loop to convert  from string to int for the integer part in result float
		StroreFloat:
		
			lb $t9, 0($s1)         		# Load a character from the medical_test buffer
		  	beq $t9,'.',StroreFloat2	#if $t9='.' then branch to label StroreFloat2
		  	li $t8, 48			# ASCII value of '0'
   		 	sub $t6, $t9, $t8		#$t6=$t9-$t8	
   	    	   	mul $s4, $s4, 10       		# Multiply result by 10
                  	add $s4, $s4, $t6      		# Add current digit to result
                  	addi $s1, $s1, 1       		# Move to next character
                  	
               j StroreFloat
               
               	#this loop to move from int (integer part in result float)to float and move to next character     
               	 StroreFloat2:
               	 
               		mtc1 $s4,$f1		#move the content from $s4 to $f1-->from int to float
                       cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               		addi $s1, $s1, 1       # Move to next character   
               		
               	j StorefloatConvert  
               	
               	#convert from string to int for fracthional part in result float 
               	StorefloatConvert:  
               	  
               		lb $t9, 0($s1)                 		# Load a character from the medical_test buffer
                       beq $t9,0,StorefloatConvert1   		#if we reached null branch to StorefloatConvert1	
		  	beq $t9,10,StorefloatConvert1		#if we have new line branch to StorefloatConvert1	
		  	beq $t9,13,incremantEnd   		#if we have end of text branch to incremantEnd
		  	beq $t9,',',StorefloatConvert1      	#if t9= ',' branch to StorefloatConvert1
               	        li $t8, 48		        	# ASCII value of '0'
   		 	sub $t6, $t9, $t8	        	#$t6=$t9-$t8	
   	    	   	mul $t3, $t3, 10              		# Multiply result by 10
                  	add $t3, $t3, $t6             		# Add current digit to result
                  	addi $s1, $s1, 1              		# Move to next character	
                  	addi $t2,$t2,1		       		#number of digit
                  	
               j StorefloatConvert
               
		# to not count \r 
		incremantEnd:
		
			addi $s1, $s1, 1              		# Move to next character	
			
               	j StorefloatConvert
               	
               	#loop for fractional part to convert from int to float 
		StorefloatConvert1:
		
			mtc1 $t3,$f2				#move the content from $t3 to $f2-->from int to float
                       cvt.s.w $f2,$f2				#convert the content in $f2 to float number 
               		mul.s  $f3, $f3,$f5            		# multiply result by base
               		addi $s6, $s6, 1               		# increment counter
               		bne $t2, $s6, StorefloatConvert1 	# repeat loop until counter equals exp
		  	div.s $f2,$f2,$f3
		  	
		j AddTwoFloats
		
		#add two number to have the result 1
		AddTwoFloats:
		
			add.s $f4,$f2,$f1			#$f4=$f2+$f1 which $f4 is the test result
			lb $t9, 0($s1)                 		# Load a character from the medical test buffer
			beq $t9,',',StoreRes2   		#if $t9=',' then branch to StoreRes2
			
                j CalculateAvg
                
		#loop to initialize counters to 0 if we have 2 results                
                StoreRes2:
                
                	addi $s1,$s1,1   
               		li $s4,0			#set result of int to 0
          		li $t3,0			#set result of int to 0
          		li $s6,0
          		li $t2,0			#set counter of mul to 0
          		
          	j StoreFloat1
          	
          	#this loop to convert  from string to int for result 2
          	StoreFloat1:
          	
          		lb $t9, 0($s1)         		# Load a character from the medical test buffer
		  	beq $t9,'.',StoreFloat2		#if $t9=',' then branch to label StoreFloat2
		  	li $t8, 48			# ASCII value of '0'
   		 	sub $t6, $t9, $t8		#$t6=$t9-$t8	
   	    	   	mul $s4, $s4, 10       		# Multiply result by 10
                  	add $s4, $s4, $t6      		# Add current digit to result
                  	addi $s1, $s1, 1       		# Move to next character
                  	
               j StoreFloat1
               
              	#this loop to move from int to float (int part in result 2)and move to next character
               StoreFloat2:   
               
               		mtc1 $s4,$f1		#move the content from $s4 to $f1-->from int to float
                       cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               		addi $s1, $s1, 1       # Move to next character
               		
               	j fracshional
               	
              	#convert from string to int for fracshional part in result 2               	
               	fracshional:
               	
               		lb $t9, 0($s1)        	 	# Load a character from the mrdical test  buffer
                       beq $t9,0,fracshional1		#if we reached the end of line branch to fracshional1
		 	beq $t9,10,fracshional1		#if we have new line branch to fracshional1
		  	beq $t9,13,IncremantREnd 	#if we rach \r then branch to IncremantREnd
               	    	li $t8, 48			# ASCII value of '0'
   		 	sub $t6, $t9, $t8		#$t6=$t9-$t8	
   	    	   	mul $t3, $t3, 10       		# Multiply result by 10
                  	add $t3, $t3, $t6      		# Add current digit to result
                  	addi $s1, $s1, 1       		# Move to next character	
                  	addi $t2,$t2,1			#number of digit
                  	
               j fracshional
               
               	#to not count \r                	
               	IncremantREnd:
               		
               		addi $s1,$s1,1
               		
               	 j fracshional
               	 
               	#loop for fractional part in result 2 to convert from int to float 
               	fracshional1:
               	
               		mtc1 $t3,$f2			#move the content from $t3 to $f2-->from int to float
               		cvt.s.w $f2,$f2			#convert the content in $f2 to float number 
               		mul.s  $f6, $f6,$f7            # multiply result by base
               		addi $s6, $s6, 1               # increment counter
               		bne $t2, $s6, fracshional1     # repeat loop until counter equals exponent
		  	div.s $f2,$f2,$f6
		  	
           	j AddTwoFloatResults2

		#add two number to have the result 2           	
           	AddTwoFloatResults2:
           	
           		add.s $f13,$f2,$f1		#$f13=$f2+$f1 which $f13 is the test result 2
           		
           	j CalculateAvg
           		
           		
                CalculateAvg:
                
                	la $a1,bufferName              #a1=address of buffer name 
		      	la $a2,Hemoglobin              #a2=address of Hemoglobin
		      	
		      	# Start of string comparison loop
			compare_String:
			
				# Load bytes from each string into $t0 and $t1
    				lb $t0, ($a2)
    				lb $t7, ($a1)
    				beq $t0,0,EndBuffer1     #if we reach end in the buffer a2 branch to EndBuffer1
    					
   				# Compare the bytes (first byte)
    				beq $t0, $t7, IncrementTheTwoBuffer # If equal branch to IncrementTheTwoBuffer
    				
    			j Test2Load
    			
    			#to check if the buffer a1 is also reach end or not 
    			EndBuffer1:
    			
    				beq $t7,0,checkEqual #if buffer a1 also reach end then branch to checkEqual
    				
    			j Test2Load
    				
    			IncrementTheTwoBuffer:
    			
    				addi $a2, $a2, 1
    				addi $a1, $a1, 1
    						
    			j compare_String
    			
    			
    			#to check if the two buffer is equal 
    			checkEqual:
    			
    				beq $t0, $t7, IncremantCounter # If equal branch to IncremantCounter
    				
    			j Test2Load
    			
    			IncremantCounter:
    			
    				add.s  $f15,$f15,$f25		#incremant counter of Hgb number 
    				add.s $f20,$f20,$f4		#store all Hgb result in f20
    				
    			j InitialForAvg
    			
    			
    			Test2Load:
    			
    				la $a1,bufferName	#$a1=address of bufferName
		        	la $a2,BGT		#$a2=address of BGT
		        		
		        # Start of string comparison loop
			compare_String1:
			
				# Load bytes from each string into $t0 and $t1
    				lb $t0, ($a2)
    				lb $t7, ($a1)
    				beq $t0,0,EndBuffer2     #if we reach end in the buffer a2 branch to EndBuffer2
    				
    					
   				# Compare the bytes (first byte)
    				beq $t0, $t7, IncrementTheTwoBuffer1 # If equal branch to IncrementTheTwoBuffer1
    				
    			j Test3Load
    			
    			
    			#to check if the buffer a1 is also reach end or not 
    			EndBuffer2:
    			
    				beq $t7,0,checkEqual1 	#if buffer a1 also reach end then branch to checkEqual1
    				
    			j Test3Load
    				
    				
    			IncrementTheTwoBuffer1:
    			
    				addi $a2, $a2, 1
    				addi $a1, $a1, 1
    						
    			j compare_String1
    			
    			
    			#to check if the two buffer is equal 
    			checkEqual1:
    			
    				beq $t0, $t7, IncremantCounter1   # If equal branch to IncremantCounter1
    				
    			j Test3Load
    			
    			IncremantCounter1:
    			
    				add.s  $f16,$f16,$f25		#incremant counter of BGT number 
    				add.s $f21,$f21,$f4		#store all the BGT result in f21
    						
    			j InitialForAvg
    			
		        
    			Test3Load:
    			
    				la $a1,bufferName	#$a1=address of bufferName
		        	la $a2,LDL		#$a2=address of LDL
		        		
		        # Start of string comparison loop
			compare_String2:
			
				# Load bytes from each string into $t0 and $t1
    				lb $t0, ($a2)
    				lb $t7, ($a1)
    				beq $t0,0,EndBuffer3     #if we reach end in the buffer a2 branch to EndBuffer3
    				
    					
   				# Compare the bytes (first byte)
    				beq $t0, $t7, IncrementTheTwoBuffer2 # If equal branch to IncrementTheTwoBuffer1
    				
    			j Test4Load
    			
    			#to check if the buffer a1 is also reach end or not 
    			EndBuffer3:
    			
    				beq $t7,0,checkEqual2 	#if buffer a1 also reach end then branch to checkEqual2
    				
    			j Test4Load
    				
    			IncrementTheTwoBuffer2:
    			
    				addi $a2, $a2, 1
    				addi $a1, $a1, 1
    						
    			j compare_String2
    			
    			
    			#to check if the two buffer is equal 
    			checkEqual2:
    			
    				beq $t0, $t7, IncremantCounter2 # If equal branch to IncremantCounter2
    				
    			j Test4Load
    			
    			IncremantCounter2:
    			
    				add.s  $f17,$f17,$f25 		#incremant counter of LDL number 
    				add.s $f22,$f22,$f4		#store all the LDL result in f22
    						
    			j InitialForAvg
		        
    			Test4Load:
    			
    				la $a1,bufferName	#$a1=address of bufferName
		        	la $a2,BPT		#$a2=address of BPT
		        	
		        # Start of string comparison loop
			compare_String3:
			
				# Load bytes from each string into $t0 and $t1
    				lb $t0, ($a2)
    				lb $t7, ($a1)
    				beq $t0,0,EndBuffer4     #if we reach null in the buffer a2 branch to EndBuffer4
    				
    					
   				# Compare the bytes (first byte)
    				beq $t0, $t7, IncrementTheTwoBuffer3 # If equal branch to IncrementTheTwoBuffer3
    				
    			j InitialForAvg
    			
    			
    			#to check if the buffer a1 is also reach end or not 
    			EndBuffer4:
    			
    				beq $t7,0,checkEqual3 #if buffer a1 also reach end then branch to checkEqual3
    				
    			j InitialForAvg
    				
    			IncrementTheTwoBuffer3:
    			
    				addi $a2, $a2, 1
    				addi $a1, $a1, 1
    						
    			j compare_String3
    			
    			
    			#to check if the two buffer is equal 
    			checkEqual3:
    			
    				beq $t0, $t7, IncremantCounter3 # If equal branch to IncremantCounter3
    				
    			j InitialForAvg
    			
    			IncremantCounter3:
    			
    				add.s  $f18,$f18,$f25		#incremant counter of BPT number 
    				add.s  $f19,$f19,$f25		#incremant counter of BPT number 
    				add.s $f23,$f23,$f4		#store all the BPT result 1 in f23
    				add.s $f24,$f24,$f13		#store all the BPT result 2 in f24
    						
    			j InitialForAvg
    			
		        
		        PrintAvgResult:
		        
		                #division to find the AVG for all tests 
		        	div.s $f20,$f20,$f15
		        	div.s $f23,$f23,$f18
    				div.s $f24,$f24,$f19
    				div.s $f22,$f22,$f17
    				div.s $f21,$f21,$f16
		        	print_string (Hemoglobin)  
		        	print_string (point) 
		        			        	
		        	#to print result (float)
		        	li $v0,2
		        	mov.s  $f12,$f20
		        	syscall
		       		print_string (newLine)
		       		
		       		print_string (LDL)  
		        	print_string (point) 	
		        		        	
		        	#to print result (float)
		        	li $v0,2
		        	mov.s  $f12,$f22
		        	syscall
		       		print_string (newLine)
		       		
		       		print_string (BGT)  
		        	print_string (point) 
		        			        	
		        	#to print result (float)
		        	li $v0,2
		        	mov.s  $f12,$f21
		        	syscall
		       		print_string (newLine)
		       		
		       		print_string (BPT)  
		        	print_string (point) 		        	
		        	
		        	#to print result (float)
		        	li $v0,2
		        	mov.s  $f12,$f23
		        	syscall
		        	
		        	print_string (COMMA)
		        	
		        	#to print result (float)
		        	li $v0,2
		        	mov.s  $f12,$f24
		        	syscall
		        	
		        	print_string (newLine)
		        	
		        j loopMenu
		       		
		        	
	#case 5:	
	Update:
	
		li $t5,0	#counter for all test 
		li $t6,0	#counter for equal test
		li $s4,0	#counter for know if the test that user enter is found
		li $s7,0
		li $s6,0
		la $s2,medical_tests  
		
		#print the medical test
		print_string(medical_tests)
		print_string (newLine)
		 
		la $t9, UpdateBuffer  		# Load address of the buffer
    		li $t3, 0             		# Initialize value to store (zero)

    		# Fill the buffer with zeros
    		li $s0, 100         		# Buffer size (number of iterations)
    		
		loopResC:
		
    			sb $t3, ($t9)       	# Store zero in the buffer
    			addi $t9, $t9, 1    	# Move to the next memory location
    			subi $s0, $s0, 1    	# Decrement the iteration count
    			bnez $s0, loopResC   	# Repeat until all locations are filled
    		
		print_string (MsgToUpdate)
		
		
		li $a1,100			#a1= maximum string length
		la $a0,UpdateBuffer		#$a0=address of UpdateBuffer
		li $v0,8			#read string
		move $t9,$a0			#$s1=address of UpdateBuffer
		syscall
		
		la $t1, BufferTOUpdate  	# Load address of the BufferTOUpdate
    		li $t6,0	
    		
		parse1:

    			lb $t4, 0($s2)                	# Load a character from the medical_test
    			beq $t4,'\n' ,CHECKFORUPDATE1  #if we reach the end of line branch to CHECKFORUPDATE
    			beq $t4,0,CHECKFORUPDATE       #if we reach end of file brach to CHECKFORUPDATE
    			addi $t5,$t5,1	
    			
    			
   			# Store the character in the BufferTOUpdate
    			sb $t4, 0($t1)             
    			addi $t1, $t1, 1
    			
   		j continue_1
   		
    	
		continue_1:
		
    			addi $s2, $s2, 1     		# Move to the next character
    			
    		j parse1
    		
    		CHECKFORUPDATE1:
    		
    			addi $s2, $s2, 1               # Move to the next character
    			
    		j CHECKFORUPDATE
    		
    		
    		CHECKFORUPDATE:
    		    	
    		    	addi $t5,$t5,1
    			la $a1,UpdateBuffer         	#a1=address of UpdateBuffer
		        la $a2,BufferTOUpdate          #a2=address of BufferTOUpdate
		        li $t6,0
		        
		        LoopForCompare:
		        
				# Load bytes from each string into $t0 and $t1
    				lb $t0, ($a2)
    				lb $t7, ($a1)
    				addi $t6,$t6,1
    				beq $t0,13,IFBufferEnd 			#if we reach the end of bufferName branch to IFBufferEnd
    				beq $t0,0,IFBufferEnd 			#if we reach the end of bufferName branch to IFBufferEnd
    				
   				# Compare the bytes
    				beq $t0, $t7, INCREMANTBUFFERS  	# If equal branch to INCREMANTBUFFERS 
   				
    			j Testparse1
    			
    			
		       IFBufferEnd:
		       
		       		beq $t7,0,TOcheckIfBuffersEqual1 	#if we reach the end of bufferUserTest branch to TOcheckIfBuffersEqual1
    				beq $t7,10,TOcheckIfBuffersEqual1	#if we reach new line then branch to TOcheckIfBuffersEqual1
    				
    			j Testparse1
    			
    			#incremant the two buffer to hold new char
		       INCREMANTBUFFERS:
		       
		       		addi $a2, $a2, 1
    				addi $a1, $a1, 1
    						
    			j LoopForCompare
    			
    			
    			TOcheckIfBuffersEqual1:
    			
    				li $t7,13				#this becouse the end of bufferUserTest is 13
    				
    			j TOcheckIfBuffersEqual
    			
    			
    			TOcheckIfBuffersEqual:

    				beq $t0, $t7,Equal_Buffer  		# If equal branch to Equal_Buffer 
    				li $t7,0
    				b TOcheckIfBuffersEqual
    				
    			j Testparse1
    			
    			
    			Testparse1:
    			
    				beq $t4,0,DefultCASE
    				la $t1, BufferTOUpdate  # Load address of the buffer
    				li $t3, 0            	 # Initialize value to store (zero)

    				# Fill the buffer with zeros
    				li $s0, 50         	    	 # Buffer size (number of iterations)
				loopResD:
				
    					sb $t3, ($t1)       	# Store zero in the buffer
    					addi $t1, $t1, 1    	# Move to the next memory location
    					subi $s0, $s0, 1    	# Decrement the iteration count
    					bnez $s0, loopResD  	# Repeat until all locations are filled
    				        la $t1,BufferTOUpdate  # Load address of the buffer
    				
    			j parse1
    			
    			
    		Equal_Buffer :
    		
    			addi $s4,$s4,1	
    			la $s2,medical_tests
    			sub $t6,$t5,$t6
    			li $t5,0
    			print_string(MSgToUserForUpdate)
    			
    			li $a1,50			#a1= maximum string length
			la $a0,NewUpdateResult		#$a0=address of NewUpdateResult
			li $v0,8			#read string
			move $s3,$a0			#$s1=address of NewUpdateResult
			syscall
			
			lwc1 $f3,floatnumber		# initialize result for mul to 1 for result 1
			lwc1 $f5,floatnumfordiv 	# to count the number we want to div by it result 1
			lwc1 $f6,floatnumber    	# initialize result for mul to 1 for result 2
			lwc1 $f7,floatnumfordiv 	# to count the number we want to div by it for result 2
			
    			la $t9,UpdateBuffer
    			
    			CheckUpdateResult:
    			
    				lb $t4, 0($s3)         		# Load a character from the NewUpdateResult buffer
		  		beq $t4,'.',Resultfloat2	#if $t9='.' then branch to label Resultfloat2
		  	
		  		#if user enter char insted of int in result:
		   		blt $t4,'0',UpdateError5  
		   		bgt $t4,'9',UpdateError5
		   		#..........................................
		   		
		  		li $t8, 48		# ASCII value of '0'
   		 		sub $t7, $t4, $t8	#$t6=$t9-$t8	
   	    	   		mul $t2, $t2, 10       # Multiply result by 10
                  		add $t2, $t2, $t7      # Add current digit to result
                  		addi $s3, $s3, 1       # Move to next character
                  		
               		j CheckUpdateResult
               		
               		#this loop to move from int to float and move to next character
               		Resultfloat2:
               		
               			bge  $s7,1,ErrorUpdateFloat  	#to test if there any char in result
                		mtc1 $t2,$f1			#move the content from $t2 to $f1-->from int to float
                       	cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               			addi $s3, $s3, 1       		# Move to next character
               			
               		j UpdatefloatRes
               		
               		#convert from string to int
               		UpdatefloatRes:
               		
               			lb $t4, 0($s3)         		# Load a character from the NewUpdateResult buffer
                      		beq $t4,0,UpdatefloatRes1	#if we reached the end of line branch to UpdatefloatRes1
		  		beq $t4,',',incremantForUpdate	#if $t9=',' then branch to label incremantForUpdate
		  		beq $t4,10,UpdatefloatRes1	#if we have new line branch to UpdatefloatRes1
               	        	li $t8, 48			# ASCII value of '0'
   		 		sub $t7, $t4, $t8		#$t6=$t9-$t8	
   	    	   		mul $t3, $t3, 10       		# Multiply result by 10
                  		add $t3, $t3, $t7      		# Add current digit to result
                  		addi $s3, $s3, 1       		# Move to next character	
                  		addi $s5,$s5,1			#number of digit 
                  		
              		j UpdatefloatRes
              		
              		 #loop for fractional part
              		UpdatefloatRes1:
              		
              			mtc1 $t3,$f2			#move the content from $t5 to $f2-->from int to float
                       	cvt.s.w $f2,$f2			#convert the content in $f1 to float number 
               			mul.s  $f3, $f3,$f5           	# multiply result by base
               			addi $s6, $s6, 1               # increment counter
               			bne $s5, $s6, UpdatefloatRes1  # repeat loop until counter equals exponent
		  		div.s $f2,$f2,$f3
		  		
			j AddFloatREs
			
			
			#add two number to have the result
			AddFloatREs:
			
				add.s $f4,$f2,$f1		#$f4=$f2+$f1 which $f4 is the test result
				
			j UPDATETESTNAME 
			
			#loop to initialize counters to 0 if we have 2 results
              		incremantForUpdate:
              		
              			li $t2,0			#set result of int to 0
          			li $t3,0			#set result of int to 0
          			li $s7,0			#set counter of char to 0
          			li $s6,0			#set counter of mul to 0
          			li $s1,0
          			
          		j CheckUpdateResult2
          		
          		
          		#this loop to convert  from string to int
          		CheckUpdateResult2:
          		
          			lb $t4, 0($s3)         		# Load a character from the  NewUpdateResult buffer
		  		beq $t4,'.',CheckUpdatefloat21	#if $t4='.' then branch to label CheckUpdatefloat21
		  		beq $t4,',',CheckUpdatefloat213	#if $t4='.' then branch to label CheckUpdatefloat213
		  		
		  		#if user enter char insted of int in float:
		   		blt $t4,'0',UpdateError6  
		   		bgt $t4,'9',UpdateError6
		   		#..........................................
		   		
		  		li $t8, 48			# ASCII value of '0'
   		 		sub $t7, $t4, $t8		#$t6=$t9-$t8	
   	    	   		mul $t2, $t2, 10       		# Multiply result by 10
                  		add $t2, $t2, $t7      		# Add current digit to result
                  		addi $s3, $s3, 1       		# Move to next character
                  		
              		j CheckUpdateResult2
              		
              		
              		CheckUpdatefloat213:
              		
              			addi $s3,$s3,1
              			
              		j CheckUpdateResult2
              		
              		#this loop to move from int to float and move to next character
              		CheckUpdatefloat21:
              		
              			bge  $s7,1,ErrorUpdateFloat  	#to test if there any char in float 
              			mtc1 $t2,$f1			#move the content from $t2 to $f1-->from int to float
                       	cvt.s.w $f1,$f1		#convert the content in $f1 to float number 
               			addi $s3, $s3, 1       		# Move to next character
               			
              		j UpdatefloatF
              		
              		
              		#convert from string to int
              		UpdatefloatF:
              		
              			lb $t4, 0($s3)         		# Load a character from the NewUpdateResult buffer
                       	beq $t4,0,Updatefloat11#if we reached null branch to Updatefloat11
		  		beq $t4,10,Updatefloat11	#if we have new line branch to Updatefloat11
               	        	li $t8, 48			# ASCII value of '0'
   		 		sub $t7, $t4, $t8		#$t6=$t9-$t8	
   	    	   		mul $t3, $t3, 10       		# Multiply result by 10
                  		add $t3, $t3, $t6      		# Add current digit to result
                  		addi $s3, $s3, 1       		# Move to next character	
                  		addi $s1,$s1,1			#number of digit 
                  		
               		j UpdatefloatF
               		
               		#loop for fractional part
               		Updatefloat11:
               		
               			mtc1 $t3,$f2			#move the content from $t3 to $f2 -->from int to float
                       	cvt.s.w $f2,$f2			#convert the content in $f2 to float number 
               			mul.s  $f6, $f6,$f7           	# multiply result by base
               			addi $s6, $s6, 1               # increment counter
               			bne $t2, $s6,Updatefloat11     # repeat loop until counter equals exponent
		  		div.s $f2,$f2,$f6
		  		
			j AddFloatREs

			#this loop if user enter char insted of int in float number
               		UpdateError5:
               		
               			addi $s7,$s7,1		#increment counter if there is an char in float result
				addi $s3,$s3,1		#move to next char
				
			j CheckUpdateResult
			
			#this loop if user enter char insted of int in float number
			UpdateError6:
			
				addi $s7,$s7,1		#increment counter if there is an char in float result
				addi $s3,$s3,1		#move to next char
				
			j CheckUpdateResult2
			
   
               		ErrorUpdateFloat:
               		
               			print_string(Errorfloat)
                		addi $s3,$s3,1		# Move to next character
                		
   		 	j Equal_Buffer 
               		
               		#load untill we reach the line that have to update 
               		UPDATETESTNAME:
               		
               			lb $t4, 0($s2)         		# Load a character from the medical test buffer
				addi $s2,$s2,1         		# move to next char
				addi $t5,$t5,1         		#count the number of char we reach in medical test
				beq $t5,$t6,StoreUPDATETESTNAME #if we reach the first position we want to update branch to StoreUPDATETESTNAME
				
			j UPDATETESTNAME
			
			
			#to skip untill we reach comma in the line we want to update 
			StoreUPDATETESTNAME:
			
				lb $t4, 0($s2)         			# Load a character from the medical test buffer
			       	beq $t4,',',StoreUPDATETESTNAME1       #if we reach comma branch to StoreUPDATETESTNAME1
				addi $s2,$s2,1                         #move to next char 
				
			j StoreUPDATETESTNAME
			
			
			#loop to skip the comma 
			StoreUPDATETESTNAME1:
			
				addi $s2,$s2,1
				
			j StoreUPDATETESTNAME2
			
			
			#still skip untill we reach the second comma 
			StoreUPDATETESTNAME2:
			
				lb $t4, 0($s2)        			 # Load a character from the medical test buffer
				beq $t4,',',StoreUPDATETESTNAME3 	 #if we reach comma branch to StoreUPDATETESTNAME3
				addi $s2,$s2,1
				
			j StoreUPDATETESTNAME2
			
			
			#skip the comma and load NewUpdateResult to store it in s3
			StoreUPDATETESTNAME3:
			
				addi $s2,$s2,1
				la $s3,NewUpdateResult
				
			j StoreUPDATETESTNAME4
			
			
			#store NewUpdateResult insted of result we update it 
			StoreUPDATETESTNAME4:
			
				lb $t4, 0($s3)       	      # Load a character from the medical_tests  buffer
				beq $t4,10,StoreNewLine
				sb $t4,0($s2)
				addi $s3,$s3,1
				addi $s2,$s2,1
				
			j StoreUPDATETESTNAME4
			
			#skip new line and print the Msg 
			StoreNewLine:
			
				addi $s2,$s2,1
				
				li $v0,4
				la $a0,UpdateMSg
				syscall
			j loopMenu
			
		#if the user enter invalid test 			
		DefultCASE:
		
			beq $s4,0,PrintWrongRes
			
		j loopMenu
		
		
		PrintWrongRes:
		
			print_string(WrongUpDateResult)
			
		j Update
		
	j loopMenu
	
	#case 6:
	Delete:
	
		li $t5,0
		li $t6,0	#counter for equal test
		li $s4,0	#counter for know if the test that user enter is found
		li $s7,0
		li $s6,0
		la $s2,medical_tests 
		 
		#print the medical test
		print_string(medical_tests)
		print_string (newLine)
		
		
		la $t9, UpdateBuffer  		# Load address of the UpdateBuffer
		
		li $t3, 0             		# Initialize value to store (zero)

    		# Fill the buffer with zeros
    		li $s0, 100         		# Buffer size (number of iterations)
    		
		loopResE:
		
    			sb $t3, ($t9)       	# Store zero in the buffer
    			addi $t9, $t9, 1    	# Move to the next memory location
    			subi $s0, $s0, 1    	# Decrement the iteration count
    			bnez $s0, loopResE   	# Repeat until all locations are filled
    			
    			
    		print_string (MsgToDelete)
    		
    		li $a1,100			#a1= maximum string length
		la $a0,UpdateBuffer		#$a0=address of UpdateBuffer
		li $v0,8			#read string
		move $t9,$a0			#$s1=address of UpdateBuffer
		syscall
		
		la $t1, BufferTOUpdate  	# Load address of the BufferTOUpdate
    		li $t6,0
    		
    		
    		#skip the medical test char untill we reach new line 
    		parse1LOOP:
    		
    			lb $t4, 0($s2)                		# Load a character from the medical_test
    			beq $t4,'\n' ,CHECKFORUPDATE1LOOP  	#if we reach the end of line branch to CHECKFORUPDATE1LOOP
    			beq $t4,0,CHECKFORUPDATELOOP        	#if we reach end of file brach to CHECKFORUPDATELOOP
    			addi $t5,$t5,1	                       #to count the number char we reach in medical test 
    			
   			# Store the character in the BufferTOUpdate
    			sb $t4, 0($t1)             
    			addi $t1, $t1, 1
    			
   		j continue_1LOOP
   		
   		
   		continue_1LOOP:
   		
    			addi $s2, $s2, 1     # Move to the next character
    			
    		j parse1LOOP
    		
    		
    		
    		CHECKFORUPDATE1LOOP:
    		
    			addi $s2, $s2, 1               # Move to the next character
    			
    		j CHECKFORUPDATELOOP
    		
    		
    		#check if we reach the line we want to delete 
    		CHECKFORUPDATELOOP:
    		    	
    		    	addi $t5,$t5,1
    			la $a1,UpdateBuffer         	#a1=address of UpdateBuffer
		        la $a2,BufferTOUpdate         #a2=address of BufferTOUpdate
		        li $t6,0
		        
		        LOOPForCompare:
		        
				# Load bytes from each string into $t0 and $t1
    				lb $t0, ($a2)
    				lb $t7, ($a1)
    				addi $t6,$t6,1
    				beq $t0,13,IFBufferEndLOOP		#if we reach the end of BufferTOUpdate branch to IFBufferEndLOOP
    				beq $t0,0,IFBufferEndLOOP		#if we reach the end of UpdateBuffer branch to IFBufferEndLOOP
    				
    				# Compare the bytes
    				beq $t0, $t7, INCREMANTBUFFERSLOOP 	# If equal branch to INCREMANTBUFFERSLOOP 
   				
    			j Testparse1LOOP
    			
    			
    			
    			IFBufferEndLOOP:
    			
		       		beq $t7,0,TOcheckIfBuffersEqual1LOOP	#if we reach the end of UpdateBuffer branch to TOcheckIfBuffersEqual1LOOP
    				beq $t7,10,TOcheckIfBuffersEqual1LOOP	#if we reach new line then branch to TOcheckIfBuffersEqual1LOOP
    				
    			j Testparse1LOOP
    			
    			
    			#incremant the two buffer to hold new char
		       INCREMANTBUFFERSLOOP:
		       
		       		addi $a2, $a2, 1
    				addi $a1, $a1, 1
    						
    			j LOOPForCompare
    			
    			TOcheckIfBuffersEqual1LOOP:
    			
    				li $t7,13	#this becouse the end of bufferUserTest is 13
    				addi $t6,$t6,1  #this to count the new line to delete it 
    				
    			j TOcheckIfBuffersEqualLOOP
    			
    			
    			
    			TOcheckIfBuffersEqualLOOP:
    			
    				beq $t0, $t7,Equal_BufferLOOP # If equal branch to Equal_BufferLOOP 
    				li $t7,0
    				b TOcheckIfBuffersEqualLOOP
    				
    			j Testparse1LOOP
    			
    			
    			Testparse1LOOP:
    			
    				beq $t4,0,DefultCASELOOP
    				la $t1, BufferTOUpdate  	# Load address of the BufferTOUpdate
    				
    				li $t3, 0             		# Initialize value to store (zero)
    				
    				# Fill the buffer with zeros
    				li $s0, 50         		# Buffer size (number of iterations)
				loopResF:
    					sb $t3, ($t1)       	# Store zero in the buffer
    					addi $t1, $t1, 1    	# Move to the next memory location
    					subi $s0, $s0, 1    	# Decrement the iteration count
    					bnez $s0, loopResF  	# Repeat until all locations are filled
    					
    				la $t1,BufferTOUpdate 	        # Load address of the buffer	
    				
    			j parse1LOOP
    			
    			
    			#fill the line we want to delete with spaces
    			Equal_BufferLOOP :
    			
    				addi $s4,$s4,1	               #incremant the counter of valid test 
    				la $s2,medical_tests
    				sub $t6,$t5,$t6               #this to reach the position we want to delete 
    				addi $t6,$t6,-1               #this to decremant \r
    				li $t5,0
    				
    				#skip untill we reach the line we want to delete 
    				UPDATETESTNAMELOOP:
    				
               				lb $t4, 0($s2)         # Load a character from the strings buffer
					addi $s2,$s2,1
					beq $t5,$t6,StoreUPDATETESTNAMELOOP
					addi $t5,$t5,1
					
				j UPDATETESTNAMELOOP
				
				
				StoreUPDATETESTNAMELOOP:
				
					li $t3,32             #t3= space
					sb $t3,0($s2)         #store the space in the first position 
					
				j StoreUPDATETESTNAMELOOP1
				
				
				#store all position we want to delete with spaces
				StoreUPDATETESTNAMELOOP1:
				
					lb $t4,0($s2)
					beq $t4,10,PrintThenMenu
					beq $t4,0,PrintThenMenu
					sb $t3,0($s2)
					addi $s2,$s2,1
					
				j StoreUPDATETESTNAMELOOP1
			PrintThenMenu:
				li $v0,4
				la $a0,DeleteMSG
				syscall
			j loopMenu	
				
			DefultCASELOOP:
			
				beq $s4,0,PrintWrongResLOOP
				
			j loopMenu
			
			
			PrintWrongResLOOP:
			
				print_string(WrongUpDateResult)
				
			j Delete
			
	#case 7:
	Exit:
	
		#Open file for for write purposes
		li $v0, 13          	#syscall 13 - open file
		la $a0, fileLoc        #passing in file name
		li $a1, 1              #set flag 0 (read), 1 (write) , 9 (to append)
		li $a2, 0              #mode is ignored
		syscall
		#bltz $v0, openError   #if $v0 is less than 0, there is an error found
				
  		move $t1, $v0 				#save $v0 in t0 to be used later in write Line procedure and in closing the file
  			
		# Write the medical tests to file
   		li $v0, 15              		# syscall 15: write to file
    		move $a0, $t1           		# File descriptor
    		la $a1, medical_tests   		# Load address of medical_tests
    		li $a2, 1000            		# Length of medical_tests buffer
		syscall 
		
		li $v0, 16
		move $a0, $t1
		syscall

		
		print_string (EndMsg) 			#print String EndMsg
		
	j endProgram
		
	#the defult case:
	defultCase:
	
		print_string (WrongChoose) 	#print String WrongChoose
		
	j loopMenu
	

#this for print the menu to user 	
showMenu:

	print_string (MsgToUser) 	#print String MsgToUser
	print_string (menu) 		#print String menu
	print_string (option1) 		#print String option1
	print_string (option2) 		#print String option2
	print_string (option3) 		#print String option3
	print_string (option4) 		#print String option4
	print_string (option5) 		#print String option5
	print_string (option6) 		#print String option6
	print_string (option7) 		#print String option7
	
jr $ra
	
	
	#*********************************************************************************************
#Functions:

#function that tell if there is an error in open the file	
openError:

	la $a0, openErrorMsg
	li $v0, 4
	syscall
	
j endProgram

#function that tell if there is an error in read the file	
readError:

	la $a0, readErrorMsg
	li $v0, 4
	syscall
	
j endProgram
	
#function that call the os to end the program
endProgram:

	li $v0, 10
	syscall	


#function that reads one line from the file and saves into an 2D array 
read_loop:

    li $v0, 14           # syscall code for read file
    move $a0, $t0        # File descriptor
    la $a1, buffer       # Load the address of the buffer
    li $a2, 1000          # Maximum number of bytes to read
    syscall

    # Parse the fields and store them in the  array
    la $t1, medical_tests
   

parse_loop:

    lb $t4, 0($a1)       # Load a character from the buffer
    beqz $t4, done_parse # End of file reached

    # Store the character in the array
    sb $t4, 0($t1)
    addi $t1, $t1, 1
    
j continue_parse

	    
continue_parse:

    addi $a1, $a1, 1     # Move to the next character
    
j parse_loop
    
done_parse:

       #Close the file
    	li $v0, 16
	move $a0,$t0
   	syscall
    
jr $ra
