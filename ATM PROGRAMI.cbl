       IDENTIFICATION DIVISION.
      *----
       PROGRAM-ID.   ATM0001.
       AUTHOR.       SINEM SEN.
      *----
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL. 
           SELECT ACCT-INP  ASSIGN TO ACCTINP
                            ORGANIZATION INDEXED
                            ACCESS RANDOM
                            RECORD KEY ACCT-KEY
                            STATUS ST-ACCT-INP.
       DATA DIVISION. 
      *----
       FILE SECTION.
       FD  ACCT-INP.
       01  ACCT-REC.
           05 ACCT-KEY.
              10 ACCT-ID    PIC 9(10).
           05 ACCT-NAME     PIC X(15).
           05 ACCT-SURNAME  PIC X(15).
           05 ACCT-PIC      PIC 9(04).
           05 ACCT-BALANCE  PIC 9(10).
      *----
       WORKING-STORAGE SECTION.
      *----
       01  ENTRY-INFORMATION.
           05 ACCOUNT-NBR              PIC 9(10).
           05 ACCOUNT-PIC              PIC 9(04).
           05 ACCOUNT-NAME             PIC X(15).
           05 ACCOUNT-SURNAME          PIC X(15).
      *----
       01  TRANSFER-PROCESS.
           05 TRANSFER-AMOUNT       PIC 9(8).
           05 TRANSFER-IBAN         PIC 9(10).
           05 TRANSFER-DESCRIPTION  PIC X(30).
      *----
       01  CREDIT-PAYMENT.
           05 CREDIT-CARD-NO           PIC 9(16).
           05 CREDIT-CARD-LIMIT        PIC 9(06)       VALUE 60000.
           05 CREDIT-CARD-DEBT         PIC 9(06)       VALUE 28000.
           05 LAST-PAYMENT             PIC 9(08)       VALUE 20230730.
      *----
       01  PAYING-INVOINCE-PROCESS.
           05 INVOINCE-TYPE            PIC X(08). 
           05 INSTITUTION-NAME         PIC X(10).
           05 SUBSCRIBER-NO            PIC 9(10).       
           05 LAST-PAYMENT-DATE        PIC 9(08)       VALUE 20230725.
           05 PAYMENT-AMOUNT           PIC 9(04)       VALUE 2250.
           05 PAYMENT-AMOUNT-IN        PIC 9(04).
      *----
       01  OTHER-PROCESS.
           05 BALANCE-INQUIRY          PIC 9(10).
           05 WITHDRAWAL               PIC 9(08).
           05 DEPOSIT                  PIC 9(08).
      *----
       01  FLAG.
           05 EXIT-FLAG                PIC X(03)       VALUE 'YES'.
      *----
       01  COUNTER                     PIC 9           VALUE 1.
      *----
       01  SELECTING                   PIC 9.
      *----
       01  CUT                         PIC 9(03).
      *----
       01  ST-ACCT-INP                 PIC 9(02).
           88 ACCT-INP-SUCC            VALUE 00 97.
      *----
       PROCEDURE DIVISION.
      *----
       MAIN-PROCESS.
           OPEN INPUT ACCT-INP.
           DISPLAY 'Welcome to the ATM Program !'
           PERFORM ENTRY-INF
           PERFORM ACCOUNT-PIC-PROGRAM
           DISPLAY 'Please select the action you want to take:'
           PERFORM SELECT-PROCESS
           DISPLAY 'Is there any process you want to do?'
           ACCEPT EXIT-FLAG
           IF EXIT-FLAG = 'YES'
              PERFORM SELECT-PROCESS
           ELSE IF EXIT-FLAG = 'NO'
              DISPLAY 'Thanks for choose us. Have a good day :)'
           END-IF.
           CLOSE ACCT-INP. 
           STOP RUN.   
       MAIN-END. EXIT.
      *----
       ENTRY-INF.
           DISPLAY 'Please type into your 16-digit account number.'
           ACCEPT ACCOUNT-NBR
           PERFORM CHECK-ACCOUNT-NBR.
       ENTRY-END. EXIT.
      *----
       ACCOUNT-PIC-PROGRAM.
           DISPLAY 'Please enter your 4 digit password.'
           ACCEPT ACCOUNT-PIC
           PERFORM CHECK-ACCOUNT-PIC.
       ACCOUNT-END. EXIT. 
      *----
       CHECK-ACCOUNT-NBR.
           MOVE ACCOUNT-NBR TO ACCT-ID.
           DISPLAY ACCT-ID.
              READ ACCT-INP KEY IS ACCT-KEY 
                 INVALID KEY 
                 DISPLAY 'Wrong entry !'
                 STOP RUN.
       CHECK-END. EXIT.
      *----
       CHECK-ACCOUNT-PIC.
           IF NOT (ACCT-PIC = ACCOUNT-PIC) 
                 DISPLAY 'Incorrect entry ! Password mismatch.'
                 STOP RUN
           END-IF.
           MOVE ACCT-BALANCE TO BALANCE-INQUIRY. 
       CHECK-END. EXIT.
      *----
       SELECT-PROCESS.
           DISPLAY '1 - BALANCE-INQUIRY'.
           DISPLAY '2 - WITHDRAWAL'.
           DISPLAY '3 - DEPOSIT'.
           DISPLAY '4 - PAYING INVOINCE'.
           DISPLAY '5 - CREDIT PAYMENT'.
           DISPLAY '6 - TRANSFER'.
           ACCEPT SELECTING.
           IF SELECTING = '1'
              DISPLAY 'Your Account Balance:' BALANCE-INQUIRY
           ELSE IF SELECTING = '2'
              PERFORM WITHDRAWAL-PROGRAM
           ELSE IF SELECTING = '3'
              PERFORM DEPOSIT-PROGRAM
           ELSE IF SELECTING = '4'
              PERFORM PAYING-INVOINCE-PROGRAM
           ELSE IF SELECTING = '5'
              PERFORM CREDIT-PAYMENT-PROGRAM
           ELSE IF SELECTING = '6'
              PERFORM TRANSFER-PROGRAM
           END-IF.
       SELECT-END. EXIT.
      *----
       WITHDRAWAL-PROGRAM.
           DISPLAY 
      -    'Please enter the amount of money you want to withdraw.'.
           ACCEPT WITHDRAWAL.
           IF WITHDRAWAL > BALANCE-INQUIRY
              DISPLAY 'There is not enough balance in your account.'
           ELSE 
              IF WITHDRAWAL < 1000
                COMPUTE BALANCE-INQUIRY = BALANCE-INQUIRY - WITHDRAWAL
                DISPLAY 'Your balance:' BALANCE-INQUIRY 
              ELSE IF (WITHDRAWAL > 1000) AND (WITHDRAWAL < 5000)
                MOVE 10 TO CUT
                COMPUTE BALANCE-INQUIRY = 
      -         BALANCE-INQUIRY - WITHDRAWAL - CUT
                DISPLAY 'Your balance:' BALANCE-INQUIRY
              ELSE IF (WITHDRAWAL > 5000) AND (WITHDRAWAL < 20000)
                MOVE 50 TO CUT
                COMPUTE BALANCE-INQUIRY = 
      -         BALANCE-INQUIRY - WITHDRAWAL - CUT
                DISPLAY 'Your balance:' BALANCE-INQUIRY
              ELSE IF (WITHDRAWAL > 20000) AND (WITHDRAWAL < 100000)
                MOVE 100 TO CUT
                COMPUTE BALANCE-INQUIRY = 
      -         BALANCE-INQUIRY - WITHDRAWAL - CUT
                DISPLAY 'Your balance:' BALANCE-INQUIRY
              ELSE
                DISPLAY 'You can not withdraw more than 100000.'
           END-IF. EXIT.
      *----
       DEPOSIT-PROGRAM.
           DISPLAY 
      -    'Please enter the amount of money you want to deposit.'.
           ACCEPT DEPOSIT.
           IF DEPOSIT > 10000
              DISPLAY 'You cannot deposit more than 10000 TL per day.'
              STOP RUN
           ELSE
              COMPUTE BALANCE-INQUIRY = BALANCE-INQUIRY + DEPOSIT
              DISPLAY 'Your balance:' BALANCE-INQUIRY
           END-IF.
       DEPOSIT-END. EXIT.
      *----
       PAYING-INVOINCE-PROGRAM.
           DISPLAY 'Please enter invoice type.'.
           ACCEPT   INVOINCE-TYPE.
           DISPLAY 'Please enter invoice institution.'.
           ACCEPT   INSTITUTION-NAME.
           DISPLAY 'Please enter subscriber number.'.
           ACCEPT   SUBSCRIBER-NO.
           DISPLAY 'Last payment date:' LAST-PAYMENT-DATE.
           DISPLAY 'Payment amount:' PAYMENT-AMOUNT 'TL'.
           DISPLAY 'Please enter the payment amount.'.
           ACCEPT   PAYMENT-AMOUNT-IN.
           IF (PAYMENT-AMOUNT-IN = PAYMENT-AMOUNT) AND (PAYMENT-AMOUNT <
      -       BALANCE-INQUIRY)
              COMPUTE BALANCE-INQUIRY = BALANCE-INQUIRY - PAYMENT-AMOUNT
              DISPLAY 'Your balance:' BALANCE-INQUIRY
              DISPLAY 'Your payment has been successfully completed.'
           ELSE
             DISPLAY 'You entered the wrong amount/not enough balance.'
             STOP RUN
           END-IF.
       PAYING-END. EXIT.
      *----
       CREDIT-PAYMENT-PROGRAM.
           DISPLAY 'Please enter your credit card number.'.
           ACCEPT   CREDIT-CARD-NO.
           DISPLAY 'Your current credit card limit:' CREDIT-CARD-LIMIT.
           DISPLAY 'Your current credit card debt:'  CREDIT-CARD-DEBT.
           DISPLAY 'Due date:'                       LAST-PAYMENT.
       CREDIT-END. EXIT.
      *----
       TRANSFER-PROGRAM.
           DISPLAY 'Please enter the IBAN number to be transferred.'.
           ACCEPT  TRANSFER-IBAN.
           PERFORM CHECK-TRANSFER-IBAN.
           DISPLAY 'Please enter the amount to transfer.'.
           ACCEPT  TRANSFER-AMOUNT.
           PERFORM CHECK-TRANSFER-AMOUNT.
           DISPLAY 'Please enter the transfer describtion.'.
           ACCEPT  TRANSFER-DESCRIPTION.
           DISPLAY 'Your transfer has been successfully completed.'.
       TRANSFER-END. EXIT.
      *---- 
       CHECK-TRANSFER-IBAN.
           IF NOT (LENGTH OF TRANSFER-IBAN) = 26
              DISPLAY 'Incorrect Entry !'
           ELSE 
              STOP RUN
           END-IF.
       CHECK-END. EXIT.
      *----
       CHECK-TRANSFER-AMOUNT.
           IF TRANSFER-AMOUNT > BALANCE-INQUIRY
              DISPLAY 'There is not enough balance in your account.'
              STOP RUN
           END-IF.
       CHECK-END. EXIT.
       