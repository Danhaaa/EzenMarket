CREATE TABLE userlist (

    user_Number NUMBER(10)
    CONSTRAINT user_Number_pk primary key,
    
    user_Name VARCHAR2(20)
    CONSTRAINT user_Name_NN NOT NULL,
    
    user_ID VARCHAR2(20)
    CONSTRAINT user_Id_unique unique
    CONSTRAINT user_Id_NN NOT NULL,
    
    user_PW VARCHAR2(50)
    CONSTRAINT user_PW_NN NOT NULL,
    
    nickname VARCHAR2(70)
    CONSTRAINT nickname_unique unique
    CONSTRAINT nickname_NN NOT NULL,
    
    phoneNumber VARCHAR2(20)
    CONSTRAINT phoneNumber_unique unique
    CONSTRAINT phoneNumber_NN NOT NULL,
     
    email VARCHAR2(50)
    CONSTRAINT email_unique unique
    CONSTRAINT email_NN NOT NULL,
    
    user_image VARCHAR(255),
    
    bannedDate DATE default sysdate);
    
CREATE TABLE city(

   city_id NUMBER(10)
   CONSTRAINT city_id_pk primary key,
   
   city_name VARCHAR2(30)
   CONSTRAINT city_name_nn NOT NULL,
   
   district VARCHAR2(150)
   CONSTRAINT district_nn NOT NULL
);

CREATE TABLE address(

    address_id NUMBER(10)
    CONSTRAINT address_id_pk primary key,
    
    user_number NUMBER(11)
    CONSTRAINT address_user_number_fk REFERENCES userlist (user_number),
    
    city_id NUMBER(10)
    CONSTRAINT address_city_id_fk REFERENCES city (city_id)
);

CREATE TABLE category(

    category_id NUMBER(10)
    CONSTRAINT category_id_pk primary key,
    
    category_name VARCHAR2(30)
    CONSTRAINT category_name_unique unique
    CONSTRAINT category_name_nn NOT NULL
    );

CREATE TABLE post (

    post_id NUMBER(10)
    CONSTRAINT post_id_pk primary key,
    
    user_number NUMBER(10)
    CONSTRAINT post_user_number_fk REFERENCES userlist (user_number),
    
    address_id NUMBER(10)
    CONSTRAINT post_address_id_fk REFERENCES address (address_id),
    
    title VARCHAR2(150)
    CONSTRAINT title_nn NOT NULL,
    
    category_id NUMBER(10)
    CONSTRAINT post_category_id_fk REFERENCES category (category_id),
    
    price NUMBER(9),
    
    created DATE default sysdate,
    
    updated DATE,
    
    post_view NUMBER(9)default 0 
    
);
    
CREATE TABLE postContent(

    post_id NUMBER(10)
    CONSTRAINT postContent_post_id_fk REFERENCES post (post_id),
    
    content VARCHAR2(1500)
);

CREATE TABLE postImage(
    
    post_image_id NUMBER(10)
    CONSTRAINT post_image_id_pk primary key,
    
    post_id NUMBER(10)
    CONSTRAINT postImage_post_id_fk REFERENCES post (post_id),
    
    image_url VARCHAR2(250)
    CONSTRAINT image_url_nn NOT NULL

);

CREATE TABLE wishList (
    
    wishList_id NUMBER(10)
    CONSTRAINT wishList_id_pk primary key,
    
    user_number NUMBER(10)
    CONSTRAINT wishList_user_number_fk REFERENCES userlist (user_number),
    
    post_id NUMBER(10)
    CONSTRAINT wishList_post_id_fk REFERENCES post (post_id)
    
);

CREATE TABLE chattingRoom (

    chattingRoom_id NUMBER(10)
    CONSTRAINT chattingRoom_id_pk primary key,
    
    seller_user_number NUMBER(10)
    CONSTRAINT CR_seller_user_number_nn NOT NULL,
    
    buyer_user_number NUMBER(10)
    CONSTRAINT CR_buyer_user_number_nn NOT NULL
    
);

CREATE TABLE chattingContent(
    
    chatting_content_id NUMBER(10)
    CONSTRAINT chatting_content_id_pk primary key,
    
    chattingRoom_id NUMBER(10)
    CONSTRAINT content_chattingRoom_id_fk 
    REFERENCES chattingRoom (chattingRoom_id),
    
    user_number NUMBER(10)
    CONSTRAINT content_user_number_fk REFERENCES userlist (user_number),
    
    contents VARCHAR2(4000),
    
    chatting_date DATE default sysdate
);

CREATE TABLE endDeal (
    
    endDeal_id NUMBER(10)
    CONSTRAINT endDeal_id_pk primary key,
    
    seller_user_number NUMBER(10)
    CONSTRAINT ED_seller_user_number_nn NOT NULL,
    
    buyer_user_number NUMBER(10)
    CONSTRAINT ED_buyer_user_number_nn NOT NULL
);

CREATE TABLE review(
    review_id NUMBER(10)
    CONSTRAINT review_id_pk primary key,
    
    endDeal_id NUMBER(10)
    CONSTRAINT review_endDeal_id_fk REFERENCES endDeal (endDeal_id),
    
    rating NUMBER(1)
    CONSTRAINT rating_nn NOT NULL,
    
    user_number NUMBER(10)
    CONSTRAINT review_user_number_fk REFERENCES userlist (user_number),
    
    review_content VARCHAR2(300)
    CONSTRAINT review_content_nn NOT NULL
);

