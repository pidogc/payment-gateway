alter table merchant_payment
    add provider tinyint unsigned null;

alter table merchant_payment
    add `desc` varchar(255) default '' null;