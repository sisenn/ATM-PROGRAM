# ATM-PROGRAM
Bu program, kullanıcıların bakiye sorgulama, para çekme, para yatırma, fatura ödeme, kredi kartı ödemeleri ve transfer gibi çeşitli bankacılık işlemlerini gerçekleştirmelerine izin veren bir ATM programı içerir.
Ana süreç, giriş dosyasını açarak ve bir karşılama mesajı görüntüleyerek başlar.
"entry-inf" paragrafı, kullanıcının hesap numarasını toplar.
"account-pic-program" paragrafı, hesap şifresi için bir giriş istemini görüntüler.
"check-account-nbr" ve "check-account-pic" paragrafları, girilen hesap numarasını ve şifreyi doğrular.
"select-process" paragrafı, bir seçenek menüsünü görüntüler ve kullanıcının bir işlem seçmesine olanak tanır.
Seçilen işleme bağlı olarak, program ilgili paragrafı çalıştırır veya seçilen işlemi gerçekleştirir.
"withdrawal-program", "deposit-program", "paying-invoice-program", "credit-payment-program" ve "transfer-program" paragrafları, sırasıyla ilgili işlemleri işler.
Kullanıcı çıkış yapana kadar program, select-process paragrafını tekrarlar.
Son olarak, program giriş dosyasını kapatır ve çalışmayı durdurur.