CREATE TABLE admin(
    
    admin_number NUMBER(4)
    CONSTRAINT admin_number_pk primary key,
    
    admin_id VARCHAR2(20)
    CONSTRAINT admin_id_nn NOT NULL
    CONSTRAINT admin_id_unique unique,
    
    admin_pw VARCHAR2(50)
    CONSTRAINT admin_pw_nn NOT NULL
    );
    
CREATE TABLE report(

    report_id NUMBER(10)
    CONSTRAINT report_id_pk primary key,
    
    report_type NUMBER(2)
    CONSTRAINT report_type_nn NOT NULL,
    
    report_detail NUMBER(10)
    CONSTRAINT report_detail_nn NOT NULL,
    
    user_number NUMBER(10)
    CONSTRAINT report_user_number_fk REFERENCES userlist (user_number),
    
    report_content VARCHAR2(900)
    CONSTRAINT report_content_nn NOT NULL
);

CREATE SEQUENCE user_number_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE category_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE post_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE chattingRoom_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE chatting_content_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE post_image_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE wishlist_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE address_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE endDeal_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE review_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

CREATE SEQUENCE report_id_seq
START WITH 1
INCREMENT BY 1 MAXVALUE 1000000
NOCYCLE NOCACHE;

INSERT INTO userlist(user_number, user_name, user_id, user_pw, nickname, phonenumber, email, user_image) values(user_number_seq.nextval,'������','qwert1', 'YQCaawZtfTgCs8Ah/APHAlK_e_CjPkdgHT', '¯¯����zz', '01012345678', 'dlswo1234@gmail.com', 'https://s.pstatic.net/shopping.phinf/20220308_28/8e811a9e-1c0f-4313-ad60-0b0ee9872029.jpg?type=f214_292');

INSERT INTO userlist(user_number, user_name, user_id, user_pw, nickname, phonenumber, email, user_image) values(user_number_seq.nextval,'��ö��', 'qwert2', 'AFvIBn_ihXRTW4xyWpOTJPUrmprYlWJoN7hiewkRkuE6GbSIg', 'ööö��', '01087654321', 'cjftn123@naver.com', 'https://naverpa-phinf.pstatic.net/MjAyMjEyMDdfMTc2/MDAxNjcwMzg1MDc0NDA5.T155TC3cDdY0WgLl2keblW4pqHuk2PJMfQLzoXHHF5Ig.VPg5TrpdllpD0FOC5mlN-baxxGQ-JdJmiLXjxshDhP8g.JPEG/221207_gfa_16703850743931154144555135500874.jpg');

INSERT INTO category VALUES(category_id_seq.nextval, '�����Ƿ�');

INSERT INTO city VALUES(1, '������', '��â��');

INSERT INTO address VALUES(address_id_seq.nextval, 1, 1);

INSERT INTO post(post_id, user_number, address_id, title, category_id, price) VALUES(post_id_seq.nextval, 1, 1, '������ û���� �Ⱦƿ�', 1, 7500);

INSERT INTO postContent VALUES(1, '2������ �� ������ û���� �Ⱦƿ� �������տ��� ���ŷ��մϴ�.');

INSERT INTO postImage VALUES(post_image_id_seq.nextval, 1, 'https://contents.lotteon.com/itemimage/_v145632/LO/19/60/56/32/08/_1/96/05/63/20/9/LO1960563208_1960563209_1.jpg/dims/optimize/dims/resizemc/400x400');

INSERT INTO wishList VALUES(wishList_id_seq.nextval, 1, 1);

INSERT INTO chattingRoom VALUES(chattingRoom_id_seq.nextval, 1, 2);

INSERT INTO chattingContent(chatting_content_id, chattingRoom_id, user_number, contents) VALUES(chatting_content_id_seq.nextval, 1, 1, 'ö���Ծȳ��ϼ���');

INSERT INTO chattingContent(chatting_content_id, chattingRoom_id, user_number, contents) VALUES(chatting_content_id_seq.nextval, 1, 2, '¯¯����Ծȳ��ϼ���');

INSERT INTO chattingContent(chatting_content_id, chattingRoom_id, user_number, contents) VALUES(chatting_content_id_seq.nextval, 1, 2, '6500�����ּ���');

INSERT INTO chattingContent(chatting_content_id, chattingRoom_id, user_number, contents) VALUES(chatting_content_id_seq.nextval, 1, 1, '��');

INSERT INTO endDEAL VALUES(endDeal_id_seq.nextval, 1, 2);

INSERT INTO review VALUES(review_id_seq.nextval, 1, 5, 1, '��ŷ������մϴ�');

INSERT INTO review VALUES(review_id_seq.nextval, 1, 5, 2, '������̻��������߻���̾��');

INSERT INTO admin VALUES(1, 'admin1', 'AFvIBn_ihXRTW4xyWpOTJPUrmprYlWJo');

INSERT INTO REPORT VALUES(report_id_seq.nextval, 1, 1, 2, 'ä���߿� �弳�� �߽��ϴ�.');


commit;

